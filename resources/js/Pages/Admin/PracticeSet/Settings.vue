<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">Practice Set Settings</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1" v-html="editFlag ? practiceSet.title : 'New Practice Set'"></p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>
        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="md:w-8/12 w-full py-6 md:pb-0 md:px-6">
                            <form class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0" @submit.prevent="submitForm">
                                <div class="w-full flex justify-between items-center mb-6">
                                    <div class="flex gap-2">
                                        <label for="auto_grading" class="font-semibold text-sm text-gray-800 pb-1">Points Mode</label>
                                        <pop-info>
                                            <template #message>
                                                <ul>
                                                    <li class="text-sm text-gray-500">
                                                        <span class="text-green-400 font-semibold">Auto</span> - Points will be assigned based on question's default marks
                                                    </li>
                                                    <li class="text-sm text-gray-500">
                                                        <span class="text-green-400 font-semibold">Manual</span> - Points will be assigned to each correct answered question as specified
                                                    </li>
                                                </ul>
                                            </template>
                                        </pop-info>
                                    </div>
                                    <SelectButton id="auto_grading" v-model="form.auto_grading" :options="autoModes"
                                                  dataKey="code" optionValue="code" optionLabel="name" />
                                </div>
                                <div v-if="!form.auto_grading" class="w-full flex flex-col mb-6">
                                    <label for="correct_marks" class="pb-2 text-sm font-semibold text-gray-800">Points for Correct Answer<span class="ml-1 text-red-400">*</span></label>
                                    <InputNumber id="correct_marks" v-model="$v.form.correct_marks.$model" placeholder="Enter Marks" aria-describedby="correct_marks-help"/>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.correct_marks.$error && !$v.form.correct_marks.required" role="alert"
                                           class="text-xs text-red-500 pt-2">Please enter correct marks</p>
                                    </div>
                                </div>
                                <div class="w-full flex justify-end my-8">
                                    <button type="submit" class="qt-btn qt-btn-success" v-html="editFlag ? 'Update Settings' : 'Save settings'"></button>
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
    import AdminLayout from "@/Layouts/AdminLayout";
    import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";
    import Button from "primevue/button";
    import InputNumber from "primevue/inputnumber";
    import PopInfo from "@/Components/PopInfo";
    import SelectButton from "primevue/selectbutton";
    import { required } from 'vuelidate/lib/validators';
    export default {
        name: 'Settings',
        components: {
            AdminLayout,
            HorizontalStepper,
            Button,
            InputNumber,
            PopInfo,
            SelectButton
        },
        props: {
            practiceSet: Object,
            steps: Array,
            editFlag: {
                type: Boolean,
                default: false
            },
            practiceSetId: Number,
            errors: Object
        },
        data () {
            return {
                form: {
                    auto_grading: this.editFlag ? this.practiceSet.auto_grading : true,
                    correct_marks: this.editFlag ? this.practiceSet.correct_marks : 1,
                },
                autoModes: [{name: 'Auto', code: true},{name: 'Manual', code: false}],
                debounce: null,
                submitStatus: null
            };
        },
        validations() {
            return {
                form: {
                    correct_marks: {},
                    ...!this.form.auto_grading && {
                        correct_marks: {
                            required
                        }
                    },
                }
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return 'Practice Set Settings - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
        methods: {
            submitForm() {
                this.$v.$touch()
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
                this.$inertia.post(route('practice-sets.settings.update', { id: this.practiceSet.id }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
        }
    }
</script>
