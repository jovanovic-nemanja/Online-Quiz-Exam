<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">Question Details</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1">{{ questionType.name }} Question</p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>
        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="xl:w-8/12 w-full py-2 md:pb-0 md:px-6">
                            <form @submit.prevent="submitForm">
                                <div v-if="!editFlag" class="w-full flex flex-col mb-6">
                                    <label for="skill_id" class="pb-2 text-sm font-semibold text-gray-800">Skill</label>
                                    <v-select id="skill_id" v-model="$v.form.skill_id.$model" :options="skills" @search="searchSkills"
                                              :reduce="skill => skill.id" label="name" placeholder="Select a Skill"/>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.skill_id.$error && !$v.form.skill_id.required" role="alert" class="text-xs text-red-500 pt-2">Please select Skill</p>
                                    </div>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label for="question" class="pb-2 font-semibold text-gray-800 text-sm">Question</label>
                                    <ckeditor id="question" :editor-url="editorUrl" v-model="form.question" :class="[errors.question ? 'p-invalid' : '']"></ckeditor>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.question.$error && !$v.form.question.required" role="alert" class="text-xs text-red-500 pt-2">Question is required</p>
                                    </div>
                                </div>
                                <div class="w-full bg-green-50 rounded py-4 px-6">
                                    <div v-if="questionType.code === 'MSA'">
                                        <MSAOptions :parentOptions="form.options" :parentAnswer="form.correct_answer" v-on:modifyOptions="updateOptions" v-on:modifyAnswer="updateAnswer" />
                                    </div>
                                    <div v-if="questionType.code === 'PQ'">
                                        <PQOptions :parentOptions="form.options" :parentAnswer="form.correct_answer" v-on:modifyOptions="updateOptions" v-on:modifyAnswer="updateAnswer" />
                                    </div>
                                    <div v-if="questionType.code === 'MMA'">
                                        <MMAOptions :parentOptions="form.options" :parentAnswer="form.correct_answer" v-on:modifyOptions="updateOptions" v-on:modifyAnswer="updateAnswer" />
                                    </div>
                                    <div v-if="questionType.code === 'TOF'">
                                        <TOFOptions :parentOptions="form.options" :parentAnswer="form.correct_answer" v-on:modifyOptions="updateOptions" v-on:modifyAnswer="updateAnswer" />
                                    </div>
                                    <div v-if="questionType.code === 'ORD'">
                                        <ORDOptions :parentOptions="form.options" v-on:modifyOptions="updateOptions" />
                                    </div>
                                    <div v-if="questionType.code === 'MTF'">
                                        <MTFOptions :parentOptions="form.options" v-on:modifyOptions="updateOptions" />
                                    </div>
                                    <div v-if="questionType.code === 'SAQ'">
                                        <SAQOptions :parentOptions="form.options" :parentAnswer="form.correct_answer" v-on:modifyOptions="updateOptions" v-on:modifyAnswer="updateAnswer" />
