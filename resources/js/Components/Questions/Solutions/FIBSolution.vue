<template>
    <div class="q-inputs">
        <div v-for="(blank, index) in options" :key="'blank_'+index">
            <div class="mb-2" :class="labelClass(index)">
                <div class="i-id">
                    <label :for="question_id+'ans_'+(blank-1)">{{ blank }}</label>
                </div>
                <input :id="question_id+'ans_'+(blank-1)" v-model="answer[blank-1]"
                       :placeholder="'Type your answer for blank '+ blank" disabled="disabled"/>
            </div>
        </div>
        <div class="flex gap-2 border border-green-200 bg-green-50 items-center rounded p-4 mt-6">
            <svg class="w-6 h-6 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            <h4 class="text-gray-600" v-html="answerText"></h4>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'FIBSolution',
        props: {
            parentQid: [Number, String],
            parentOptions: [String, Array, Number],
            parentAnswer: [String, Array, Number],
            correctAnswer: [String, Array, Number],
            isCorrect: Boolean,
            status: String,
        },
        data() {
            return {
                question_id: this.parentQid,
                options: this.parentOptions,
                answer: this.parentAnswer,
            }
        },
        methods: {
            labelClass(index) {
                if(this.status === 'answered') {
                    if(this.answer[index].toLowerCase() === this.correctAnswer[index].toLowerCase()) {
                        return 'q-input correct';
                    } else {
                        return 'q-input wrong';
                    }
                } else {
                    return 'q-input';
                }
            }
        },
        computed: {
            answerText() {
                let answers = this.correctAnswer.map(function (value, index) {
                    return (index + 1) + '. ' + value;
                }).join(', ');
                return 'Correct answers for the blanks are '+answers;
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
