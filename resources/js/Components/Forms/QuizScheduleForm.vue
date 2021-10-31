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
            <div class="w-full flex flex-col mb-6">
                <label class="pb-2 text-sm font-semibold text-gray-800">Schedule Type<span class="ml-1 text-red-400">*</span></label>
                <div class="flex flex-col sm:flex-row gap-4">
                    <div class="p-field-radiobutton" v-for="scheduleType in scheduleTypes">
                        <RadioButton :id="'schedule_type'+scheduleType.code" name="schedule_type" :value="scheduleType.code"
                                     v-model="form.schedule_type" :disabled="editFlag" />
                        <label class="text-sm text-gray-800" :for="'schedule_type'+scheduleType.code">{{ scheduleType.name }}</label>
                    </div>
                </div>
            </div>
            <div class="flex gap-2">
                <div class="w-full flex flex-col mb-6">
                    <label for="start_date" class="pb-2 font-semibold text-gray-800">Start Date</label>
                    <VueCtkDateTimePicker id="start_date" :label="'Select Start Date'" v-model="form.start_date" :only-date="true" :formatted="'MMMM Do YYYY'" :format="'YYYY-MM-DD'"
                                          :no-label="true" :min-date="minDate" :no-header="true" :class="[errors.start_date ? 'p-invalid' : '']" :disabled="disableFlag"/>
                    <small id="start_date-help" v-if="errors.start_date" class="p-invalid">{{ errors.start_date }}</small>
                </div>
                <div class="w-full flex flex-col mb-6">
                    <label for="start_time" class="pb-2 font-semibold text-gray-800">Start Time</label>
                    <VueCtkDateTimePicker id="start_time" :label="'Select Start Time'" v-model="form.start_time" :only-time="true" :formatted="'HH:mm'" :format="'HH:mm:ss'"
                                          :no-label="true" :no-header="true" :minute-interval="5" :class="[errors.start_time ? 'p-invalid' : '']" :disabled="disableFlag" />
                    <small id="start_time-help" v-if="errors.start_time" class="p-invalid">{{ errors.start_time }}</small>
                </div>
            </div>
            <div v-if="form.schedule_type === 'flexible'" class="flex gap-2">
                <div class="w-full flex flex-col mb-6">
                    <label for="end_date" class="pb-2 font-semibold text-gray-800">End Date</label>
                    <VueCtkDateTimePicker id="end_date" :label="'Select End Date'" v-model="form.end_date" :only-date="true" :formatted="'MMMM Do YYYY'" :format="'YYYY-MM-DD'"
                                          :no-label="true" :min-date="minDate" :no-header="true" :class="[errors.end_date ? 'p-invalid' : '']" :disabled="disableFlag"/>
                    <small id="ends_at-help" v-if="errors.end_date" class="p-invalid">{{ errors.end_date }}</small>
                </div>
                <div class="w-full flex flex-col mb-6">
                    <label for="end_time" class="pb-2 font-semibold text-gray-800">End Time</label>
                    <VueCtkDateTimePicker id="end_time" :label="'Select End Time'" v-model="form.end_time" :only-time="true" :formatted="'HH:mm'" :format="'HH:mm:ss'"
                                          :no-label="true" :no-header="true" :minute-interval="5" :class="[errors.end_time ? 'p-invalid' : '']" :disabled="disableFlag"/>
                    <small id="end_time-help" v-if="errors.end_time" class="p-invalid">{{ errors.end_time }}</small>
                </div>
            </div>
            <div v-if="form.schedule_type === 'fixed'" class="w-full flex flex-col mb-6">
                <label for="grace_period" class="pb-2 font-semibold text-gray-800">Grace Period to Join (in Minutes)</label>
                <InputNumber id="grace_period" v-model="form.grace_period" placeholder="Enter Grace Period" aria-describedby="grace_period-help"
                           :class="[errors.grace_period ? 'p-invalid' : '']" :disabled="disableFlag"/>
                <small id="grace_period-help" v-if="errors.grace_period" class="p-invalid">{{ errors.grace_period }}</small>
            </div>
            <div class="w-full flex flex-col mb-6">
                <label for="users" class="pb-2 font-semibold text-gray-800">Schedule to User Groups</label>
                <v-select multiple id="users" v-model="form.user_groups" :options="userGroups" :reduce="group => group.id" label="name" :disabled="disableFlag"/>
                <small id="users-help" v-if="errors.user_groups" class="p-invalid">{{ errors.user_groups }}</small>
            </div>
            <div v-if="editFlag" class="w-full flex flex-col mb-6">
                <label for="status" class="pb-2 font-semibold text-gray-800">Status</label>
                <Dropdown id="status" v-model="form.status" :options="quizStatus" optionLabel="name" optionValue="code" dataKey="code"
                          placeholder="Select Status" :disabled="disableFlag" />
                <small id="status-help" v-if="errors.status" class="p-invalid">{{ errors.status }}</small>
            </div>
            <small id="expire-note" v-if="disableFlag" class="text-sm text-red-400">You can't update once quiz schedule starts or expired. Please create a new schedule.</small>
            <div v-if="!disableFlag" class="w-full flex">
                <Button type="submit" :label="editFlag ? 'Update' : 'Create'" />
            </div>
        </form>
    </div>
