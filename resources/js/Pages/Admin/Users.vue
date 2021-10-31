<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">Users</h4>
        </template>
        <template #actions>
            <button @click="createForm = true" class="qt-btn qt-btn-success">
                New User
            </button>
        </template>

        <div class="container mx-auto py-10 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="users.meta.pagination.total"
                                    :rows="users.data">
                        <template slot="table-row" slot-scope="props">
                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" :value="props.row.code" icon="pi pi-copy"
                                     class="w-full p-mr-2 cursor-pointer"/>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span :class="[props.row.status ? 'badge-success' : 'badge-danger', 'badge']">{{ props.row.status ? 'Active' : 'Inactive' }}</span>
                            </div>

                            <!-- Action Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <Button icon="pi pi-pencil" class="p-button-rounded p-button-secondary p-button-text p-mr-2"
                                        @click="editForm = true; currentId = props.row.id;"/>
                                <Button icon="pi pi-trash" class="p-button-rounded p-button-danger p-button-text" @click="deleteUser(props.row.id)"/>
                            </div>

                            <!-- Remaining Columns -->
                            <span v-else>
                                {{props.formattedRow[props.column.field]}}
                            </span>
                        </template>
                        <div slot="emptystate">
                            <no-data-table>
                                <template slot="action">
                                    <button @click="createForm = true" class="qt-btn-sm qt-btn-primary" type="button">
                                        Create New
                                    </button>
                                </template>
                            </no-data-table>
                        </div>
                    </vue-good-table>

                    <!-- Sidebar Forms -->
                    <Sidebar position="right" :visible.sync="createForm" v-on:hide="loadItems" class="p-sidebar-md">
                        <UserForm :errors="errors" :roles="roles" @close="createForm = false" :user-groups="userGroups" title="New User"/>
                    </Sidebar>
                    <Sidebar position="right" :visible.sync="editForm" v-on:hide="loadItems" class="p-sidebar-md">
                        <UserForm :edit-flag.sync="editForm" :roles="roles" :user-id="currentId" :user-groups="userGroups" :errors="errors"
                                       @close="editForm = false" title="Edit User"/>
                    </Sidebar>

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
    import Sidebar from 'primevue/sidebar'
    import UserForm from "@/Components/Forms/UserForm";
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';
    import NoDataTable from "@/Components/NoDataTable";

    export default {
        components: {
            UserForm,
            AdminLayout,
            Column,
            InputText,
            Toolbar,
            Button,
            Sidebar,
            Chip,
            Tag,
            NoDataTable
        },
        props: {
            users: Object,
            errors: Object,
            roles: Array,
            userGroups: Array
        },
        data() {
            return {
                createForm: false,
                editForm: false,
                currentId: null,
                columns: [
                    {
                        label: 'Name',
                        field: 'fullName',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Name',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: 'User Name',
                        field: 'userName',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by User Name',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: 'Email',
                        field: 'email',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Email',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: 'Role',
                        field: 'role',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Role',
                            filterValue: null,
                            filterDropdownItems: this.roles,
                        },
                        sortable: false,
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
                        width: '11rem'
                    },
                    {
                        label: 'Actions',
                        field: 'actions',
                        sortable: false,
                        width: '12rem'
                    },
                ],
                options: {
                    enabled: true,
                    mode: 'pages',
                    perPage: this.users.meta.pagination.per_page,
                    setCurrentPage: this.users.meta.pagination.current_page,
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
                return 'Users - ' + this.$page.props.general.app_name + ' Admin';
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
            deleteUser(id) {
                this.$confirm.require({
                    header: 'Confirm Delete',
                    message: 'Do you want to delete this record?',
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: 'Cancel',
                    acceptLabel: 'Delete',
                    accept: () => {
                        this.$inertia.delete(route('users.destroy', {id: id}), {}, {
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
                        life: 3000
                    });
                }
            }
        }
    }
</script>
