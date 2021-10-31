<template>
    <div class="w-full overflow-hidden dark_question_card rounded cursor-pointer mb-1">
        <div :class="[active ? 'bg-gray-600 text-gray-200': 'text-gray-400']" class="hover:bg-gray-600 hover:text-gray-200 rounded p-4">
            <div class="flex items-start gap-4">
                <div :class="chipClasses" class="h-5 w-5 text-sm flex items-center justify-center border border-gray-600 rounded p-4">
                    <span class="leading-relaxed">{{ sno }}</span>
                </div>
                <div class="leading-relaxed text-sm" v-html="question.question"></div>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'DarkQuestionCard',
        props: {
            question: Object,
            sno: Number,
            active: Boolean,
            is_correct: Boolean,
            status: String,
        },
        computed: {
            chipClasses() {
                if(this.status === 'answered') {
                    return this.is_correct ? 'bg-green-400 text-white': 'bg-red-400 text-white';
                }
                return this.active ? 'bg-gray-600 text-gray-200': 'text-gray-400';
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
