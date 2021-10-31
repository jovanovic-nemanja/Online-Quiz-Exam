<template>
    <arc-form-section @submitted="updateProfileInformation">
        <template #title>
            Profile Information
        </template>

        <template #description>
            Update your account's profile information and email address.
        </template>

        <template #form>
            <!-- Profile Photo -->
            <div class="col-span-6 sm:col-span-4" v-if="$page.props.jetstream.managesProfilePhotos">
                <!-- Profile Photo File Input -->
                <input type="file" class="hidden"
                            ref="photo"
                            @change="updatePhotoPreview">

                <arc-label for="photo" value="Photo" />

                <!-- Current Profile Photo -->
                <div class="mt-2" v-show="! photoPreview">
                    <img :src="user.profile_photo_url" :alt="user.name" class="rounded-full h-20 w-20 object-cover">
                </div>

                <!-- New Profile Photo Preview -->
                <div class="mt-2" v-show="photoPreview">
                    <span class="block rounded-full w-20 h-20"
                          :style="'background-size: cover; background-repeat: no-repeat; background-position: center center; background-image: url(\'' + photoPreview + '\');'">
                    </span>
                </div>

                <arc-secondary-button class="mt-2 mr-2" type="button" @click.native.prevent="selectNewPhoto">
                    Select A New Photo
                </arc-secondary-button>

                <arc-secondary-button type="button" class="mt-2" @click.native.prevent="deletePhoto" v-if="user.profile_photo_path">
                    Remove Photo
                </arc-secondary-button>

                <arc-input-error :message="form.errors.photo" class="mt-2" />
            </div>

            <!-- Last Name -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="first_name" value="First Name" />
                <arc-input id="first_name" type="text" class="mt-1 block w-full" v-model="form.first_name" autocomplete="first_name" />
                <arc-input-error :message="form.errors.first_name" class="mt-2" />
            </div>

            <!-- Last Name -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="last_name" value="Last Name" />
                <arc-input id="last_name" type="text" class="mt-1 block w-full" v-model="form.last_name" autocomplete="last_name" />
                <arc-input-error :message="form.errors.last_name" class="mt-2" />
            </div>

            <!-- Email -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="email" value="Email" />
                <arc-input id="email" type="email" class="mt-1 block w-full" v-model="form.email" />
                <arc-input-error :message="form.errors.email" class="mt-2" />
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
    import ArcButton from '@/Components/Button'
    import ArcFormSection from '@/Components/FormSection'
    import ArcInput from '@/Components/Input'
    import ArcInputError from '@/Components/InputError'
    import ArcLabel from '@/Components/Label'
    import ArcActionMessage from '@/Components/ActionMessage'
    import ArcSecondaryButton from '@/Components/SecondaryButton'

    export default {
        components: {
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
            ArcInput,
            ArcInputError,
            ArcLabel,
            ArcSecondaryButton,
        },

        props: ['user'],

        data() {
            return {
                form: this.$inertia.form({
                    _method: 'PUT',
                    first_name: this.user.first_name,
                    last_name: this.user.last_name,
                    email: this.user.email,
                    photo: null,
                }),

                photoPreview: null,
            }
        },

        methods: {
            updateProfileInformation() {
                if (this.$refs.photo) {
                    this.form.photo = this.$refs.photo.files[0]
                }

                this.form.post(route('user-profile-information.update'), {
                    errorBag: 'updateProfileInformation',
                    preserveScroll: true
                });
            },

            selectNewPhoto() {
                this.$refs.photo.click();
            },

            updatePhotoPreview() {
                const reader = new FileReader();

                reader.onload = (e) => {
                    this.photoPreview = e.target.result;
                };

                reader.readAsDataURL(this.$refs.photo.files[0]);
            },

            deletePhoto() {
                this.$inertia.delete(route('current-user-photo.destroy'), {
                    preserveScroll: true,
                    onSuccess: () => (this.photoPreview = null),
                });
            },
        },
    }
</script>
