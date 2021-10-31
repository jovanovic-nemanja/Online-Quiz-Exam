<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">Question Solution</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1">{{ questionType.name }} Question</p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>
        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="md:w-8/12 w-full py-6 md:pb-0 md:px-6">
                            <form @submit.prevent="submitForm">
                                <div class="w-full flex flex-col mb-6">
                                    <label for="solution" class="pb-2 font-semibold text-gray-800">Solution</label>
                                    <ckeditor id="solution" :editor-url="editorUrl" v-model="form.solution" :class="[errors.solution ? 'p-invalid' : '']"></ckeditor>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label for="hint" class="pb-2 font-semibold text-gray-800">Hint</label>
                                    <ckeditor id="hint" :editor-url="editorUrl" v-model="form.hint" :class="[errors.hint ? 'p-invalid' : '']"></ckeditor>
                                </div>
                                <!-- Submit Button -->
                                <div class="w-full flex justify-end my-8">
                                    <Button type="submit" :label="editFlag ? 'Update Solution' : 'Save Solution'" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </admin-layout>
</template>
<script>
    import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";
    import AdminLayout from "@/Layouts/AdminLayout";
    import {numeric, required, maxLength} from "vuelidate/lib/validators";
    import CKEditor from "ckeditor4-vue";
    import Button from "primevue/button";

    export default {
        components: {
            AdminLayout,
            HorizontalStepper,
            ckeditor: CKEditor.component,
            Button
        },
        props: {
            question: Object,
            steps: Array,
            questionType: Object,
            editFlag: false,
            questionId: Number,
            errors: Object
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        data() {
            return {
                form: {
                    solution: this.editFlag ? this.question.solution : '',
                    hint: this.editFlag ? this.question.hint : '',
                },
                debounce: null,
                editorUrl: window.CKEditorURL,
                submitStatus: null,
            }
        },
        validations() {
            return {
                form: {
                    hint: {
                        maxLength: maxLength(10000),
                    },
                    solution: {
                        maxLength: maxLength(10000),
                    },
                }
            }
        },
        methods: {
            submitForm() {
                this.$v.$touch();
                if (this.$v.$invalid) {
                    this.submitStatus = 'ERROR';
                } else {
                    this.submitStatus = 'PENDING';
                    setTimeout(() => {
                        this.submitStatus = 'OK';
                        this.update();
                    }, 100)
                }
            },
            update() {
                this.formValidated = true;
                this.$inertia.post(route('update_question_solution', { id: this.questionId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
        },
        computed: {
            title() {
                return 'Question Solution - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
    }
</script>
