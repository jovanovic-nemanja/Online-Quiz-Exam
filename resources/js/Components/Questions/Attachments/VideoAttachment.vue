<template>
    <div class="audio-options">
        <div class="font-mono px-2 py-1 inline-block text-gray-600 rounded text-sm mb-2">
            Watch the video and answer the question
        </div>
        <div v-if="options.video_type === 'mp4'">
            <vue-plyr :ref="reference" :options="plyrOptions">
                <video :src="options.link">
                    <source :src="options.link" type="video/mp4">
                </video>
            </vue-plyr>
        </div>
        <div v-if="options.video_type === 'youtube'">
            <vue-plyr :ref="reference" :options="plyrOptions">
                <div class="plyr__video-embed">
                    <iframe :src="getVideoLink" allowfullscreen allowtransparency allow="autoplay"></iframe>
                </div>
            </vue-plyr>
        </div>
        <div v-if="options.video_type === 'vimeo'">
            <vue-plyr :ref="reference">
                <div class="plyr__video-embed">
                    <iframe :src="getVideoLink"></iframe>
                </div>
            </vue-plyr>
        </div>
    </div>
</template>
<script>
    import VuePlyr from 'vue-plyr';

    export default {
        name: 'VideoAttachment',
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
                    controls: ['play-large', 'play', 'progress', 'current-time', 'mute', 'volume', 'captions', 'settings', 'airplay', 'fullscreen'],
                    speed: { selected: 1, options: [0.5,1,1.25] }
                },
            }
        },
        computed: {
            getVideoLink() {
                if(this.options.video_type === 'youtube') {
                    return "https://www.youtube.com/embed/"+this.options.link+"?amp;iv_load_policy=3&amp;modestbranding=1&amp;playsinline=1&amp;showinfo=0&amp;rel=0&amp;enablejsapi=1";
                }
                if(this.options.video_type === 'vimeo') {
                    return "https://player.vimeo.com/video/"+this.options.link+"?loop=false&amp;byline=false&amp;portrait=false&amp;title=false&amp;speed=true&amp;transparent=0&amp;gesture=media"
                }
                return "";
            }
        }
    }
</script>
