<template>
    <div class="w-full">
        <div class="sm:hidden relative w-full mx-auto rounded">
            <div class="w-full flex items-start relative" @click="open = !open">
                <button class="w-full bg-green-600 text-white flex items-center justify-center shadow rounded text-xs focus:outline-none">
                    <span class="p-3">Go To</span>
                    <span class="py-3 rounded-r px-2">
                    <svg id="downIcon2" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                        <path stroke="none" d="M0 0h24v24H0z" />
                        <polyline points="6 9 12 15 18 9" />
                    </svg>
                    <svg id="upIcon2" xmlns="http://www.w3.org/2000/svg" class="hidden icon icon-tabler icon-tabler-chevron-up" width="16" height="16" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                        <path stroke="none" d="M0 0h24v24H0z" />
                        <polyline points="6 15 12 9 18 15" />
                    </svg>
                </span>
                </button>
                <ul v-show="open" class="bg-white shadow rounded py-1 absolute right-0 left-0 top-0 mt-12 dropdown-content">
                    <li v-for="(step, index) in steps" :key="step.key" class="cursor-pointer text-gray-600 text-sm leading-3 tracking-normal py-3 hover:bg-indigo-700 hover:text-white px-3 font-normal">
                        <inertia-link class="block" v-if="step.enable !== true" :href="step.url" >
                            {{ step.title }}
                        </inertia-link>
                        <span v-else>{{ step.title }}</span>
                    </li>
                </ul>
            </div>
        </div>
        <div class="xl:w-full xl:mx-0 h-12 hidden sm:block bg-white">
            <ul class="flex justify-end gap-8">
                <li v-for="(step, index) in steps" :key="step.key" :class="step.status === 'active' ? 'border-green-600' : 'border-gray-400'"
                    class="group hover:border-green-600 hover:shadow ease-linear transition-all duration-150 text-sm flex flex-col justify-between border pt-3 rounded-t font-normal cursor-pointer">
                    <inertia-link v-if="editFlag" :href="step.url" class="block">
                        <div class="flex items-center px-8 mb-2">
                            <div :class="step.status === 'active' ? 'bg-green-600' : 'bg-gray-400'" class="w-6 h-6 group-hover:bg-green-600 rounded-full flex items-center justify-center">
                                <p class="focus:outline-none text-xs text-white">{{ step.step }}</p>
                            </div>
                            <span :class="step.status === 'active' ? 'text-green-600' : 'text-gray-600'" class="ml-2 group-hover:text-green-600">{{ step.title }}</span>
                        </div>
                    </inertia-link>
                    <div v-else @click="showAlert" class="flex items-center px-8 mb-2">
                        <div :class="step.status === 'active' ? 'bg-green-600' : 'bg-gray-300'" class="w-6 h-6 group-hover:bg-green-600 rounded-full flex items-center justify-center">
                            <p class="focus:outline-none text-xs text-white">{{ step.step }}</p>
                        </div>
                        <span :class="step.status === 'active' ? 'text-green-600' : 'text-gray-600'" class="ml-2 group-hover:text-green-600">{{ step.title }}</span>
                    </div>
                    <div :class="step.status === 'active' ? 'bg-green-600' : 'bg-gray-300'" class="w-full h-1 group-hover:bg-green-600 rounded-t-md"></div>
                </li>
            </ul>
        </div>
    </div>
</template>
<script>
    export default {
        name: "HorizontalStepper",
        props: {
            steps: Array,
            editFlag: {
                type: Boolean,
                default: false,
            }
        },
        data() {
            return {
                open: false,
            }
        },
        methods: {
            showAlert() {
                this.$toast.add({
                    severity: 'info',
                    summary: 'Info',
                    detail: 'Please save the current details to proceed!',
                    life: 2000
                });
            }
        }
    }
</script>
