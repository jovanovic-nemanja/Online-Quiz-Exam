<template>
    <arc-authentication-card>
        <template #logo>
            <inertia-link :href="route('welcome')">
                <img :src="$page.props.assetUrl + $page.props.general.logo_path" :alt="$page.props.general.app_name" class="h-12">
            </inertia-link>
        </template>

        <div class="mb-4 text-sm text-gray-600">
            This is a secure area of the application. Please confirm your password before continuing.
        </div>

        <arc-validation-errors class="mb-4" />

        <form @submit.prevent="submit">
            <div>
                <arc-label for="password" value="Password" />
                <arc-input id="password" type="password" class="mt-1 block w-full" v-model="form.password" required autocomplete="current-password" autofocus />
            </div>

            <div class="flex justify-end mt-4">
                <arc-button class="ml-4" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                    Confirm
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

        data() {
            return {
                form: this.$inertia.form({
                    password: '',
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
                return 'Confirm Password - ' + this.$page.props.general.app_name;
            }
        },

        methods: {
            submit() {
                this.form.post(this.route('password.confirm'), {
                    onFinish: () => this.form.reset(),
                })
            }
        }
    }
</script>
