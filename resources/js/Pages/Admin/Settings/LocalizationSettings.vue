<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                Localization Settings
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <localization-settings-form :settings="localizationSettings" :timezones="timezones" :languages="languages" />
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import LocalizationSettingsForm from "@/Pages/Admin/Settings/LocalizationSettingsForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            LocalizationSettingsForm,
        },
        props: {
            localizationSettings: Object,
            timezones: Array,
            languages: Array,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return 'Localization Settings - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
    }
</script>
