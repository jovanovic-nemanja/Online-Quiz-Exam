<template>
    <div class="inline relative">
        <a class="text-green-600" href="#" @mouseover="hover" @mouseout="hoverOut">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
        </a>
        <div class="absolute w-96 shadow border border-green-200 bg-white p-2 rounded" v-if="showPopup" transition="fade"
             @mouseover="hoverInfo" @mouseout="hoverOutInfo" style="z-index: 999;">
            <slot name="message"></slot>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'PopInfo',
        data() {
            return {
                showPopup: false,
                timer: '',
                isInInfo: false
            }
        },
        methods: {
            hover() {
                let vm = this;
                this.timer = setTimeout(function() {
                    vm.showPopover();
                }, 600);
            },
            hoverOut() {
                let vm = this;
                clearTimeout(vm.timer);
                this.timer = setTimeout(function() {
                    if(!vm.isInInfo)
                    {
                        vm.closePopover();
                    }
                }, 200);
            },
            hoverInfo() {
                this.isInInfo = true;
            },
            hoverOutInfo() {
                this.isInInfo = false;
                this.hoverOut();
            },
            showPopover() {
                this.showPopup = true;
            },
            closePopover() {
                this.showPopup = false;
            }
        }
    }
</script>
