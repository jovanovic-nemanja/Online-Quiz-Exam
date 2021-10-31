<template>
    <div>
        <!-- Generate API Token -->
        <arc-form-section @submitted="createApiToken">
            <template #title>
                Create API Token
            </template>

            <template #description>
                API tokens allow third-party services to authenticate with our application on your behalf.
            </template>

            <template #form>
                <!-- Token Name -->
                <div class="col-span-6 sm:col-span-4">
                    <arc-label for="name" value="Name" />
                    <arc-input id="name" type="text" class="mt-1 block w-full" v-model="createApiTokenForm.name" autofocus />
                    <arc-input-error :message="createApiTokenForm.errors.name" class="mt-2" />
                </div>

                <!-- Token Permissions -->
                <div class="col-span-6" v-if="availablePermissions.length > 0">
                    <arc-label for="permissions" value="Permissions" />

                    <div class="mt-2 grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div v-for="permission in availablePermissions" :key="permission">
                            <label class="flex items-center">
                                <arc-checkbox :value="permission" v-model="createApiTokenForm.permissions"/>
                                <span class="ml-2  text-gray-600">{{ permission }}</span>
                            </label>
                        </div>
                    </div>
                </div>
            </template>

            <template #actions>
                <arc-action-message :on="createApiTokenForm.recentlySuccessful" class="mr-3">
                    Created.
                </arc-action-message>

                <arc-button :class="{ 'opacity-25': createApiTokenForm.processing }" :disabled="createApiTokenForm.processing">
                    Create
                </arc-button>
            </template>
        </arc-form-section>

        <div v-if="tokens.length > 0">
            <arc-section-border />

            <!-- Manage API Tokens -->
            <div class="mt-10 sm:mt-0">
                <arc-action-section>
                    <template #title>
                        Manage API Tokens
                    </template>

                    <template #description>
                        You may delete any of your existing tokens if they are no longer needed.
                    </template>

                    <!-- API Token List -->
                    <template #content>
                        <div class="space-y-6">
                            <div class="flex items-center justify-between" v-for="token in tokens" :key="token.id">
                                <div>
                                    {{ token.name }}
                                </div>

                                <div class="flex items-center">
                                    <div class=" text-gray-400" v-if="token.last_used_ago">
                                        Last used {{ token.last_used_ago }}
                                    </div>

                                    <button class="cursor-pointer ml-6  text-gray-400 underline"
                                        @click="manageApiTokenPermissions(token)"
                                        v-if="availablePermissions.length > 0"
                                    >
                                        Permissions
                                    </button>

                                    <button class="cursor-pointer ml-6  text-red-500" @click="confirmApiTokenDeletion(token)">
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </div>
                    </template>
                </arc-action-section>
            </div>
        </div>

        <!-- Token Value Modal -->
        <arc-dialog-modal :show="displayingToken" @close="displayingToken = false">
            <template #title>
                API Token
            </template>

            <template #content>
                <div>
                    Please copy your new API token. For your security, it won't be shown again.
                </div>

                <div class="mt-4 bg-gray-100 px-4 py-2 rounded font-mono  text-gray-500" v-if="$page.props.jetstream.flash.token">
                    {{ $page.props.jetstream.flash.token }}
                </div>
            </template>

            <template #footer>
                <arc-secondary-button @click.native="displayingToken = false">
                    Close
                </arc-secondary-button>
            </template>
        </arc-dialog-modal>

        <!-- API Token Permissions Modal -->
        <arc-dialog-modal :show="managingPermissionsFor" @close="managingPermissionsFor = null">
            <template #title>
                API Token Permissions
            </template>

            <template #content>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div v-for="permission in availablePermissions" :key="permission">
                        <label class="flex items-center">
                            <arc-checkbox :value="permission" v-model="updateApiTokenForm.permissions"/>
                            <span class="ml-2  text-gray-600">{{ permission }}</span>
                        </label>
                    </div>
                </div>
            </template>

            <template #footer>
                <arc-secondary-button @click.native="managingPermissionsFor = null">
                    Nevermind
                </arc-secondary-button>

                <arc-button class="ml-2" @click.native="updateApiToken" :class="{ 'opacity-25': updateApiTokenForm.processing }" :disabled="updateApiTokenForm.processing">
                    Save
                </arc-button>
            </template>
        </arc-dialog-modal>

        <!-- Delete Token Confirmation Modal -->
        <arc-confirmation-modal :show="apiTokenBeingDeleted" @close="apiTokenBeingDeleted = null">
            <template #title>
                Delete API Token
            </template>

            <template #content>
                Are you sure you would like to delete this API token?
            </template>

            <template #footer>
                <arc-secondary-button @click.native="apiTokenBeingDeleted = null">
                    Nevermind
                </arc-secondary-button>

                <arc-danger-button class="ml-2" @click.native="deleteApiToken" :class="{ 'opacity-25': deleteApiTokenForm.processing }" :disabled="deleteApiTokenForm.processing">
                    Delete
                </arc-danger-button>
            </template>
        </arc-confirmation-modal>
    </div>
