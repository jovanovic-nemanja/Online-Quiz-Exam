<template>
    <div class="q-inputs">
        <div class="font-mono px-2 py-1 inline-block bg-gray-100 text-gray-600 rounded text-sm mb-2">
            Type your answer in the below text box
        </div>
        <div :class="labelClass()">
            <div class="i-id">
                <label :for="question_id">A</label>
            </div>
            <input :id="question_id" v-model="answer" @change="selectAnswer" placeholder="Type your answer"/>
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
            labelClass() {
                if(this.answer !== "" && this.answer !== null) {
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
