<template>
    <div class="h-screen max-h-screen overflow-hidden flex flex-no-wrap bg-white select-none">
        <!-- Sidebar starts -->
        <div class="w-96 overflow-hidden absolute sm:relative bg-gray-800 shadow md:h-full flex-col justify-between hidden sm:flex sm:flex-col">
            <div class="z-30 h-16 w-full mx-auto absolute top-0 left-0 bg-gray-700 flex items-center px-4">
                <slot name="title"></slot>
            </div>
            <div class="z-30 h-16 w-full mx-auto absolute top-16 left-0 bg-gray-800 flex justify-between items-center px-4">
                <slot name="actions"></slot>
            </div>
            <perfect-scrollbar class="h-screen max-h-screen px-4 pt-32 pb-16" ref="scroll" :options="scrollbarOptions">
                <slot name="questions"></slot>
            </perfect-scrollbar>
            <div class="w-96 w-full absolute left-0 bottom-0 px-4 border-t border-gray-700">
                <slot name="footer"></slot>
            </div>
        </div>
        <div class="w-80 h-full z-40 fixed bg-gray-800 shadow md:h-full flex-col justify-between sm:hidden transition duration-150 ease-in-out" ref="mobileNav">
            <div v-if="moved" id="openSideBar" class="h-10 w-10 text-white bg-gray-800 absolute right-0 mt-3 -mr-10 flex items-center shadow rounded-tr rounded-br justify-center cursor-pointer" @click="sidebarHandler(true)">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            </div>
            <div v-if="!moved" id="closeSideBar" class="h-10 w-10 text-white bg-gray-800 absolute right-0 mt-3 z-50 mr-4 flex items-center shadow rounded justify-center cursor-pointer" @click="sidebarHandler(true)">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
            </div>
            <div class="z-30 h-16 w-full mx-auto absolute top-0 left-0 bg-gray-700 flex items-center px-4">
                <slot name="title"></slot>
            </div>
            <div class="z-30 h-16 w-full mx-auto absolute top-16 left-0 bg-gray-800 flex justify-between items-center px-4">
                <slot name="actions"></slot>
            </div>
            <perfect-scrollbar class="h-screen max-h-screen overflow-hidden px-4 pt-32 pb-16" ref="scroll" :options="scrollbarOptions">
                <slot name="questions"></slot>
            </perfect-scrollbar>
            <div class="w-full absolute bottom-0 px-8 border-t border-gray-700">
                <ul class="w-full flex items-center justify-between bg-gray-800">
                    <slot name="footer"></slot>
                </ul>
            </div>
        </div>
        <!-- Sidebar ends -->
        <div class="relative h-full container mx-auto md:w-4/5 w-full">
            <slot></slot>
        </div>
    </div>
</template>

<script>
    import { PerfectScrollbar } from 'vue2-perfect-scrollbar'
    export default {
        name: "PracticeLayout",
        components: {
            PerfectScrollbar
        },
        data() {
            return {
                moved: true,
                scrollbarOptions: {
                    maxScrollbarLength: 1,
                    suppressScrollX: true
                }
            }
        },
        methods: {
            sidebarHandler() {
                // this.$refs.scroll.$el.scrollTop = 0;
                let sideBar = this.$refs.mobileNav;
                if (this.moved) {
                    sideBar.style.transform = "translateX(0px)";
                    this.moved = false;
                } else {
                    sideBar.style.transform = "translateX(-320px)";
                    this.moved = true;
                }
            },
        },
        mounted() {
            let sideBar = this.$refs.mobileNav;
            sideBar.style.transform = "translateX(-320px)";
        }
    };
</script>
