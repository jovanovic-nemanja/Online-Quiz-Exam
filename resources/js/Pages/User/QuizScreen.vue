<template>
    <quiz-layout>

        <template #title>
            <h4 class="font-semibold text-white">{{ quiz.title }}</h4>
        </template>

        <template #timer>
            <span class="ml-2">
                <vue-countdown :time="remainingTime * 1000" @end="finishTest" :transform="transformSlotProps" v-slot="{ days, hours, minutes, seconds }">
                    {{ hours !== '00' ? hours+':' : '' }}{{ minutes }}:{{ seconds }}
                </vue-countdown>
            </span>
        </template>

        <template #actions>
            <h5 class="text-sm text-gray-800">{{ answered }}/{{ quiz.total_questions }} Answered</h5>
            <button v-if="quiz.settings.list_questions" class="text-gray-400 hover:text-gray-800 focus:outline-none" @click="chipView = !chipView">
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

        <template #sections>
            <button class="focus:outline-none flex items-center gap-2 text-white text-sm bg-green-800 hover:bg-green-600 rounded-sm py-2 px-4">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 11V7a4 4 0 118 0m-4 8v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2z"></path></svg>
                <span>All Questions</span>
            </button>
        </template>

        <template #questions>
            <div>
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
                        <light-question-card v-if="!chipView" :question="question" :sno="index+1"
                                             :is_correct="question.is_correct" :status="question.status"
                                             :active="current_question === index"></light-question-card>
                        <exam-question-chip v-if="chipView" :sno="index+1"
                                            :is_correct="question.is_correct" :status="question.status"
                                            :active="current_question === index"></exam-question-chip>
                    </li>
                </ul>
            </div>
        </template>

        <template #footer>
            <div v-if="!quiz.settings.disable_finish_button" class="w-full h-16 flex items-center justify-center bg-white px-8">
                <button @click="finishAlert" class="w-full focus:outline-none">
                    <finish-button :name="'Finish Test'"></finish-button>
                </button>
            </div>
        </template>

        <perfect-scrollbar class="h-screen max-h-screen pt-32 pb-16" ref="scroll2" :options="scrollbarOptions">
            <div class="mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col justify-center">
                    <div class="w-full mt-4 py-4 sm:w-2/3" v-if="loading">
                        <PracticeQuestionShimmer class="w-full"></PracticeQuestionShimmer>
                    </div>
                    <div v-else class="w-full mt-4 py-4">
                        <div class="w-full" v-for="(question, index) in questions" :key="question.id">
                            <div class="flex flex-col sm:flex-row gap-4" :id="question.code" v-show="current_question === index">
                                <div v-if="question.attachment_type != null" class="w-full sm:w-1/3 sm:border-r sm:border-gray-300 pr-4">
                                    <div v-if="question.attachment_type === 'audio'">
                                        <audio-attachment :reference="'player_'+question.code" :options="question.attachment"></audio-attachment>
                                    </div>
                                    <div v-if="question.attachment_type === 'video'">
                                        <video-attachment :reference="'player_'+question.code" :options="question.attachment"></video-attachment>
                                    </div>
                                    <div v-if="question.attachment_type === 'comprehension'">
                                        <comprehension-attachment :passage="question.attachment"></comprehension-attachment>
                                    </div>
                                </div>
                                <div class="w-full sm:w-2/3">
                                    <div>
                                        <quiz-question-card :key="question.card" :question="question"
                                                            :sno="index+1"
                                                            :total-questions="quiz.total_questions"></quiz-question-card>
                                        <div class="mt-4"
                                             v-if="question.questionType === 'MSA' || question.questionType === 'TOF'">
                                            <MSAInteractiveOptions :key="question.code" :parent-qid="question.code"
                                                                   :status="question.status"
                                                                   :parent-options="question.options"
                                                                   :parent-answer="question.user_answer"
                                                                   v-on:modifyAnswer="updateAnswer">
                                            </MSAInteractiveOptions>
                                        </div>
                                        <div class="mt-4"
                                             v-if="question.questionType === 'PQ'">
                                            <PQInteractiveOptions :key="question.code" :parent-qid="question.code"
                                                                   :status="question.status"
                                                                   :parent-options="question.options"
                                                                   :parent-answer="question.user_answer"
                                                                   v-on:modifyAnswer="updateAnswer">
                                            </PQInteractiveOptions>
                                        </div>
                                        <div class="mt-4"
                                             v-if="question.questionType === 'MMA'">
                                            <MMAInteractiveOptions :key="question.code" :parent-qid="question.code"
                                                                   :status="question.status"
                                                                   :parent-options="question.options"
                                                                   :parent-answer="question.user_answer"
                                                                   v-on:modifyAnswer="updateAnswer">
                                            </MMAInteractiveOptions>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'MTF'">
                                            <MTFInteractiveOptions :key="question.code" :parentQid="question.code"
                                                                   :status="question.status"
                                                                   :parent-options="question.options"
                                                                   :parent-answer="question.user_answer"
                                                                   v-on:modifyAnswer="updateAnswer">
                                            </MTFInteractiveOptions>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'ORD'">
                                            <ORDInteractiveOptions :key="question.code" :parentQid="question.code"
                                                                   :status="question.status"
                                                                   :parent-options="question.options"
                                                                   :parent-answer="question.user_answer"
                                                                   v-on:modifyAnswer="updateAnswer">
                                            </ORDInteractiveOptions>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'FIB'">
                                            <FIBInteractiveOptions :key="question.code" :parentQid="question.code"
                                                                   :status="question.status"
                                                                   :parent-options="question.options"
                                                                   :parent-answer="question.user_answer"
                                                                   v-on:modifyAnswer="updateAnswer">
                                            </FIBInteractiveOptions>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'SAQ'">
                                            <SAQInteractiveOptions :key="question.code" :parentQid="question.code"
                                                                   :status="question.status"
                                                                   :parent-options="question.options"
                                                                   :parent-answer="question.user_answer"
                                                                   v-on:modifyAnswer="updateAnswer">
                                            </SAQInteractiveOptions>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </perfect-scrollbar>
        <div class="w-full h-16 absolute z-30 bottom-0 right-0 border-t border-gray-200 mx-auto bg-white">
            <div class="w-full h-full mx-auto px-4 sm:px-6 lg:px-8">
                <div v-if="!loading" class="h-full flex flex-col justify-center items-center">
                    <div class="w-full flex items-center justify-between">
                        <div class="flex items-center gap-2">
                            <button @click="clearAnswer" class="focus:outline-none">
                                <clear-button :name="'Clear Answer'"></clear-button>
                            </button>
                        </div>
                        <div class="flex items-center gap-2">
                            <button @click="nextQuestion" class="focus:outline-none">
                                <next-button :name="'Save & Next'"></next-button>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <ConfirmDialog></ConfirmDialog>
    </quiz-layout>
