<template>
    <div class="h-10 flex items-center justify-center gap-2 px-4 py-2 bg-green-400 hover:bg-green-600 shadow-inner text-sm text-white rounded border border-green-300 cursor-pointer">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
        <span>{{ name }}</span>
    </div>
</template>
<script>
    export default {
        props: {
            name: {
                type: String,
                default: 'Submit',
            },
        }
    }
</script>
