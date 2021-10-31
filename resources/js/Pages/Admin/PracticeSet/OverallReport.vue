<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ practiceSet.title }} - Overall Report</h4>
        </template>
        <template #actions>
            <inertia-link :href="route('practice-sets.detailed_report', { practice_set: practiceSet.id })" class="qt-btn qt-btn-success">
                Detailed Report
            </inertia-link>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="bg-white shadow rounded-lg w-full overflow-hidden">
                    <div class="grid sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
                        <admin-test-stat-card :title="'Total Attempts'" :count="stats.total_attempts"></admin-test-stat-card>
                        <admin-test-stat-card :title="'Unique Attempts'" :count="stats.unique_test_takers"></admin-test-stat-card>
                        <admin-test-stat-card :title="'Avg. Time Spent'" :count="stats.avg_time.detailed_readable"></admin-test-stat-card>
                        <admin-test-stat-card :title="'Avg. Score'" :count="stats.avg_score"></admin-test-stat-card>
                        <admin-test-stat-card :title="'High Score'" :count="stats.high_score"></admin-test-stat-card>
                        <admin-test-stat-card :title="'Low Score'" :count="stats.low_score"></admin-test-stat-card>
                        <admin-test-stat-card :title="'Avg. Accuracy'" :count="stats.avg_accuracy"></admin-test-stat-card>
                        <admin-test-stat-card :title="'Avg. Speed'" :count="stats.avg_speed"></admin-test-stat-card>
                    </div>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import AdminTestStatCard from "@/Components/Cards/AdminTestStatCard";
    export default {
        components: {
            AdminLayout,
            AdminTestStatCard,
        },
        props: {
            practiceSet: Object,
            stats: Object,
        },
        data() {
            return {
                loading: false,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.practiceSet.title + ' Overall Report - ' + this.$page.props.general.app_name;
            },
        }
    }
</script>
