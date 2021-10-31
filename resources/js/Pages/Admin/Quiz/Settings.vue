<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">Quiz Settings</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1" v-html="editFlag ? quiz.title : 'New Quiz'"></p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>
        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="w-full py-6 md:pb-0 md:px-6">
                            <form @submit.prevent="submitForm">
                                <div class="flex flex-wrap">
                                    <div class="md:w-6/12 w-full py-8 md:pb-0 md:px-8 border-r border-gray-200">
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="auto_duration" class="font-semibold text-sm text-gray-800 pb-1">Duration Mode</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Auto</span> - Duration will be calculated based on questions' default time
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Manual</span> - Duration will be considered as specified
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="auto_duration" v-model="form.auto_duration" :options="autoModes"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div v-if="!form.auto_duration" class="w-full flex flex-col mb-6">
                                            <label for="total_duration" class="pb-2 text-sm font-semibold text-gray-800">Duration (In Minutes)<span class="ml-1 text-red-400">*</span></label>
                                            <InputNumber id="total_duration" v-model="$v.form.total_duration.$model" placeholder="Enter Duration (in Minutes)"
                                                         aria-describedby="total_duration-help" :disabled="form.enable_section_timer"/>
                                            <div class="form-control-errors">
                                                <p v-if="$v.form.total_duration.$error && !$v.form.total_duration.required" role="alert" class="text-xs text-red-500 pt-2">
                                                    Total Duration is required
                                                </p>
                                            </div>
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="auto_grading" class="font-semibold text-sm text-gray-800 pb-1">Marks/Points Mode</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Auto</span> - Marks/Points will be calculated based on questions' default marks
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Manual</span> - Marks/Points will be assigned to each question as specified
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="auto_grading" v-model="form.auto_grading" :options="autoModes"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div v-if="!form.auto_grading" class="w-full flex flex-col mb-6">
                                            <label for="correct_marks" class="pb-2 text-sm font-semibold text-gray-800">Marks for Correct Answer<span class="ml-1 text-red-400">*</span></label>
                                            <InputNumber id="correct_marks" v-model="$v.form.correct_marks.$model" placeholder="Enter Marks" mode="decimal"
                                                         :minFractionDigits="2" :maxFracionDigits="2" aria-describedby="correct_marks-help"/>
                                            <div class="form-control-errors">
                                                <p v-if="$v.form.correct_marks.$error && !$v.form.correct_marks.required" role="alert" class="text-xs text-red-500 pt-2">Total Marks is required</p>
                                            </div>
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="enable_negative_marking" class="font-semibold text-sm text-gray-800 pb-1">Negative Marking</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Negative marking will be considered as specified
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - No Negative marking
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="enable_negative_marking" v-model="form.enable_negative_marking" :options="choices"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div v-if="form.enable_negative_marking" class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="negative_marking_type" class="font-semibold text-sm text-gray-800 pb-1">Negative Marking Type</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Fixed</span> - Fixed amount will be deduct from question marks
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Percentage</span> - Percentage will be deduct from question marks
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="negative_marking_type" v-model="form.negative_marking_type" :options="amountTypes"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div v-if="form.enable_negative_marking" class="w-full flex flex-col mb-6">
                                            <label for="negative_marks" class="pb-2 text-sm font-semibold text-gray-800">Negative Marks for Wrong Answer<span class="ml-1 text-red-400">*</span></label>
                                            <InputNumber id="negative_marks" v-model="$v.form.negative_marks.$model" aria-describedby="negative_marks-help"
                                                         :placeholder="form.negative_marking_type === 'percentage' ? 'Enter Percentage' : 'Enter Number'"
                                                         :suffix="form.negative_marking_type === 'percentage' ? ' %' : ''" :max="100"
                                                         mode="decimal" :minFractionDigits="form.negative_marking_type === 'fixed' ? 2 : null"
                                                         :maxFracionDigits="form.negative_marking_type === 'fixed' ? 2 : null" />
                                            <div class="form-control-errors">
                                                <p v-if="$v.form.negative_marks.$error && !$v.form.negative_marks.required" role="alert" class="text-xs text-red-500 pt-2">
                                                    Negative Marks are required
                                                </p>
                                            </div>
                                        </div>
                                        <div class="w-full flex flex-col mb-6">
                                            <label for="cutoff" class="pb-2 text-sm font-semibold text-gray-800">Pass Percentage<span class="ml-1 text-red-400">*</span></label>
                                            <InputNumber id="cutoff" v-model="$v.form.cutoff.$model" placeholder="Enter Percentage" aria-describedby="cutoff-help"
                                                         suffix=" %" :max="100" />
                                            <div class="form-control-errors">
                                                <p v-if="$v.form.cutoff.$error && !$v.form.cutoff.required" role="alert" class="text-xs text-red-500 pt-2">
                                                    Pass Percentage is required
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="md:w-6/12 w-full py-8 md:pb-0 md:px-8">
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="restrict_attempts" class="font-semibold text-sm text-gray-800 pb-1">Restrict Attempts</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Attempts will be restricted as specified
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - Unlimited attempts
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="restrict_attempts" v-model="form.restrict_attempts" :options="choices"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div v-if="form.restrict_attempts" class="w-full flex flex-col mb-6">
                                            <label for="no_of_attempts" class="pb-2 text-sm font-semibold text-gray-800">Number of Attempts<span class="ml-1 text-red-400">*</span></label>
                                            <InputNumber id="no_of_attempts" v-model="$v.form.no_of_attempts.$model" placeholder="Enter Number" aria-describedby="no_of_attempts-help" />
                                            <div class="form-control-errors">
                                                <p v-if="$v.form.no_of_attempts.$error && !$v.form.no_of_attempts.required" role="alert" class="text-xs text-red-500 pt-2">
                                                    Number of Attempts is required
                                                </p>
                                            </div>
                                        </div>
                                        <!--<div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="disable_question_navigation" class="font-semibold text-sm text-gray-800 pb-1">Disable Question Navigation</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - User cannot be able to navigate questions
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - User can be able to navigate questions
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="disable_question_navigation" v-model="form.disable_question_navigation"
                                                          :options="choices" dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>-->
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="disable_finish_button" class="font-semibold text-sm text-gray-800 pb-1">Disable Finish Button</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Test Finish button will be disabled
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - Test Finish button will be displayed
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="disable_finish_button" v-model="form.disable_finish_button"
                                                          :options="choices" dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="list_questions" class="font-semibold text-sm text-gray-800 pb-1">Enable Question List View</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - User can be able to see all questions as list
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - User cannot be able to see all questions as list
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="list_questions" v-model="form.list_questions" :options="choices"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="hide_solutions" class="font-semibold text-sm text-gray-800 pb-1">Hide Solutions</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Solutions will not be shown in results
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - Solutions will be shown in results
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="hide_solutions" v-model="form.hide_solutions"
                                                          :options="choices" dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
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
    import QuizNavigation from "@/Components/Quizzes/QuizNavigation";
    import InputText from "primevue/inputtext";
    import InputNumber from "primevue/inputnumber";
    import SelectButton from "primevue/selectbutton";
    import RadioButton from "primevue/radiobutton";
    import Button from "primevue/button";
    import PopInfo from "@/Components/PopInfo";
    import {required} from "vuelidate/lib/validators";
    import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";
    export default {
        name: "Settings",
        components: {
            AdminLayout,
            QuizNavigation,
            InputText,
            InputNumber,
            SelectButton,
            RadioButton,
            PopInfo,
            Button,
            HorizontalStepper
        },
        props: {
            errors: Object,
            quiz: Object,
            steps: Array,
            editFlag: false,
            settings: Object,
        },
        data () {
            return {
                form: {
                    auto_duration: this.settings.auto_duration,
                    total_duration: this.settings.total_duration,
                    auto_grading: this.settings.auto_grading,
                    correct_marks: this.settings.correct_marks,
                    cutoff: this.settings.cutoff,
                    enable_negative_marking: this.settings.enable_negative_marking,
                    negative_marking_type: this.settings.negative_marking_type,
                    negative_marks: this.settings.negative_marks,
                    restrict_attempts: this.settings.restrict_attempts,
                    no_of_attempts: this.settings.no_of_attempts,
                    disable_question_navigation: this.settings.disable_question_navigation,
                    disable_finish_button: this.settings.disable_finish_button,
                    hide_solutions: this.settings.hide_solutions,
                    list_questions: this.settings.list_questions,
                },
                autoModes: [{name: 'Auto', code: true},{name: 'Manual', code: false}],
                choices: [{name: 'Yes', code: true},{name: 'No', code: false}],
                amountTypes: [{name: 'Fixed', code: 'fixed'},{name: 'Percentage', code: 'percentage'}],
                submitStatus: null,
            };
        },
        validations() {
            return {
                form: {
                    correct_marks: {},
                    total_duration: {},
                    negative_marks: {},
                    cutoff: {
                        required
                    },
                    ...!this.form.auto_grading && {
                        correct_marks: {
                            required
                        }
                    },
                    ...!this.form.auto_duration && {
                        total_duration: {
                            required
                        }
                    },
                    ...this.form.enable_negative_marking && {
                        negative_marks: {
                            required
                        }
                    },
                    no_of_attempts: {},
                    ...this.form.restrict_attempts && {
                        no_of_attempts: {
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
                return this.quiz.title+ ' (Settings) - ' + this.$page.props.general.app_name + ' Admin';
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
                this.$inertia.post(route('quizzes.settings.update', { quiz: this.quiz.id }), this.form, {
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
