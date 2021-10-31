<template>
    <div class="w-full relative flex flex-col justify-between items-start rounded shadow bg-white py-6 px-6 hover:shadow-lg">
        <div class="flex items-center justify-center bg-green-100 rounded mb-1">
            <p class="font-mono text-xs leading-loose text-center text-green-700 px-2">{{ quiz.category }}</p>
        </div>
        <h1 class="text-lg mt-2 font-semibold text-gray-800 leading-5 py-2">{{ quiz.title }}</h1>
        <div class="absolute top-5 right-0 py-2 px-5 flex justify-center items-center bg-gray-700">
            <p class="text-sm font-bold leading-none text-white">{{ quiz.redeem }}</p>
        </div>
        <div class="w-full flex flex-col sm:gap-4 items-center">
            <div v-if="quiz.scheduleType === 'Fixed'" class="w-full mt-4 p-4 rounded-sm bg-yellow-50 border border-yellow-100 flex flex-col gap-4">
                <p class="text-sm uppercase font-mono font-medium leading-3 text-yellow-600">Fixed Schedule Time</p>
                <div class="flex items-center text-gray-600">
                    <i class="pi pi-calendar text-green-500"></i>
                    <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ml-2">{{ quiz.starts_at }}</p>
                </div>
                <div class="flex items-center text-gray-600">
                    <i class="pi pi-clock text-red-500"></i>
                    <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ml-2">{{ quiz.ends_at }}</p>
                </div>
                <div class="flex items-center text-gray-600">
                    <i class="pi pi-globe text-green-500"></i>
                    <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ml-2">Timezone - {{ quiz.timezone }}</p>
                </div>
            </div>
            <div v-else class="w-full mt-4 p-4 rounded-sm bg-yellow-50 border border-yellow-100 flex flex-col gap-4">
                <p class="text-sm uppercase font-mono font-medium leading-3 text-yellow-600">Quiz Available Between</p>
                <div class="flex items-center text-gray-600">
                    <i class="pi pi-calendar text-green-500"></i>
                    <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ml-2">{{ quiz.starts_at }}</p>
                </div>
                <div class="flex items-center text-gray-600">
                    <i class="pi pi-calendar text-red-500"></i>
                    <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ml-2">{{ quiz.ends_at }}</p>
                </div>
                <div class="flex items-center text-gray-600">
                    <i class="pi pi-globe text-green-500"></i>
                    <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ml-2">Timezone - {{ quiz.timezone }}</p>
                </div>
            </div>
            <div class="w-full my-4">
                <div class="flex items-center">
                    <div>
                        <p class="text-lg font-semibold leading-tight text-green-600">{{ quiz.total_questions }}</p>
                        <p class="font-mono text-sm leading-3 mt-2 text-gray-500">Questions</p>
                    </div>
                    <div class="ml-11">
                        <p class="text-lg font-semibold leading-tight text-green-600">{{ quiz.total_duration }}</p>
                        <p class="font-mono text-sm leading-3 mt-2 text-gray-500">Minutes</p>
                    </div>
                    <div class="ml-11">
                        <p class="text-lg font-semibold leading-tight text-green-600">{{ quiz.total_marks }}</p>
                        <p class="font-mono text-sm leading-3 mt-2 text-gray-500">Marks</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="w-full flex items-center justify-between mt-4">
            <div class="flex items-center py-2">
                <div class="w-2 h-2 bg-yellow-600 rounded-full"></div>
                <p class="font-mono text-sm leading-3 text-yellow-600 ml-1">{{ quiz.type }}</p>
            </div>
            <slot name="action"></slot>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'QuizScheduleCard',
        props: {
            quiz: Object
        }
    }
</script>
