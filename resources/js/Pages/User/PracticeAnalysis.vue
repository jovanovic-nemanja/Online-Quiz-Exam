<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">{{ practiceSet.title }} Analysis</h4>
        </template>
        <template #actions>
            <inertia-link v-if="session.status !== 'completed'" :href="route('go_to_practice', {'practiceSet': practiceSet.slug, 'session': session.code})">
                <span class="qt-btn qt-btn-sm qt-btn-success">Resume Practice</span>
            </inertia-link>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="w-full flex flex-col justify-center items-center">
                    <div v-if="session.status !== 'completed'" class="font-mono px-4 py-2 border border-green-200 bg-green-100 text-green-600 rounded text-sm mb-4">
                        Finish the session to transfer points to your wallet.
                    </div>
                    <div class="w-full card mb-6">
                        <div class="card-body">
                            <div class="flex gap-4 justify-between border-b border-gray-100 items-center h-16 px-4 py-4">
                                <div class="flex items-center gap-2">
                                    <svg class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="300px"
                                         height="300px" viewBox="0 0 300 300" enable-background="new 0 0 300 300"
                                         xml:space="preserve">
                                                    <g><ellipse fill="#FFC843" cx="149.833" cy="149.501" rx="147.833" ry="146.166"/><ellipse fill="#D38700" cx="150" cy="150.168" rx="113.667" ry="113.833"/>
                                                        <polygon fill="#FFC843" points="192.716,211.945 151.021,190.203 109.476,212.222 117.27,165.852 83.489,133.142 129.999,126.226
                                                                                    150.667,83.991 171.618,126.086 218.172,132.693 184.611,165.626"/></g>
                                                </svg>
                                    <h4 class="font-semibold text-sm">Score/Points</h4>
                                </div>
                                <div class="text-sm">{{ session.total_points_earned }} XP</div>
                            </div>
                            <div class="flex gap-4 justify-between border-b border-gray-100 items-center h-16 px-4 py-4">
                                <div class="flex items-center gap-2">
                                    <img class="w-7 h-7" :src="$page.props.appUrl+'images/darts.png'" alt="Accuracy">
                                    <h4 class="font-semibold text-sm">Accuracy</h4>
                                </div>
                                <div class="text-sm">{{ analytics.accuracy }}%</div>
                            </div>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 border-b border-gray-100 justify-center items-center px-4 py-4">
                                <div class="flex gap-4 sm:justify-center items-center">
                                    <div class="w-28">
                                        <doughnut-chart id="status" :key="'status'" :chart-data="statusChartData" :element-text="totalAnswered"/>
                                    </div>
                                    <div class="flex flex-col gap-2 justify-center">
                                        <div class="flex gap-2 items-center text-xs">
                                            <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                            {{ analytics.correct_answered_questions }} Correct
                                        </div>
                                        <div class="flex gap-2 items-center text-xs">
                                            <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                            {{ analytics.wrong_answered_questions }} Wrong
                                        </div>
                                        <div class="flex gap-2 items-center text-xs">
                                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                            {{ analytics.unanswered_questions }} Unanswered
                                        </div>
                                    </div>
                                </div>
                                <div class="flex gap-4 sm:justify-center items-center">
                                    <div class="w-28">
                                        <doughnut-chart id="time_spent" :key="'time_spent'" :chart-data="timeSpentChartData" :element-text="totalTimeSpent"/>
                                    </div>
                                    <div class="flex flex-col gap-2 justify-center">
                                        <div class="flex gap-2 items-center text-xs">
                                            <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                            {{ analytics.time_taken_for_correct_answered.detailed_readable }} on Correct
                                        </div>
                                        <div class="flex gap-2 items-center text-xs">
                                            <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                            {{ analytics.time_taken_for_wrong_answered.detailed_readable }} on Wrong
                                        </div>
                                        <div class="flex gap-2 items-center text-xs">
                                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                            {{ analytics.time_taken_for_other.detailed_readable }} on Other
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="flex gap-4 justify-between items-center h-16 px-4 py-4">
                                <div class="flex items-center gap-2">
                                    <img class="w-7 h-7" :src="$page.props.appUrl+'images/clock.png'" alt="Speed">
                                    <h4 class="font-semibold text-sm">Avg. Speed</h4>
                                </div>
                                <div class="text-sm">{{ analytics.speed }} que/hr</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div v-if="session.status === 'completed'">
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
                                                    <span v-if="question.is_correct">+{{ question.points_earned }} Points Earned</span>
                                                    <span v-if="!question.is_correct">No Points</span>
                                                </div>
                                                <div v-else class="font-mono px-2 py-1 inline-block bg-gray-100 text-gray-600 rounded text-sm mb-2">
                                                    Not Answered
                                                </div>
                                            </div>
                                            <practice-question-card :key="question.card" :question="question"
                                                                    :sno="index+1"
                                                                    :total-questions="practiceSet.total_questions"></practice-question-card>
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
    import PracticeQuestionCard from "@/Components/Cards/PracticeQuestionCard";
    import PracticeQuestionChip from "@/Components/Cards/PracticeQuestionChip";
    import NavigationQuestionCardShimmer from "@/Components/Shimmers/NavigationQuestionCardShimmer";
    import PracticeQuestionShimmer from "@/Components/Shimmers/PracticeQuestionShimmer";
    import PracticeSolutionCard from "@/Components/Cards/PracticeSolutionCard";
    import SAQSolution from "@/Components/Questions/Solutions/SAQSolution";
    import FIBSolution from "@/Components/Questions/Solutions/FIBSolution";
    import ORDSolution from "@/Components/Questions/Solutions/ORDSolution";
    import MTFSolution from "@/Components/Questions/Solutions/MTFSolution";
    import MSASolution from "@/Components/Questions/Solutions/MSASolution";
    import MMASolution from "@/Components/Questions/Solutions/MMASolution";

    export default {
        components: {
            AppLayout,
            DoughnutChart,
            RewardsBadge,
            PracticeQuestionCard,
            PracticeQuestionChip,
            NavigationQuestionCardShimmer,
            PracticeQuestionShimmer,
            PracticeSolutionCard,
            SAQSolution,
            FIBSolution,
            ORDSolution,
            MTFSolution,
            MSASolution,
            MMASolution,
        },
        props: {
            practiceSet: Object,
            session: Object,
            analytics: Object
        },
        data() {
            return {
                loading: false,
                questions: [],
                current_question: 0,
                statusChartData: {
                    labels: ['Correct', 'Wrong', 'Unanswered'],
                    datasets: [{
                        label: 'Status',
                        data: [
                            this.analytics.correct_answered_questions,
                            this.analytics.wrong_answered_questions,
                            this.analytics.unanswered_questions
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
                            this.analytics.time_taken_for_correct_answered.seconds,
                            this.analytics.time_taken_for_wrong_answered.seconds,
                            this.analytics.time_taken_for_other.seconds],
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
        methods: {
            jumpToQuestion(questionID) {
                this.current_question = questionID;
            },
            fetchQuestions() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_practice_set_solutions', {
                    practiceSet: this.practiceSet.slug,
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
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.practiceSet.title + ' Analysis - ' + this.$page.props.general.app_name;
            },
            totalAnswered() {
                return this.analytics.answered_questions+'/'+this.analytics.total_questions+' Answered';
            },
            totalTimeSpent() {
                return this.analytics.total_time_taken.detailed_readable +' Spent';
            }
        },
        mounted() {
            if(this.session.status === 'completed') {
                this.fetchQuestions();
            }
        }
    }
</script>
