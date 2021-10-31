<template>
    <div class="q-data rounded bg-yellow-50 border border-yellow-200 p-6">
        <h4 class="font-semibold text-gray-600 mb-4">SOLUTION</h4>
        <div v-html="solution"></div>
    </div>
</template>
<script>
    export default {
        name: 'PracticeSolutionCard',
        props: {
            solution: String,
            correctAnswer: String
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
