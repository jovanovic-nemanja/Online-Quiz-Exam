<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">Import Questions</h4>
        </template>

        <div class="py-12">
            <div class="md:w-10/12 lg:w-8/12 xl:w-6/12 w-full mx-auto md:pb-0 md:px-6">
                <div v-if="hasErrors" class="bg-red-200 shadow rounded-md md:flex justify-between items-center top-0 mt-12 mb-8 pb-4 px-4">
                    <arc-validation-errors></arc-validation-errors>
                </div>
                <div class="bg-white shadow rounded">
                    <div class="w-full border-b border-gray-200 flex justify-end p-2">
                        <a :href="sampleFileUrl" class="flex bg-white hover:bg-green-50 py-2 px-4 items-center rounded mb-2 xl:mb-0 lg:mb-0 md:mb-0 sm:mb-0 cursor-pointer">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="27" viewBox="0 0 48 54.2">
                                <g id="xlsx" transform="translate(-24.36 5)">
                                    <path id="main" data-name="main" d="M76.323,19.387h-1.3v-6.28a1.041,1.041,0,0,0-.011-.119,1.043,1.043,0,0,0-.253-.688L64.307.363S64.3.359,64.3.356a1.046,1.046,0,0,0-.212-.178c-.023-.015-.046-.028-.069-.041a1.116,1.116,0,0,0-.21-.088c-.02-.005-.037-.013-.057-.018A1.056,1.056,0,0,0,63.507,0H37.825A2.128,2.128,0,0,0,35.7,2.126V19.387H34.4a3.038,3.038,0,0,0-3.038,3.038v15.8A3.039,3.039,0,0,0,34.4,41.26h1.3V52.075A2.127,2.127,0,0,0,37.825,54.2H72.9a2.128,2.128,0,0,0,2.125-2.125V41.26h1.3a3.038,3.038,0,0,0,3.038-3.038v-15.8A3.037,3.037,0,0,0,76.323,19.387ZM37.825,2.126h24.62V13a1.063,1.063,0,0,0,1.063,1.063H72.9v5.324H37.825Zm21.532,28.98c-2.088-.727-3.451-1.883-3.451-3.711,0-2.145,1.79-3.786,4.756-3.786a7.693,7.693,0,0,1,3.207.634l-.634,2.293a5.982,5.982,0,0,0-2.629-.6c-1.231,0-1.828.56-1.828,1.213,0,.8.709,1.156,2.331,1.772,2.219.821,3.263,1.977,3.263,3.749,0,2.108-1.623,3.9-5.073,3.9a8.217,8.217,0,0,1-3.562-.765l.578-2.35a7.261,7.261,0,0,0,3.152.784c1.307,0,2-.541,2-1.362C61.464,32.094,60.867,31.646,59.357,31.105ZM54.547,34v2.388H46.694V23.812h2.855V34ZM37.576,36.384H34.331l3.637-6.361-3.507-6.211h3.264l1.1,2.294c.373.765.653,1.379.952,2.089h.036c.3-.8.541-1.362.858-2.089l1.063-2.294h3.245l-3.544,6.135,3.731,6.436H41.883l-1.138-2.276c-.465-.875-.764-1.529-1.119-2.256h-.037c-.261.727-.578,1.381-.97,2.256ZM72.9,51.5H37.825V41.26H72.9V51.5Zm.019-15.116-1.138-2.276c-.466-.876-.764-1.529-1.119-2.256h-.036c-.262.728-.579,1.38-.971,2.256l-1.043,2.276H65.361L69,30.022l-3.506-6.211h3.264l1.1,2.294c.373.765.652,1.379.951,2.089h.037c.3-.8.54-1.362.857-2.089l1.063-2.294h3.246l-3.544,6.135,3.73,6.436H72.915Z" transform="translate(-7 -5)" fill="#1d6f42"/>
                                </g>
                            </svg>
                            <span class="text-gray-600 text-sm font-bold pl-2">Download Sample Excel</span>
                        </a>
                    </div>
                    <div class="p-6">
                        <form @submit.prevent="submit" enctype="multipart/form-data">
                            <div class="w-full flex flex-col mb-6">
                                <label class="pb-2 text-sm font-semibold text-gray-800">Choose Skill<span class="ml-1 text-red-400">*</span></label>
                                    <v-select id="skill_id" v-model="skill_id" :options="skills" @input="skillChanged" @search="searchSkills" :reduce="skill => skill.id" label="name" placeholder="Search Skill" />
                                <div class="form-control-errors">
                                    <p v-if="errors.skill_id" role="alert" class="text-xs text-red-500 pt-2">{{ errors.skill_id }}</p>
                                </div>
                            </div>
                            <!--<div class="w-full flex flex-col mb-6">
                                <label class="pb-2 text-sm font-semibold text-gray-800">Choose Topic <span>(Optional)</span></label>
                                <v-select id="topic_id" v-model="topic_id" :options="topics" @search="searchTopics" :reduce="topic => topic.id" label="name" placeholder="Search Topic" />
                                <div class="form-control-errors">
                                    <p v-if="errors.topic_id" role="alert" class="text-xs text-red-500 pt-2">{{ errors.topic_id }}</p>
                                </div>
                            </div>-->
                            <div class="w-full flex flex-col mb-6">
                                <input class="text-sm" type="file" id="file" ref="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" @change="handleFileUpload()"/>
                                <div class="form-control-errors">
                                    <p v-if="errors.file" role="alert" class="text-xs text-red-500 pt-2">{{ errors.file }}</p>
                                </div>
                            </div>
                            <div class="w-full flex justify-end">
                                <button type="submit" class="qt-btn qt-btn-success">Upload File</button>
                            </div>
                        </form>
                    </div>
                    <hr>
                    <div class="w-full p-6">
                        <h4 class="pb-6 text-sm font-semibold text-gray-800">Question Types</h4>
                        <table class="w-full table-auto">
                            <thead>
                                <tr>
                                    <th class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">Name</th>
                                    <th class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-center">Acceptable Code</th>
                                </tr>
                            </thead>
                            <tbody>
                            <tr v-for="questionType in questionTypes">
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">{{ questionType.name }}</td>
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-center">
                                    <Tag v-clipboard:copy="questionType.code" v-clipboard:success="handleCopyStatus" :value="questionType.code" icon="pi pi-copy"
                                         class="w-28 p-mr-2 text-sm cursor-pointer"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <h4 class="py-6 text-sm font-semibold text-gray-800">Difficulty Levels</h4>
                        <table class="w-full table-auto">
                            <thead>
                            <tr>
                                <th class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">Name</th>
                                <th class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-center">Acceptable Code</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="difficultyLevel in difficultyLevels">
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">{{ difficultyLevel.name }}</td>
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-center">
                                    <Tag v-clipboard:copy="difficultyLevel.code" v-clipboard:success="handleCopyStatus" :value="difficultyLevel.code" icon="pi pi-copy"
                                         class="w-28 p-mr-2 text-sm cursor-pointer"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcValidationErrors from '@/Components/ValidationErrors'
    import Tag from "primevue/tag";
    export default {
        components: {
            AdminLayout,
            ArcValidationErrors,
            Tag
        },
        props: {
            sampleFileUrl: String,
            errors: Object,
            questionTypes: Array,
            difficultyLevels: Array,
        },
        data() {
            return {
                skill_id: null,
                topic_id: null,
                debounce: null,
                skills: [],
                topics: [],
                file: null,
                formValidated: false,
            }
        },
        methods: {
            submit() {
                this.formValidated = true;
                if(this.skill_id !== null && this.file !== null) {
                    let formData = new FormData();
                    formData.append('file', this.file);
                    formData.append('topic', this.topic_id);
                    this.$inertia.post(route('import_questions', {skill: this.skill_id}), formData, {
                        onSuccess: () => {
                            if (Object.keys(this.errors).length === 0) {
                                this.$emit('close', true);
                            }
                        },
                    });
                } else {
                    this.$toast.add({
                        severity: 'error',
                        summary: 'Caution',
                        detail: 'Please Choose Skill or File',
                        life: 3000
                    });
                }
            },
            handleFileUpload(){
                this.file = this.$refs.file.files[0];
            },
            skillChanged() {
                this.topics = [];
                this.topic_id = null;
            },
            searchSkills(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.skills = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_skills', {query: search}))
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
            searchTopics(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.topics = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_topics', {query: search, skill_id: _this.skill_id}))
                            .then(function (response) {
                                _this.topics = response.data.topics;
                                loading(false);
                            })
                            .catch(function (error) {
                                loading(false);
                            });
                    }, 600)
                }
            },
            handleCopyStatus(status) {
                if (status) {
                    this.$toast.add({
                        severity: 'success',
                        summary: 'Copied',
                        detail: 'Copied Successfully!',
                        life: 2000
                    });
                }
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return 'Import Questions - ' + this.$page.props.general.app_name + ' Admin';
            },
            hasErrors() {
                return Object.keys(this.errors).length > 0;
            },
        }
    }
</script>
