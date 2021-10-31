<template>
    <div>
        <div @click="open = !open" :class="{'text-green-400': open}" class="flex items-center justify-between px-4 py-3 transition cursor-pointer group hover:bg-gray-800 hover:text-gray-200" role="button">
            <div class="flex items-center">
                <slot name="icon"></slot>
                <span>{{ title }}</span>
            </div>
            <svg :class="{ 'rotate-90': open }" class="flex-shrink-0 w-4 h-4 ml-2 transition transform" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
            </svg>
        </div>
        <div class="mb-4" v-show="open">
            <div class="block" v-for="item in items" :key="item.url">
                <inertia-link v-if="item.active" :href="item.url" :class="{'text-green-400': isActive(item.url)}"  class="flex items-center py-2 pl-12 pr-4 transition cursor-pointer hover:bg-gray-800 hover:text-gray-200">
                    {{ item.label }}
                </inertia-link>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'SidebarDropdown',
        props: {
            title: String,
            items: Array,
        },
        data() {
            return {
                open: false
            }
        },
        methods: {
            isActive(url) {
                return window.location.href === url;
            },
            isOpen() {
                return this.urls.includes(window.location.href);
            }
        },
        computed: {
            urls() {
                let arr = [];
                this.items.forEach(item => arr.push(item.url));
                return arr;
            }
        },
        created() {
            this.open = this.isOpen();
        }
    }
</script>
