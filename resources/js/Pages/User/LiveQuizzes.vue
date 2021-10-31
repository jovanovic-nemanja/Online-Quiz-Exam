<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Live Quizzes') }}</h4>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col items-center">
                    <div class="w-full sm:w-2/3">
                        <div class="flex justify-between items-center  mb-4">
                            <div class="relative inline-flex">
                              <h4 class="py-4 px-4 text-xl font-semibold leading-tight text-gray-800">Live Quizzes</h4>
                              <span class="flex absolute h-3 w-3 top-4 -right-1">
                                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-yellow-500 opacity-75"></span>
                                <span class="relative inline-flex rounded-full h-3 w-3 bg-yellow-500"></span>
                              </span>
                            </div>
                            <div class="px-4">
                                <span v-if="!loading && pagination" class="text-sm text-gray-500">{{ pagination.total }} schedules found</span>
                            </div>
                        </div>
                        <div v-if="loading" class="grid grid-cols-1 sm:grid-cols-2 gap-4 auto-rows-auto justify-center">
                            <quiz-schedule-card-shimmer></quiz-schedule-card-shimmer>
                            <quiz-schedule-card-shimmer></quiz-schedule-card-shimmer>
                            <quiz-schedule-card-shimmer></quiz-schedule-card-shimmer>
                            <quiz-schedule-card-shimmer></quiz-schedule-card-shimmer>
                        </div>
                        <div v-else class="grid grid-cols-1 sm:grid-cols-2 gap-4 px-4 mb-6">
                            <template v-for="(quiz, index) in schedules">
                                <quiz-schedule-card :quiz="quiz">
                                    <template #action>
                                        <inertia-link :href="route('quiz_schedule_instructions', {quiz: quiz.slug, schedule: quiz.code})">
                                            <span class="qt-btn qt-btn-sm qt-btn-success">Details</span>
                                        </inertia-link>
                                    </template>
                                </quiz-schedule-card>
                            </template>
                        </div>
                        <div class="mb-6" v-if="!loading && schedules.length === 0" >
                            <empty-student-card :title="'No Schedules Found'"></empty-student-card>
                        </div>
                        <div v-if="!loading && pagination && !(schedules.length === pagination.total)" class="flex justify-center items-center">
                            <button @click="loadMoreSchedules" class="qt-btn qt-btn-success flex items-center justify-center">
                                <span v-if="paginationLoading" class="text-sm"><i class="pi pi-spin pi-spinner mr-2"></i> Fetching</span>
                                <span v-else>Load More</span>
                            </button>
                        </div>
                        <div v-if="!loading && pagination && (pagination.total_pages === pagination.current_page)" class="flex text-sm justify-center items-center py-4">
                            No more schedules found for the selected criteria.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import QuizScheduleCard from "@/Components/Cards/QuizScheduleCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import QuizScheduleCardShimmer from "@/Components/Shimmers/QuizScheduleCardShimmer";

    export default {
        components: {
            QuizScheduleCard,
            EmptyStudentCard,
            AppLayout,
            QuizScheduleCardShimmer
        },
        data() {
            return {
                schedules: Object,
                pagination: Object,
                debounce: null,
                loading: false,
                paginationLoading: false,
            }
        },
        methods: {
            fetchSchedules() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_live_quizzes')).then(function (response) {
                    let data = response.data.schedules;
                    _this.schedules = data.data;
                    _this.pagination = data.meta.pagination;
                    _this.loading = false;
                })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            },
            loadMoreSchedules() {
                let _this = this;
                _this.paginationLoading = true;
                axios.get(this.pagination.links.next)
                    .then(function (response) {
                        let data = response.data.schedules.data;
                        _this.pagination = response.data.schedules.meta.pagination;
                        data.forEach((item) => _this.schedules.push(item));
                        _this.paginationLoading = false;
                    })
                    .catch(function (error) {
                        _this.paginationLoading = false;
                    });
            },
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return 'Live Quizzes - ' + this.$page.props.general.app_name;
            }
        },
        created() {
            this.fetchSchedules();
        }
    }
</script>