</template>

<script>
    import ArcActionMessage from '@/Components/ActionMessage'
    import ArcActionSection from '@/Components/ActionSection'
    import ArcButton from '@/Components/Button'
    import ArcConfirmationModal from '@/Components/ConfirmationModal'
    import ArcDangerButton from '@/Components/DangerButton'
    import ArcDialogModal from '@/Components/DialogModal'
    import ArcFormSection from '@/Components/FormSection'
    import ArcInput from '@/Components/Input'
    import ArcCheckbox from '@/Components/Checkbox'
    import ArcInputError from '@/Components/InputError'
    import ArcLabel from '@/Components/Label'
    import ArcSecondaryButton from '@/Components/SecondaryButton'
    import ArcSectionBorder from '@/Components/SectionBorder'

    export default {
        components: {
            ArcActionMessage,
            ArcActionSection,
            ArcButton,
            ArcConfirmationModal,
            ArcDangerButton,
            ArcDialogModal,
            ArcFormSection,
            ArcInput,
            ArcCheckbox,
            ArcInputError,
            ArcLabel,
            ArcSecondaryButton,
            ArcSectionBorder,
        },

        props: [
            'tokens',
            'availablePermissions',
            'defaultPermissions',
        ],

        data() {
            return {
                createApiTokenForm: this.$inertia.form({
                    name: '',
                    permissions: this.defaultPermissions,
                }),

                updateApiTokenForm: this.$inertia.form({
                    permissions: []
                }),

                deleteApiTokenForm: this.$inertia.form(),

                displayingToken: false,
                managingPermissionsFor: null,
                apiTokenBeingDeleted: null,
            }
        },

        methods: {
            createApiToken() {
                this.createApiTokenForm.post(route('api-tokens.store'), {
                    preserveScroll: true,
                    onSuccess: () => {
                        this.displayingToken = true
                        this.createApiTokenForm.reset()
                    }
                })
            },

            manageApiTokenPermissions(token) {
                this.updateApiTokenForm.permissions = token.abilities

                this.managingPermissionsFor = token
            },

            updateApiToken() {
                this.updateApiTokenForm.put(route('api-tokens.update', this.managingPermissionsFor), {
                    preserveScroll: true,
                    preserveState: true,
                    onSuccess: () => (this.managingPermissionsFor = null),
                })
            },

            confirmApiTokenDeletion(token) {
                this.apiTokenBeingDeleted = token
            },

            deleteApiToken() {
                this.deleteApiTokenForm.delete(route('api-tokens.destroy', this.apiTokenBeingDeleted), {
                    preserveScroll: true,
                    preserveState: true,
                    onSuccess: () => (this.apiTokenBeingDeleted = null),
                })
            },
        },
    }
</script>
