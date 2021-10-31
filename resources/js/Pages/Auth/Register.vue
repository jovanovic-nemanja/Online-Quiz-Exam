<template>
    <auth-layout>
        <h1 class="mt-20 sm:mt-12 text-xl sm:text-2xl font-semibold text-black tracking-ringtighter title-font">{{ __('Register New Account') }}</h1>
        <arc-validation-errors class="mb-4" />

        <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
            {{ status }}
        </div>

        <form @submit.prevent="submit">
            <div class="mt-8 w-full">
                <div class="md:flex gap-3">
                    <div class="flex w-full flex-col mt-5">
                        <label for="first_name" class="text-sm leading-tight">{{ __('First Name') }}</label>
                        <input id="first_name" type="text" v-model="form.first_name" class="h-10 px-2 w-full rounded mt-2 text-gray-600 focus:outline-none focus:border focus:border-green-700 border-gray-300 border shadow" required autofocus autocomplete="current-password"/>
                    </div>
                    <div class="flex w-full flex-col mt-5">
                        <label for="last_name" class="text-sm leading-tight">{{ __('Last Name') }}</label>
                        <input id="last_name" type="text" v-model="form.last_name" class="h-10 px-2 w-full rounded mt-2 text-gray-600 focus:outline-none focus:border focus:border-green-700 border-gray-300 border shadow" required autocomplete="current-password"/>
                    </div>
                </div>
                <div class="flex flex-col mt-5">
                    <label for="email" class="text-sm leading-tight">{{ __('Email') }}</label>
                    <input id="email" type="email" v-model="form.email" class="h-10 px-2 w-full rounded mt-2 text-gray-600 focus:outline-none focus:border focus:border-green-700 border-gray-300 border shadow" required/>
                </div>
                <div class="flex flex-col mt-5">
                    <label for="user_name" class="text-sm leading-tight">{{ __('User Name') }}</label>
                    <input id="user_name" type="text" v-model="form.user_name" class="h-10 px-2 w-full rounded mt-2 text-gray-600 focus:outline-none focus:border focus:border-green-700 border-gray-300 border shadow" required/>
                </div>
                <div class="md:flex gap-3">
                    <div class="w-full flex flex-col mt-5">
                        <label for="password" class="text-sm leading-tight">{{ __('Password') }}</label>
                        <input id="password" type="password" v-model="form.password" class="h-10 px-2 w-full rounded mt-2 text-gray-600 focus:outline-none focus:border focus:border-green-700 border-gray-300 border shadow" required autocomplete="current-password"/>
                    </div>
                    <div class="w-full flex flex-col mt-5">
                        <label for="password_confirmation" class="text-sm leading-tight">{{ __('Confirm Password') }}</label>
                        <input id="password_confirmation" type="password" v-model="form.password_confirmation" class="h-10 px-2 w-full rounded mt-2 text-gray-600 focus:outline-none focus:border focus:border-green-700 border-gray-300 border shadow" required autocomplete="current-password"/>
                    </div>
                </div>
            </div>

            <div class="flex items-center mt-8">
                <arc-button class="h-10 w-full justify-center rounded bg-green-700" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                    Register
                </arc-button>
            </div>
        </form>
        <div class="my-6 flex items-center justify-between"><span class="border-b dark:border-gray-600 w-1/5 md:w-1/4"></span> <a href="#" class="text-xs text-gray-500 dark:text-gray-400 uppercase hover:underline">or Login</a> <span class="border-b dark:border-gray-600 w-1/5 md:w-1/4"></span></div>
        <div class="mb-6 text-sm text-center">
            <span>{{ __('Already registered?') }} </span>
            <inertia-link class="underline text-green-600" :href="route('login')">{{ __('Login') }}</inertia-link>
        </div>
    </auth-layout>
</template>

<script>
    import AuthLayout from '@/Layouts/AuthLayout'
    import ArcAuthenticationCard from "@/Components/AuthenticationCard";
    import ArcCheckbox from "@/Components/Checkbox"
    import ArcLabel from "@/Components/Label"
    import ArcValidationErrors from '@/Components/ValidationErrors'
    import ApplicationLogo from "@/Components/ApplicationLogo"
    import ArcInput from "@/Components/Input";
    import ArcButton from "@/Components/Button";

    export default {
        components: {
            AuthLayout,
            ArcAuthenticationCard,
            ArcCheckbox,
            ArcInput,
            ArcLabel,
            ArcButton,
            ArcValidationErrors,
            ApplicationLogo
        },

        props: {
           settings: Object,
            status: String
        },

        data() {
            return {
                form: this.$inertia.form({
                    first_name: '',
                    last_name: '',
                    user_name: '',
                    email: '',
                    password: '',
                    password_confirmation: '',
                    terms: false,
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
                return 'Register - ' + this.$page.props.general.app_name;
            }
        },

        methods: {
            submit() {
                this.form.post(this.route('register'), {
                    onFinish: () => this.form.reset('password', 'password_confirmation'),
                })
            }
        }
    }
</script>