</template>

<script>
    import QuizLayout from '@/Layouts/QuizLayout'
    import PrevButton from "@/Components/Buttons/PrevButton";
    import NextButton from "@/Components/Buttons/NextButton";
    import ClearButton from "@/Components/Buttons/ClearButton";
    import FinishButton from "@/Components/Buttons/FinishButton";
    import MSAInteractiveOptions from "@/Components/Questions/ExamInteract/MSAInteractiveOptions";
    import PQInteractiveOptions from "@/Components/Questions/ExamInteract/PQInteractiveOptions";
    import MMAInteractiveOptions from "@/Components/Questions/ExamInteract/MMAInteractiveOptions";
    import MTFInteractiveOptions from "@/Components/Questions/ExamInteract/MTFInteractiveOptions";
    import ORDInteractiveOptions from "@/Components/Questions/ExamInteract/ORDInteractiveOptions";
    import FIBInteractiveOptions from "@/Components/Questions/ExamInteract/FIBInteractiveOptions";
    import SAQInteractiveOptions from "@/Components/Questions/ExamInteract/SAQInteractiveOptions";
    import LightQuestionCard from "@/Components/Cards/LightQuestionCard";
    import ExamQuestionChip from "@/Components/Cards/ExamQuestionChip";
    import QuizQuestionCard from "@/Components/Cards/QuizQuestionCard";
    import NavigationQuestionCardShimmer from "@/Components/Shimmers/NavigationQuestionCardShimmer";
    import PracticeQuestionShimmer from "@/Components/Shimmers/PracticeQuestionShimmer";
    import ConfirmDialog from 'primevue/confirmdialog';
    import VueCountdown from '@chenfengyuan/vue-countdown';
    import {PerfectScrollbar} from "vue2-perfect-scrollbar";
    import AudioAttachment from "@/Components/Questions/Attachments/AudioAttachment";
    import VideoAttachment from "@/Components/Questions/Attachments/VideoAttachment";
    import ComprehensionAttachment from "@/Components/Questions/Attachments/ComprehensionAttachment";

    export default {
        components: {
            SAQInteractiveOptions,
            FIBInteractiveOptions,
            ORDInteractiveOptions,
            MTFInteractiveOptions,
            MSAInteractiveOptions,
            PQInteractiveOptions,
            MMAInteractiveOptions,
            QuizLayout,
            PrevButton,
            NextButton,
            FinishButton,
            ClearButton,
            PerfectScrollbar,
            LightQuestionCard,
            ExamQuestionChip,
            NavigationQuestionCardShimmer,
            QuizQuestionCard,
            VueCountdown,
            PracticeQuestionShimmer,
            ConfirmDialog,
            AudioAttachment,
            VideoAttachment,
            ComprehensionAttachment
        },
        props: {
            quiz: Object,
            session: Object,
            remainingTime: Number,
            answeredQuestions: Number,
        },
        data() {
            return {
                questions: [],
                answered: this.answeredQuestions,
                total_time_taken: this.session.total_time_taken,
                current_question:this.session.current_question,
                chipView: true,
                loading: true,
                submitting: false,
                scrollbarOptions: {
                    maxScrollbarLength: 1,
                    suppressScrollX: true
                },
            }
        },
        methods: {
            submitAnswer() {
                let _this = this;
                _this.submitting = true;
                axios.post(route('update_quiz_answer', {
                    quiz: this.quiz.slug,
                    session: this.session.code
                }), {
                    'question_id': this.questions[this.current_question].code,
                    'user_answer': this.questions[this.current_question].user_answer,
                    'time_taken': this.questions[this.current_question].time_taken,
                    'total_time_taken': this.total_time_taken,
                    'current_question': this.current_question,
                    'status': this.questions[this.current_question].status
                })
                    .then(function (response) {
                        let data = response.data;
                        _this.answered = data.answered;
                        _this.submitting = false;
                    })
                    .catch(function (error) {
                        _this.submitting = false;
                    })
                    .then(function () {
                        _this.submitting = false;
                    });
            },
            finishAlert() {
                let _this = this;
                this.$confirm.require({
                    message: 'Are you sure you want to finish?',
                    header: 'Confirmation',
                    icon: 'pi pi-exclamation-triangle',
                    accept: () => {
                        _this.finishTest();
                    },
                    reject: () => {
                        //callback to execute when user rejects the action
                    }
                });
            },
            finishTest() {
                this.$inertia.post(route('finish_quiz_session', {
                    quiz: this.quiz.slug,
                    session: this.session.code
                }), {
                    'total_time_taken': this.total_time_taken,
                    'questions': this.questions
                });
            },
            updateAnswer(value) {
                this.questions[this.current_question].user_answer = value;
                this.questions[this.current_question].status = 'answered';
            },
            prevQuestion() {
                if (this.current_question !== 0) {
                    this.current_question--;
                }
            },
            nextQuestion() {
                if(this.questions[this.current_question].status !== 'answered') {
                    this.questions[this.current_question].status = 'not_answered';
                }
                this.submitAnswer();
                if (this.current_question < this.questions.length - 1) {
                    this.current_question++;
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
            clearAnswer() {
                let qType = this.questions[this.current_question].questionType;
                this.questions[this.current_question].user_answer = this.getClearedAnswer(qType);
                this.questions[this.current_question].status = 'not_answered';
                this.submitAnswer();
            },
            getClearedAnswer(qType) {
                switch(qType) {
                    case "MTF":
                        return this.questions[this.current_question].options['pairs'];
                    case "ORD":
                        return this.questions[this.current_question].options;
                    case "MMA":
                    case "FIB":
                        return [];
                    case "SAQ":
                    case "LAQ":
                    default:
                        return '';
                }
            },
            fetchQuestions() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_quiz_questions', {
                    quiz: this.quiz.slug,
                    session: this.session.code
                }))
                    .then(function (response) {
                        let data = response.data;
                        _this.questions = data.questions;
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
            transformSlotProps(props) {
                const formattedProps = {};

                Object.entries(props).forEach(([key, value]) => {
                    formattedProps[key] = value < 10 ? `0${value}` : String(value);
                });

                return formattedProps;
            },
            startTimer() {
                setInterval(this.incrementTime, 1000);
            },
            incrementTime() {
                this.total_time_taken = parseInt(this.total_time_taken) + 1;
                this.questions[this.current_question].time_taken = parseInt(this.questions[this.current_question].time_taken) + 1;
            },
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.quiz.title + ' - ' + this.$page.props.general.app_name;
            },
            appUrl() {
                return this.$page.props.appUrl;
            }
        },
        mounted() {
            this.fetchQuestions();
            // document.addEventListener('contextmenu', event => event.preventDefault());
        }
    }
</script>
