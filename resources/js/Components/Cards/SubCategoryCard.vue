<template>
    <div class="card w-full cursor-pointer hover:shadow-lg">
        <inertia-link :href="route('practice_skills', {category: category.slug})">
            <div class="card-body h-28 flex flex-col justify-center items-center">
                <div class="font-semibold mb-2">{{ category.name }}</div>
                <div class="flex items-center justify-center bg-green-100 rounded">
                    <p class="text-xs leading-loose text-center text-green-700 px-2">{{ category.category }} {{ category.type }}</p>
                </div>
            </div>
        </inertia-link>
    </div>
</template>
<script>
    export default {
        name: 'SubCategoryCard',
        props: {
            category: Object
        }
    }
</script>
