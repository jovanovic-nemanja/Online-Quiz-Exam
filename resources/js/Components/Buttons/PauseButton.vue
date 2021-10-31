<template>
    <div class="h-10 flex items-center justify-center gap-2 px-4 py-2 bg-yellow-500 hover:bg-yellow-600 text-white text-sm rounded border border-yellow-300 cursor-pointer">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 9v6m4-6v6m7-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
        <span>{{ name }}</span>
    </div>
</template>
<script>
    export default {
        props: {
            name: {
                type: String,
                default: 'Pause',
            },
        }
    }
</script>
