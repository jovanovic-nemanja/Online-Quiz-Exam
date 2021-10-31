<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">{{ quiz.title }}</h4>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col items-center">
                    <div class="w-full sm:w-2/3">
                        <div class="card">
                            <div class="card-body">
                                <div class="w-full lg:flex flex-wrap px-2 py-2">
                                    <div class="py-4 lg:w-2/3 w-full md:pr-6 sm:border-r border-gray-200">
                                        <div class="inline-block bg-green-100 rounded mb-1">
                                            <p class="font-mono text-xs leading-loose text-center text-green-700 px-2">{{ quiz.category }}</p>
                                        </div>
                                        <h1 class="text-2xl font-semibold text-gray-800 leading-5 py-2">{{ quiz.title }}</h1>
                                        <div class="flex items-center mt-1">
                                            <div class="w-2 h-2 bg-yellow-600 rounded-full"></div>
                                            <p class="font-mono text-sm leading-3 text-yellow-600 ml-1">{{ quiz.type }}</p>
                                        </div>
                                        <hr class="my-8 border-t border-gray-200">
                                        <div class="flex items-center">
                                            <div>
                                                <p class="font-mono text-sm leading-3 mb-2 text-green-600">Total Duration</p>
                                                <p class="font-semibold leading-tight">{{ quiz.total_duration }} Mins</p>
                                            </div>
                                            <div class="ml-11">
                                                <p class="font-mono text-sm leading-3 mb-2 text-green-600">No. of Questions</p>
                                                <p class="font-semibold leading-tight">{{ quiz.total_questions }} Q</p>
                                            </div>
                                            <div class="ml-11">
                                                <p class="font-mono text-sm leading-3 mb-2 text-green-600">Total Marks</p>
                                                <p class="font-semibold leading-tight">{{ quiz.total_marks }} Marks</p>
                                            </div>
                                        </div>
                                        <hr class="my-8 border-t border-gray-200">
                                        <div class="text-gray-600 text-sm mb-2" v-html="quiz.description"></div>
                                        <hr class="my-8 border-t border-gray-200">
                                        <h4 class="text-gray-900 font-semibold mb-4">
                                            Quiz Instructions
                                        </h4>
                                        <div class="text-gray-800 text-sm mb-2">
                                            <ul class="ml-4 list-disc">
                                                <li v-for="instruction in instructions.quiz" v-html="instruction" class="text-sm leading-normal mb-2"></li>
                                            </ul>
                                        </div>
                                        <hr class="my-8 border-t border-gray-200">
                                        <h4 class="text-gray-900 font-semibold mb-4">
                                            Standard Instructions
                                        </h4>
                                        <div class="text-gray-800 text-sm mb-2">
                                            <ul class="ml-4 list-disc">
                                                <li v-for="instruction in instructions.standard" v-html="instruction" class="text-sm leading-normal mb-2"></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="py-4 lg:w-1/3 w-full md:pl-6">
                                        <h1 class="text-2xl font-semibold text-gray-800 leading-5 py-2">{{ quiz.redeem }}</h1>
                                        <div v-if="quiz.can_redeem && !quiz.uncompleted_sessions > 0" class="font-mono p-2 inline-block bg-yellow-50 text-yellow-500 rounded text-sm my-2">
                                            Note: You'll need {{ quiz.redeem }} for one attempt of this quiz. {{ quiz.redeem }} will be deducted from your wallet.
                                        </div>
                                        <div class="pt-2">
                                            <input type="checkbox" id="agree" v-model="agree">
                                            <label for="agree" class="ml-2 text-sm leading-normal font-normal text-gray-800 cursor-pointer">
                                                I've read all the instructions carefully and have understood them.
                                            </label>
                                        </div>
                                        <inertia-link v-if="agree" :href="route('init_quiz', {quiz: quiz.slug})" v-html="quiz.uncompleted_sessions > 0 ? 'Resume Test' : 'Start Test'"
                                                      class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 bg-green-700 rounded focus:outline-none hover:bg-green-600 text-white cursor-pointer">
                                        </inertia-link>
                                        <div v-else v-html="quiz.uncompleted_sessions > 0 ? 'Resume Test' : 'Start Test'"
                                                      class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 rounded bg-green-600 opacity-75 text-white">
                                        </div>
                                        <p class="font-mono text-sm mt-4 leading-normal text-gray-600" v-if="quiz.uncompleted_sessions > 0">
                                            Note: You have {{ quiz.uncompleted_sessions }} uncompleted session(s)
                                        </p>
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
    import QuizCard from "@/Components/Cards/QuizCard";

    export default {
        components: {
            AppLayout,
            QuizCard
        },
        props: {
            quiz: Object,
            instructions: Object
        },
        data() {
           return {
               agree: false,
           }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.quiz.title + ' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
