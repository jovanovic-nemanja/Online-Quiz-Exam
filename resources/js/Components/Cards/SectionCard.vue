<template>
    <div class="flex flex-col justify-center items-center p-4 rounded hover:bg-blue-50 cursor-pointer">
        <div class="flex items-center justify-center w-12 h-12 bg-purple-100 rounded-full">
            <span class="font-mono font-semibold">{{ section.name.charAt(0) }}</span>
        </div>
        <div class="pt-4 text-center">
            <p class="text-sm leading-none text-gray-800">{{ section.name }}</p>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'SectionCard',
        props: {
            section: Object
        }
    }
</script>
