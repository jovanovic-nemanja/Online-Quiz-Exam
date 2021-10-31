<template>
    <section class="flex flex-col items-center min-h-screen sm:h-screen md:flex-row ">
        <div class="hidden auth-wrap w-full min-h-screen sm:h-screen bg-white lg:block md:w-1/3 lg:w-2/3 relative"
                        :style="{ 'background-image': 'url('+$page.props.assetUrl+$page.props.homePageSettings.hero_image_path+')'}">
            <div class="auth-background-overlay"></div>
            <div class="absolute bottom-10 left-10">
                <h3 class="text-4xl mb-4 font-extrabold leading-normal text-white" v-html="$page.props.homePageSettings.hero_title"></h3>
                <p class="text-lg leading-tight text-white leading-normal pt-3 xl:w-10/12" v-html="$page.props.homePageSettings.hero_subtitle"></p>
            </div>
        </div>
        <div class="flex relative items-center justify-center w-full min-h-screen sm:h-screen px-6 bg-white md:max-w-md lg:max-w-full md:mx-auto md:w-1/2 xl:w-1/3 lg:px-16">
            <div class="w-full">
                <inertia-link :href="route('welcome')">
                    <img :src="$page.props.assetUrl + $page.props.general.logo_path" :alt="$page.props.general.app_name"
                         class="h-12 absolute top-5 sm:top-10">
                </inertia-link>
                <slot></slot>
            </div>
        </div>
    </section>
</template>

<script>
    import ArcApplicationMark from '@/Components/ApplicationMark'
    import ArcBanner from '@/Components/Banner'
    import ArcDropdown from '@/Components/Dropdown'
    import ArcDropdownLink from '@/Components/DropdownLink'
    import ArcNavLink from '@/Components/NavLink'
    import ArcResponsiveNavLink from '@/Components/ResponsiveNavLink'
    import Toast from 'primevue/toast';

    export default {
        components: {
            ArcApplicationMark,
            ArcBanner,
            ArcDropdown,
            ArcDropdownLink,
            ArcNavLink,
            ArcResponsiveNavLink,
            Toast
        },

        props: {
            canLogin: Boolean,
            canRegister: Boolean,
        },
        methods: {
            logout() {
                this.$inertia.post(route('logout'));
            },
        }
    }
</script>
<style scoped>
    .auth-wrap {
        background-position: center right;
        background-repeat: no-repeat;
        background-size: cover;
        transition: background 0.3s, border 0.3s, border-radius 0.3s, box-shadow 0.3s;
        padding: 200px 30px 120px 30px;
        position: relative;
    }
    .auth-background-overlay {
        background-color: transparent;
        background-image: linear-gradient(
            290deg
            , #047857 50%, #047857 100%);
        opacity: 0.92;
        transition: background 0.3s, border-radius 0.3s, opacity 0.3s;
        height: 100%;
        width: 100%;
        top: 0;
        left: 0;
        position: absolute;
    }
</style>
