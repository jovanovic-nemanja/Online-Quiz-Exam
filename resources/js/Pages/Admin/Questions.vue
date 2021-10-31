<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">Questions</h4>
        </template>
        <template #actions>
            <div class="flex gap-4 items-center">
                <inertia-link :href="route('initiate_import_questions')" class="qt-btn qt-btn-primary">
                    Import Questions
                </inertia-link>
                <arc-dropdown align="right" width="48">
                    <template #trigger>
                        <button class="qt-btn qt-btn-success">
                            New Question
                        </button>
                    </template>
                    <template #content>
                        <template v-for="questionType in questionTypes">
                            <arc-dropdown-link :href="route('questions.create', {'question_type': questionType.code})">
                                {{ questionType.text }}
                            </arc-dropdown-link>
                        </template>
                    </template>
                </arc-dropdown>
            </div>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="questions.meta.pagination.total"
                                    :rows="questions.data">
                        <template slot="table-row" slot-scope="props">
                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" v-clipboard:success="handleCopyStatus" :value="props.row.code" icon="pi pi-copy"
                                     class="w-full p-mr-2 text-sm cursor-pointer"/>
                            </div>

                            <!-- Question Column -->
                            <div v-else-if="props.column.field === 'question'">
                                <div class="py-4" v-html="props.row.question"></div>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span :class="[props.row.status === 'Active' ? 'badge-success' : 'badge-danger', 'badge']">{{ props.row.status }}</span>
                            </div>

                            <!-- Actions Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <Button icon="pi pi-pencil" class="p-button-rounded p-button-secondary p-button-text p-mr-2"
                                        @click="editQuestion(props.row.id)"/>
                                <Button icon="pi pi-trash" class="p-button-rounded p-button-danger p-button-text"
                                        @click="deleteQuestion(props.row.id)"/>
                            </div>

                            <!-- Remaining Columns -->
                            <span v-else>
                              {{props.formattedRow[props.column.field]}}
                            </span>
                        </template>

                        <div slot="emptystate">
                            <no-data-table />
                        </div>
                    </vue-good-table>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcDropdown from '@/Components/Dropdown'
    import ArcDropdownLink from '@/Components/DropdownLink'
    import Toast from 'primevue/toast';
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';
    import Button from 'primevue/button';
    import NoDataTable from "@/Components/NoDataTable";
    export default {
        components: {
            AdminLayout,
            ArcDropdown,
            ArcDropdownLink,
            Toast,
            Chip,
            Tag,
            Button,
            NoDataTable
        },
        props: {
            questionTypes: Array,
            questions: Object,
            sections: Array
        },
        data() {
            return {
                createForm: false,
                editForm: false,
                currentId: null,
                columns: [
                    {
                        label: 'Code',
                        field: 'code',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Code',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                        width: '11rem',
                    },
                    {
                        label: 'Question',
                        field: 'question',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Question',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: 'Type',
                        field: 'questionType',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Filter by Type',
                            filterValue: null,
                            filterDropdownItems: this.questionTypes,
                        },
                    },
                    {
                        label: 'Section',
                        field: 'section',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Section',
                            filterValue: null,
                            trigger: 'enter',
                        },
                    },
                    {
                        label: 'Skill',
                        field: 'skill',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Skill',
                            filterValue: null,
                            trigger: 'enter',
                        },
                    },
                    {
                        label: 'Topic',
                        field: 'topic',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Topic',
                            filterValue: null,
                            trigger: 'enter',
                        },
                    },
                    {
                        label: 'Status',
                        field: 'status',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Filter by Status',
                            filterValue: null,
                            filterDropdownItems: [{value: 1, text: 'Active'}, {value: 0, text: 'In-active'}],
                        },
                    },
                    {
                        label: 'Actions',
                        field: 'actions',
                        sortable: false,
                        width: '200px',
                        tdClass: 'text-center',
                    }
                ],
                options: {
                    enabled: true,
                    mode: 'pages',
                    perPage: this.questions.meta.pagination.per_page,
                    setCurrentPage: this.questions.meta.pagination.current_page,
                    perPageDropdown: [10, 20, 50, 100],
                    dropdownAllowAll: false,
                },
                serverParams: {
                    columnFilters: {},
                    sort: {
                        field: '',
                        type: '',
                    },
                    page: 1,
                    perPage: 10
                },
                loading: false,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return 'Questions - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
        methods: {
            updateParams(newProps) {
                this.serverParams = Object.assign({}, this.serverParams, newProps);
            },
            onPageChange(params) {
                this.updateParams({page: params.currentPage});
                this.loadItems();
                this.$nextTick(function() {
                    window.renderMathInElement(this.$el);
                });
            },
            onPerPageChange(params) {
                this.updateParams({perPage: params.currentPerPage});
                this.loadItems();
            },
            onSortChange(params) {
                this.updateParams({
                    sort: [{
                        type: params.sortType,
                        field: this.columns[params.columnIndex].field,
                    }],
                });
                this.loadItems();
            },
            onColumnFilter(params) {
                this.updateParams(params);
                this.serverParams.page = 1;
                this.loadItems();
            },
            getQueryParams() {
                let data = {
                    'page': this.serverParams.page,
                    'perPage': this.serverParams.perPage
                }

                for (const [key, value] of Object.entries(this.serverParams.columnFilters)) {
                    if (value) {
                        data[key] = value;
                    }
                }

                return data;
            },
            loadItems() {
                this.$inertia.get(route(route().current()), this.getQueryParams(), {
                    replace: false,
                    preserveState: true,
                    preserveScroll: true,
                });
            },
            editQuestion(id) {
                this.$inertia.get(route('questions.edit', {question: id}));
            },
            deleteQuestion(id) {
                this.$confirm.require({
                    header: 'Confirm Delete',
                    message: 'Do you want to delete this record?',
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: 'Cancel',
                    acceptLabel: 'Delete',
                    accept: () => {
                        this.$inertia.delete(route('questions.destroy', {id: id}), {}, {
                            onSuccess: () => {
                                this.$toast.add({
                                    severity: 'info',
                                    summary: 'Confirmed',
                                    detail: 'Record deleted',
                                    life: 3000
                                });
                            },
                        });
                    },
                    reject: () => {

                    }
                });

            },
            handleCopyStatus(status) {
                if (status) {
                    this.$toast.add({
                        severity: 'success',
                        summary: 'Copied',
                        detail: 'Copied Successfully!',
                        life: 2000
                    });
                }
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
