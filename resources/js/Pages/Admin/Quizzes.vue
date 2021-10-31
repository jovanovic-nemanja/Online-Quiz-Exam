<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">Quizzes</h4>
        </template>
        <template #actions>
            <inertia-link :href="route('quizzes.create')" class="qt-btn qt-btn-success">
                New Quiz
            </inertia-link>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote"
                                    @on-page-change="onPageChange"
                                    @on-column-filter="onColumnFilter"
                                    @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="quizzes.meta.pagination.total"
                                    :rows="quizzes.data">
                        <template slot="table-row" slot-scope="props">

                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" severity="info" v-clipboard:success="handleCopyStatus"
                                     :value="props.row.code" icon="pi pi-copy" class="w-full p-mr-2 mb-2 text-xs cursor-pointer"/>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span :class="[props.row.status === 'Published' ? 'badge-success' : 'badge-danger', 'badge']">{{ props.row.status }}</span>
                            </div>

                            <!-- Actions Column -->
                            <div class="flex items-center gap-2" v-else-if="props.column.field === 'actions'">
                                <Button icon="pi pi-pencil" class="p-button-rounded p-button-secondary p-button-text p-mr-2"
                                        @click="editQuiz(props.row.id)"/>
                                <Button icon="pi pi-clock" class="p-button-rounded p-button-secondary p-button-text p-mr-2"
                                        @click="goToSchedules(props.row.id)"/>
                                <Button icon="pi pi-chart-line" class="p-button-rounded p-button-secondary p-button-text p-mr-2"
                                        @click="goToAnalytics(props.row.id)"/>
                                <Button icon="pi pi-trash" class="p-button-rounded p-button-danger p-button-text"
                                        @click="deleteExam(props.row.id)"/>
                            </div>

                            <!-- Remaining Columns -->
                            <span v-else>
                              {{props.formattedRow[props.column.field]}}
                            </span>

                        </template>
                        <div slot="emptystate">
                            <no-data-table>
                                <template slot="action">
                                    <inertia-link :href="route('quizzes.create')" class="qt-btn-sm qt-btn-primary">
                                        Create New
                                    </inertia-link>
                                </template>
                            </no-data-table>
                        </div>
                    </vue-good-table>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout';
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
            quizzes: Object,
            statusFilters: Array,
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
                        label: 'Title',
                        field: 'title',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Title',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: 'Category',
                        field: 'category',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Category',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: 'Type',
                        field: 'quizType',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Type',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: 'Visibility',
                        field: 'visibility',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Filter by Visibility',
                            filterValue: null,
                            filterDropdownItems: [{value: 1, text: 'Private'}, {value: 0, text: 'Public'}],
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
                            filterDropdownItems: [{value: 1, text: 'Published'}, {value: 0, text: 'Draft'}],
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
                    perPage: this.quizzes.meta.pagination.per_page,
                    setCurrentPage: this.quizzes.meta.pagination.current_page,
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
                return 'Quizzes - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
        methods: {
            updateParams(newProps) {
                this.serverParams = Object.assign({}, this.serverParams, newProps);
            },
            onPageChange(params) {
                this.updateParams({page: params.currentPage});
                this.loadItems();
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
            editQuiz(id) {
                this.$inertia.get(route('quizzes.edit', {quiz: id}));
            },
            goToSchedules(id) {
                this.$inertia.get(route('quizzes.schedules.index', {quiz: id}));
            },
            goToAnalytics(id) {
                this.$inertia.get(route('quizzes.overall_report', {quiz: id}));
            },
            deleteExam(id) {
                this.$confirm.require({
                    header: 'Confirm Delete',
                    message: 'Do you want to delete this quiz?',
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: 'Cancel',
                    acceptLabel: 'Delete',
                    accept: () => {
                        this.$inertia.delete(route('quizzes.destroy', {id: id}), {}, {
                            onSuccess: () => {
                                this.$toast.add({
                                    severity: 'info',
                                    summary: 'Confirmed',
                                    detail: 'Quiz deleted',
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
        }
    }
</script>
