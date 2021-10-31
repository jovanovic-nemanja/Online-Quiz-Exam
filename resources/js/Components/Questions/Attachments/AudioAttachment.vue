<template>
    <div class="audio-options z-40">
        <div class="font-mono px-2 py-1 inline-block text-gray-600 rounded text-sm mb-2">
            Listen to the audio and answer the question
        </div>
        <div v-if="options.audio_type === 'mp3'">
            <vue-plyr :ref="reference" :options="plyrOptions">
                <audio controls crossorigin>
                    <source :src="options.link" type="audio/mp3" />
                </audio>
            </vue-plyr>
        </div>
        <div v-if="options.audio_type === 'ogg'">
            <vue-plyr :ref="reference" :options="plyrOptions">
                <audio controls crossorigin>
                    <source :src="options.link" type="audio/ogg" />
                </audio>
            </vue-plyr>
        </div>
    </div>
</template>
<script>
    import VuePlyr from 'vue-plyr';

    export default {
        name: 'AudioAttachment',
        components: {
            VuePlyr,
        },
        props: {
            reference: String,
            options: Object,
        },
        data() {
            return {
                plyrOptions: {
                    speed: { selected: 1, options: [1] }
                }
            }
        },
    }
</script>
