<template>
    <ckeditor :editor-url="editorUrl" :value="value" ref="editor" :config="editorConfig"></ckeditor>
</template>

<script>
    import CKEditor from 'ckeditor4-vue'
    export default {
        components: {
            ckeditor: CKEditor.component,
        },
        props: ['value'],
        data() {
            return {
                editorData: "",
                editorUrl: window.CKEditorURL,
                editorConfig: {
                    extraPlugins: ['mathjax'],
                }
            };
        },
        methods: {
            focus() {
                this.$refs.editor.focus()
            },
            reRender() {
                if(window.MathJax) {
                    console.log('rendering mathjax');
                    window.MathJax.Hub.Queue(["Typeset", window.MathJax.Hub], () => console.log('done'));
                }
            }
        },
        watch: {
            editorData: function() {
                console.log('data changed');
                this.$nextTick().then(()=>{
                    this.reRender();
                });
            }
        },
        mounted() {
            this.reRender();
        }
    }
</script>

