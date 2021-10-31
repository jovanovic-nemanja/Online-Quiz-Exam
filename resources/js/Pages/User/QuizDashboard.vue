<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Quizzes') }}</h4>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col items-center">
                    <div class="w-full sm:w-2/3">
                        <div class="flex justify-between items-center mb-4">
                            <div class="relative inline-flex">
                              <h4 class="py-4 px-4 text-xl font-semibold leading-tight text-gray-800">Live Quizzes</h4>
                              <span class="flex absolute h-3 w-3 top-4 -right-1">
                                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-yellow-500 opacity-75"></span>
                                <span class="relative inline-flex rounded-full h-3 w-3 bg-yellow-500"></span>
                              </span>
                            </div>
                            <inertia-link class="px-4" :href="route('live_quizzes')">
                                <span class="text-sm font-semibold text-green-500 underline">View All</span>
                            </inertia-link>
                        </div>
                        <div v-if="quizSchedules.length > 0" class="grid grid-cols-1 sm:grid-cols-2 gap-4 px-4 mb-6">
                            <template v-for="(quiz, index) in quizSchedules">
                                <quiz-schedule-card :quiz="quiz">
                                    <template #action>
                                        <inertia-link :href="route('quiz_schedule_instructions', {quiz: quiz.slug, schedule: quiz.code})">
                                            <span class="qt-btn qt-btn-sm qt-btn-success">Details</span>
                                        </inertia-link>
                                    </template>
                                </quiz-schedule-card>
                            </template>
                        </div>
                        <div class="mb-6" v-else>
                            <empty-student-card :title="'No Schedules Found'"></empty-student-card>
                        </div>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div class="mb-6" v-for="quizType in quizTypes">
                                <div class="flex justify-between items-center mb-4">
                                    <h4 class="py-4 px-4 text-xl font-semibold leading-tight text-gray-800">{{ quizType.name }}</h4>
                                    <inertia-link class="px-4" :href="route('quizzes_by_type', { type: quizType.slug })">
                                        <span class="text-sm font-semibold text-green-500 underline">View All</span>
                                    </inertia-link>
                                </div>
                                <div v-if="quizType.latest_quiz" class="flex flex-col gap-4 justify-center px-4">
                                    <quiz-card :quiz="quizType.latest_quiz">
                                        <template #action>
                                            <inertia-link :href="route('quiz_instructions', {slug: quizType.latest_quiz.slug})">
                                                <span class="qt-btn qt-btn-sm qt-btn-success">Details</span>
                                            </inertia-link>
                                        </template>
                                    </quiz-card>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import QuizCard from "@/Components/Cards/QuizCard";
    import QuizScheduleCard from "@/Components/Cards/QuizScheduleCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";

    export default {
        components: {
            QuizScheduleCard,
            EmptyStudentCard,
            AppLayout,
            QuizCard
        },
        props: {
            quizTypes: Array,
            quizSchedules: Array,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return 'Quiz Dashboard - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
