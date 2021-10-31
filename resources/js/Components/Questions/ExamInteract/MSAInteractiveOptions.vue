<template>
    <div class="q-radio">
            <div class="font-mono px-2 py-1 inline-block bg-gray-100 text-gray-600 rounded text-sm mb-2">
                Choose one from below options
            </div>
            <div class="q-options">
                <div v-for="(option, index) in options" :key="option" class="q-option">
                    <input type="radio" @change="selectAnswer" :id="question_id+'_option_'+index" v-model="answer" :value="index+1">
                    <label :class="labelClass(index)" class="cursor-pointer" :for="question_id+'_option_'+index">
                        <span class="o-id"><strong>{{ index+1 }}</strong></span>
                        <span class="o-text" v-html="option"></span>
                    </label>
                </div>
            </div>
    </div>
</template>
<script>
    export default {
        name: 'MSAInteractiveOptions',
        props: {
            parentQid: [Number, String],
            parentOptions: Array,
            parentAnswer: [String, Array, Number],
            status: String
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
            selectAnswer (event) {
                this.$emit('modifyAnswer', this.answer);
            },
            labelClass(index) {
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
