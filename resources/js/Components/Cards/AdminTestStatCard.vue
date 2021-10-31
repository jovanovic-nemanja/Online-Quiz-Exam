<template>
    <div class="ease-linear transition-all duration-150 w-full flex items-center justify-center py-12 group hover:bg-green-800 border-b border-r border-gray-200">
        <div class="flex flex-col items-center">
            <p class="focus:outline-none text-sm font-medium leading-none text-center group-hover:text-white text-gray-800">{{ title }}</p>
            <p class="focus:outline-none text-base sm:text-lg md:text-xl font-bold leading-normal text-center group-hover:text-white text-green-800 mt-3">{{ count }}</p>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'AdminTestStatCard',
        props: {
            title: String,
            hint: String,
            count: String|Number
        }
    }
</script>
