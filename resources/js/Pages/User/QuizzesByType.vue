<template>
    <app-layout>
        <template #header>
            <h4 class="page-heading">{{ type.plural_name }}</h4>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col items-center">
                    <div class="w-full sm:w-2/3">
                        <div class="flex justify-between items-center mb-4">
                            <div class="relative inline-flex">
                              <h4 class="py-4 px-4 text-xl font-semibold leading-tight text-gray-800">{{ type.plural_name }}</h4>
                            </div>
                            <div class="px-4">
                                <span v-if="!loading && pagination" class="text-sm text-gray-500">{{ pagination.total }} quizzes found</span>
                            </div>
                        </div>
                        <div v-if="loading" class="grid grid-cols-1 sm:grid-cols-2 gap-4 auto-rows-auto justify-center">
                            <quiz-card-shimmer></quiz-card-shimmer>
                            <quiz-card-shimmer></quiz-card-shimmer>
                            <quiz-card-shimmer></quiz-card-shimmer>
                            <quiz-card-shimmer></quiz-card-shimmer>
                        </div>
                        <div v-else class="grid grid-cols-1 sm:grid-cols-2 gap-4 px-4 mb-6">
                            <template v-for="(quiz, index) in quizzes">
                                <quiz-card :quiz="quiz">
                                    <template #action>
                                        <inertia-link :href="route('quiz_instructions', {slug: quiz.slug})">
                                            <span class="qt-btn qt-btn-sm qt-btn-success">Details</span>
                                        </inertia-link>
                                    </template>
                                </quiz-card>
                            </template>
                        </div>
                        <div class="mb-6" v-if="!loading && quizzes.length === 0" >
                            <empty-student-card :title="'No Schedules Found'"></empty-student-card>
                        </div>
                        <div v-if="!loading && pagination && !(quizzes.length === pagination.total)" class="flex justify-center items-center">
                            <button @click="loadMoreQuizzes" class="qt-btn qt-btn-success flex items-center justify-center">
                                <span v-if="paginationLoading" class="text-sm"><i class="pi pi-spin pi-spinner mr-2"></i> Fetching</span>
                                <span v-else>Load More</span>
                            </button>
                        </div>
                        <div v-if="!loading && pagination && (pagination.total_pages === pagination.current_page)" class="flex text-sm justify-center items-center py-4">
                            No more quizzes found for the selected criteria.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import QuizCard from "@/Components/Cards/QuizCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import QuizCardShimmer from "@/Components/Shimmers/QuizCardShimmer";

    export default {
        components: {
            EmptyStudentCard,
            AppLayout,
            QuizCard,
            QuizCardShimmer
        },
        props: {
            type: Object,
        },
        data() {
            return {
                quizzes: Object,
                pagination: Object,
                debounce: null,
                loading: false,
                paginationLoading: false,
            }
        },
        methods: {
            fetchQuizzes() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_quizzes_by_type', {type:  _this.type.slug})).then(function (response) {
                    let data = response.data.quizzes;
                    _this.quizzes = data.data;
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
            loadMoreQuizzes() {
                let _this = this;
                _this.paginationLoading = true;
                axios.get(this.pagination.links.next)
                    .then(function (response) {
                        let data = response.data.quizzes.data;
                        _this.pagination = response.data.quizzes.meta.pagination;
                        data.forEach((item) => _this.quizzes.push(item));
                        _this.paginationLoading = false;
                    })
                    .catch(function (error) {
                        _this.paginationLoading = false;
                    });
            },
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.type.name + ' - ' + this.$page.props.general.app_name;
            }
        },
        mounted() {
            this.fetchQuizzes()
        }
    }
</script>
