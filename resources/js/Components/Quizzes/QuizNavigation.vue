<template>
    <SplitButton class="p-button-success" label="Manage" icon="pi pi-cog" :model="items"></SplitButton>
</template>
<script>
    import SplitButton from 'primevue/splitbutton';
    export default {
        name: 'QuizNavigation',
        components: {
            SplitButton
        },
        props: {
            currentRoute: '',
            quizId: ''
        },
        data() {
            return {
                items: [
                    {
                        label: 'Edit Details',
                        command: () => {
                            this.$inertia.get(route('quizzes.edit', { quiz: this.quizId }))
                        }
                    },
                    {
                        label: 'Questions',
                        command: () => {
                            this.$inertia.get(route('quizzes.questions', { quiz: this.quizId }))
                        }
                    },
                    {
                        label: 'Settings',
                        command: () => {
                            this.$inertia.get(route('quizzes.settings', { quiz: this.quizId }))
                        }
                    },
                    {
                        label: 'Schedules',
                        command: () => {
                            this.$inertia.get(route('quizzes.schedules.index', { quiz: this.quizId }))
                        }
                    }
                ]
            }
        },
        computed: {
            activeLink() {
                return route(route().current(), {exam: this.examId});
            }
        },
    }
</script>
