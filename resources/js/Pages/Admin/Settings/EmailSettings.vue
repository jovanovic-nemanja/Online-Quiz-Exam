<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                Email Settings
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <email-settings-form :settings="emailSettings" />
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import EmailSettingsForm from "@/Pages/Admin/Settings/EmailSettingsForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            EmailSettingsForm
        },
        props: {
            emailSettings: Object
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
