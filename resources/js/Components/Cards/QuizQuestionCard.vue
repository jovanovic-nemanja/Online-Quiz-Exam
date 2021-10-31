<template>
    <div class="q-data">
        <div class="flex gap-2 mb-4">
            <span class="text-sm font-semibold">{{ sno }} of {{ totalQuestions }}</span>
            <span class="text-sm">|</span>
            <span class="text-sm text-gray-600 uppercase">{{ question.skill }}</span>
        </div>
        <div class="question" v-html="question.question"></div>
    </div>
</template>
<script>
    export default {
        name: 'QuizQuestionCard',
        props: {
            question: Object,
            sno: Number,
            totalQuestions: Number
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
