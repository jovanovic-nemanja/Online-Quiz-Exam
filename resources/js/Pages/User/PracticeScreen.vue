<template>
    <practice-layout>
        <!-- Side Title -->
        <template #title>
            <h4 class="font-semibold text-white">{{ practiceSet.title }}</h4>
        </template>
        <!-- Test Title -->
        <template #actions>
            <h5 class=" text-white">{{ answered }}/{{ practiceSet.total_questions }} Attempted</h5>
            <button class="text-gray-400 hover:text-white focus:outline-none" @click="chipView = !chipView">
                <svg v-if="!chipView" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                     xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path>
                </svg>
                <svg v-if="chipView" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                     xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M4 6h16M4 10h16M4 14h16M4 18h16"></path>
                </svg>
            </button>
        </template>

        <template #questions>
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
            <ul v-else class="my-6" :class="{'flex flex-wrap justify-center items-center gap-2': chipView }">
                <li v-for="(question, index) in questions" :key="question.code" @click="jumpToQuestion(index)">
                    <dark-question-card v-if="!chipView" :question="question" :sno="getQuestionNo(index)"
                                        :is_correct="question.is_correct" :status="question.status"
                                        :active="current_question === index"></dark-question-card>
                    <practice-question-chip v-if="chipView" :sno="getQuestionNo(index)"
                                        :is_correct="question.is_correct" :status="question.status"
                                        :active="current_question === index"></practice-question-chip>
                </li>
            </ul>
        </template>

        <template #footer>
            <ul v-if="!loading" class="w-full h-16 flex items-center justify-between bg-gray-800">
                <li class="text-gray-400 hover:text-white cursor-pointer" @click="prevPage">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                         xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path>
                    </svg>
                </li>
                <li>
                    <span
                        class=" text-white">Page {{ pagination.current_page }}/{{ pagination.total_pages }}</span>
                </li>
                <li class="text-gray-400 hover:text-white cursor-pointer" @click="nextPage">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                         xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M13 9l3 3m0 0l-3 3m3-3H8m13 0a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </li>
            </ul>
        </template>

        <div class="w-full h-16 fixed sm:absolute z-30 top-0 right-0 mx-auto bg-white">
            <div class="w-full sm:max-w-7xl h-full mx-auto px-4 sm:px-6 lg:px-8">
                <div v-if="!loading" class="h-full flex flex-col justify-center items-center">
                    <div class="w-full sm:w-2/3 flex items-center justify-end gap-4 sm:gap-0 sm:justify-between">
                        <rewards-badge :points="total_points_earned"></rewards-badge>
                        <button v-if="headerButton === 'finish'" class="focus:outline-none" @click="finishTest">
                            <finish-button></finish-button>
                        </button>
                        <inertia-link v-if="headerButton === 'close'" :href="route('practice_session_analysis', { practiceSet: practiceSet.slug, session: session.code })">
                            <finish-button :name="'Close'"></finish-button>
                        </inertia-link>
                        <button v-if="headerButton === 'pause'" class="focus:outline-none" @click="pauseTest">
                            <pause-button></pause-button>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <perfect-scrollbar class="h-screen max-h-screen pt-16 pb-16" ref="scroll2" :options="scrollbarOptions">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col justify-center items-center">
                    <div class="w-full sm:w-2/3" v-if="loading">
                        <div class="card card-body">
                            <PracticeQuestionShimmer class="w-full"></PracticeQuestionShimmer>
                        </div>
                    </div>
                    <div v-else class="w-full py-2 sm:w-2/3">
                        <div v-for="(question, index) in questions" :key="question.id">
                            <div :id="question.code" v-show="current_question === index">
                                <practice-question-card :key="question.card" :question="question"
                                                        :sno="getQuestionNo(index)" :attachment-type="question.attachment_type" :attachment="question.attachment"
                                                        :total-questions="practiceSet.total_questions"></practice-question-card>
                                <div class="mt-4"
                                     v-if="question.questionType === 'MSA' || question.questionType === 'TOF'">
                                    <MSAInteractiveOptions :key="question.code" :parent-qid="question.code"
                                                           :is-correct="question.is_correct"
                                                           :status="question.status"
                                                           :parent-options="question.options"
                                                           :parent-answer="question.user_answer"
                                                           :correct-answer="question.ca"
                                                           v-on:modifyAnswer="updateAnswer">
                                    </MSAInteractiveOptions>
                                </div>
                                <div class="mt-4"
                                     v-if="question.questionType === 'MMA'">
                                    <MMAInteractiveOptions :key="question.code" :parent-qid="question.code"
                                                           :is-correct="question.is_correct"
                                                           :status="question.status"
                                                           :parent-options="question.options"
                                                           :parent-answer="question.user_answer"
                                                           :correct-answer="question.ca"
                                                           v-on:modifyAnswer="updateAnswer">
                                    </MMAInteractiveOptions>
                                </div>
                                <div class="mt-4" v-if="question.questionType === 'MTF'">
                                    <MTFInteractiveOptions :key="question.code" :parentQid="question.code"
                                                           :is-correct="question.is_correct"
                                                           :status="question.status"
                                                           :parent-options="question.options"
                                                           :parent-answer="question.user_answer"
                                                           :correct-answer="question.ca"
                                                           v-on:modifyAnswer="updateAnswer">
                                    </MTFInteractiveOptions>
                                </div>
                                <div class="mt-4" v-if="question.questionType === 'ORD'">
                                    <ORDInteractiveOptions :key="question.code" :parentQid="question.code"
                                                           :is-correct="question.is_correct"
                                                           :status="question.status"
                                                           :parent-options="question.options"
                                                           :parent-answer="question.user_answer"
                                                           :correct-answer="question.ca"
                                                           v-on:modifyAnswer="updateAnswer">
                                    </ORDInteractiveOptions>
                                </div>
                                <div class="mt-4" v-if="question.questionType === 'FIB'">
                                    <FIBInteractiveOptions :key="question.code" :parentQid="question.code"
                                                           :is-correct="question.is_correct"
                                                           :status="question.status"
                                                           :parent-options="question.options"
                                                           :parent-answer="question.user_answer"
                                                           :correct-answer="question.ca"
                                                           v-on:modifyAnswer="updateAnswer">
                                    </FIBInteractiveOptions>
                                </div>
                                <div class="mt-4" v-if="question.questionType === 'SAQ'">
                                    <SAQInteractiveOptions :key="question.code" :parentQid="question.code"
                                                           :is-correct="question.is_correct"
                                                           :status="question.status"
                                                           :parent-options="question.options"
                                                           :parent-answer="question.user_answer"
                                                           :correct-answer="question.ca"
                                                           v-on:modifyAnswer="updateAnswer">
                                    </SAQInteractiveOptions>
                                </div>
                                <div v-if="question.status === 'answered'" class="mt-4">
                                    <practice-solution-card :solution="question.solution"></practice-solution-card>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </perfect-scrollbar>
        <div class="w-full h-16 fixed sm:absolute z-30 bottom-0 right-0 mx-auto bg-white">
            <div class="w-full sm:max-w-7xl h-full mx-auto px-4 sm:px-6 lg:px-8">
                <div v-if="!loading" class="h-full flex flex-col justify-center items-center">
                    <div class="w-full sm:w-2/3 flex items-center justify-between">
                        <button class="focus:outline-none" @click="prevQuestion">
                            <prev-button></prev-button>
                        </button>
                        <button v-if="footerButton === 'submit'" :class="{ 'opacity-25': submitting }"
                                :disabled="submitting" class="focus:outline-none" @click="submitAnswer">
                            <submit-button></submit-button>
                        </button>
                        <button v-if="footerButton === 'next'" class="focus:outline-none" @click="nextQuestion">
                            <next-button :name="'Next'"></next-button>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <ConfirmDialog></ConfirmDialog>
    </practice-layout>
