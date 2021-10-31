<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            Email SMTP Settings
        </template>

        <template #description>
            Email SMTP Configuration Details
        </template>

        <template #form>
            <!-- Mail Host -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="host" value="Host Name" />
                <arc-input id="host" type="text" class="mt-1 block w-full" v-model="form.host" />
                <arc-input-error :message="form.errors.host" class="mt-2" />
            </div>

            <!-- Port Number -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="port" value="Port Number" />
                <arc-input id="port" type="number" class="mt-1 block w-full" v-model="form.port"  />
                <arc-input-error :message="form.errors.port" class="mt-2" />
            </div>

            <!-- User Name -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="username" value="User Name" />
                <arc-input id="username" type="text" class="mt-1 block w-full" v-model="form.username" />
                <arc-input-error :message="form.errors.username" class="mt-2" />
            </div>

            <!-- Password -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="password" value="Password" />
                <arc-input id="password" type="password" class="mt-1 block w-full" v-model="form.password" />
                <arc-input-error :message="form.errors.password" class="mt-2" />
            </div>

            <!-- Encryption -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="encryption" value="Encryption" />
                <arc-input id="encryption" type="text" class="mt-1 block w-full" v-model="form.encryption" />
                <arc-input-error :message="form.errors.encryption" class="mt-2" />
            </div>

            <!-- From Address -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="from_address" value="From Address" />
                <arc-input id="from_address" type="text" class="mt-1 block w-full" v-model="form.from_address" />
                <arc-input-error :message="form.errors.from_address" class="mt-2" />
            </div>

            <!-- From Name -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="from_name" value="From Name" />
                <arc-input id="from_name" type="text" class="mt-1 block w-full" v-model="form.from_name" />
                <arc-input-error :message="form.errors.from_name" class="mt-2" />
            </div>

        </template>

        <template #actions>
            <arc-action-message :on="form.recentlySuccessful" class="mr-3">
                Saved.
            </arc-action-message>

            <arc-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                Save
            </arc-button>
        </template>
    </arc-form-section>
</template>
<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcActionMessage from "@/Components/ActionMessage";
    import ArcButton from "@/Components/Button";
    import ArcFormSection from "@/Components/FormSection";
    import ArcInput from "@/Components/Input";
    import ArcInputError from "@/Components/InputError";
    import ArcLabel from "@/Components/Label";
    import ArcSecondaryButton from "@/Components/SecondaryButton";

    export default {
        components: {
            AdminLayout,
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
            ArcInput,
            ArcInputError,
            ArcLabel,
            ArcSecondaryButton,
        },
        props: {
            settings: Object
        },
        data() {
            return {
                form: this.$inertia.form({
                    host: this.settings.host,
                    port: this.settings.port,
                    username: this.settings.username,
                    password: this.settings.password,
                    encryption: this.settings.encryption,
                    from_name: this.settings.from_name,
                    from_address: this.settings.from_address,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_email_settings'), {
                    errorBag: 'updateEmailSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
