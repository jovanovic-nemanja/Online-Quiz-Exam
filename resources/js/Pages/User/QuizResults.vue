<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">{{ quiz.title }} Results</h4>
        </template>
        <template #actions>
            <a :href="route('download_quiz_report', {quiz: quiz.slug, session: session.code})" target="_blank" class="qt-btn qt-btn-sm qt-btn-success">
                Download Score Report
            </a>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div v-if="type.name !== 'Personality'" class="grid sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                    <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                        <div class="absolute w-2 h-4 bg-green-700 left-0"></div>
                        <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base">{{ session.results.pass_or_fail }}</h3>
                        <div class="flex flex-col items-end">
                            <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ session.results.percentage }}%</h2>
                            <p tabindex="0" class="focus:outline-none ml-2 mb-1 text-sm text-gray-600 dark:text-gray-400">Min. {{ session.results.cutoff }}%</p>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                        <div class="absolute w-2 h-4 bg-green-700 left-0"></div>
                        <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base">Score</h3>
                        <div class="flex flex-col items-end">
                            <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ session.results.score }}</h2>
                            <p tabindex="0" class="focus:outline-none ml-2 mb-1 text-sm text-gray-600 dark:text-gray-400">Out of {{ session.results.total_marks }}</p>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                        <div class="absolute w-2 h-4 bg-green-700 left-0"></div>
                        <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base">Accuracy</h3>
                        <div class="flex flex-col items-end">
                            <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ session.results.accuracy }}%</h2>
                            <p tabindex="0" class="focus:outline-none ml-2 mb-1 text-sm text-gray-600 dark:text-gray-400"></p>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                        <div class="absolute w-2 h-4 bg-green-700 left-0"></div>
                        <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base">Speed</h3>
                        <div class="flex flex-col items-end">
                            <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ session.results.speed }}</h2>
                            <p tabindex="0" class="focus:outline-none ml-2 mb-1 text-sm text-gray-600 dark:text-gray-400">Que/Hour</p>
                        </div>
                    </div>
                </div>

                <div v-if="type.name === 'Personality'" class="grid sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 mb-3">
                    <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                        <div class="absolute w-2 h-4 bg-green-700 left-0"></div>
                        <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base font-bold">A</h3>
                        <div class="flex flex-col items-end">
                            <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ questions.filter((question) => question.user_answer === 1).length }}</h2>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                        <div class="absolute w-2 h-4 bg-green-700 left-0"></div>
                        <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base font-bold">B</h3>
                        <div class="flex flex-col items-end">
                            <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ questions.filter((question) => question.user_answer === 2).length }}</h2>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                        <div class="absolute w-2 h-4 bg-green-700 left-0"></div>
                        <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base font-bold">C</h3>
                        <div class="flex flex-col items-end">
                            <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ questions.filter((question) => question.user_answer === 3).length }}</h2>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                        <div class="absolute w-2 h-4 bg-green-700 left-0"></div>
                        <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base font-bold">D</h3>
                        <div class="flex flex-col items-end">
                            <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ questions.filter((question) => question.user_answer === 4).length }}</h2>
                        </div>
                    </div>
                </div>
                <div v-if="type.name !== 'Personality'" class="grid sm:grid-cols-1 md:grid-cols-3 gap-8 py-8">
                    <div class="bg-white dark:bg-gray-800 rounded flex flex-col items-center justify-center p-5 relative shadow">
                        <h2 class="focus:outline-none text-gray-800 text-base leading-normal font-semibold mb-6">
                            Total {{ session.results.total_questions }} Questions
                        </h2>
                        <div class="flex gap-4 sm:justify-center items-center">
                            <div class="w-28">
                                <doughnut-chart id="status" :key="'status'" :chart-data="statusChartData" :element-text="totalAnswered"/>
                            </div>
                            <div class="flex flex-col gap-2 justify-center">
                                <div class="flex gap-2 items-center text-xs">
                                    <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                    {{ session.results.correct_answered_questions }} Correct
                                </div>
                                <div class="flex gap-2 items-center text-xs">
                                    <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                    {{ session.results.wrong_answered_questions }} Wrong
                                </div>
                                <div class="flex gap-2 items-center text-xs">
                                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                    {{ session.results.unanswered_questions }} Unanswered
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-gray-800 rounded flex flex-col items-center justify-center p-5 relative shadow">
                        <h2 class="focus:outline-none text-gray-800 text-base leading-normal font-semibold mb-6">
                            Total {{ session.results.total_duration }} Minutes
                        </h2>
                        <div class="flex gap-4 sm:justify-center items-center">
                            <div class="w-28">
                                <doughnut-chart id="time_spent" :key="'time_spent'" :chart-data="timeSpentChartData" :element-text="totalTimeSpent"/>
                            </div>
                            <div class="flex flex-col gap-2 justify-center">
                                <div class="flex gap-2 items-center text-xs">
                                    <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                    {{ session.results.time_taken_for_correct_answered.detailed_readable }} on Correct
                                </div>
                                <div class="flex gap-2 items-center text-xs">
                                    <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                    {{ session.results.time_taken_for_wrong_answered.detailed_readable }} on Wrong
                                </div>
                                <div class="flex gap-2 items-center text-xs">
                                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                    {{ session.results.time_taken_for_other.detailed_readable }} on Other
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-gray-800 rounded flex flex-col items-center justify-center p-5 relative shadow">
                        <h2 class="focus:outline-none text-gray-800 text-base leading-normal font-semibold mb-6">
                            Total Scored Marks
                        </h2>
                        <div class="w-full flex gap-4 sm:justify-center items-center">
                            <table class="w-full table-auto">
                                <tbody>
                                    <tr>
                                        <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">Marks Earned</td>
                                        <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">{{ session.results.marks_earned }}</td>
                                    </tr>
                                    <tr class="bg-emerald-200">
                                        <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">Negative Marks</td>
                                        <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">-{{ session.results.marks_deducted }}</td>
                                    </tr>
                                    <tr>
                                        <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">Total Marks</td>
                                        <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">{{ session.results.score }}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div v-if="!quiz.settings.hide_solutions">
                    <h2 class="text-lg font-semibold leading-tight text-gray-800 mb-6">Solutions</h2>
                    <div class="w-full card">
                        <div class="w-full card-body lg:flex flex-wrap">
                            <div class="py-4 lg:w-1/3 w-full md:pr-6">
                                <ul v-if="loading">
                                    <li>
                                        <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                                    </li>
                                    <li>
                                        <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                                    </li>
                                    <li>
                                        <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                                    </li>
                                    <li>
                                        <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                                    </li>
                                </ul>
                                <ul v-else class="my-6 flex flex-wrap justify-center items-center gap-2">
                                    <li v-for="(question, index) in questions" :key="question.code" @click="jumpToQuestion(index)">
                                        <practice-question-chip :sno="index+1"
                                                                :is_correct="question.is_correct" :status="question.status"
                                                                :active="current_question === index"></practice-question-chip>
                                    </li>
                                </ul>
                            </div>
                            <div class="py-4 lg:w-2/3 w-full md:pl-6 sm:border-l border-gray-200">
                                <div class="w-full sm:w-2/3" v-if="loading">
                                    <div class="card card-body">
                                        <PracticeQuestionShimmer class="w-full"></PracticeQuestionShimmer>
                                    </div>
                                </div>
                                <div v-else>
                                    <div v-for="(question, index) in questions" :key="question.id">
                                        <div :id="question.code" v-show="current_question === index">
                                            <div class="flex justify-between items-center mb-6">
                                                <div class="font-mono px-2 py-1 inline-block bg-qt-option text-white rounded text-sm mb-2">
                                                    Time Spent: {{ question.time_taken.detailed_readable }}
                                                </div>
                                                <div v-if="question.status === 'answered'" :class="question.is_correct ? 'bg-green-400' : 'bg-red-400'"
                                                     class="font-mono px-2 py-1 inline-block text-white rounded text-sm mb-2">
                                                    <span v-if="question.is_correct">+{{ question.marks_earned }} Marks Earned</span>
                                                    <span v-if="!question.is_correct">-{{ question.marks_deducted }} Marks Deducted</span>
                                                </div>
                                                <div v-else class="font-mono px-2 py-1 inline-block bg-gray-100 text-gray-600 rounded text-sm mb-2">
                                                    Not Answered
                                                </div>
                                            </div>
                                            <practice-question-card :key="question.card" :question="question"
                                                                    :sno="index+1"
                                                                    :total-questions="quiz.total_questions"></practice-question-card>
                                            <div class="mt-4"
                                                 v-if="question.questionType === 'MSA' || question.questionType === 'TOF'">
                                                <MSASolution :key="question.code" :parent-qid="question.code"
                                                             :is-correct="question.is_correct"
                                                             :status="question.status"
                                                             :parent-options="question.options"
                                                             :parent-answer="question.user_answer"
                                                             :correct-answer="question.ca">
                                                </MSASolution>
                                            </div>
                                            <div class="mt-4"
                                                 v-if="question.questionType === 'MMA'">
                                                <MMASolution :key="question.code" :parent-qid="question.code"
                                                             :is-correct="question.is_correct"
                                                             :status="question.status"
                                                             :parent-options="question.options"
                                                             :parent-answer="question.user_answer"
                                                             :correct-answer="question.ca">
                                                </MMASolution>
                                            </div>
                                            <div class="mt-4" v-if="question.questionType === 'MTF'">
                                                <MTFSolution :key="question.code" :parentQid="question.code"
                                                             :is-correct="question.is_correct"
                                                             :status="question.status"
                                                             :parent-options="question.options"
                                                             :parent-answer="question.user_answer"
                                                             :correct-answer="question.ca">
                                                </MTFSolution>
                                            </div>
                                            <div class="mt-4" v-if="question.questionType === 'ORD'">
                                                <ORDSolution :key="question.code" :parentQid="question.code"
                                                             :is-correct="question.is_correct"
                                                             :status="question.status"
                                                             :parent-options="question.options"
                                                             :parent-answer="question.user_answer"
                                                             :correct-answer="question.ca">
                                                </ORDSolution>
                                            </div>
                                            <div class="mt-4" v-if="question.questionType === 'FIB'">
                                                <FIBSolution :key="question.code" :parentQid="question.code"
                                                             :is-correct="question.is_correct"
                                                             :status="question.status"
                                                             :parent-options="question.options"
                                                             :parent-answer="question.user_answer"
                                                             :correct-answer="question.ca">
                                                </FIBSolution>
                                            </div>
                                            <div class="mt-4" v-if="question.questionType === 'SAQ'">
                                                <SAQSolution :key="question.code" :parentQid="question.code"
                                                             :is-correct="question.is_correct"
                                                             :status="question.status"
                                                             :parent-options="question.options"
                                                             :parent-answer="question.user_answer"
                                                             :correct-answer="question.ca">
                                                </SAQSolution>
                                            </div>
                                            <div class="mt-4">
                                                <practice-solution-card :solution="question.solution"></practice-solution-card>
                                            </div>
                                        </div>
                                    </div>
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
    import DoughnutChart from "@/Charts/DoughnutChart";
    import RewardsBadge from "@/Components/RewardsBadge";
    import MSASolution from "@/Components/Questions/Solutions/MSASolution";
    import PracticeQuestionCard from "@/Components/Cards/PracticeQuestionCard";
    import PracticeQuestionChip from "@/Components/Cards/PracticeQuestionChip";
    import NavigationQuestionCardShimmer from "@/Components/Shimmers/NavigationQuestionCardShimmer";
    import PracticeQuestionShimmer from "@/Components/Shimmers/PracticeQuestionShimmer";
    import PracticeSolutionCard from "@/Components/Cards/PracticeSolutionCard";
    import MMASolution from "@/Components/Questions/Solutions/MMASolution";
    import MTFSolution from "@/Components/Questions/Solutions/MTFSolution";
    import ORDSolution from "@/Components/Questions/Solutions/ORDSolution";
    import FIBSolution from "@/Components/Questions/Solutions/FIBSolution";
    import SAQSolution from "@/Components/Questions/Solutions/SAQSolution";

    export default {
        components: {
            SAQSolution,
            FIBSolution,
            ORDSolution,
            MTFSolution,
            MSASolution,
            MMASolution,
            AppLayout,
            DoughnutChart,
            RewardsBadge,
            PracticeQuestionCard,
            PracticeQuestionChip,
            NavigationQuestionCardShimmer,
            PracticeQuestionShimmer,
            PracticeSolutionCard,
        },
        props: {
            quiz: Object,
            type: Object,
            session: Object,
        },
        data() {
            return {
                letters: ['A','B','C','D'],
                loading: false,
                questions: [],
                current_question: 0,
                statusChartData: {
                    labels: ['Correct', 'Wrong', 'Unanswered'],
                    datasets: [{
                        label: 'Status',
                        data: [
                            this.session.results.correct_answered_questions,
                            this.session.results.wrong_answered_questions,
                            this.session.results.unanswered_questions
                        ],
                        backgroundColor: [
                            'rgb(52, 211, 153)',
                            'rgb(248, 113, 113)',
                            'rgb(156, 163, 175)'
                        ],
                        hoverOffset: 4
                    }]
                },
                timeSpentChartData: {
                    labels: ['Correct', 'Wrong', 'Other'],
                    datasets: [{
                        label: 'Time Spent',
                        data: [
                            this.session.results.time_taken_for_correct_answered.seconds,
                            this.session.results.time_taken_for_wrong_answered.seconds,
                            this.session.results.time_taken_for_other.seconds],
                        backgroundColor: [
                            'rgb(52, 211, 153)',
                            'rgb(248, 113, 113)',
                            'rgb(156, 163, 175)'
                        ],
                        hoverOffset: 4
                    }]
                },
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        methods: {
            jumpToQuestion(questionID) {
                this.current_question = questionID;
            },
            fetchQuestions() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_quiz_solutions', {
                    quiz: this.quiz.slug,
                    session: this.session.code
                }))
                    .then(function (response) {
                        let data = response.data;
                        _this.questions = data.questions;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            },
        },
        computed: {
            title() {
                return this.quiz.title + ' Results - ' + this.$page.props.general.app_name;
            },
            totalAnswered() {
                return this.session.results.answered_questions+'/'+this.session.results.total_questions+' Answered';
            },
            totalTimeSpent() {
                return this.session.results.total_time_taken.detailed_readable +' Spent';
            }
        },
        mounted() {
            if(!this.quiz.settings.hide_solutions) {
                this.fetchQuestions();
            }
        }
    }
</script>
