<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">{{ quiz.title }}</h4>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col items-center">
                    <div class="w-full sm:w-2/3">
                        <div class="w-full rounded shadow-lg p-8 bg-gradient-to-tl from-green-600 to-green-700">
                            <h1 class="text-2xl font-semibold leading-relaxed text-white">Time's up! Thank You for attempting {{ quiz.title }}</h1>
                            <div v-if="type.name !== 'Personality'" class="flex flex-col sm:flex-row mt-7 gap-4">
                                <div>
                                    <p class="focus:outline-none text-xs text-gray-300">Answered</p>
                                    <p class="focus:outline-none mt-2 text-base sm:text-lg md:text-xl 2xl:text-2xl text-gray-50">
                                        {{ session.results.answered_questions }} out of {{ session.results.total_questions }}
                                    </p>
                                </div>
                                <div class="sm:ml-11">
                                    <p class="focus:outline-none text-xs text-gray-300">Percentage</p>
                                    <p class="focus:outline-none mt-2 text-base sm:text-lg md:text-xl 2xl:text-2xl text-gray-50">{{ session.results.percentage }}%</p>
                                </div>
                                <div class="sm:ml-11">
                                    <p class="focus:outline-none text-xs text-gray-300">Score</p>
                                    <p class="focus:outline-none mt-2 text-base sm:text-lg md:text-xl 2xl:text-2xl text-gray-50">
                                        {{ session.results.score }}/{{ quiz.total_marks }}
                                    </p>
                                </div>
                                <div class="sm:ml-11">
                                    <p class="focus:outline-none text-xs text-gray-300">Pass/Fail</p>
                                    <p class="focus:outline-none mt-2 text-base sm:text-lg md:text-xl 2xl:text-2xl text-gray-50">{{ session.results.pass_or_fail }}</p>
                                </div>
                            </div>
                            <div class="pt-7 flex items-center justify-between">
                                <p v-if="type.name !== 'Personality'" class="focus:outline-none text-sm text-white">Pass Percentage {{ session.results.cutoff }}%</p>
                                <inertia-link :href="route('quiz_results', {quiz: quiz.slug, session: session.code})"
                                              class="h-9 flex items-center text-green-700 rounded-sm bg-gray-50 focus:outline-none hover:opacity-90 px-4 py-2 text-sm font-medium leading-3">
                                    View Results
                                </inertia-link>
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

    export default {
        components: {
            AppLayout,
            QuizCard
        },
        props: {
            quiz: Object,
            type: Object,
            session: Object
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.quiz.title + ' Thank You - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
