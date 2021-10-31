<template>
    <div class="w-full overflow-hidden dark_question_card rounded cursor-pointer">
        <div class="hover:bg-gray-600 text-gray-400 hover:text-gray-200 rounded p-4">
            <div class="flex items-start gap-4 opacity-25">
                <Skeleton width="1rem" height="10px" class="bg-gray-700"></Skeleton>
                <div class="w-full">
                    <Skeleton class="w-full mb-2" height="10px"></Skeleton>
                    <Skeleton class="w-full mb-2" height="10px"></Skeleton>
                    <Skeleton class="w-full" height="10px"></Skeleton>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import Skeleton from "primevue/skeleton";

    export default {
        name: 'NavigationQuestionCardShimmer',
        components: {
            Skeleton
        }
    }
</script>
