<template>
    <div class="w-full overflow-hidden dark_question_card rounded cursor-pointer mb-1">
        <div :class="[active ? 'bg-gray-600 text-gray-200': 'text-gray-600']" class="hover:bg-gray-600 hover:text-gray-200 rounded p-4">
            <div class="flex items-start gap-4">
                <div :class="chipClasses" class="h-5 w-5 text-sm flex items-center justify-center border rounded-sm p-4">
                    <span class="leading-relaxed">{{ sno }}</span>
                </div>
                <div class="leading-relaxed text-sm" v-html="question.question"></div>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'LightQuestionCard',
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
                    return 'bg-green-400 text-white border-green-400';
                }
                if(this.status === 'not_answered') {
                    return 'bg-red-400 text-white border-red-400';
                }
                return this.active ? 'bg-gray-600 text-gray-400 hover:text-gray-200 border-gray-600': 'text-gray-400 hover:text-gray-200 border-gray-600';
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
