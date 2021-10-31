<template>
    <div class="w-full flex flex-col justify-between items-start rounded shadow bg-white py-6 px-6 hover:shadow-lg">
        <div class="flex items-center justify-center bg-green-100 rounded mb-1">
            <p class="font-mono text-xs leading-loose text-center text-green-700 px-2">{{ practiceSet.skill }}</p>
        </div>
        <h1 class="text-lg font-semibold text-gray-800 leading-5 py-2">{{ practiceSet.title }}</h1>
        <div class="w-full flex items-end justify-between mt-4">
            <h2 class="font-mono text-gray-600 text-sm">{{ practiceSet.total_questions }} Questions</h2>
            <slot name="action"></slot>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'PracticeSetCard',
        props: {
            practiceSet: Object
        }
    }
</script>
