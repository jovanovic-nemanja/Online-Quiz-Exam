<template>
    <auth-layout>
        <div>Hello</div>
    </auth-layout>
</template>

<script>
    import AuthLayout from "@/Layouts/AuthLayout";
    export default {
        components: {
            AuthLayout
        },

        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.$page.props.general.app_name + ' - ' + this.$page.props.general.tag_line;
            }
        },
        props: {
            settings: Object,
        },
    }
</script>
