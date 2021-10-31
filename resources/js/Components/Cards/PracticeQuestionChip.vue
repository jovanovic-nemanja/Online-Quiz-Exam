<template>
    <div class="w-full overflow-hidden rounded-sm cursor-pointer">
        <div :class="chipClasses"
             class="h-10 w-10 text-sm flex items-center justify-center border hover:bg-gray-600 hover:text-gray-200 rounded-sm p-4">
            <span class="">{{ sno }}</span>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'PracticeQuestionChip',
        props: {
            sno: Number,
            active: Boolean,
            is_correct: Boolean,
            status: String,
        },
        computed: {
            chipClasses() {
                if(this.status === 'answered') {
                    return this.is_correct ? 'bg-green-400 text-white border-green-600': 'bg-red-400 text-white border-red-600';
                }
                return this.active ? 'bg-gray-600 text-gray-200 border-gray-600 text-white': 'border-gray-600 text-gray-400';
            }
        }
    }
</script>
