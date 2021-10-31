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
                <ul v-show="open" class="z-30 bg-white shadow rounded py-1 absolute right-0 left-0 top-0 mt-12 dropdown-content">
                    <li v-for="(step, index) in steps" :key="step.key" class="cursor-pointer text-gray-600 text-sm leading-3 tracking-normal py-3 hover:bg-indigo-700 hover:text-white px-3 font-normal">
                        <inertia-link class="block" :href="step.url" >
                            {{ step.title }}
                        </inertia-link>
                    </li>
                </ul>
            </div>
        </div>
        <div class="sm:flex items-center border-b border-gray-200 hidden">
            <inertia-link v-for="step in steps" :href="step.url" :key="step.key">
                <div v-if="step.active" class="flex items-center mr-16 group border-green-700 border-b pb-5">
                    <p class="text-sm leading-none text-green-700">{{ step.title }}</p>
                </div>
                <div v-else class="flex items-center mr-16 group border-transparent hover:border-green-700 cursor-pointer border-b pb-5">
                    <p class="text-sm leading-none text-gray-600 group-hover:text-green-700">{{ step.title }}</p>
                </div>
            </inertia-link>
        </div>
    </div>
</template>
<script>
    export default {
        name: "ProgressNavigator",
        props: {
            steps: Array,
        },
        data() {
            return {
                open: false,
            }
        },
    }
</script>
