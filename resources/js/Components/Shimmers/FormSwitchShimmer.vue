<template>
    <div class="mb-6">
        <div class="flex gap-4 items-center justify-between">
            <div class="w-9/12">
                <Skeleton width="10rem" class="mb-2"></Skeleton>
                <Skeleton height="2rem"></Skeleton>
            </div>
            <div class="">
                <Skeleton width="5rem" height="2rem"></Skeleton>
            </div>
        </div>
    </div>
</template>
<script>
    import Skeleton from 'primevue/skeleton';
    export default {
        name: "FormSwitchShimmer",
        components: {
            Skeleton
        }
    }
</script>