</template>
<script>
    import InputText from 'primevue/inputtext';
    import InputNumber from 'primevue/inputnumber';
    import Dropdown from 'primevue/dropdown';
    import RadioButton from 'primevue/radiobutton';
    import Button from 'primevue/button';
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
    import vSelect from "vue-select";

    export default {
        name: 'QuizScheduleForm',
        components: {
            InputText,
            InputNumber,
            Dropdown,
            Button,
            FormInputShimmer,
            FormSwitchShimmer,
            vSelect,
            RadioButton
        },
        props: {
            editFlag: Boolean,
            quizScheduleId: Number,
            quizId: Number,
            userGroups: Array,
            errors: Object,
            title: ''
        },
        data() {
            return {
                form: {
                    quiz_id: this.quizId,
                    schedule_type: 'fixed',
                    start_date: '',
                    end_date: '',
                    start_time: '',
                    end_time: '',
                    grace_period: 5,
                    status: 'active',
                    user_groups: []
                },
                quizzes: [],
                disableFlag: false,
                scheduleTypes: [
                    {name: 'Fixed', code: 'fixed'},
                    {name: 'Flexible', code: 'flexible'},
                ],
                quizStatus: [
                    {name: 'Active', code: 'active'},
                    {name: 'Expired', code: 'expired'},
                    {name: 'Cancelled', code: 'cancelled'},
                ],
                minDate: new Date().toISOString().slice(0,10),
                formValidated: false,
                loading: false,
                debounce: null,
            }
        },
        methods: {
            submitForm() {
                this.editFlag ? this.update() : this.create();
            },
            create() {
                this.formValidated = true;
                this.$inertia.post(route('quizzes.schedules.store', { quiz: this.quizId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('quizzes.schedules.update', { quiz: this.quizId, schedule: this.quizScheduleId }), this.form, {
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
                    axios.get(route('quizzes.schedules.edit', { quiz: this.quizId, schedule: this.quizScheduleId }))
                        .then(function (response) {
                            let data = response.data.schedule;
                            _this.form.schedule_type = data.schedule_type;
                            _this.form.start_date = data.start_date;
                            _this.form.start_time = data.start_time;
                            _this.form.end_date = data.end_date;
                            _this.form.end_time = data.end_time;
                            _this.form.grace_period = data.grace_period;
                            _this.form.status = data.status;

                            _this.form.user_groups = response.data.userGroups;
                            _this.disableFlag = response.data.disableFlag;
                        })
                        .catch(function (error) {
                            _this.loading = false;
                        })
                        .then(function () {
                            _this.loading = false;
                        });
                }
            },
        },
        mounted() {
            if(this.editFlag === true) {
                this.fetch();
            }
        }
    }
</script>
