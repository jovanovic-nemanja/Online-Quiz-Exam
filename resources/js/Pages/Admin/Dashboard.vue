<template>
    <admin-layout>
        <div class="container mx-auto py-4 px-4 sm:px-6 lg:px-8">
            <div class="flex flex-wrap mb-6">
                <div class="w-full">
                    <div class="w-full grid sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                        <dashboard-stat v-for="stat in stats" :key="stat.key" :title="stat.title" :count="stat.count"></dashboard-stat>
                    </div>
                </div>
            </div>
            <div class="flex flex-wrap mb-6">
                <div class="w-full">
                    <div class="w-full grid sm:grid-cols-1 md:grid-cols-2 gap-8">
                        <admin-help></admin-help>
                        <admin-quick-links></admin-quick-links>
                    </div>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import DashboardStat from "@/Components/Cards/DashboardStat";
    import AdminQuickLinks from "@/Components/Widgets/AdminQuickLinks";
    import AdminHelp from "@/Components/Widgets/AdminHelp";

    export default {
        components: {
            AdminLayout,
            DashboardStat,
            AdminQuickLinks,
            AdminHelp
        },
        props: {
            stats: Array
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return 'Dashboard - ' + this.$page.props.general.app_name + ' Admin';
            }
        },
    }
</script>
