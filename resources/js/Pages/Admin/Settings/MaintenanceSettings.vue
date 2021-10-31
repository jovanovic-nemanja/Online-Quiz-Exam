<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                Maintenance Settings (v{{ appVersion }})
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <clear-cache-form></clear-cache-form>
                <arc-section-border />
                <expire-schedules-form></expire-schedules-form>
                <arc-section-border />
                <update-app-form></update-app-form>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import ClearCacheForm from "@/Pages/Admin/Settings/ClearCacheForm";
    import ExpireSchedulesForm from "@/Pages/Admin/Settings/ExpireSchedulesForm";
    import UpdateAppForm from "@/Pages/Admin/Settings/UpdateAppForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            ClearCacheForm,
            ExpireSchedulesForm,
            UpdateAppForm
        },
        props: {
            appVersion: String,
            homePageSettings: Object,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return 'Maintenance Settings - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
    }
</script>
