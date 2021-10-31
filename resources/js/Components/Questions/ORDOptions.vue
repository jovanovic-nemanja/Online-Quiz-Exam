<template>
    <div class="ord-options">
        <div class="transition duration-150 ease-in-out w-full mx-auto py-3 px-4 bg-white lg:flex items-center justify-between shadow rounded">
            <div class="lg:flex sm:items-start lg:items-center">
                <div class="flex items-end">
                    <div class="mr-2 text-red-400">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
                            <path class="heroicon-ui" d="M12 22a10 10 0 1 1 0-20 10 10 0 0 1 0 20zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm0-9a1 1 0 0 1 1 1v4a1 1 0 0 1-2 0v-4a1 1 0 0 1 1-1zm0-4a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
                        </svg>
                    </div>
                    <p class="mr-2 text-sm font-bold text-red-400">Note</p>
                </div>
                <div class="h-1 w-1 bg-gray-300 dark:bg-gray-700 rounded-full mr-2 hidden xl:block"></div>
                <p class="text-sm text-gray-600 dark:text-gray-400 pt-2 lg:pt-0 pb-2 lg:pb-0 w-4/5 lg:w-auto">
                    Enter items in correct order. Items will automatically shuffle while showing to users.
                </p>
            </div>
        </div>
        <div class="my-4" v-for="(option, index) in options" :key="index">
            <div class=" font-semibold mb-2">Sequence Item {{ index+1 }}</div>
            <ckeditor :id="'option_text_'+index" :editor-url="editorUrl" :config="editorConfig" v-model="options[index].option"></ckeditor>
            <div class="flex bg-gray-50 border-b border-l border-r border-gray-300 justify-between items-center px-4 py-2">
                <div class="flex gap-1 items-center">

                </div>
                <div class="flex items-center justify-end gap-2">
                    <div v-if="index > 1" class="text-sm bg-red-500 px-2 py-1 rounded text-white cursor-pointer hover:bg-red-600" @click="removeOption(index)">
                        Remove
                    </div>
                </div>
            </div>
        </div>
        <button type="button" class="text-sm transition focus:outline-none duration-150 w-full my-2 p-4 border border-green-300 border-dashed hover:bg-green-100 hover:border-green-400"
                @click="addOption">Add Sequence Item</button>
    </div>
</template>
<script>
    import CKEditor from 'ckeditor4-vue';
    export default {
        name: 'ORDOptions',
        props: {
            parentOptions: Array,
        },
        components: {
            ckeditor: CKEditor.component,
        },
        data: function () {
            return {
                options: this.parentOptions,
                editorUrl: window.CKEditorURL,
                editorConfig: {
                    height: '75px',
                    toolbar: [
                        ['Image','Katex'],
                        ['Subscript','Superscript'],
                    ]
                }
            }
        },
        methods: {
            addOption: function () {
                if(this.options.length > 4) {
                    this.$confirm.require({
                        header: 'Are you sure?',
                        message: 'Usually, a good question will not have more than 5 options!',
                        icon: 'pi pi-info-circle',
                        acceptClass: 'p-button-warning',
                        rejectLabel: 'Cancel',
                        acceptLabel: 'Add Anyway',
                        accept: () => {
                            if(this.options.length <= 9) {
                                this.options.push({
                                    'option' : '',
                                    'partial_weightage' : 0
                                });
                            } else {
                                this.$toast.add({
                                    severity: 'error',
                                    summary: 'Nope',
                                    detail: 'You can only add a maximum no. of 10 options',
                                    life: 3000
                                });
                            }
                        },
                        reject: () => {

                        }
                    });
                } else {
                    if(this.options.length <= 9) {
                        this.options.push({
                            'option' : '',
                            'partial_weightage' : 0
                        });
                    } else {
                        this.$toast.add({
                            severity: 'error',
                            summary: 'Nope',
                            detail: 'You can only add a maximum no. of 10 options',
                            life: 3000
                        });
                    }
                }
            },
            clearAnswer: function (evt) {
                this.$emit('modifyOptions', this.options);
            },
            removeOption: function (option) {
                this.options.splice(option, 1);
            },
        }
    }
</script>
