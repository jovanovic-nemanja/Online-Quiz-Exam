<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">Practice {{ category.name }} {{ section.name }}</h4>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col justify-center items-center">
                    <div class="w-full sm:w-2/3">
                        <div class="w-full flex flex-col mb-6">
                            <v-select class="bg-white" id="skill" @input="fetchSets" v-model="currentSkill" :options="skills" @search="searchSkills"
                                      :reduce="skill => skill.id" label="name" placeholder="Search by skill"/>
                        </div>
                        <div v-if="loading" class="grid grid-cols-1 sm:grid-cols-2 gap-4 auto-rows-auto justify-center">
                            <practice-set-card-shimmer></practice-set-card-shimmer>
                            <practice-set-card-shimmer></practice-set-card-shimmer>
                            <practice-set-card-shimmer></practice-set-card-shimmer>
                            <practice-set-card-shimmer></practice-set-card-shimmer>
                        </div>
                        <div v-else class="grid grid-cols-1 sm:grid-cols-2 gap-4 auto-rows-auto justify-center">
                            <template v-for="(practiceSet, index) in practiceSets">
                                <practice-set-card :practice-set="practiceSet">
                                    <template #action>
                                        <inertia-link :href="route('init_practice_set', {slug: practiceSet.slug})">
                                            <span class="qt-btn qt-btn-sm qt-btn-success">Start Practice</span>
                                        </inertia-link>
                                    </template>
                                </practice-set-card>
                            </template>
                        </div>
                        <empty-student-card v-if="!loading && practiceSets.length === 0" :title="'No practice tests found in this section'">
                            <template #action>
                                <inertia-link :href="route('practice_dashboard')">
                                    <span class="qt-btn qt-btn-sm qt-btn-primary">Go Back</span>
                                </inertia-link>
                            </template>
                        </empty-student-card>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import PracticeSetCard from "@/Components/Cards/PracticeSetCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import PracticeSetCardShimmer from "@/Components/Shimmers/PracticeSetCardShimmer";
    export default {
        components: {
            AppLayout,
            PracticeSetCard,
            EmptyStudentCard,
            PracticeSetCardShimmer
        },
        props: {
            category: Object,
            section: Object,
        },
        data() {
            return {
                practiceSets: [],
                pagination: {},
                skills: [],
                currentSkill: null,
                debounce: null,
                loading: false,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        methods: {
            fetchSets() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_practice_sets', {
                    category: _this.category.slug,
                    section: _this.section.slug,
                    skill_id: _this.currentSkill
                })).then(function (response) {
                        let data = response.data.sets;
                        _this.practiceSets = data.data;
                        _this.pagination = data.meta.pagination;
                        _this.loading = false;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            },
            searchSkills(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.skills = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_skills', {query: search, section_id: _this.section.id}))
                            .then(function (response) {
                                _this.skills = response.data.skills;
                                loading(false);
                            })
                            .catch(function (error) {
                                loading(false);
                            });
                    }, 600)
                }
            },
        },

        computed: {
            title() {
                return this.category.name + ' ' + this.section.name + ' Practice Sets - ' + this.$page.props.general.app_name;
            },
            subTitle() {
                return this.practiceSets.length > 0 ? this.practiceSets.length + ' Practice Sets in this Section.' : 'No Practice Sets in this Section.'
            }
        },

        created() {
            this.fetchSets();
        }
    }
</script>
