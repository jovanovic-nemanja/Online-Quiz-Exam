<template>
    <div class="overflow-y-auto h-screen px-2">
        <div class="bg-gray-100 py-4 lg:py-4 rounded">
            <div class="container px-6 mx-auto flex flex-col md:flex-row items-start md:items-center justify-between">
                <div>
                    <h4 class="text-base font-semibold leading-tight text-gray-800">
                        {{ title }}
                    </h4>
                </div>
            </div>
        </div>
        <div v-if="loading" class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0">
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
            <form-switch-shimmer></form-switch-shimmer>
        </div>
        <form v-else class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0" @submit.prevent="submitForm">
            <!-- First Name -->
            <div class="w-full flex flex-col mb-6">
                <label for="first_name" class="pb-2 font-semibold text-gray-800">First Name<span class="ml-1 text-red-400">*</span></label>
                <InputText type="text"
                           id="first_name"
                           v-model="form.first_name"
                           placeholder="Enter First Name" aria-describedby="first_name-help"
                           :class="[errors.first_name ? 'p-invalid' : '']"

                />
                <small id="first_name-help" v-if="errors.first_name" class="p-invalid">{{ errors.first_name }}</small>
            </div>

            <!-- Last Name -->
            <div class="w-full flex flex-col mb-6">
                <label for="last_name" class="pb-2 font-semibold text-gray-800">Last Name<span class="ml-1 text-red-400">*</span></label>
                <InputText type="text"
                           id="last_name"
                           v-model="form.last_name"
                           placeholder="Enter Last Name" aria-describedby="last_name-help"
                           :class="[errors.last_name ? 'p-invalid' : '']"

                />
                <small id="last_name-help" v-if="errors.last_name" class="p-invalid">{{ errors.last_name }}</small>
            </div>

            <!-- Email -->
            <div class="w-full flex flex-col mb-6">
                <label for="email" class="pb-2 font-semibold text-gray-800">Email<span class="ml-1 text-red-400">*</span></label>
                <InputText type="email"
                           id="email"
                           v-model="form.email"
                           placeholder="Enter Email" aria-describedby="email-help"
                           :class="[errors.email ? 'p-invalid' : '']"

                />
                <small id="email-help" v-if="errors.email" class="p-invalid">{{ errors.email }}</small>
            </div>

            <!-- User Name -->
            <div class="w-full flex flex-col mb-6">
                <label for="user_name" class="pb-2 font-semibold text-gray-800">User Name<span class="ml-1 text-red-400">*</span></label>
                <InputText type="text"
                           id="user_name"
                           v-model="form.user_name"
                           placeholder="Enter User Name" aria-describedby="user_name-help"
                           :class="[errors.user_name ? 'p-invalid' : '']"

                />
                <small id="user_name-help" v-if="errors.user_name" class="p-invalid">{{ errors.user_name }}</small>
            </div>

            <!-- User Role Dropdown -->
            <div class="w-full flex flex-col mb-6">
                <label for="userRole" class="pb-2 font-semibold text-gray-800">User Role<span class="ml-1 text-red-400">*</span></label>
                <v-select id="userRole" v-model="form.role" :options="roles" :reduce="role => role.value" label="text" placeholder="Choose Role"/>
                <small id="userRole-help" v-if="errors.role" class="p-invalid">{{ errors.role }}</small>
            </div>

            <!-- User Groups Dropdown -->
            <div v-if="form.role !== 1" class="w-full flex flex-col mb-6">
                <label for="users" class="pb-2 font-semibold text-gray-800">User Groups</label>
                <v-select multiple id="users" v-model="form.user_groups" :options="userGroups" :reduce="group => group.id" label="name" placeholder="Select User Groups"/>
                <small id="users-help" v-if="errors.user_groups" class="p-invalid">{{ errors.user_groups }}</small>
            </div>

            <!-- Password -->
            <div class="w-full flex flex-col mb-6">
                <label for="password" class="pb-2 font-semibold text-gray-800">Password<span v-if="!editFlag" class="ml-1 text-red-400">*</span></label>
                <InputText type="password" id="password" v-model="form.password" placeholder="Enter Password" aria-describedby="password-help"
                           :class="[errors.password ? 'p-invalid' : '']"/>
                <small id="password-help" v-if="errors.password" class="p-invalid">{{ errors.password }}</small>
            </div>

            <!-- Is Active Switch -->
            <div class="w-full">
                <div class="flex justify-between items-center mb-8">
                    <div class="w-9/12">
                        <label for="is_active" class="font-semibold text-gray-800 pb-1" v-html="form.is_active ? 'Status (Active)' : 'Status (In-active)'"></label>
                        <p class="text-gray-500">Active (Allow Login). In-active (Login Disabled).</p>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="is_active" v-model="form.is_active" />
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="w-full flex">
                <Button type="submit" :label="editFlag ? 'Update' : 'Create'" />
            </div>
        </form>
    </div>
</template>
<script>
    import InputText from 'primevue/inputtext';
    import Button from 'primevue/button';
    import InputSwitch from 'primevue/inputswitch';
    import TextEditor from "@/Components/TextEditor";
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
    import vSelect from "vue-select";
    export default {
        name: 'UserForm',
        components: {
            InputText,
            Button,
            InputSwitch,
            TextEditor,
            FormInputShimmer,
            FormSwitchShimmer,
            vSelect
        },
        props: {
            editFlag: Boolean,
            userId: Number,
            errors: Object,
            roles: Array,
            userGroups: Array,
            title: ''
        },
        data() {
            return {
                editorUrl: window.CKEditorURL,
                form: {
                    first_name: '',
                    last_name: '',
                    user_name: '',
                    email: '',
                    role: '',
                    password: '',
                    is_active: true,
                    user_groups: []
                },
                formValidated: false,
                loading: false,
            }
        },
        methods: {
            submitForm() {
                this.editFlag ? this.update() : this.create();
            },
            create() {
                this.formValidated = true;
                this.$inertia.post(route('users.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('users.update', { id: this.userId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            fetch() {
                if(this.editFlag) {
                    let _this = this;
                    _this.loading = true;
                    axios.get(route('users.edit', { id: this.userId }))
                        .then(function (response) {
                            let data = response.data.user;
                            _this.form.first_name = data.first_name;
                            _this.form.last_name = data.last_name;
                            _this.form.user_name = data.user_name;
                            _this.form.email = data.email;
                            _this.form.role = data.role_id;
                            _this.form.is_active = data.is_active;

                            _this.form.user_groups = response.data.userGroups;
                        })
                        .catch(function (error) {
                            _this.loading = false;
                        })
                        .then(function () {
                            _this.loading = false;
                        });
                }
            }
        },
        mounted() {
            if(this.editFlag === true) {
                this.fetch();
            }
        }
    }
</script>
