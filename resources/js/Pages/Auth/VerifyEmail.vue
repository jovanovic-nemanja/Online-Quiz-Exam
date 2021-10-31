<template>
    <arc-authentication-card>
        <template #logo>
            <application-logo />
        </template>

        <div class="mb-4 text-sm text-gray-600">
            Thanks for signing up! Before getting started, could you verify your email address by clicking on the link we just emailed to you? If you didn't receive the email, we will gladly send you another.
        </div>

        <div class="mb-4 font-medium text-sm text-green-600" v-if="verificationLinkSent" >
            A new verification link has been sent to the email address you provided during registration.
        </div>

        <form @submit.prevent="submit">
            <div class="mt-4 flex items-center justify-between">
                <arc-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                    Resend Verification Email
                </arc-button>

                <inertia-link :href="route('logout')" method="post" as="button" class="underline text-sm text-gray-600 hover:text-gray-900">Logout</inertia-link>
            </div>
        </form>
    </arc-authentication-card>
</template>

<script>
    import ArcAuthenticationCard from '@/Components/AuthenticationCard'
    import ArcButton from '@/Components/Button'
    import ApplicationLogo from "@/Components/ApplicationLogo";

    export default {
        components: {
            ArcAuthenticationCard,
            ArcButton,
            ApplicationLogo
        },

        props: {
            status: String
        },

        data() {
            return {
                form: this.$inertia.form()
            }
        },

        metaInfo() {
            return {
                title: this.title
            }
        },

        methods: {
            submit() {
                this.form.post(this.route('verification.send'))
            },
        },

        computed: {
            verificationLinkSent() {
                return this.status === 'verification-link-sent';
            },
            title() {
                return 'Verification Email - ' + this.$page.props.general.app_name;
            }
        }
    }
</script>
