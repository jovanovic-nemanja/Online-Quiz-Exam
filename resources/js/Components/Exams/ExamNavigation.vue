<template>
    <SplitButton class="p-button-success" label="Manage" icon="pi pi-cog" :model="items"></SplitButton>
</template>
<script>
    import SplitButton from 'primevue/splitbutton';
    export default {
        name: 'ExamNavigation',
        components: {
            SplitButton
        },
        props: {
            currentRoute: '',
            examId: ''
        },
        data() {
            return {
                items: [
                    {
                        label: 'Exam Dashboard',
                        command: () => {
                            this.$inertia.get(route('exams.show', { exam: this.examId }))
                        }
                    },
                    {
                        label: 'Edit Details',
                        command: () => {
                            this.$inertia.get(route('exams.edit', { exam: this.examId }))
                        }
                    },
                    {
                        label: 'Sections',
                        command: () => {
                            this.$inertia.get(route('exams.sections.index', { exam: this.examId }))
                        }
                    },
                    {
                        label: 'Questions',
                        command: () => {
                            this.$inertia.get(route('exams.questions', { exam: this.examId }))
                        }
                    },
                    {
                        label: 'Settings',
                        command: () => {
                            this.$inertia.get(route('exams.settings', { exam: this.examId }))
                        }
                    },
                    {
                        label: 'Schedules',
                        command: () => {
                            this.$inertia.get(route('exams.sections.index', { exam: this.examId }))
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
