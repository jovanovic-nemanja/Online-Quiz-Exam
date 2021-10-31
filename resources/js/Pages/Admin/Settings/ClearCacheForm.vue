<template>
    <arc-action-section>
        <template #title>
            Clear Cache
        </template>

        <template #description>
           Clear Application cache.
        </template>

        <template #content>
            <div class="max-w-xl text-sm text-gray-600">
                If necessary, you may clear your application cache. This action may slow down application for a while.
            </div>

            <div class="flex items-center mt-5">
                <arc-confirms-password @confirmed="clearCache">
                    <arc-button type="button" :class="{ 'opacity-25': loading }" :disabled="loading">
                        Clear Cache
                    </arc-button>
                </arc-confirms-password>
            </div>
        </template>
    </arc-action-section>
</template>

<script>
    import ArcActionMessage from '@/Components/ActionMessage'
    import ArcActionSection from '@/Components/ActionSection'
    import ArcButton from '@/Components/Button'
    import ArcConfirmsPassword from '@/Components/ConfirmsPassword'
    import ArcSecondaryButton from '@/Components/SecondaryButton'

    export default {
        components: {
            ArcActionMessage,
            ArcActionSection,
            ArcButton,
            ArcConfirmsPassword,
            ArcSecondaryButton,
        },
        data() {
            return {
                loading: false,
            }
        },
        methods: {

            clearCache() {
                this.loading = true;
                this.$inertia.post(route('clear_cache'), {}, {
                    preserveScroll: true,
                    onSuccess: () => Promise.all([
                        this.loading = false,
                    ]),
                    onFinish: () => (this.loading = false),
                })
            },
        },
    }
</script>
