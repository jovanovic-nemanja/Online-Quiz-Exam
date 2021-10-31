<template>
    <div class="msa-options">
        <div class="mb-4" v-for="(option, index) in options" :key="index">
            <div class="text-sm font-semibold mb-2">Option {{ letters[index] }}</div>
            <ckeditor :id="'option_text_'+index" :editor-url="editorUrl" :config="editorConfig" v-model="options[index].option"></ckeditor>
            <div class="flex flex-col sm:flex-row bg-gray-50 border-b border-l border-r border-gray-300 sm:justify-between sm:items-center px-4 py-2">
                <div class="flex items-center sm:justify-end gap-2">
                    <div class="flex gap-1 items-center">
                        <label class="custom-control-label" :for="'weight-'+index">Partial Weighting: </label>
                        <InputNumber class="tiny-input" :id="'weight-'+index" v-model="options[index].partial_weightage"
                                     suffix=" %" :disabled="(correct_answer-1) === index" />
                    </div>
                </div>
            </div>

        </div>
    </div>
</template>
<script>
    import CKEditor from 'ckeditor4-vue';
    import InputNumber from 'primevue/inputnumber';
    export default {
        name: 'PQOptions',
        
        components: {
            ckeditor: CKEditor.component,
            InputNumber
        },
        props: {
            parentOptions: Array,
            parentAnswer: null,
        },
        data: function () {
            return {
                letters: ['A','B','C','D'],
                options: this.parentOptions,
                correct_answer: this.parentAnswer,
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
        mounted: function(){
            this.addOption(),
            this.addOption()
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
                                Swal.fire({
                                    type: 'error',
                                    text: 'You can only add a maximum no. of 10 options'
                                })
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
            removeOption: function (option) {
                this.options.splice(option, 1);
                this.correct_answer = '';
                this.$emit('modifyOptions', this.options);
                this.$emit('modifyAnswer', this.correct_answer);
            },
            selectAnswer (event) {
                this.options[this.correct_answer-1].partial_weightage = 0;
                this.$emit('modifyAnswer', this.correct_answer)
            }
        }
    }
</script>
