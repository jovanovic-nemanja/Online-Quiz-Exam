<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            Site Logo
        </template>

        <template #description>
            Update site logo.
        </template>

        <template #form>

            <!-- Site Logo -->
            <div class="col-span-6 sm:col-span-4">
                <input id="logo" type="file" class="hidden"
                       name="logo" ref="logo"
                       @change="updateLogoPreview">

                <arc-label for="logo" value="Site Logo" />

                <div class="mt-2" v-show="!logoPreview">
                    <img :src="$page.props.assetUrl + settings.logo_path" :alt="settings.app_name" class="h-20 object-cover">
                </div>

                <!-- New Logo Preview -->
                <div class="mt-2" v-show="logoPreview">
                                <span class="block h-20"
                                      :style="'background-size: contain; background-repeat: no-repeat; background-position: center center; background-image: url(\'' + logoPreview + '\');'">
                                </span>
                </div>

                <arc-secondary-button class="mt-2 mr-2" type="button" @click.native.prevent="selectNewLogo">
                    Select A New Logo
                </arc-secondary-button>

                <arc-input-error :message="form.errors.logo_path" class="mt-2" />
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
                    logo_path: this.settings.logo_path,
                }),
                logoPreview: null,
            }
        },
        methods: {
            updateSettings() {
                if (this.$refs.logo) {
                    this.form.logo_path = this.$refs.logo.files[0]
                }

                this.form.post(route('update_logo'), {
                    errorBag: 'updateLogo',
                    preserveScroll: true
                });
            },

            selectNewLogo() {
                this.$refs.logo.click();
            },

            updateLogoPreview() {
                const logoReader = new FileReader();

                logoReader.onload = (e) => {
                    this.logoPreview = e.target.result;
                };

                logoReader.readAsDataURL(this.$refs.logo.files[0]);
            },
        },
    }
</script>
