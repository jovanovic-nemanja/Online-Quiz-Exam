<template>
    <div class="overflow-y-auto h-screen px-2">
        <div class="bg-gray-100 py-4 lg:py-4 rounded">
            <div class="container px-6 mx-auto flex flex-col md:flex-row items-start md:items-center justify-between">
                <div>
                    <h4 class="text-base font-semibold leading-tight text-gray-800">
                        {{ title }}
                    </h4>
                </div>
            </div>
        </div>
        <div v-if="loading" class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0">
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
            <form-switch-shimmer></form-switch-shimmer>
        </div>
        <form v-else class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0" @submit.prevent="submitForm">
            <h3 class="mb-4 font-semibold">Select Sections</h3>
            <div v-for="section in sections" class="p-field-checkbox mb-2 py-2 cursor-pointer">
                <Checkbox :id="'section_'+section.id" name="section" :value="section.id" v-model="selected_sections" />
                <label class="ml-2" :for="'section_'+section.id">{{ section.name }}</label>
            </div>
            <small id="sections-error" v-if="formValidated && selected_sections.length === 0" class="p-invalid">Please choose at least one section.</small>
            <div class="w-full flex mt-4">
                <Button type="submit" :label="'Update'" />
            </div>
        </form>
    </div>
</template>
<script>
    import Button from 'primevue/button';
    import Checkbox from 'primevue/checkbox';
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
    export default {
        name: 'SectionMapForm',
        components: {
            Button,
            Checkbox,
            FormInputShimmer,
            FormSwitchShimmer
        },
        props: {
            editFlag: Boolean,
            subCategoryId: Number,
            errors: Object,
            title: ''
        },
        data() {
            return {
                sections: [],
                selected_sections: [],
                formValidated: false,
                loading: false,
            }
        },
        methods: {
            submitForm() {
                this.update();
            },
            update() {
                this.formValidated = true;
                if(this.selected_sections.length > 0) {
                    this.$inertia.post(route('update_sub_category_sections', { id: this.subCategoryId }), {selected_sections: this.selected_sections}, {
                        onSuccess: () => {
                            if (Object.keys(this.errors).length === 0) {
                                this.$emit('close', true);
                            }
                        },
                    });
                }
            },
            fetchSections() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_sub_category_sections', { id: this.subCategoryId }))
                    .then(function (response) {
                        let data = response.data;
                        _this.sections = data.sections;
                        _this.selected_sections = data.selected_sections;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            }
        },
        mounted() {
            this.fetchSections();
        }
    }
</script>
