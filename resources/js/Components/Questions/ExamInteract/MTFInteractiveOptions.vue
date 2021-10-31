<template>
    <div class="q-radio">
        <div class="font-mono px-2 py-1 inline-block bg-gray-100 text-gray-600 rounded text-sm mb-2">
            Match the following by drag and drop right side items
        </div>
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
                <draggable v-model="answer" group="options" @end="selectAnswer">
                    <transition-group name="flip-list" tag="div" class="w-full flex flex-col justify-between">
                        <div v-for="(item, index) in answer" :key="item.id" class="q-option h-full">
                            <label class="h-full" :for="question_id+'_pair_'+index" :class="labelClass(index)">
                                <span class="o-id match"><strong>{{ index+1 }}</strong> - <strong>{{ item.code }}</strong></span>
                                <span class="o-text" v-html="item.value"></span>
                                <span class="o-bars text-gray-400">
                                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
                                </span>
                            </label>
                        </div>
                    </transition-group>
                </draggable>
            </div>
        </div>
    </div>
</template>
<script>
    import draggable from 'vuedraggable'
    export default {
        name: 'MTFInteractiveOptions',
        components: {
            draggable,
        },
        props: {
            parentQid: [Number, String],
            parentOptions: [Array, Object],
            parentAnswer: [Array, Object],
            status: String
        },
        data() {
            return {
                question_id: this.parentQid,
                options: this.parentOptions['matches'],
                answer: typeof this.parentAnswer !== 'undefined' && this.status === 'answered' ? this.parentAnswer : this.parentOptions['pairs'],
                touched: false,
            }
        },
        watch: {
            parentAnswer: function (newAnswer, oldAnswer) {
                this.answer = newAnswer;
            }
        },
        methods: {
            selectAnswer (event) {
                this.touched = true;
                this.$emit('modifyAnswer', this.answer);
            },
            labelClass(index) {
                if(this.touched || this.status === 'answered') {
                    return 'answered cursor-move'
                }
                return 'cursor-move';
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
