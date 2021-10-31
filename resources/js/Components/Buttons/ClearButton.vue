<template>
    <div class="h-10 flex items-center justify-center gap-2 px-4 py-2 bg-white text-red-600 hover:bg-red-600 hover:text-white text-sm rounded border border-red-600 cursor-pointer">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
        <span>{{ name }}</span>
    </div>
</template>
<script>
    export default {
        props: {
            name: {
                type: String,
                default: 'Clear Response',
            },
        }
    }
</script>
