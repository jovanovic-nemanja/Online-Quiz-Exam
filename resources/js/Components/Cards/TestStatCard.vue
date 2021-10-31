<template>
    <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
        <div class="absolute w-2 h-4 bg-green-700 left-0"></div>
        <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base">{{ title }}</h3>
        <div class="flex flex-col items-end">
            <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ count }}</h2>
            <p v-if="hint" class="focus:outline-none ml-2 mb-1 text-sm text-gray-600 dark:text-gray-400">{{ hint }}</p>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'TestStatCard',
        props: {
            title: String,
            hint: String,
            count: String|Number
        }
    }
</script>
