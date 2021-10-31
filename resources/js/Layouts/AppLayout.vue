<template>
    <div>
        <arc-banner/>
        <div class="min-h-screen bg-blue-50">
            <nav class="fixed w-full bg-gray-700 shadow border-b border-gray-200 h-16 z-30">
                <div class="max-w-7xl h-full flex flex-col justify-center container mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex items-center justify-between">
                        <div class="hidden sm:flex gap-4 items-center">
                            <inertia-link :href="route('home')">
                                <img :src="$page.props.assetUrl + $page.props.general.logo_path"
                                     :alt="$page.props.general.app_name" class="h-9 sm:h-12 p-2">
                            </inertia-link>
                            <inertia-link :href="route('user_dashboard')"
                                          :class="[route().current() === 'user_dashboard' ? 'border-green-400' : 'border-transparent']"
                                          class="text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                {{ __('Dashboard') }}
                            </inertia-link>
                            <inertia-link :href="route('practice_dashboard')"
                                          :class="[route().current() === 'practice_dashboard' ? 'border-green-400' : 'border-transparent']"
                                          class="text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                {{ __('Learn & Practice') }}
                            </inertia-link>
                            <inertia-link :href="route('quiz_dashboard')"
                                          :class="[route().current() === 'quiz_dashboard' ? 'border-green-400' : 'border-transparent']"
                                          class="text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                {{ __('Quizzes') }}
                            </inertia-link>
                            <inertia-link :href="route('my_progress')"
                                          :class="[route().current() === 'my_progress' ? 'border-green-400' : 'border-transparent']"
                                          class="text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                {{ __('My Progress') }}
                            </inertia-link>
                        </div>
                        <inertia-link class="sm:hidden" :href="route('home')">
                            <img :src="$page.props.assetUrl + $page.props.general.logo_path"
                                 :alt="$page.props.general.app_name" class="block h-9 w-auto mr-3">
                        </inertia-link>
                        <div v-if="$page.props.canLogin">
                            <div @click="toggleMenu(true)"
                                 class="sm:block md:hidden lg:hidden text-gray-500 hover:text-gray-700 focus:text-gray-700 focus:outline-none">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" viewBox="0 0 24 24"
                                     stroke-width="1.5"
                                     stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                    <path stroke="none" d="M0 0h24v24H0z"/>
                                    <line x1="4" y1="6" x2="20" y2="6"/>
                                    <line x1="4" y1="12" x2="20" y2="12"/>
                                    <line x1="4" y1="18" x2="20" y2="18"/>
                                </svg>
                            </div>
                            <div id="menu" class="md:block lg:block hidden">
                                <div @click="toggleMenu(false)"
                                     class="block md:hidden lg:hidden text-gray-500 hover:text-gray-700 focus:text-gray-700 fixed focus:outline-none z-30 top-0 pt-4">
                                    <svg aria-haspopup="true" aria-label="Main Menu" xmlns="http://www.w3.org/2000/svg"
                                         class="h-8 w-8" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
                                         fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z"/>
                                        <line x1="18" y1="6" x2="6" y2="18"/>
                                        <line x1="6" y1="6" x2="18" y2="18"/>
                                    </svg>
                                </div>
                                <ul class="flex gap-4 md:gap-0 md:flex bg-gray-700 text-lg md:text-base lg:text-base lg:flex flex-col md:flex-row lg:flex-row justify-center items-center fixed md:relative lg:relative top-0 bottom-0 left-0 right-0 z-20">
                                    <li class="md:mr-8 lg:mr-10 flex items-center">
                                        <inertia-link :href="route('user_dashboard')"
                                                      :class="[route().current() === 'user_dashboard' ? 'border-green-400' : 'border-transparent']"
                                                      class="sm:hidden text-white font-semibold border-b-2 hover:border-green-400 px-4 py-4">
                                            {{ __('Dashboard') }}
                                        </inertia-link>
                                    </li>
                                    <li class="md:mr-8 lg:mr-10 flex items-center">
                                        <inertia-link :href="route('practice_dashboard')"
                                                      :class="[route().current() === 'practice_dashboard' ? 'border-green-400' : 'border-transparent']"
                                                      class="sm:hidden text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                            {{ __('Learn & Practice') }}
                                        </inertia-link>
                                    </li>
                                    <li class="md:mr-8 lg:mr-10 flex items-center">
                                        <inertia-link :href="route('quiz_dashboard')"
                                                      :class="[route().current() === 'quiz_dashboard' ? 'border-green-400' : 'border-transparent']"
                                                      class="sm:hidden text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                            {{ __('Quizzes') }}
                                        </inertia-link>
                                    </li>
                                    <li class="md:mr-8 lg:mr-10 flex items-center">
                                        <inertia-link :href="route('my_progress')"
                                                      :class="[route().current() === 'my_progress' ? 'border-green-400' : 'border-transparent']"
                                                      class="sm:hidden text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                            {{ __('My Progress') }}
                                        </inertia-link>
                                    </li>
                                    <li class="md:mr-8 lg:mr-10 flex items-center">
                                        <inertia-link :href="route('profile.show')"
                                                      :class="[route().current() === 'profile.show' ? 'border-green-400' : 'border-transparent']"
                                                      class="sm:hidden text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                            {{ __('Profile') }}
                                        </inertia-link>
                                    </li>
                                    <li class="md:mr-8 lg:mr-10 flex items-center">
                                        <form @submit.prevent="logout">
                                            <button
                                                class="sm:hidden text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                                Logout
                                            </button>
                                        </form>
                                    </li>
                                    <li>
                                        <rewards-badge :text-color="'text-white'" :points="$page.props.user.wallet_balance"></rewards-badge>
                                    </li>
                                    <li v-if="$page.props.user" class="md:mr-8 lg:mr-10 flex items-center">
                                        <div>
                                            <div class="hidden sm:flex sm:items-center sm:ml-6">
                                                <!-- Account Dropdown -->
                                                <div class="ml-3 relative">
                                                    <arc-dropdown align="right" width="48">
                                                        <template #trigger>
                                                            <button v-if="$page.props.jetstream.managesProfilePhotos"
                                                                    class="flex border-2 border-transparent rounded-full focus:outline-none focus:border-gray-300 transition duration-150 ease-in-out">
                                                                <img class="h-8 w-8 rounded-full object-cover"
                                                                     :src="$page.props.user.profile_photo_url"
                                                                     :alt="$page.props.user.first_name"/>
                                                            </button>

                                                            <span v-else class="inline-flex rounded-md">
                                                                <button type="button"
                                                                        class="inline-flex items-center px-3 py-2 border border-transparent leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150">
                                                                    {{ $page.props.user.first_name }}

                                                                    <svg class="ml-2 -mr-0.5 h-4 w-4" xmlns="http://www.w3.org/2000/svg"
                                                                         viewBox="0 0 20 20" fill="currentColor">
                                                                        <path fill-rule="evenodd"
                                                                              d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                                              clip-rule="evenodd"/>
                                                                    </svg>
                                                                </button>
                                                            </span>
                                                        </template>
                                                        <template #content>
                                                            <!-- Account Management -->
                                                            <div class="block px-4 py-2 text-xs text-gray-400">
                                                                {{ $page.props.user.first_name }} {{
                                                                $page.props.user.last_name }}
                                                            </div>

                                                            <arc-dropdown-link :href="route('profile.show')">
                                                                Profile
                                                            </arc-dropdown-link>

                                                            <arc-dropdown-link :href="route('api-tokens.index')"
                                                                               v-if="$page.props.jetstream.hasApiFeatures">
                                                                API Tokens
                                                            </arc-dropdown-link>

                                                            <div class="border-t border-gray-100"></div>

                                                            <!-- Authentication -->
                                                            <form @submit.prevent="logout">
                                                                <arc-dropdown-link as="button">
                                                                    Logout
                                                                </arc-dropdown-link>
                                                            </form>
                                                        </template>
                                                    </arc-dropdown>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li v-else class="md:mr-8 lg:mr-10 flex items-center">
                                        <inertia-link :href="route('login')"
                                                      class="text-white font-semibold border-b-2 border-transparent hover:border-green-400 px-4 py-4">
                                            {{ __('Login') }}
                                        </inertia-link>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Page Heading -->
            <header class="bg-white shadow pt-16">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex flex-col md:flex-row items-start md:items-center justify-between">
                        <div>
                            <slot name="header"></slot>
                        </div>
                        <div class="mb-6 sm:mb-0 sm:mt-0">
                            <slot name="actions"></slot>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Page Content -->
            <main>
                <div class="container max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <Message v-show="$page.props.successMessage" severity="success" :closable="false">{{
                        $page.props.successMessage }}
                    </Message>
                    <Message v-if="$page.props.errorMessage" severity="error" :closable="false">{{
                        $page.props.errorMessage }}
                    </Message>
                </div>
                <slot></slot>
            </main>
            <Toast position="top-right"/>
            <!-- Modal Portal -->
            <portal-target name="modal" multiple>
            </portal-target>
        </div>
    </div>
