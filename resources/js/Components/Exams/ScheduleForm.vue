<template>
    <div class="flex flex-wrap justify-center">
        <div class="md:w-6/12 w-full py-6 md:pb-0 md:px-6">
            <div class="w-full flex flex-col mb-6">
                <div class="flex gap-2">
                    <label class="pb-2  font-semibold text-gray-800">Schedule Type<span class="ml-1 text-red-400">*</span></label>
                    <pop-info>
                        <template #message>
                            <ul>
                                <li class=" text-gray-500">
                                    <span class="text-green-400 font-semibold">Yes</span> - If exam has multiple sections
                                </li>
                                <li class=" text-gray-500">
                                    <span class="text-green-400 font-semibold">No</span> - If exam doesn't have any sections
                                </li>
                            </ul>
                        </template>
                    </pop-info>
                </div>
                <div class="flex gap-4">
                    <div class="p-field-radiobutton" v-for="scheduleType in $store.state.exam.scheduleTypes">
                        <RadioButton @input="updateField('exam_pattern_id', parseInt($event))" :id="'schedule_type'+scheduleType.code" name="exam_type" :value="scheduleType.code"
                                     v-model="details.schedule_type" />
                        <label class=" text-gray-800" :for="'schedule_type'+scheduleType.code">{{ scheduleType.name }}</label>
                    </div>
                </div>
            </div>
            <div class="w-full flex flex-col mb-6">
                <label for="schedule_from" class="pb-2  font-semibold text-gray-800">Access Starts From</label>
                <Calendar id="schedule_from" v-model="details.schedule_from" :dateFormat="'dd M yy'" :locale="$store.state.exam.en" :minDate="minDate" :showTime="true"
                          @date-select="updateField('schedule_from', $event)" hourFormat="12" :manualInput="false" class="w-full" />
                <div class="form-control-errors">
                    <p v-if="$v.details.schedule_from.$error && !$v.details.schedule_from.required" role="alert" class="text-xs text-red-500 pt-2">
                        Access Start Date & Time is required
                    </p>
                </div>
            </div>
            <div v-if="details.schedule_type === 2" class="w-full flex flex-col mb-6">
                <label for="schedule_to" class="pb-2  font-semibold text-gray-800">Access Ends At</label>
                <Calendar id="schedule_to" v-model="details.schedule_to" :dateFormat="'dd M yy'" :locale="$store.state.exam.en" :minDate="minDate" :showTime="true"
                          @date-select="updateField('schedule_to', $event)" hourFormat="12" :manualInput="false" class="w-full" />
                <div class="form-control-errors">
                    <p v-if="$v.details.schedule_to.$error && !$v.details.schedule_to.required" role="alert" class="text-xs text-red-500 pt-2">
                        Access End Date & Time is required
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import InputText from 'primevue/inputtext';
    import RadioButton from 'primevue/radiobutton';
    import InputNumber from 'primevue/inputnumber';
    import SelectButton from 'primevue/selectbutton';
    import Calendar from 'primevue/calendar';
    import { required } from 'vuelidate/lib/validators';
    import PopInfo from "@/Components/PopInfo";
    import {mapActions} from "vuex";
    export default {
        name: 'ScheduleForm',
        components: {
            InputText,
            InputNumber,
            SelectButton,
            RadioButton,
            Calendar,
            PopInfo
        },
        props: {
           errors: Object,
        },
        data () {
            return {
                details: this.$store.state.exam.details,
                users: this.$store.state.exam.users,
            };
        },
        validations() {
            return {
                details: {
                    schedule_from: {
                        required
                    },
                    schedule_to: {},
                    ...this.details.schedule_type === 2 && {
                        schedule_to: {
                            required
                        }
                    }
                }
            }
        },
        computed: {
            minDate() {
                return new Date();
            }
        },
        methods: {
            updateField(field, value) {
                this.$store.commit('UPDATE_DETAILS', {[field]: value});
            },
            validate() {
                this.$v.details.schedule_from.$touch();
                this.$v.details.schedule_to.$touch();
                return !(this.$v.details.schedule_from.$error || this.$v.details.schedule_to.$error);
            },
        }
    }
</script>
