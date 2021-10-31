<template>
    <div class="q-inputs">
        <div v-if="!disable" class="font-mono px-2 py-1 inline-block bg-gray-100 text-gray-600 rounded text-sm mb-2">
            Type your answer in the below text box
        </div>
        <div :class="labelClass()">
            <div class="i-id">
                <label :for="question_id">A</label>
            </div>
            <input :id="question_id" v-model="answer" @change="selectAnswer" placeholder="Type your answer" :disabled="disable"/>
        </div>
        <div v-if="disable" class="flex gap-2 border border-green-200 bg-green-50 items-center rounded p-4 mt-6">
            <svg class="w-6 h-6 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            <h4 class=" text-gray-600" v-html="answerText"></h4>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'SAQInteractiveOptions',
        props: {
            parentQid: [Number, String],
            parentOptions: [String, Array, Number],
            parentAnswer: [String, Array, Number],
            correctAnswer: [String, Array, Number],
            isCorrect: Boolean,
            status: String,
            solutionMode: false,
        },
        data() {
            return {
                question_id: this.parentQid,
                options: this.parentOptions,
                answer: this.parentAnswer,
            }
        },
        watch: {
            parentAnswer: function (newAnswer, oldAnswer) {
                this.answer = newAnswer;
            }
        },
        methods: {
            selectAnswer(event) {
                this.touched = true;
                this.$emit('modifyAnswer', this.answer);
            },
            labelClass() {
                if(this.status === 'answered') {
                    if(this.isCorrect) {
                        return 'q-input correct';
                    } else {
                        return 'q-input wrong';
                    }
                } else {
                    if(this.answer !== "") {
                        return 'q-input answered'
                    }
                    return 'q-input';
                }
            }
        },
        computed: {
            disable() {
                return this.status === 'answered' || this.solutionMode;
            },
            answerText() {
                if(this.disable) {
                    let answers = this.correctAnswer.sort();
                    let str = answers.join(", ")
                    return 'Acceptable answers are '+str;
                }
                return '';
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
