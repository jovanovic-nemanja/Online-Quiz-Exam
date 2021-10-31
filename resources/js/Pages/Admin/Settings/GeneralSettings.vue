<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                General Settings
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <site-settings-form :settings="siteSettings" />
                <arc-section-border />
                <site-logo-form :settings="siteSettings" />
                <arc-section-border />
                <site-favicon-form :settings="siteSettings" />
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import SiteSettingsForm from "@/Pages/Admin/Settings/SiteSettingsForm";
    import SiteLogoForm from "@/Pages/Admin/Settings/SiteLogoForm";
    import SiteFaviconForm from "@/Pages/Admin/Settings/SiteFaviconForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            SiteSettingsForm,
            SiteLogoForm,
            SiteFaviconForm
        },
        props: {
            siteSettings: Object,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return 'General Settings - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
    }
</script>
