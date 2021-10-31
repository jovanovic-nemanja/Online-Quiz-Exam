<template>
    <arc-form-section @submitted="updatePassword">
        <template #title>
            Update Password
        </template>

        <template #description>
            Ensure your account is using a long, random password to stay secure.
        </template>

        <template #form>
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="current_password" value="Current Password" />
                <arc-input id="current_password" type="password" class="mt-1 block w-full" v-model="form.current_password" ref="current_password" autocomplete="current-password" />
                <arc-input-error :message="form.errors.current_password" class="mt-2" />
            </div>

            <div class="col-span-6 sm:col-span-4">
                <arc-label for="password" value="New Password" />
                <arc-input id="password" type="password" class="mt-1 block w-full" v-model="form.password" ref="password" autocomplete="new-password" />
                <arc-input-error :message="form.errors.password" class="mt-2" />
            </div>

            <div class="col-span-6 sm:col-span-4">
                <arc-label for="password_confirmation" value="Confirm Password" />
                <arc-input id="password_confirmation" type="password" class="mt-1 block w-full" v-model="form.password_confirmation" autocomplete="new-password" />
                <arc-input-error :message="form.errors.password_confirmation" class="mt-2" />
            </div>
        </template>

        <template #actions>
            <arc-action-message :on="form.recentlySuccessful" class="mr-3">
                Saved.
            </arc-action-message>

            <arc-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                Save
            </arc-button>
        </template>
    </arc-form-section>
</template>

<script>
    import ArcActionMessage from '@/Components/ActionMessage'
    import ArcButton from '@/Components/Button'
    import ArcFormSection from '@/Components/FormSection'
    import ArcInput from '@/Components/Input'
    import ArcInputError from '@/Components/InputError'
    import ArcLabel from '@/Components/Label'

    export default {
        components: {
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
            ArcInput,
            ArcInputError,
            ArcLabel,
        },

        data() {
            return {
                form: this.$inertia.form({
                    current_password: '',
                    password: '',
                    password_confirmation: '',
                }),
            }
        },

        methods: {
            updatePassword() {
                this.form.put(route('user-password.update'), {
                    errorBag: 'updatePassword',
                    preserveScroll: true,
                    onSuccess: () => this.form.reset(),
                    onError: () => {
                        if (this.form.errors.password) {
                            this.form.reset('password', 'password_confirmation')
                            this.$refs.password.focus()
                        }

                        if (this.form.errors.current_password) {
                            this.form.reset('current_password')
                            this.$refs.current_password.focus()
                        }
                    }
                })
            },
        },
    }
</script>
