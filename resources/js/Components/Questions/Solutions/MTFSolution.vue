<template>
    <div class="q-radio">
        <div class="flex flex-col sm:flex-row gap-2 q-options">
            <div class="w-full flex flex-col justify-between">
                <div v-for="(item, index) in options" :key="item.id" class="q-option h-full">
                    <label class="h-full" :for="question_id+'_option_'+index">
                        <span class="o-id"><strong>{{ index+1 }}</strong></span>
                        <span class="o-text" v-html="item.value"></span>
                    </label>
                </div>
            </div>
            <div class="w-full">
                <draggable v-model="answer" group="options" :sort="false">
                    <transition-group name="flip-list" tag="div" class="w-full flex flex-col justify-between">
                        <div v-for="(item, index) in answer" :key="item.id" class="q-option h-full">
                            <label class="h-full" :for="question_id+'_pair_'+index" :class="labelClass(index)">
                                <span class="o-id match"><strong>{{ index+1 }}</strong> - <strong>{{ item.code }}</strong></span>
                                <span class="o-text" v-html="item.value"></span>
                            </label>
                        </div>
                    </transition-group>
                </draggable>
            </div>
        </div>
        <div class="flex gap-2 border border-green-200 bg-green-50 items-center rounded p-4 mt-6">
            <svg class="w-6 h-6 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            <h4 class="text-sm text-gray-600" v-html="answerText"></h4>
        </div>
    </div>
</template>
<script>
    import draggable from 'vuedraggable'
    export default {
        name: 'MTFSolution',
        components: {
            draggable,
        },
        props: {
            parentQid: [Number, String],
            parentOptions: [Array, Object],
            parentAnswer: [Array, Object],
            correctAnswer: [String, Array, Number],
            isCorrect: Boolean,
            status: String,
        },
        data() {
            return {
                question_id: this.parentQid,
                options: this.parentOptions['matches'],
                answer: this.status === 'answered' ? this.parentAnswer : this.parentOptions['pairs'],
            }
        },
        methods: {
            labelClass(index) {
                if(this.status === 'answered') {
                    if(this.answer[index].id === this.correctAnswer[index]) {
                        return 'correct';
                    } else {
                        return 'wrong';
                    }
                } else {
                    return '';
                }
            }
        },
        computed: {
            answerText() {
                let _this = this;
                let answers = [];
                this.correctAnswer.forEach(function (item, index) {
                    let obj = _this.answer.find(o => o.id === item);
                    answers.push((index+1) + " - " +obj.code)
                });
                let str = answers.join(", ");
                return 'Correct answers are '+str;
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