</template>

<script>
    import PracticeLayout from '@/Layouts/PracticeLayout'
    import PracticeQuestionCard from "@/Components/Cards/PracticeQuestionCard";
    import DarkQuestionCard from "@/Components/Cards/DarkQuestionCard";
    import PracticeQuestionChip from "@/Components/Cards/PracticeQuestionChip";
    import NavigationQuestionCardShimmer from "@/Components/Shimmers/NavigationQuestionCardShimmer";
    import PracticeQuestionShimmer from "@/Components/Shimmers/PracticeQuestionShimmer";
    import PrevButton from "@/Components/Buttons/PrevButton";
    import NextButton from "@/Components/Buttons/NextButton";
    import FinishButton from "@/Components/Buttons/FinishButton";
    import SubmitButton from "@/Components/Buttons/SubmitButton";
    import PauseButton from "@/Components/Buttons/PauseButton";
    import MSAInteractiveOptions from "@/Components/Questions/PracticeInteract/MSAInteractiveOptions";
    import MMAInteractiveOptions from "@/Components/Questions/PracticeInteract/MMAInteractiveOptions";
    import MTFInteractiveOptions from "@/Components/Questions/PracticeInteract/MTFInteractiveOptions";
    import ORDInteractiveOptions from "@/Components/Questions/PracticeInteract/ORDInteractiveOptions";
    import FIBInteractiveOptions from "@/Components/Questions/PracticeInteract/FIBInteractiveOptions";
    import SAQInteractiveOptions from "@/Components/Questions/PracticeInteract/SAQInteractiveOptions";
    import PracticeSolutionCard from "@/Components/Cards/PracticeSolutionCard";
    import RewardsBadge from "@/Components/RewardsBadge";
    import Swal from 'sweetalert2';
    import {PerfectScrollbar} from "vue2-perfect-scrollbar";
    import ConfirmDialog from "primevue/confirmdialog";

    export default {
        components: {
            SAQInteractiveOptions,
            FIBInteractiveOptions,
            ORDInteractiveOptions,
            MTFInteractiveOptions,
            MSAInteractiveOptions,
            MMAInteractiveOptions,
            PracticeLayout,
            PracticeQuestionCard,
            DarkQuestionCard,
            PracticeQuestionChip,
            NavigationQuestionCardShimmer,
            PracticeQuestionShimmer,
            PrevButton,
            NextButton,
            FinishButton,
            SubmitButton,
            PauseButton,
            PracticeSolutionCard,
            PerfectScrollbar,
            RewardsBadge,
            ConfirmDialog
        },
        props: {
            practiceSet: Object,
            session: Object,
        },
        data() {
            return {
                current_question: 0,
                questions: [],
                pagination: null,
                answered: 0,
                total_points_earned: this.session.total_points_earned,
                total_time_taken: this.session.total_time_taken,
                chipView: false,
                loading: true,
                submitting: false,
                scrollbarOptions: {
                    maxScrollbarLength: 1,
                    suppressScrollX: true
                },
                rewardStrings: ['Hurray', 'Yippee', 'Congrats', 'Cheers', 'Yup', 'Precise', 'Delight', 'Glory']
            }
        },
        methods: {
            submitAnswer() {
                let _this = this;
                _this.submitting = true;
                axios.post(route('check_practice_answer', {
                    practiceSet: this.practiceSet.slug,
                    session: this.session.code
                }), {
                    'question_id': this.questions[this.current_question].code,
                    'user_answer': this.questions[this.current_question].user_answer,
                    'time_taken': this.questions[this.current_question].time_taken,
                    'total_time_taken': this.total_time_taken
                })
                    .then(function (response) {
                        let data = response.data;
                        _this.questions[_this.current_question].is_correct = data.is_correct;
                        _this.questions[_this.current_question].status = data.status;
                        _this.questions[_this.current_question].solution = data.solution;
                        _this.questions[_this.current_question].ca = data.ca;
                        _this.questions[_this.current_question].points_earned = data.points_earned;
                        _this.answered = data.answered;
                        _this.submitting = false;
                        if(data.is_correct && data.points_earned !== 0) {
                            _this.showPoints(data.points_earned);
                            _this.total_points_earned = data.total_points_earned;
                        }
                    })
                    .catch(function (error) {
                        _this.submitting = false;
                    })
                    .then(function () {
                        _this.submitting = false;
                    });
            },
            pauseTest() {
                this.$confirm.require({
                    message: 'Are you sure you want to pause practice?',
                    header: 'Confirmation',
                    icon: 'pi pi-exclamation-triangle',
                    accept: () => {
                        this.$inertia.post(route('practice_session_analysis', {
                            practiceSet: this.practiceSet.slug,
                            session: this.session.code
                        }), {
                            total_time_taken: this.total_time_taken
                        });
                    },
                    reject: () => {
                        //callback to execute when user rejects the action
                    }
                });
            },
            finishTest() {
                this.$inertia.post(route('finish_practice_session', {
                    practiceSet: this.practiceSet.slug,
                    session: this.session.code
                }));
            },
            updateAnswer(value) {
                this.questions[this.current_question].user_answer = value;
            },
            prevQuestion() {
                if (this.current_question !== 0) {
                    this.current_question--;
                } else {
                    this.prevPage();
                }
            },
            nextQuestion() {
                if (this.current_question < this.questions.length - 1) {
                    this.current_question++;
                } else {
                    if (this.current_question < this.practiceSet.total_questions - 1) {
                        this.nextPage();
                    }
                }
            },
            jumpToQuestion(questionID) {
                if (this.current_question > questionID) {
                    this.currentTransition = 'prev';
                } else {
                    this.currentTransition = 'next';
                }
                this.current_question = questionID;
            },
            prevPage() {
                if (this.pagination.current_page !== 1) {
                    this.current_question = 0;
                    this.fetchQuestions(this.pagination.current_page - 1);
                }
            },
            nextPage() {
                if (this.pagination.current_page < this.pagination.total_pages) {
                    this.current_question = 0;
                    this.fetchQuestions(this.pagination.current_page + 1);
                }
            },
            fetchQuestions(page) {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_practice_questions', {
                    practiceSet: this.practiceSet.slug,
                    session: this.session.code,
                    page: page
                }))
                    .then(function (response) {
                        let data = response.data;
                        _this.questions = data.questions;
                        _this.pagination = data.pagination;
                        _this.answered = data.answered;
                        if(_this.session.status !== 'completed') {
                            _this.startTimer();
                        }
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            },
            getQuestionNo(index) {
                return (index + 1) + (this.pagination.per_page * (this.pagination.current_page - 1));
            },
            typeCheck(value) {
                const return_value = Object.prototype.toString.call(value);
                // we can also use regex to do this...
                const type = return_value.substring(
                    return_value.indexOf(" ") + 1,
                    return_value.indexOf("]"));

                return type.toLowerCase();
            },
            startTimer() {
                setInterval(this.incrementTime, 1000);
            },
            incrementTime() {
                this.total_time_taken = parseInt(this.total_time_taken) + 1;
                if (this.questions[this.current_question].status !== 'answered') {
                    this.questions[this.current_question].time_taken = parseInt(this.questions[this.current_question].time_taken) + 1;
                }
            },
            showPoints(points) {
                let _this = this;
                let bonus = new Audio(_this.appUrl + '/images/insight.mp3');
                let rewardString = this.rewardStrings[Math.floor(Math.random() * this.rewardStrings.length)];
                setTimeout(function () {
                    bonus.play();
                    Swal.fire({
                        title: '<strong>' + points + ' XP</strong>',
                        html: '<div class="w-full flex flex-col justify-center items-center">' +
                            '<img src="' + _this.appUrl + '/images/reward.gif" />' +
                            '<span class="">'+rewardString+'! You\'ve earned ' + points + ' points</span>' +
                            '</div>',
                        showCloseButton: false,
                        focusConfirm: true,
                        confirmButtonText:
                            '<div class="flex gap-2 justify-center items-center">' +
                            '<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5"></path></svg> Great!' +
                            '</div>',
                        confirmButtonAriaLabel: 'Thumbs up, great!',
                    });
                }, 1000);

            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.practiceSet.title + ' - ' + this.$page.props.general.app_name;
            },
            headerButton() {
                if (this.session.status === 'completed') {
                    return 'close';
                } else if (this.session.status !== 'completed' && this.answered === this.practiceSet.total_questions) {
                    return 'finish';
                } else {
                    return 'pause';
                }
            },
            footerButton() {
                if ((this.typeCheck(this.questions[this.current_question].user_answer) === 'array' && this.questions[this.current_question].user_answer.length !== 0)
                    && this.questions[this.current_question].status !== 'answered') {
                    return 'submit';
                } else if ((this.typeCheck(this.questions[this.current_question].user_answer) === 'string' && this.questions[this.current_question].user_answer !== "")
                    && this.questions[this.current_question].status !== 'answered') {
                    return 'submit';
                } else if ((this.typeCheck(this.questions[this.current_question].user_answer) === 'number' && this.questions[this.current_question].user_answer !== "")
                    && this.questions[this.current_question].status !== 'answered') {
                    return 'submit';
                } else if (this.getQuestionNo(this.current_question) !== this.practiceSet.total_questions) {
                    return 'next';
                }
                return '';
            },
            appUrl() {
                return this.$page.props.appUrl;
            }
        },
        mounted() {
            // document.addEventListener('contextmenu', event => event.preventDefault());
            this.fetchQuestions(1);
        }
    }
</script>
