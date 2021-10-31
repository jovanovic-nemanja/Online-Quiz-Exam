<template>
    <div class="h-10 focus:outline-none flex items-center justify-center gap-2 px-4 py-2 text-white bg-gray-800 text-sm rounded cursor-pointer hover:bg-gray-700">
        <span>{{ name }}</span>
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
    </div>
</template>
<script>
    export default {
        props: {
            name: {
                type: String,
                default: 'Next',
            },
        }
    }
</script>
