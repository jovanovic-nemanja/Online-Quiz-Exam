<template>
    <textarea class="text-sm border-gray-300 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 rounded-sm shadow-sm"
              :value="value" @input="$emit('input', $event.target.value)" ref="input" rows="4">
    </textarea>
</template>

<script>
    export default {
        props: ['value'],

        methods: {
            focus() {
                this.$refs.input.focus()
            }
        }
    }
</script>

