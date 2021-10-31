<template>
    <inertia-link :href="route('welcome')">
        <img :src="$page.props.assetUrl + $page.props.general.logo_path" :alt="$page.props.general.app_name" class="h-12">
    </inertia-link>
</template>
