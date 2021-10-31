<template>
    <arc-action-section>
        <template #title>
            Fix App Updates
        </template>

        <template #description>
           Check and fix app updates.
        </template>

        <template #content>
            <div class="max-w-xl text-sm text-gray-600">
                After updating the application with latest files, we need to fix some settings. You can do that by using this option.
            </div>

            <div class="flex items-center mt-5">
                <arc-confirms-password @confirmed="clearCache">
                    <arc-button type="button" :class="{ 'opacity-25': loading }" :disabled="loading">
                        Check & Fix Updates
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
                this.$inertia.post(route('fix_updates'), {}, {
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
