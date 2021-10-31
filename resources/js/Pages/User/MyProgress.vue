<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">{{ __('My Progress') }}</h4>
        </template>
        <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
            <progress-navigator :steps="steps"></progress-navigator>
        </div>
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col items-center">
                <div class="w-full sm:w-2/3">
                    <div class="flex">
                        <div class="relative inline-flex">
                            <h4 class="py-4 px-4 text-xl font-semibold leading-tight text-gray-800 mb-4">In-completed Quizzes</h4>
                        </div>
                    </div>
                    <div v-if="quizSessions.length > 0" class="grid grid-cols-1 sm:grid-cols-2 gap-4 px-4 mb-6">
                        <template v-for="(quizSession, index) in quizSessions">
                            <quiz-session-card :quiz-session="quizSession" :key="quizSession.code">
                                <template #action>
                                    <inertia-link v-if="quizSession.quizSchedule === null" :href="route('init_quiz', {slug: quizSession.slug})">
                                        <span class="qt-btn qt-btn-sm qt-btn-success">Resume Quiz</span>
                                    </inertia-link>
                                    <inertia-link v-else :href="route('init_quiz_schedule', {quiz: quizSession.slug, schedule: quizSession.quizSchedule})">
                                        <span class="qt-btn qt-btn-sm qt-btn-success">Resume Quiz</span>
                                    </inertia-link>
                                </template>
                            </quiz-session-card>
                        </template>
                    </div>
                    <div class="mb-6" v-else>
                        <empty-student-card :title="'No Sessions Found'">
                            <template #action>
                                <inertia-link :href="route('quiz_dashboard')">
                                    <span class="qt-btn qt-btn-sm qt-btn-primary">View Quizzes</span>
                                </inertia-link>
                            </template>
                        </empty-student-card>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import NoDataTable from "@/Components/NoDataTable";
    import ProgressNavigator from "@/Components/Stepper/ProgressNavigator";
    import QuizSessionCard from "@/Components/Cards/QuizSessionCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";

    export default {
        components: {
            AppLayout,
            NoDataTable,
            ProgressNavigator,
            QuizSessionCard,
            EmptyStudentCard
        },
        props: {
            quizSessions: Array,
            steps: Array
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return 'My Progress - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
