<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Learn & Practice') }}</h4>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="flex flex-col justify-center items-center">
                    <div class="w-full sm:w-2/3">
                        <div class="flex flex-col gap-4 justify-center px-4">
                            <template v-for="category in categories">
                                <practice-category-card :category="category"></practice-category-card>
                            </template>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import PracticeCategoryCard from "@/Components/Cards/PracticeCategoryCard";
    export default {
        components: {
            AppLayout,
            PracticeCategoryCard
        },
        props: {
            categories: Array,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return 'Practice Dashboard - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
