<template>
    <inertia-link :class="{'text-green-400': active}" :href="url" class="flex items-center px-4 py-3 transition cursor-pointer group hover:bg-gray-800 hover:text-gray-200">
        <slot name="icon"></slot>
        <span>{{ title }}</span>
    </inertia-link>
</template>
<script>
    export default {
        name: 'SidebarLink',
        props: {
            title: String,
            url: String
        },
        computed: {
            active() {
                return window.location.href === this.url;
            }
        }
    }
</script>
