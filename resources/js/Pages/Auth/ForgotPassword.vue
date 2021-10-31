<template>
    <arc-authentication-card>
        <template #logo>
            <application-logo></application-logo>
        </template>

        <div class="mb-4 text-sm text-gray-600">
            Forgot your password? No problem. Just let us know your email address and we will email you a password reset link that will allow you to choose a new one.
        </div>

        <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
            {{ status }}
        </div>

        <arc-validation-errors class="mb-4" />

        <form @submit.prevent="submit">
            <div>
                <arc-label for="email" value="Email" />
                <arc-input id="email" type="email" class="mt-1 block w-full" v-model="form.email" required autofocus />
            </div>

            <div class="flex items-center justify-end mt-4">
                <arc-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                    Email Password Reset Link
                </arc-button>
            </div>
        </form>
    </arc-authentication-card>
</template>

<script>
    import AuthLayout from '@/Layouts/AuthLayout'
    import ArcAuthenticationCard from '@/Components/AuthenticationCard'
    import ArcButton from '@/Components/Button'
    import ArcInput from '@/Components/Input'
    import ArcLabel from '@/Components/Label'
    import ArcValidationErrors from '@/Components/ValidationErrors'
    import ApplicationLogo from "@/Components/ApplicationLogo";

    export default {
        components: {
            AuthLayout,
            ArcAuthenticationCard,
            ArcButton,
            ArcInput,
            ArcLabel,
            ArcValidationErrors,
            ApplicationLogo
        },

        props: {
            status: String,
            settings: Object,
        },

        data() {
            return {
                form: this.$inertia.form({
                    email: ''
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
                return 'Forgot Password - ' + this.$page.props.general.app_name;
            }
        },

        methods: {
            submit() {
                this.form.post(this.route('password.email'))
            }
        }
    }
</script>
