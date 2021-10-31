<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            Localization Settings
        </template>

        <template #description>
            Update timezone and locale settings.
        </template>

        <template #form>
            <!-- Default Locale -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="locale" value="Default Locale" />
                <v-select id="locale" v-model="form.default_locale" :options="languages"
                          :reduce="lang => lang.id" label="name" placeholder="Select a Locale"/>
                <arc-input-error :message="form.errors.default_locale" class="mt-2" />
            </div>
            <!-- Default Timezone -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="timezone" value="Default Timezone" />
                <v-select id="timezone" v-model="form.default_timezone" :options="timezones"
                          placeholder="Select a Timezone"/>
                <arc-input-error :message="form.errors.default_timezone" class="mt-2" />
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
    import vSelect from "vue-select";

    export default {
        name: "LocalizationSettingsForm",
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
            vSelect
        },
        props: {
            settings: Object,
            timezones: Array,
            languages: Array
        },
        data() {
            return {
                form: this.$inertia.form({
                    default_locale: this.settings.default_locale,
                    default_timezone: this.settings.default_timezone,
                }),
                imagePreview: null,
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_localization_settings'), {
                    errorBag: 'updateLocalizationSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
