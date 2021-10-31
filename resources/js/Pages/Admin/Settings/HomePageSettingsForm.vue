<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            Home Page Hero Settings
        </template>

        <template #description>
            Update home page hero section details.
        </template>

        <template #form>
            <!-- Hero Title -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="hero_title" value="Home Hero Title" />
                <arc-input id="hero_title" type="text" class="mt-1 block w-full" v-model="form.hero_title" autocomplete="hero_title" />
                <arc-input-error :message="form.errors.hero_title" class="mt-2" />
            </div>

            <!-- Hero Subtitle -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="hero_subtitle" value="Home Hero Subtitle" />
                <arc-text-area id="hero_subtitle" class="mt-1 block w-full" v-model="form.hero_subtitle" />
                <arc-input-error :message="form.errors.hero_subtitle" class="mt-2" />
            </div>

            <!-- Tag Line -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="hero_cta_text" value="Home Hero CTA Text" />
                <arc-input id="hero_cta_text" type="text" class="mt-1 block w-full" v-model="form.hero_cta_text" autocomplete="hero_cta_text" />
                <arc-input-error :message="form.errors.hero_cta_text" class="mt-2" />
            </div>


            <!-- Hero Image Path -->
            <div class="col-span-6 sm:col-span-4">
                <input type="file" class="hidden"
                       ref="image"
                       @change="updateImagePreview">

                <arc-label for="image" value="Home Hero Image" />

                <div class="mt-2" v-show="!imagePreview">
                    <img :src="$page.props.assetUrl + settings.hero_image_path" alt="Hero Image" class="h-20 object-cover">
                </div>

                <!-- New Profile Photo Preview -->
                <div class="mt-2" v-show="imagePreview">
                                <span class="block h-20"
                                      :style="'background-size: contain; background-repeat: no-repeat; background-position: center center; background-image: url(\'' + imagePreview + '\');'">
                                </span>
                </div>

                <arc-secondary-button class="mt-2 mr-2" type="button" @click.native.prevent="selectNewImage">
                    Select A New Image
                </arc-secondary-button>

                <arc-input-error :message="form.errors.hero_image_path" class="mt-2" />
            </div>
        </template>

        <template #actions>
            <arc-action-message :on="form.recentlySuccessful" class="mr-3">
                Saved.
            </arc-action-message>

            <arc-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                Save
            </arc-button>
        </template>
    </arc-form-section>
</template>
<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcActionMessage from "@/Components/ActionMessage";
    import ArcButton from "@/Components/Button";
    import ArcFormSection from "@/Components/FormSection";
    import ArcInput from "@/Components/Input";
    import ArcTextArea from "@/Components/TextArea";
    import ArcInputError from "@/Components/InputError";
    import ArcLabel from "@/Components/Label";
    import ArcSecondaryButton from "@/Components/SecondaryButton";

    export default {
        components: {
            AdminLayout,
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
            ArcInput,
            ArcTextArea,
            ArcInputError,
            ArcLabel,
            ArcSecondaryButton,
        },
        props: {
            settings: Object
        },
        data() {
            return {
                form: this.$inertia.form({
                    hero_title: this.settings.hero_title,
                    hero_subtitle: this.settings.hero_subtitle,
                    hero_cta_text: this.settings.hero_cta_text,
                    hero_image_path: this.settings.hero_image_path,
                }),
                imagePreview: null,
            }
        },
        methods: {
            updateSettings() {
                if (this.$refs.image) {
                    this.form.hero_image_path = this.$refs.image.files[0]
                }

                this.form.post(route('update_home_page_settings'), {
                    errorBag: 'updateHomePageSettings',
                    preserveScroll: true
                });
            },

            selectNewImage() {
                this.$refs.image.click();
            },

            updateImagePreview() {
                const reader = new FileReader();

                reader.onload = (e) => {
                    this.imagePreview = e.target.result;
                };

                reader.readAsDataURL(this.$refs.image.files[0]);
            },
        },
    }
</script>
