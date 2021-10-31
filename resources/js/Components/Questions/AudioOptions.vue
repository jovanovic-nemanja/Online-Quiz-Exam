<template>
    <div class="audio-options">
        <div class="w-full flex flex-col mb-6">
            <label class="pb-2 text-sm font-semibold text-gray-800">
                Audio Type (Supported .mp3 & .ogg files)
            </label>
            <SelectButton @input="changePlayer" v-model="options.audio_type" :options="audioFormats" optionLabel="name" optionValue="value" dataKey="value"></SelectButton>
        </div>
        <div class="w-full flex flex-col mb-6">
            <label for="audio_link" class="pb-2 text-sm font-semibold text-gray-800">
                Audio Link
            </label>
            <InputText @input="selectOptions" id="audio_link" v-model="options.link" placeholder="Enter Link" aria-describedby="audio_link-help" />
        </div>
        <div class="my-4 flex">
            <Button type="button" @click="showPlayer" icon="pi pi-play" label="Preview" />
        </div>
        <div v-if="player && options.audio_type === 'mp3'">
            <vue-plyr>
                <audio controls crossorigin playsinline>
                    <source :src="getAudioLink" type="audio/mp3" />
                </audio>
            </vue-plyr>
        </div>
        <div v-if="player && options.audio_type === 'ogg'">
            <vue-plyr>
                <audio controls crossorigin playsinline>
                    <source :src="getAudioLink" type="audio/ogg" />
                </audio>
            </vue-plyr>
        </div>
    </div>
</template>
<script>
    import InputText from 'primevue/inputtext';
    import SelectButton from 'primevue/selectbutton';
    import VuePlyr from 'vue-plyr';
    import Button from 'primevue/button';

    export default {
        name: 'AudioOptions',
        components: {
            InputText,
            SelectButton,
            VuePlyr,
            Button
        },
        props: {
            parentOptions: Object,
        },
        data: function () {
            return {
                options: this.parentOptions,
                audioFormats: [
                    {value: 'mp3', name: 'MP3 Format'},
                    {value: 'ogg', name: 'OGG Format'}
                ],
                player: false,
            }
        },
        methods: {
            showPlayer() {
                this.player = false;
                if(this.options.link !== "" &&  this.options.link !== null) {
                    this.$nextTick(() => {
                        this.player = true;
                    });
                }
            },
            changePlayer(format) {
                this.player = false;
                this.options.link = '';
                this.selectOptions();
            },
            selectOptions () {
                this.$emit('modifyOptions', this.options)
            }
        },
        computed: {
            getAudioLink() {
                return this.options.link;
            }
        },
        created() {
            if(this.options === null) {
                this.options = {audio_type: 'mp3', link: ''};
            }
        }
    }
</script>
