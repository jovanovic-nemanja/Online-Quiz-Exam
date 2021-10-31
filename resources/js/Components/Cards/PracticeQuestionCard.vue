<template>
    <div class="border rounded border-gray-200 bg-gray-50 p-6 shadow-sm">
        <div class="flex gap-2 mb-4">
            <span class="text-sm font-semibold">{{ sno }} of {{ totalQuestions }}</span>
            <span class="text-sm">|</span>
            <span class="text-sm text-gray-600 uppercase">{{ question.skill }}</span>
        </div>
        <div class="mb-4" v-if="attachmentType != null">
            <div v-if="attachmentType === 'audio'">
                <audio-attachment :reference="'player_'+question.code" :options="attachment"></audio-attachment>
            </div>
            <div v-if="attachmentType === 'video'">
                <video-attachment :reference="'player_'+question.code" :options="attachment"></video-attachment>
            </div>
            <div v-if="attachmentType === 'comprehension'">
                <comprehension-attachment :passage="attachment"></comprehension-attachment>
            </div>
        </div>
        <div class="q-data question" v-html="question.question"></div>
    </div>
</template>
<script>
    import AudioAttachment from "@/Components/Questions/Attachments/AudioAttachment";
    import VideoAttachment from "@/Components/Questions/Attachments/VideoAttachment";
    import ComprehensionAttachment from "@/Components/Questions/Attachments/ComprehensionAttachment";
    export default {
        name: 'PracticeQuestionCard',
        components: {
            AudioAttachment,
            VideoAttachment,
            ComprehensionAttachment
        },
        props: {
            question: Object,
            sno: Number,
            totalQuestions: Number,
            attachmentType: String,
            attachment: [String, Object]
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
