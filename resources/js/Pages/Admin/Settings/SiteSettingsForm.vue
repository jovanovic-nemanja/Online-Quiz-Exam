<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            Site Settings
        </template>

        <template #description>
            Update site meta tags and registration settings.
        </template>

        <template #form>
            <!-- App Name -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="app_name" value="Site/App Name" />
                <arc-input id="app_name" type="text" class="mt-1 block w-full" v-model="form.app_name" autocomplete="app_name" />
                <arc-input-error :message="form.errors.app_name" class="mt-2" />
            </div>

            <!-- Tag Line -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="tag_line" value="Tag Line" />
                <arc-input id="tag_line" type="text" class="mt-1 block w-full" v-model="form.tag_line" autocomplete="tag_line" />
                <arc-input-error :message="form.errors.tag_line" class="mt-2" />
            </div>

            <!-- SEO Description -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="seo_description" value="SEO Description" />
                <arc-text-area id="seo_description" class="mt-1 block w-full" v-model="form.seo_description" />
                <arc-input-error :message="form.errors.seo_description" class="mt-2" />
            </div>

            <!-- Enable Registration -->
            <div class="p-4 bg-blue-50 rounded col-span-6 sm:col-span-4">
                <arc-label for="can_register" value="Enable User Registration" />
                <div class="flex justify-between items-center my-2">
                    <span class="text-sm text-blue-700">{{ form.can_register ? 'Enabled' : 'Disabled' }}</span>
                    <InputSwitch id="can_register" v-model="form.can_register" />
                </div>
                <arc-input-error :message="form.errors.can_register" class="mt-2" />
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
    import InputSwitch from "primevue/inputswitch";

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
            InputSwitch,
        },
        props: {
            settings: Object,
        },
        data() {
            return {
                form: this.$inertia.form({
                    app_name: this.settings.app_name,
                    tag_line: this.settings.tag_line,
                    seo_description: this.settings.seo_description,
                    can_register: this.settings.can_register,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_site_settings'), {
                    errorBag: 'updateSiteSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
