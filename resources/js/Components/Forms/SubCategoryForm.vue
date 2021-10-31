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
            <!-- Sub Category Name -->
            <div class="w-full flex flex-col mb-6">
                <label for="name" class="pb-2 font-semibold text-gray-800">Sub Category Name</label>
                <InputText type="text"
                           id="name"
                           v-model="form.name"
                           placeholder="Enter Category Name" aria-describedby="name-help"
                           :class="[errors.name ? 'p-invalid' : '']"

                />
                <small id="name-help" v-if="errors.name" class="p-invalid">{{ errors.name }}</small>
            </div>

            <!-- Category -->
            <div class="w-full flex flex-col mb-6">
                <label for="category" class="pb-2 font-semibold text-gray-800">Category</label>
                <Dropdown id="category" v-model="form.category_id" :options="categories" :filter="true" optionLabel="name" optionValue="id" dataKey="id" placeholder="Select a Category" />
                <small id="category-help" v-if="errors.category_id" class="p-invalid">{{ errors.category_id }}</small>
            </div>

            <!-- Type -->
            <div class="w-full flex flex-col mb-6">
                <label for="type" class="pb-2 font-semibold text-gray-800">Type</label>
                <Dropdown id="type" v-model="form.sub_category_type_id" :options="types" :filter="true" optionLabel="name" optionValue="id" dataKey="id" placeholder="Select a Type" />
                <small id="type-help" v-if="errors.sub_category_type_id" class="p-invalid">{{ errors.sub_category_type_id }}</small>
            </div>

            <!-- Short Description -->
            <div class="w-full flex flex-col mb-6">
                <label for="short_description" class="pb-2 font-semibold text-gray-800">SEO Description</label>
                <Textarea id="short_description" v-model="form.short_description" :class="[errors.short_description ? 'p-invalid' : '']"></Textarea>
                <small id="short_description-help" v-if="errors.short_description" class="p-invalid">{{ errors.short_description }}</small>
            </div>

            <!-- Description -->
            <div class="w-full flex flex-col mb-6">
                <label for="description" class="pb-2 font-semibold text-gray-800">Description</label>
                <ckeditor id="description" :editor-url="editorUrl" v-model="form.description" :class="[errors.description ? 'p-invalid' : '']"></ckeditor>
                <small id="description-help" v-if="errors.description" class="p-invalid">{{ errors.description }}</small>
            </div>

            <!-- Status Switch -->
            <div class="w-full">
                <div class="flex justify-between items-center mb-8">
                    <div class="w-9/12">
                        <label for="is_active" class="font-semibold text-gray-800 pb-1" v-html="form.is_active ? 'Active' : 'In-active'"></label>
                        <p class="text-gray-500">Active (Shown Everywhere). In-active (Hidden Everywhere).</p>
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
    import Textarea from 'primevue/textarea';
    import CKEditor from 'ckeditor4-vue'
    import TextEditor from "@/Components/TextEditor";
    import Dropdown from 'primevue/dropdown';
    import InputNumber from 'primevue/inputnumber';
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
    export default {
        name: 'SubCategoryForm',
        components: {
            ckeditor: CKEditor.component,
            InputText,
            Button,
            InputSwitch,
            Textarea,
            TextEditor,
            Dropdown,
            InputNumber,
            FormInputShimmer,
            FormSwitchShimmer
        },
        props: {
            editFlag: Boolean,
            subCategoryId: Number,
            categories: Array,
            types: Array,
            errors: Object,
            title: ''
        },
        data() {
            return {
                editorUrl: window.CKEditorURL,
                form: {
                    name: '',
                    description: '',
                    category_id: '',
                    sub_category_type_id: '',
                    short_description: '',
                    is_active: true,
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
                this.$inertia.post(route('sub-categories.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('sub-categories.update', { id: this.subCategoryId }), this.form, {
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
                    axios.get(route('sub-categories.edit', { id: this.subCategoryId }))
                        .then(function (response) {
                            let data = response.data;
                            _this.form.name = data.name;
                            _this.form.category_id = data.category_id;
                            _this.form.sub_category_type_id = data.sub_category_type_id;
                            _this.form.short_description = data.short_description;
                            _this.form.description = data.description;
                            _this.form.is_private = data.is_private;
                            _this.form.is_active = data.is_active;
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
