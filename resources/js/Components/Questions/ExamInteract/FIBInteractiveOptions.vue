<template>
    <div class="q-inputs">
        <div class="font-mono px-2 py-1 inline-block bg-gray-100 text-gray-600 rounded text-sm mb-2">
            Fill the blanks in the below text boxes
        </div>
        <div v-for="(blank, index) in options" :key="'blank_'+index">
            <div :class="labelClass(index)">
                <div class="i-id">
                    <label :for="question_id+'ans_'+(blank-1)">{{ blank }}</label>
                </div>
                <input :id="question_id+'ans_'+(blank-1)" v-model="answer[blank-1]" @change="selectAnswer"
                       :placeholder="'Type your answer for blank '+ blank"/>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'FIBInteractiveOptions',
        props: {
            parentQid: [Number, String],
            parentOptions: [String, Array, Number],
            parentAnswer: [String, Array, Number],
            status: String,
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
            labelClass(index) {
                if(this.answer[index] && (this.answer[index] !== "" || this.answer[index] !== null)) {
                    return 'q-input answered'
                }
                return 'q-input';
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
