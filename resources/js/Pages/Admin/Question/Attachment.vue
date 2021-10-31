<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">Question Attachment</h2>
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
                                    <div class="flex gap-2 mb-2">
                                        <label for="has_attachment" class="font-semibold text-sm text-gray-800 pb-1">Enable Question Attachment</label>
                                    </div>
                                    <SelectButton id="has_attachment" v-model="form.has_attachment" :options="choices"
                                                  dataKey="code" optionValue="code" optionLabel="name" />
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label class="pb-2 text-sm font-semibold text-gray-800">Select Attachment Type (Anyone)</label>
                                    <div class="flex gap-4 items-center my-2">
                                        <div v-for="attachment in attachmentTypes" :key="attachment.id" class="p-field-radiobutton">
                                            <RadioButton @input="attachmentTypeChanged($event)" :id="attachment.id" name="attachment_type" :value="attachment.id" v-model="form.attachment_type" />
                                            <label class="custom-control-label" :for="attachment.id">{{ attachment.name }}</label>
                                        </div>
                                    </div>
                                </div>
                                <div v-if="form.has_attachment" class="w-full">
                                    <div class="mb-4" v-if="form.has_attachment && form.attachment_type === 'comprehension'">
                                        <ComprehensionOptions :parent-comprehensions="initialComprehensions" :parent-comprehension-id="form.comprehension_id" v-on:modifyComprehension="updateComprehension" />
                                    </div>
                                    <div class="mb-4" v-if="form.has_attachment && form.attachment_type === 'audio'">
                                        <AudioOptions :parentOptions="form.attachment_options" v-on:modifyOptions="updateAudioOptions" />
                                    </div>
                                    <div class="mb-4" v-if="form.has_attachment && form.attachment_type === 'video'">
                                        <VideoOptions :parentOptions="form.attachment_options" v-on:modifyOptions="updateVideoOptions" />
                                    </div>
                                </div>
                                <div v-if="form.has_attachment && form.attachment_type === 'comprehension'" class="form-control-errors">
                                    <p v-if="$v.form.comprehension_id.$error && !$v.form.comprehension_id.required" role="alert" class="text-xs text-red-500 pt-2">Please choose Comprehension.</p>
                                </div>
                                <div v-if="form.has_attachment && form.attachment_type === 'video'" class="form-control-errors">
                                    <p v-if="$v.form.attachment_options.link.$error && !$v.form.attachment_options.link.required" role="alert" class="text-xs text-red-500 pt-2">Video link is required.</p>
                                </div>
                                <div v-if="form.has_attachment && form.attachment_type === 'audio'" class="form-control-errors">
                                    <p v-if="$v.form.attachment_options.link.$error && !$v.form.attachment_options.link.required" role="alert" class="text-xs text-red-500 pt-2">Audio link is required.</p>
                                </div>
                                <!-- Submit Button -->
                                <div class="w-full flex justify-end my-8">
                                    <Button type="submit" :label="editFlag ? 'Update Details' : 'Save Details'" />
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
    import {numeric, required} from "vuelidate/lib/validators";
    import ComprehensionOptions from "@/Components/Questions/ComprehensionOptions";
    import VideoOptions from "@/Components/Questions/VideoOptions";
    import AudioOptions from "@/Components/Questions/AudioOptions";
    import Button from "primevue/button";
    import RadioButton from "primevue/radiobutton";
    import SelectButton from "primevue/selectbutton";

    export default {
        components: {
            AdminLayout,
            HorizontalStepper,
            ComprehensionOptions,
            VideoOptions,
            AudioOptions,
            Button,
            RadioButton,
            SelectButton
        },
        props: {
            question: Object,
            steps: Array,
            questionType: Object,
            editFlag: false,
            questionId: Number,
            errors: Object,
            initialComprehensions: Array,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        data() {
            return {
                form: {
                    has_attachment: this.editFlag ? this.question.has_attachment : false,
                    attachment_type: this.editFlag ? this.question.attachment_type : '',
                    comprehension_id: this.editFlag ? this.question.comprehension_passage_id : null,
                    attachment_options: this.editFlag ? this.question.attachment_options : null,
                },
                attachmentTypes: [
                    { id: 'comprehension', name: 'Comprehension Passage'},
                    { id: 'audio', name: 'Audio'},
                    { id: 'video', name: 'Video'},
                ],
                choices: [{name: 'Yes', code: true},{name: 'No', code: false}],
                debounce: null,
                editorUrl: window.CKEditorURL,
                submitStatus: null,
            }
        },
        validations() {
            return {
                form: {
                    ...(this.form.has_attachment && this.form.attachment_type === 'comprehension') && {
                        comprehension_id: {
                            required
                        },
                    },
                    ...(this.form.has_attachment && this.form.attachment_type === 'audio') && {
                        attachment_options: {
                            link: {
                                required
                            }
                        },
                    },
                    ...(this.form.has_attachment && this.form.attachment_type === 'video') && {
                        attachment_options: {
                            link: {
                                required
                            }
                        },
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
                this.$inertia.post(route('update_question_attachment', { id: this.questionId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            attachmentTypeChanged(value) {
                if(value === 'video') {
                    this.form.attachment_options = {video_type: 'mp4', link: ''};
                }

                if(value === 'audio') {
                    this.form.attachment_options = {audio_type: 'mp3', link: ''};
                }
            },
            updateAudioOptions(value) {
                this.form.attachment_options = value;
            },
            updateVideoOptions(value) {
                this.form.attachment_options = value;
            },
            updateComprehension(value) {
                this.form.comprehension_id = value;
            },
        },
        computed: {
            title() {
                return 'Question Attachment - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
    }
</script>
