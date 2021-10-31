<template>
    <auth-layout>
        <h1 class="mt-20 sm:mt-12 text-xl sm:text-2xl font-semibold text-black tracking-ringtighter title-font">{{ __('Login To Your Account') }}</h1>
        <arc-validation-errors class="mb-4" />

        <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
            {{ status }}
        </div>
        <form @submit.prevent="submit">
            <div class="mt-8 w-full">
                <div class="flex flex-col mt-8">
                    <label for="email" class="text-sm leading-tight">{{ __('Email') }} / {{ __('User Name') }}</label>
                    <input id="email" type="text" v-model="form.email" class="h-10 px-2 w-full rounded mt-2 text-gray-600 focus:outline-none focus:border focus:border-green-700 border-gray-300 border shadow" required autofocus/>
                </div>
                <div class="flex flex-col mt-5">
                    <label for="password" class="text-sm leading-tight">{{ __('Password') }}</label>
                    <input id="password" type="password" v-model="form.password" class="h-10 px-2 w-full rounded mt-2 text-gray-600 focus:outline-none focus:border focus:border-green-700 border-gray-300 border shadow" required autocomplete="current-password"/>
                </div>
            </div>
            <div class="mt-8 w-full flex justify-between">
                <label class="flex items-center">
                    <arc-checkbox name="remember" v-model="form.remember" />
                    <span class="ml-2 text-sm text-gray-600">{{ __('Remember me') }}</span>
                </label>
                <inertia-link class="text-sm text-green-600" v-if="canResetPassword" :href="route('password.request')">{{ __('Forgot Password?') }}</inertia-link>
            </div>

            <div class="flex items-center mt-8">
                <arc-button class="h-10 w-full justify-center rounded bg-green-700" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                    Log in
                </arc-button>
            </div>
        </form>
        <div v-if="$page.props.isDemo" class="mt-8 justify-between items-center flex gap-4 flex-wrap">
            <span class="text-sm">Login To:</span>
            <button @click="fillCredentials('admin')" class="qt-btn qt-btn-sm qt-btn-primary">Admin</button>
            <button @click="fillCredentials('instructor')" class="qt-btn qt-btn-sm qt-btn-primary">Instructor</button>
            <button @click="fillCredentials('student')" class="qt-btn qt-btn-sm qt-btn-primary">Student</button>
            <button @click="fillCredentials('guest')" class="qt-btn qt-btn-sm qt-btn-primary">Guest</button>
        </div>
        <div v-if="!$page.props.isDemo && $page.props.general.can_register" class="my-6 flex items-center justify-between"><span class="border-b dark:border-gray-600 w-1/5 md:w-1/4"></span> <a href="#" class="text-xs text-gray-500 dark:text-gray-400 uppercase hover:underline">or Register</a> <span class="border-b dark:border-gray-600 w-1/5 md:w-1/4"></span></div>
        <div v-if="!$page.props.isDemo && $page.props.general.can_register" class="mb-6 text-sm text-center">
            <span>{{ __('Don’t Have An Account?') }} </span>
            <inertia-link class="underline text-green-600" :href="route('register')">{{ __('Register') }}</inertia-link>
        </div>
    </auth-layout>
</template>

<script>
    import AuthLayout from '@/Layouts/AuthLayout';
    import ArcCheckbox from '@/Components/Checkbox';
    import ArcValidationErrors from '@/Components/ValidationErrors';
    import ArcAuthenticationCard from "@/Components/AuthenticationCard";
    import ArcInput from "@/Components/Input";
    import ArcLabel from "@/Components/Label";
    import ArcButton from "@/Components/Button";
    export default {
        components: {
            AuthLayout,
            ArcAuthenticationCard,
            ArcCheckbox,
            ArcValidationErrors,
            ArcInput,
            ArcLabel,
            ArcButton,
        },

        props: {
            settings: Object,
            canResetPassword: Boolean,
            status: String
        },

        data() {
            return {
                form: this.$inertia.form({
                    email: '',
                    password: '',
                    remember: false
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
                return 'Login - ' + this.$page.props.general.app_name;
            }
        },

        methods: {
            submit() {
                this.form
                    .transform(data => ({
                        ... data,
                        remember: this.form.remember ? 'on' : ''
                    }))
                    .post(this.route('login'), {
                        onFinish: () => this.form.reset('password'),
                    })
            },
            fillCredentials(role) {
                if(role === 'admin') {
                    this.form.email = 'admin';
                    this.form.password = 'Admin@123';
                }
                if(role === 'instructor') {
                    this.form.email = 'instructor';
                    this.form.password = 'Instructor@123';
                }
                if(role === 'student') {
                    this.form.email = 'student';
                    this.form.password = 'Student@123';
                }
                if(role === 'guest') {
                    this.form.email = 'guest';
                    this.form.password = 'Guest@123';
                }
            }
        }
    }
</script>
