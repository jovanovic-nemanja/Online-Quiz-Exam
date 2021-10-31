<template>
    <div class="fib-options">
        <div class="w-full">
            <div class="flex justify-between items-center mb-4">
                <div class="w-9/12">
                    <label for="is_active" class="font-semibold text-gray-800 pb-1">Word Limit</label>
                    <p class="text-gray-500">Restrict answer with certain word limit.</p>
                </div>
                <div class="cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="is_active" v-model="preferences.word_limit" />
                </div>
            </div>
        </div>
        <div class="w-full">
            <div class="flex justify-between items-center mb-8">
                <div class="w-6/12">
                    <label for="min_words" class="font-semibold text-gray-800 pb-1">Minimum Words</label>
                    <InputNumber id="min_words" v-model="preferences.min_words" placeholder="Enter Minimum Words" :disabled="!preferences.word_limit" />
                </div>
                <div class="w-6/12">
                    <label for="max_words" class="font-semibold text-gray-800 pb-1">Maximum Words</label>
                    <InputNumber id="max_words" v-model="preferences.max_words" placeholder="Enter Minimum Words" :disabled="!preferences.word_limit" />
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import InputSwitch from 'primevue/inputswitch';
    import InputNumber from 'primevue/inputnumber';
    import { required } from 'vuelidate/lib/validators';
    export default {
        name: 'LAQOptions',
        components: {
            InputSwitch,
            InputNumber
        },
        props: {
            parentPreferences: Object,
        },
        data: function () {
            return {
                preferences: this.parentPreferences,
            }
        },
        validations() {
            return {
                preferences: {
                    ...this.preferences.word_limit && {
                        min_words: {
                            required
                        },
                        max_words: {
                            required
                        },
                    },
                }
            }
        },
        methods: {
            selectAnswer (event) {
                this.$emit('modifyPreferences', this.preferences)
            }
        }
    }
</script>
