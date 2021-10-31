<template>
    <arc-authentication-card>
        <template #logo>
            <inertia-link :href="route('welcome')">
                <img :src="$page.props.assetUrl + $page.props.general.logo_path" :alt="$page.props.general.app_name" class="h-12">
            </inertia-link>
        </template>

        <arc-validation-errors class="mb-4" />

        <form @submit.prevent="submit">
            <div>
                <arc-label for="email" value="Email" />
                <arc-input id="email" type="email" class="mt-1 block w-full" v-model="form.email" required autofocus />
            </div>

            <div class="mt-4">
                <arc-label for="password" value="Password" />
                <arc-input id="password" type="password" class="mt-1 block w-full" v-model="form.password" required autocomplete="new-password" />
            </div>

            <div class="mt-4">
                <arc-label for="password_confirmation" value="Confirm Password" />
                <arc-input id="password_confirmation" type="password" class="mt-1 block w-full" v-model="form.password_confirmation" required autocomplete="new-password" />
            </div>

            <div class="flex items-center justify-end mt-4">
                <arc-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                    Reset Password
                </arc-button>
            </div>
        </form>
    </arc-authentication-card>
</template>

<script>
    import ArcAuthenticationCard from '@/Components/AuthenticationCard'
    import ArcButton from '@/Components/Button'
    import ArcInput from '@/Components/Input'
    import ArcLabel from '@/Components/Label'
    import ArcValidationErrors from '@/Components/ValidationErrors'

    export default {
        components: {
            ArcAuthenticationCard,
            ArcButton,
            ArcInput,
            ArcLabel,
            ArcValidationErrors
        },

        props: {
            email: String,
            token: String,
        },

        data() {
            return {
                form: this.$inertia.form({
                    token: this.token,
                    email: this.email,
                    password: '',
                    password_confirmation: '',
                })
            }
        },

        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return 'Reset Password - ' + this.$page.props.general.app_name;
            }
        },

        methods: {
            submit() {
                this.form.post(this.route('password.update'), {
                    onFinish: () => this.form.reset('password', 'password_confirmation'),
                })
            }
        }
    }
</script>
