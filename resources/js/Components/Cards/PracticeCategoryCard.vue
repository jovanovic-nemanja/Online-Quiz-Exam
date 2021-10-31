<template>
    <div class="flex justify-center sm:px-6 px-4">
        <div class="w-full rounded shadow bg-white dark:bg-gray-800 py-6 px-6">
            <div class="flex items-center justify-between mb-4">
                <p class="md:pr-96 font-semibold leading-4 text-green-800">{{ category.name }}</p>
                <p class="font-mono text-sm leading-3 pl-6 text-right text-gray-500 dark:text-gray-400">{{ category.category }} {{ category.type }}</p>
            </div>
            <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 items-center justify-between">
                <template v-for="section in category.sections">
                    <inertia-link :href="route('section_practice_sets', {category: category.slug, section: section.slug})">
                        <section-card :section="section"></section-card>
                    </inertia-link>
                </template>
            </div>
        </div>
    </div>
</template>
<script>
    import SectionCard from "@/Components/Cards/SectionCard";
    export default {
        name: 'PracticeCategoryCard',
        components: {
            SectionCard
        },
        props: {
            category: Object
        }
    }
</script>
