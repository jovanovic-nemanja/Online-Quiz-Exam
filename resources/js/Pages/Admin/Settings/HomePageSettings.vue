<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                Home Page Settings
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <home-page-settings-form :settings="homePageSettings"></home-page-settings-form>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import HomePageSettingsForm from "@/Pages/Admin/Settings/HomePageSettingsForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            HomePageSettingsForm
        },
        props: {
            homePageSettings: Object,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return 'Home Page Settings - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
    }
</script>
