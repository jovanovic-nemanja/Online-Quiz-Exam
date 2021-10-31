<template>
    <div class="h-screen overflow-y-auto">
        <div class="bg-gray-100 py-4 lg:py-4 rounded">
            <div class="container px-6 mx-auto flex flex-col md:flex-row items-start md:items-center justify-between">
                <div>
                    <h4 class="text-base font-semibold leading-tight text-gray-800">
                        {{ title }}
                    </h4>
                </div>
            </div>
        </div>
        <form class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0" @submit.prevent="submitForm">
            <div class="w-full flex flex-col mb-6">
                <label for="section_id" class="pb-2 text-sm font-semibold text-gray-800">Section<span class="ml-1 text-red-400">*</span></label>
                <Dropdown id="section_id" v-model="form.section_id" :options="sectionData" :filter="true" @filter="searchSections($event.value)"
                          filterPlaceholder="Type & Search" :showClear="true" optionLabel="name" optionValue="id" dataKey="id" placeholder="Search Section"/>
                <div class="form-control-errors">
                    <p v-if="$v.form.section_id.$error && !$v.form.section_id.required" role="alert" class="text-xs text-red-500 pt-2">Please choose section.</p>
                </div>
            </div>
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
                <label for="total_duration" class="pb-2 text-sm font-semibold text-gray-800">Section Duration<span class="ml-1 text-red-400">*</span></label>
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
                                    <span class="text-green-400 font-semibold">Manual</span> - Marks/Points will be assigned to all the questions equally as specified
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
            <div class="w-full flex justify-between items-center mb-6">
                <div class="flex gap-2">
                    <label for="enable_section_cutoff" class="font-semibold text-sm text-gray-800 pb-1">Enable Section Pass %</label>
                    <pop-info>
                        <template #message>
                            <ul>
                                <li class="text-sm text-gray-500">
                                    <span class="text-green-400 font-semibold">Yes</span> - Section navigation will be disabled. Section Duration is Mandatory
                                </li>
                                <li class="text-sm text-gray-500">
                                    <span class="text-green-400 font-semibold">No</span> - Test taker can be able navigate sections.
                                </li>
                            </ul>
                        </template>
                    </pop-info>
                </div>
                <SelectButton id="enable_section_cutoff" v-model="form.enable_section_cutoff" :options="choices"
                              dataKey="code" optionValue="code" optionLabel="name" />
            </div>
            <div v-if="form.enable_section_cutoff" class="w-full flex flex-col mb-6">
                <label for="section_cutoff" class="pb-2 text-sm font-semibold text-gray-800">Section Pass Percentage<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="section_cutoff" v-model="$v.form.section_cutoff.$model" placeholder="Enter Percentage" aria-describedby="section_cutoff-help"
                             suffix=" %" :max="100" />
                <div class="form-control-errors">
                    <p v-if="$v.form.section_cutoff.$error && !$v.form.section_cutoff.required" role="alert" class="text-xs text-red-500 pt-2">
                        Section Pass Percentage are required
                    </p>
                </div>
            </div>
            <div class="w-full flex justify-between items-center mb-6">
                <div class="flex gap-2">
                    <label for="assign_examiner" class="font-semibold text-sm text-gray-800 pb-1">Assign Examiner</label>
                    <pop-info>
                        <template #message>
                            <ul>
                                <li class="text-sm text-gray-500">
                                    <span class="text-green-400 font-semibold">Yes</span> - Examiner will be assigned to set questions and to evaluate
                                </li>
                            </ul>
                        </template>
                    </pop-info>
                </div>
                <SelectButton id="assign_examiner" v-model="form.assign_examiner" :options="choices"
                              dataKey="code" optionValue="code" optionLabel="name" />
            </div>
            <div class="w-full flex">
                <Button type="submit" :label="editFlag ? 'Update' : 'Add'" />
            </div>
        </form>
    </div>
</template>
<script>
    import InputText from 'primevue/inputtext';
    import Dropdown from 'primevue/dropdown';
    import Button from 'primevue/button';
    import InputSwitch from 'primevue/inputswitch';
    import {required} from "vuelidate/lib/validators";
    import InputNumber from "primevue/inputnumber";
    import SelectButton from "primevue/selectbutton";
    import RadioButton from "primevue/radiobutton";
    import PopInfo from "@/Components/PopInfo";
    export default {
        name: 'SectionForm',
        components: {
            InputText,
            Dropdown,
            Button,
            InputSwitch,
            InputNumber,
            SelectButton,
            RadioButton,
            PopInfo,
        },
        props: {
            editFlag: Boolean,
            examId: Number,
            sectionId: Number,
            errors: Object,
            title: ''
        },
        data() {
            return {
                form: {
                    section_id: '',
                    auto_duration: true,
                    total_duration: 0,
                    auto_grading: true,
                    correct_marks: null,
                    enable_section_cutoff: false,
                    section_cutoff: null,
                    enable_negative_marking: false,
                    negative_marking_type: 'fixed',
                    negative_marks: null,
                    section_order: 1,
                    assign_examiner: false,
                    examiner_id: null
                },
                sectionData: [],
                autoModes: [{name: 'Auto', code: true},{name: 'Manual', code: false}],
                choices: [{name: 'Yes', code: true},{name: 'No', code: false}],
                amountTypes: [{name: 'Fixed', code: 'fixed'},{name: 'Percentage', code: 'percentage'}],
                selectedSection: null,
                debounce: null,
                submitStatus: null,
                formValidated: false,
            }
        },
        validations() {
            return {
                form: {
                    section_id: {
                        required
                    },
                    correct_marks: {},
                    total_duration: {},
                    negative_marks: {},
                    section_cutoff: {},
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
                    ...this.form.enable_section_cutoff && {
                        section_cutoff: {
                            required
                        }
                    }
                }
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
                        this.editFlag ? this.update() : this.create();
                    }, 100)
                }
            },
            create() {
                this.formValidated = true;
                this.$inertia.post(route('exams.sections.store', { exam: this.examId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('exams.sections.update', { exam: this.examId, section: this.sectionId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            searchSections(query) {
                let _this = this;
                clearTimeout(this.debounce);
                this.sectionData = [];
                this.debounce = setTimeout(() => {
                    axios.get(route('search_sections', {query: query}))
                        .then(function (response) {
                            _this.sectionData = response.data.sections;
                        })
                        .catch(function (error) {
                        })
                        .then(function () {
                            // always executed
                        });
                }, 600)
            },
            fetch() {
                if(this.editFlag) {
                    let _this = this;
                    axios.get(route('exams.sections.edit', { exam: this.examId, section: this.sectionId }))
                        .then(function (response) {
                            let data = response.data;
                            _this.sectionData.push(data.section.section);
                            _this.form.section_id = data.section.section_id;
                            _this.form.auto_duration = data.section.auto_duration;
                            _this.form.total_duration = data.section.total_duration;
                            _this.form.auto_grading = data.section.auto_grading;
                            _this.form.correct_marks = data.section.correct_marks;
                            _this.form.enable_section_cutoff = data.section.enable_section_cutoff;
                            _this.form.section_cutoff = data.section.section_cutoff;
                            _this.form.enable_negative_marking = data.section.enable_negative_marking;
                            _this.form.negative_marking_type = data.section.negative_marking_type;
                            _this.form.negative_marks = data.section.negative_marks;
                            _this.form.section_order = data.section.section_order;
                            _this.form.assign_examiner = data.section.assign_examiner;
                            _this.form.examiner_id = data.section.examiner_id;
                        })
                        .catch(function (error) {
                            // handle error
                            console.log(error);
                        })
                        .then(function () {
                            // always executed
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
