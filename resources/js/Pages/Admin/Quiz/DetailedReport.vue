<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ quiz.title }} - {{ schedule !== null ? 'Schedule ' : '' }}Detailed Report</h4>
            <div v-if="schedule !== null" class="text-xs">Schedule ID: {{ schedule.code }}</div>
        </template>
        <template #actions>
            <a v-if="schedule !== null" :href="route('quizzes.export_report', {quiz: quiz.id, schedule: schedule.id})" target="_blank" class="qt-btn qt-btn-primary">
                Download Report
            </a>
            <a v-else :href="route('quizzes.export_report', {quiz: quiz.id})" target="_blank" class="qt-btn qt-btn-primary">
                Download Report
            </a>
            <inertia-link v-if="schedule !== null" :href="route('quizzes.overall_report', {quiz: quiz.id, schedule: schedule.id})" class="qt-btn qt-btn-success">
                Overall Report
            </inertia-link>
            <inertia-link v-else :href="route('quizzes.overall_report', {quiz: quiz.id})" class="qt-btn qt-btn-success">
                Overall Report
            </inertia-link>
        </template>

        <div class="py-8">
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                <div class="card">
                    <div class="card-body">
                        <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                        :pagination-options="options" :columns="columns"
                                        :totalRows="quizSessions.meta.pagination.total"
                                        :rows="quizSessions.data">
                            <template slot="table-row" slot-scope="props">
                                <!-- Status Column -->
                                <div v-if="props.column.field === 'status' && type.name !== 'Personality'">
                                    <span :class="[props.row.status === 'Passed' ? 'badge-success' : 'badge-danger', 'badge-sm uppercase text-xs']">{{ props.row.status }}</span>
                                </div>

                                <!-- Actions Column -->
                                <div class="py-2" v-else-if="props.column.field === 'actions'">
                                    <inertia-link class="qt-btn qt-btn-sm qt-btn-success" :href="route('quiz_session_results', {quiz: props.row.slug, session: props.row.id})">
                                        View Results
                                    </inertia-link>
                                </div>

                                <!-- Remaining Columns -->
                                <span v-else>
                                      {{props.formattedRow[props.column.field]}}
                                    </span>
                            </template>

                            <div slot="emptystate">
                                <no-data-table></no-data-table>
                            </div>
                        </vue-good-table>
                    </div>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import NoDataTable from "@/Components/NoDataTable";

    export default {
        components: {
            AdminLayout,
            NoDataTable
        },
        props: {
            quiz: Object,
            quizSessions: Object,
            type: Object,
            schedule: Object
        },
        data() {
            return {
                loading: false,
                columns: this.type.name !== 'Personality' ? [
                    {
                        label: 'Test Taker',
                        field: 'name',
                        sortable: false,
                    },
                    {
                        label: 'Completed On',
                        field: 'completed',
                        sortable: false,
                    },
                    {
                        label: 'Percentage',
                        field: 'percentage',
                        sortable: false,
                    },
                    {
                        label: 'Score',
                        field: 'score',
                        sortable: false,
                    },
                    {
                        label: 'Accuracy',
                        field: 'accuracy',
                        sortable: false,
                    },
                    {
                        label: 'IP',
                        field: 'ip',
                        sortable: false,
                    },
                    {
                        label: 'Status',
                        field: 'status',
                        sortable: false,
                    },
                    {
                        label: 'Actions',
                        field: 'actions',
                        sortable: false,
                    }
                ]: [
                    {
                        label: 'Test Taker',
                        field: 'name',
                        sortable: false,
                    },
                    {
                        label: 'Completed On',
                        field: 'completed',
                        sortable: false,
                    },
                    {
                        label: 'IP',
                        field: 'ip',
                        sortable: false,
                    },
                    {
                        label: 'Actions',
                        field: 'actions',
                        sortable: false,
                    }
                ],
                options: {
                    enabled: true,
                    mode: 'pages',
                    perPage: this.quizSessions.meta.pagination.per_page,
                    setCurrentPage: this.quizSessions.meta.pagination.current_page,
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
            }
        },
        methods: {
            toggleReport() {
                this.detailed = !this.detailed;
            },
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
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.quiz.title + ' Detailed Report - ' + this.$page.props.general.app_name;
            },
        }
    }
</script>
