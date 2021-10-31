<template>
    <section class="max-w-lg px-4 py-12 mx-auto">
        <h2 class="mt-2 text-sm font-medium text-center text-gray-800">{{ title }}</h2>
        <div class="flex flex-col items-center justify-center mt-4 space-y-1 md:flex-row md:space-y-0 md:space-x-1">
            <slot name="action"></slot>
        </div>
    </section>
</template>
<script>
    export default {
        name: 'NoDataTable',
        props: {
            title: {
                type: String,
                default: 'No Records Found'
            }
        }
    }
</script>
