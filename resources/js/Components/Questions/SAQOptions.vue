<template>
    <div class="msa-options">
        <div class="mb-4" v-for="(option, index) in options" :key="index">
            <div class="text-sm font-semibold mb-2">Acceptable Answer {{ index+1 }}</div>
            <InputText class="w-full" :id="'option_text_'+index" v-model="options[index].option" style="border-radius: 0 !important;"></InputText>
            <div class="flex bg-gray-50 border-b border-l border-r border-gray-300 justify-between items-center px-4 py-2">
                <div class="flex gap-1 items-center">
                    <input type="radio" @change="selectAnswer" class="custom-control-input" :id="'option-'+index" v-model="correct_answer" :value="index+1">
                    <label class="custom-control-label" :for="'option-'+index">Exact Answer</label>
                </div>
                <div class="flex items-center justify-end gap-2">
                    <div class="flex gap-1 items-center">
                        <label class="custom-control-label text-sm" :for="'weight-'+index">Partial Weighting: </label>
                        <InputNumber class="tiny-input" :id="'weight-'+index" v-model="options[index].partial_weightage"
                                     suffix=" %" :disabled="(correct_answer-1) === index" />
                    </div>
                    <div v-if="index > 0" class="text-sm bg-red-500 px-2 py-1 rounded text-white text-sm cursor-pointer hover:bg-red-600" @click="removeOption(index)">
                        Remove
                    </div>
                </div>
            </div>

        </div>
        <button type="button" class="text-sm transition focus:outline-none duration-150 w-full my-2 p-4 border border-green-300 border-dashed hover:bg-green-100 hover:border-green-400" @click="addOption">Add Option</button>
    </div>
</template>
<script>
    import InputNumber from 'primevue/inputnumber';
    import InputText from 'primevue/inputtext';
    export default {
        name: 'SAQOptions',
        components: {
            InputText,
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
