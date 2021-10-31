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
            <!-- title -->
            <div class="w-full flex flex-col mb-6">
                <label for="title" class="pb-2 font-semibold text-gray-800">Comprehension Title</label>
                <InputText type="text" id="title" v-model="form.title" placeholder="Enter Comprehension Name" aria-describedby="name-help"
                           :class="[errors.title ? 'p-invalid' : '']"/>
                <small id="title-help" v-if="errors.title" class="p-invalid">{{ errors.title }}</small>
            </div>

            <!-- Body -->
            <div class="w-full flex flex-col mb-6">
                <label for="body" class="pb-2 font-semibold text-gray-800">Passage Body</label>
                <ckeditor id="body" :editor-url="editorUrl" v-model="form.body" :class="[errors.body ? 'p-invalid' : '']"></ckeditor>
                <small id="body-help" v-if="errors.body" class="p-invalid">{{ errors.body }}</small>
            </div>

            <!-- Is Active -->
            <div class="w-full">
                <div class="flex justify-between items-center mb-8">
                    <div class="w-9/12">
                        <label for="is_active" class="font-semibold text-gray-800 pb-1" v-html="form.is_active ? 'Active' : 'In-active'"></label>
                        <p class="text-sm text-gray-500">Active (Shown Everywhere). In-active (Hidden Everywhere).</p>
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
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
    export default {
        name: 'ComprehensionForm',
        components: {
            ckeditor: CKEditor.component,
            InputText,
            Button,
            InputSwitch,
            Textarea,
            TextEditor,
            FormInputShimmer,
            FormSwitchShimmer
        },
        props: {
            editFlag: Boolean,
            comprehensionId: Number,
            errors: Object,
            title: ''
        },
        data() {
            return {
                editorUrl: window.CKEditorURL,
                form: {
                    title: '',
                    body: '',
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
                this.$inertia.post(route('comprehensions.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('comprehensions.update', { id: this.comprehensionId }), this.form, {
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
                    axios.get(route('comprehensions.edit', { id: this.comprehensionId }))
                        .then(function (response) {
                            let data = response.data;
                            _this.form.title = data.title;
                            _this.form.body = data.body;
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
