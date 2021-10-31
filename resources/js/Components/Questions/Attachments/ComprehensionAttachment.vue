<template>
    <div class="audio-options">
        <div class="font-mono px-2 py-1 inline-block text-gray-600 rounded text-sm mb-2">
            Read the passage and answer the question
        </div>
        <perfect-scrollbar style="max-height: 24rem" ref="comScroll" :options="scrollbarOptions">
            <div v-html="passage"></div>
        </perfect-scrollbar>
    </div>
</template>
<script>
    import {PerfectScrollbar} from "vue2-perfect-scrollbar";

    export default {
        name: 'ComprehensionAttachment',
        components: {
            PerfectScrollbar
        },
        props: {
            passage: String,
        },
        data() {
            return {
                scrollbarOptions: {
                    suppressScrollX: true
                },
            }
        }
    }
</script>
