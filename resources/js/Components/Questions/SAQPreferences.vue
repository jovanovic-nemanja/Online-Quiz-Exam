<template>
    <div class="saq-preferences">
        <div class="w-full">
            <div class="flex justify-between items-center mb-8">
                <div class="w-9/12">
                    <label for="case_sensitive" class="font-semibold text-sm text-gray-800 pb-1">Case Sensitive</label>
                    <p v-if="preferences.case_sensitive" class="text-sm text-gray-500">Yes (Answers will be considered as case sensitive).</p>
                    <p v-if="!preferences.case_sensitive" class="text-sm text-gray-500">No (Answers will not be considered as case sensitive).</p>
                </div>
                <div class="cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="case_sensitive" v-model="preferences.case_sensitive" />
                </div>
            </div>
            <div class="flex justify-between items-center">
                <div class="w-9/12">
                    <label for="is_numeric" class="font-semibold text-sm text-gray-800 pb-1">Is Numeric</label>
                    <p v-if="preferences.is_numeric" class="text-sm text-gray-500">Yes (Answers will be considered as numbers).</p>
                    <p v-if="!preferences.is_numeric" class="text-sm text-gray-500">No (Answers will not be considered as numbers).</p>
                </div>
                <div class="cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="is_numeric" v-model="preferences.is_numeric" />
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import InputSwitch from 'primevue/inputswitch';
    export default {
        name: 'SAQPreferences',
        components: {
            InputSwitch
        },
        props: {
            parentPreferences: Object,
        },
        data: function () {
            return {
                preferences: this.parentPreferences,
            }
        },
        methods: {
            selectAnswer (event) {
                this.$emit('modifyPreferences', this.preferences)
            }
        }
    }
</script>
