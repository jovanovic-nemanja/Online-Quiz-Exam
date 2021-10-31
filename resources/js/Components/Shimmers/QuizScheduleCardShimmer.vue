<template>
    <div class="bg-white opacity-75 rounded p-4 mb-6">
        <Skeleton width="10rem" class="mb-2"></Skeleton>
        <Skeleton height="1rem"></Skeleton>
    </div>
</template>
<script>
    import Skeleton from 'primevue/skeleton';
    export default {
        name: "QuizScheduleCardShimmer",
        components: {
            Skeleton
        }
    }
</script>
