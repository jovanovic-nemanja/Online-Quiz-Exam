<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">Supported Question Types</h4>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="questionTypes.meta.pagination.total"
                                    :rows="questionTypes.data">
                        <template slot="table-row" slot-scope="props">
                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" v-clipboard:success="handleCopyStatus" :value="props.row.code" icon="pi pi-copy"
                                     class="w-full p-mr-2 text-sm cursor-pointer"/>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span class="text-sm" :class="[props.row.status === 'Active' ? 'badge-success' : 'badge-danger', 'badge']">{{ props.row.status }}</span>
                            </div>

                            <!-- Remaining Columns -->
                            <span v-else>
                              {{ props.formattedRow[props.column.field] }}
                            </span>
                        </template>
                    </vue-good-table>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import Column from 'primevue/column';
    import InputText from 'primevue/inputtext';
    import Toolbar from 'primevue/toolbar';
    import Button from 'primevue/button';
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';

    export default {
        components: {
            AdminLayout,
            Column,
            InputText,
            Toolbar,
            Button,
            Chip,
            Tag
        },
        props: {
            questionTypes: Object,
            errors: Object,
        },
        data() {
            return {
                columns: [
                    {
                        label: 'Code',
                        field: 'code',
                        sortable: false,
                        width: '11rem'
                    },
                    {
                        label: 'Name',
                        field: 'name',
                        sortable: false,
                        width: '16rem'
                    },
                    {
                        label: 'Short Description',
                        field: 'short_description',
                        sortable: false,
                    },
                    {
                        label: 'Status',
                        field: 'status',
                        sortable: false,
                        width: '11rem'
                    }
                ],
                options: {
                    enabled: false,
                    mode: 'pages',
                    perPage: this.questionTypes.meta.pagination.per_page,
                    setCurrentPage: this.questionTypes.meta.pagination.current_page,
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
                return 'Question Types - ' + this.$page.props.general.app_name + ' Admin';
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