<!--                                        <SAQPreferences class="mt-4" :parent-preferences="form.preferences" v-on:modifyPreferences="updatePreferences" />-->
                                    </div>
                                    <!--<div v-if="questionType.code === 'FIB'">
                                        <FIBOptions :parent-preferences="form.preferences" v-on:modifyPreferences="updatePreferences" />
                                    </div>-->
                                    <div v-if="questionType.code === 'LAQ'">
                                        <LAQOptions :parent-preferences="form.preferences" v-on:modifyPreferences="updatePreferences" />
                                    </div>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.options.$error && !$v.form.options.required" role="alert" class="text-xs text-red-500 pt-2">- Options should not be empty</p>
                                    </div>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.correct_answer.$error && !$v.form.correct_answer.required" role="alert" class="text-xs text-red-500 pt-2">- Please specify correct answer</p>
                                    </div>
                                </div>
                                <!-- Submit Button -->
                                <div class="w-full flex justify-end my-8">
                                    <button type="submit" class="qt-btn qt-btn-success" v-html="editFlag ? 'Update Details' : 'Save Details'"></button>
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
    import FIBOptions from "@/Components/Questions/FIBOptions";
    import SAQOptions from "@/Components/Questions/SAQOptions";
    import MTFOptions from "@/Components/Questions/MTFOptions";
    import ORDOptions from "@/Components/Questions/ORDOptions";
    import TOFOptions from "@/Components/Questions/TOFOptions";
    import MSAOptions from "@/Components/Questions/MSAOptions";
    import PQOptions from "@/Components/Questions/PQOptions";
    import MMAOptions from "@/Components/Questions/MMAOptions";
    import LAQOptions from "@/Components/Questions/LAQOptions";
    import SAQPreferences from "@/Components/Questions/SAQPreferences";
    import CKEditor from "ckeditor4-vue";
    import {numeric, required} from "vuelidate/lib/validators";
    import Button from "primevue/button";

    export default {
        components: {
            AdminLayout,
            HorizontalStepper,
            FIBOptions,
            SAQOptions,
            MTFOptions,
            ORDOptions,
            TOFOptions,
            MSAOptions,
            PQOptions,
            MMAOptions,
            ckeditor: CKEditor.component,
            SAQPreferences,
            LAQOptions,
            Button
        },
        props: {
            question: Object,
            steps: Array,
            questionType: Object,
            initialPreferences: Object|Array,
            initialOptions: Array,
            initialAnswers: Array|String,
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
                    question: this.editFlag ? this.question.question : '',
                    skill_id: this.editFlag ? this.question.skill_id : null,
                    question_type_id: this.editFlag ? this.question.question_type_id : this.questionType.id,
                    options: this.editFlag ? this.question.options : this.initialOptions,
                    correct_answer: this.editFlag ? this.question.correct_answer : this.initialAnswers,
                    preferences: this.editFlag ? this.question.preferences : this.initialPreferences,
                },
                skills: [],
                debounce: null,
                editorUrl: window.CKEditorURL,
                submitStatus: null,
            }
        },
        validations() {
            return {
                form: {
                    skill_id: {
                        required
                    },
                    ...this.editFlag && {
                        skill_id: {},
                    },
                    ...this.questionType.code === 'PQ' && {
                        skill_id: {},
                    },
                    question: {
                        required,
                    },
                    question_type_id: {
                        required
                    },
                    options: {
                        $each: {
                            option: {
                                required
                            }
                        }
                    },
                    ...this.questionType.code === 'MTF' && {
                        options: {
                            $each: {
                                option: {
                                    required
                                },
                                pair: {
                                    required
                                }
                            }
                        },
                    },
                    correct_answer: {
                        required
                    },
                    ...this.questionType.code === 'ORD' && {
                        correct_answer: {},
                    },
                    ...this.questionType.code === 'PQ' && {
                        correct_answer: {},
                    },
                    ...this.questionType.code === 'MTF' && {
                        correct_answer: {},
                    },
                    ...this.questionType.code === 'LAQ' && {
                        options: {},
                        correct_answer: {},
                    },
                    ...this.questionType.code === 'FIB' && {
                        options: {},
                        correct_answer: {},
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
                        this.editFlag ? this.update() : this.create();
                    }, 100)
                }
            },
            create() {
                this.formValidated = true;
                this.$inertia.post(route('questions.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('questions.update', { id: this.questionId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            updateOptions (value) {
                this.form.options = value;
            },
            updateAnswer (value) {
                this.form.correct_answer = value;
            },
            updatePreferences (value) {
                this.form.preferences = value;
            },
            searchSkills(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.skills = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_skills', {query: search}))
                            .then(function (response) {
                                _this.skills = response.data.skills;
                                loading(false);
                            })
                            .catch(function (error) {
                                loading(false);
                            });
                    }, 600)
                }
            },
        },
        computed: {
            title() {
                return 'Question Details - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
    }
</script>
