<template>
    <div>
        <app-layout v-if="!isAdmin">
            <template #header>
                <h4 class="page-heading">
                    Profile
                </h4>
            </template>

            <div>
                <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                    <div v-if="$page.props.jetstream.canUpdateProfileInformation">
                        <update-profile-information-form :user="$page.props.user" />

                        <arc-section-border />
                    </div>

                    <div v-if="$page.props.jetstream.canUpdatePassword">
                        <update-password-form class="mt-10 sm:mt-0" />

                        <arc-section-border />
                    </div>

                    <div v-if="!$page.props.isDemo && $page.props.jetstream.canManageTwoFactorAuthentication">
                        <two-factor-authentication-form class="mt-10 sm:mt-0" />

                        <arc-section-border />
                    </div>

                    <logout-other-browser-sessions-form v-if="!$page.props.isDemo" :sessions="sessions" class="mt-10 sm:mt-0" />

                    <template v-if="$page.props.jetstream.hasAccountDeletionFeatures">
                        <arc-section-border />

                        <delete-user-form class="mt-10 sm:mt-0" />
                    </template>
                </div>
            </div>
        </app-layout>
        <admin-layout v-if="isAdmin">
            <template #header>
                <h4 class="page-heading">
                    Profile
                </h4>
            </template>

            <div>
                <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                    <div v-if="$page.props.jetstream.canUpdateProfileInformation">
                        <update-profile-information-form :user="$page.props.user" />

                        <arc-section-border />
                    </div>

                    <div v-if="$page.props.jetstream.canUpdatePassword">
                        <update-password-form class="mt-10 sm:mt-0" />

                        <arc-section-border />
                    </div>

                    <div v-if="!$page.props.isDemo && $page.props.jetstream.canManageTwoFactorAuthentication">
                        <two-factor-authentication-form class="mt-10 sm:mt-0" />

                        <arc-section-border />
                    </div>

                    <div v-if="!$page.props.isDemo">
                        <logout-other-browser-sessions-form :sessions="sessions" class="mt-10 sm:mt-0" />
                    </div>

                    <template v-if="$page.props.jetstream.hasAccountDeletionFeatures">
                        <arc-section-border />

                        <delete-user-form class="mt-10 sm:mt-0" />
                    </template>
                </div>
            </div>
        </admin-layout>
    </div>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import AdminLayout from '@/Layouts/AdminLayout'
    import DeleteUserForm from './DeleteUserForm'
    import ArcSectionBorder from '@/Components/SectionBorder'
    import LogoutOtherBrowserSessionsForm from './LogoutOtherBrowserSessionsForm'
    import TwoFactorAuthenticationForm from './TwoFactorAuthenticationForm'
    import UpdatePasswordForm from './UpdatePasswordForm'
    import UpdateProfileInformationForm from './UpdateProfileInformationForm'

    export default {
        props: ['sessions'],

        components: {
            AppLayout,
            AdminLayout,
            DeleteUserForm,
            ArcSectionBorder,
            LogoutOtherBrowserSessionsForm,
            TwoFactorAuthenticationForm,
            UpdatePasswordForm,
            UpdateProfileInformationForm,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return 'User Profile - ' + this.$page.props.general.app_name;
            },
            isAdmin() {
                return this.$page.props.isAdmin;
            }
        },
    }
</script>
