<template>
    <div class="bg-white shadow px-4 py-5 border-b-4 border-gray-800 mb-6">
        <h5 class="inline-block bg-green-100 rounded-sm px-2 py-1 mb-4 text-xs leading-3 text-green-700">{{ question.skill }}</h5>
        <div class="q-data mb-4">
            <div class="" v-html="question.question"></div>
        </div>
        <!--<div v-show="!collapse" :id="question.code+'_options'">
            <ul class="q-option" v-for="(option, index) in question.options">
                <li class="flex items-center mb-3 cursor-pointer p-3 rounded-sm border border-gray-200">
                    <div class="h-6 w-6 flex rounded-full items-center justify-center bg-gray-100 ">{{ index+1 }}</div>
                    <div class="font-normal ml-4" v-html="option.option"></div>
                </li>
            </ul>
        </div>
        <a @click="collapse = !collapse" class="qt-link-success mb-4" v-html="collapse ? 'View Options' : 'Hide Options'"></a>-->
        <ul class="mt-5">
            <li class="text-gray-600 flex items-center mb-4">
                <span class="font-semibold">Question Type:</span>
                <span class="ml-2">{{ question.question_type_name }}</span>
            </li>
            <li class="text-gray-600 flex items-center mb-4">
                <span class="font-semibold">Difficulty Level:</span>
                <span class="ml-2">{{ question.difficulty }}</span>
            </li>
            <li class="text-gray-600 flex items-center mb-4">
                <span class="font-semibold">Marks/Points:</span>
                <span class="ml-2">{{ question.marks }} XP</span>
            </li>
            <li class="text-gray-600 flex items-center mb-4">
                <span class="font-semibold">Attachment:</span>
                <span class="ml-2">{{ question.attachment }}</span>
            </li>
        </ul>
        <div class="mt-4 flex justify-between items-center">
            <h5 class="inline-block bg-gray-100 rounded-sm px-2 py-1 text-xs leading-3 text-gray-700">{{ question.code }}</h5>
            <slot name="action"></slot>
        </div>
    </div>
</template>
<script>
    export default {
        name: "LAQSolution",
        props: {
            question: Object,
        },
        data() {
            return {
                collapse: true
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
