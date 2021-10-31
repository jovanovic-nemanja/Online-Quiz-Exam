<template>
    <div class="msa-options">
        <div class="mb-4" v-for="(option, index) in options" :key="index">
            <div class=" font-semibold mb-2">Option {{ index+1 }}</div>
            <ckeditor :id="'option_text_'+index" :editor-url="editorUrl" :config="editorConfig" v-model="options[index].option"></ckeditor>
            <div class="flex bg-gray-50 border-b border-l border-r border-gray-300 justify-between items-center px-4 py-2">
                <div class="flex gap-1 items-center">
                    <input type="radio" @change="selectAnswer" class="custom-control-input" :id="'option-'+index" v-model="correct_answer" :value="index+1">
                    <label class="custom-control-label" :for="'option-'+index">Correct Answer</label>
                </div>
                <div class="flex items-center justify-end gap-2">
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
        name: 'TOFOptions',
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
        methods: {
            selectAnswer (event) {
                this.options[this.correct_answer-1].partial_weightage = 0;
                this.$emit('modifyAnswer', this.correct_answer)
            }
        }
    }
</script>