</template>

<script>
    import ArcApplicationMark from '@/Components/ApplicationMark'
    import ArcBanner from '@/Components/Banner'
    import ArcDropdown from '@/Components/Dropdown'
    import ArcDropdownLink from '@/Components/DropdownLink'
    import ArcNavLink from '@/Components/NavLink'
    import ArcResponsiveNavLink from '@/Components/ResponsiveNavLink'
    import Toast from 'primevue/toast';
    import RewardsBadge from "@/Components/RewardsBadge";
    import Message from "primevue/message";

    export default {
        components: {
            ArcApplicationMark,
            ArcBanner,
            ArcDropdown,
            ArcDropdownLink,
            ArcNavLink,
            ArcResponsiveNavLink,
            Toast,
            Message,
            RewardsBadge
        },

        props: {
            canLogin: Boolean,
            canRegister: Boolean,
        },

        data() {
            return {
                showingNavigationDropdown: false,
            }
        },

        methods: {
            switchToTeam(team) {
                this.$inertia.put(route('current-team.update'), {
                    'team_id': team.id
                }, {
                    preserveState: false
                })
            },

            toggleMenu(flag) {
                let value = document.getElementById("menu");
                if (flag) {
                    value.classList.remove("hidden");
                } else {
                    value.classList.add("hidden");
                }
            },

            logout() {
                this.$inertia.post(route('logout'));
            },
        }
    }
</script>
