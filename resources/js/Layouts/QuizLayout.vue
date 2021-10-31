<template>
    <div class="h-screen max-h-screen overflow-hidden select-none">
        <!-- Header starts -->
        <div class="w-full h-16 absolute z-30 top-0 right-0 mx-auto bg-gray-800 shadow-lg">
            <div class="w-full h-full mx-auto px-4 sm:px-6 lg:px-8">
                <div class="h-full flex flex-col justify-center items-center">
                    <div class="w-full flex items-center justify-end gap-4 sm:gap-0 sm:justify-between">
                        <div class="hidden sm:block">
                            <slot name="title"></slot>
                        </div>
                        <div class="flex items-center gap-4">
                            <button @click="toggleFullScreen" class="hidden sm:block focus:outline-none text-white text-sm bg-gray-700 hover:bg-gray-600 rounded-sm p-2">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8V4m0 0h4M4 4l5 5m11-1V4m0 0h-4m4 0l-5 5M4 16v4m0 0h4m-4 0l5-5m11 5l-5-5m5 5v-4m0 4h-4"></path></svg>
                            </button>
                            <h4 class="flex items-center text-white text-sm bg-gray-700 rounded-sm px-4 py-2">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                <slot name="timer"></slot>
                            </h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Header starts -->
        <!-- Section starts -->
        <div class="z-20 h-16 w-full mx-auto absolute top-16 left-0 bg-white border-b border-gray-200 flex justify-between items-center px-4">
            <slot name="sections"></slot>
        </div>
        <!-- Section ends -->
        <div class="flex flex-no-wrap bg-white">
            <div class="relative h-full container mx-auto md:w-4/5 w-full">
                <slot></slot>
            </div>
            <!-- Sidebar starts -->
            <div class="w-96 overflow-hidden absolute sm:relative md:h-full flex-col justify-between hidden border-l border-gray-100 sm:flex sm:flex-col transition duration-150 ease-in-out">
                <div class="z-20 h-16 w-full mx-auto absolute top-0 right-0 flex items-center px-4 shadow"></div>
                <div class="z-20 h-16 w-full mx-auto absolute top-16 left-0 bg-white border-b border-l border-gray-200 flex justify-between items-center px-4">
                    <slot name="actions"></slot>
                </div>
                <perfect-scrollbar class="h-screen max-h-screen px-4 pt-32 pb-16 bg-gray-50 border-l border-gray-200" ref="scroll" :options="scrollbarOptions">
                    <slot name="questions"></slot>
                </perfect-scrollbar>
                <div class="w-96 w-full absolute left-0 bottom-0 bg-gray-100 border-t border-l border-gray-200">
                    <slot name="footer"></slot>
                </div>
            </div>
            <div class="w-80 h-full z-40 absolute bg-gray-50 shadow md:h-full flex-col justify-between sm:hidden transition duration-150 ease-in-out" ref="mobileNav">
                <div v-if="moved" id="openSideBar" class="h-10 w-10 text-white bg-gray-800 absolute right-0 mt-3 -mr-10 flex items-center shadow rounded-tr rounded-br justify-center cursor-pointer" @click="sidebarHandler(true)">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                </div>
                <div v-if="!moved" id="closeSideBar" class="h-10 w-10 text-white bg-gray-800 absolute right-0 mt-3 z-50 mr-4 flex items-center shadow rounded justify-center cursor-pointer" @click="sidebarHandler(true)">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                </div>
                <div class="z-30 h-16 w-full mx-auto absolute top-0 left-0 bg-gray-800 shadow flex items-center px-4">
                    <slot name="title"></slot>
                </div>
                <div class="z-20 h-16 w-full mx-auto absolute top-16 left-0 bg-gray-50 flex justify-between items-center px-4">
                    <slot name="actions"></slot>
                </div>
                <perfect-scrollbar class="h-screen max-h-screen overflow-hidden px-4 pt-32 pb-16" ref="scroll" :options="scrollbarOptions">
                    <slot name="questions"></slot>
                </perfect-scrollbar>
                <div class="w-full absolute bottom-0 border-t border-gray-50 bg-white">
                    <slot name="footer"></slot>
                </div>
            </div>
            <!-- Sidebar ends -->
        </div>
    </div>
</template>

<script>
    import { PerfectScrollbar } from 'vue2-perfect-scrollbar'
    export default {
        name: "QuizLayout",
        components: {
            PerfectScrollbar
        },
        data() {
            return {
                moved: true,
                fullScreen: false,
                scrollbarOptions: {
                    maxScrollbarLength: 1,
                    suppressScrollX: true
                }
            }
        },
        methods: {
            sidebarHandler() {
                let sideBar = this.$refs.mobileNav;
                if (this.moved) {
                    sideBar.style.transform = "translateX(0px)";
                    this.moved = false;
                } else {
                    sideBar.style.transform = "translateX(-320px)";
                    this.moved = true;
                }
            },
            toggleFullScreen() {
                !this.fullScreen ? this.openFullScreen() : this.closeFullScreen();
                this.fullScreen = !this.fullScreen;
            },
            openFullScreen() {
                let elem = document.documentElement;
                if (elem.requestFullscreen) {
                    elem.requestFullscreen();
                } else if (elem.mozRequestFullScreen) { /* Firefox */
                    elem.mozRequestFullScreen();
                } else if (elem.webkitRequestFullscreen) { /* Chrome, Safari and Opera */
                    elem.webkitRequestFullscreen();
                } else if (elem.msRequestFullscreen) { /* IE/Edge */
                    elem.msRequestFullscreen();
                }
            },
            closeFullScreen() {
                if (document.exitFullscreen) {
                    document.exitFullscreen();
                } else if (document.mozCancelFullScreen) { /* Firefox */
                    document.mozCancelFullScreen();
                } else if (document.webkitExitFullscreen) { /* Chrome, Safari and Opera */
                    document.webkitExitFullscreen();
                } else if (document.msExitFullscreen) { /* IE/Edge */
                    document.msExitFullscreen();
                }
            }
        },
        mounted() {
            let sideBar = this.$refs.mobileNav;
            sideBar.style.transform = "translateX(-320px)";
        }
    };
</script>
