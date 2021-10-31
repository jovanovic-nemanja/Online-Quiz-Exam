<template>
    <div class="w-full overflow-hidden rounded-sm cursor-pointer">
        <div :class="chipClasses"
             class="h-10 w-10 text-sm flex items-center justify-center border hover:bg-gray-600 hover:border-gray-600 hover:text-gray-200 rounded-sm p-4">
            <span class="">{{ sno }}</span>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'ExamQuestionChip',
        props: {
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
                return this.active ? 'bg-gray-600 text-gray-200 border-gray-600': 'text-gray-600 border-gray-600';
            }
        }
    }
</script>
