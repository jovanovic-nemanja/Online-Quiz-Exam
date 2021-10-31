<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            Site Favicon
        </template>

        <template #description>
            Update site icon.
        </template>

        <template #form>

            <!-- Site Logo -->
            <div class="col-span-6 sm:col-span-4">
                <input id="icon" type="file" class="hidden"
                       name="icon" ref="icon"
                       @change="updateLogoPreview">

                <arc-label for="icon" value="Site Icon" />

                <div class="mt-2" v-show="!logoPreview">
                    <img :src="$page.props.assetUrl + settings.favicon_path" :alt="settings.app_name" class="h-20 object-cover">
                </div>

                <!-- New Logo Preview -->
                <div class="mt-2" v-show="logoPreview">
                                <span class="block h-20"
                                      :style="'background-size: contain; background-repeat: no-repeat; background-position: center center; background-image: url(\'' + logoPreview + '\');'">
                                </span>
                </div>

                <arc-secondary-button class="mt-2 mr-2" type="button" @click.native.prevent="selectNewLogo">
                    Select A New Icon
                </arc-secondary-button>

                <arc-input-error :message="form.errors.favicon_path" class="mt-2" />
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
    import ArcInputError from "@/Components/InputError";
    import ArcLabel from "@/Components/Label";
    import ArcSecondaryButton from "@/Components/SecondaryButton";
    import InputSwitch from "primevue/inputswitch";

    export default {
        components: {
            AdminLayout,
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
            ArcInputError,
            ArcLabel,
            ArcSecondaryButton,
            InputSwitch,
        },
        props: {
            settings: Object,
        },
        data() {
            return {
                form: this.$inertia.form({
                    favicon_path: this.settings.favicon_path,
                }),
                logoPreview: null,
            }
        },
        methods: {
            updateSettings() {
                if (this.$refs.icon) {
                    this.form.favicon_path = this.$refs.icon.files[0]
                }

                this.form.post(route('update_favicon'), {
                    errorBag: 'updateFavicon',
                    preserveScroll: true
                });
            },

            selectNewLogo() {
                this.$refs.icon.click();
            },

            updateLogoPreview() {
                const logoReader = new FileReader();

                logoReader.onload = (e) => {
                    this.logoPreview = e.target.result;
                };

                logoReader.readAsDataURL(this.$refs.icon.files[0]);
            },
        },
    }
</script>
