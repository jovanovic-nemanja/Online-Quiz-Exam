<?php
/**
 * File name: HasImage.php
 * Last modified: 18/05/21, 11:03 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Traits;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

trait HasImage
{
    /**
     * Update the model's image.
     *
     * @param  \Illuminate\Http\UploadedFile  $photo
     * @return void
     */
    public function updateImage(UploadedFile $photo)
    {
        tap($this->image_path, function ($previous) use ($photo) {
            $this->forceFill([
                'image_path' => $photo->storePublicly(
                    'image-uploads', ['disk' => $this->imageDisk()]
                ),
            ])->save();

            if ($previous) {
                Storage::disk($this->imageDisk())->delete($previous);
            }
        });
    }

    /**
     * Delete the user's profile photo.
     *
     * @return void
     */
    public function deleteImage()
    {
        Storage::disk($this->imageDisk())->delete($this->image_path);

        $this->forceFill([
            'image_path' => null,
        ])->save();
    }

    /**
     * Get the URL to the user's profile photo.
     *
     * @return string
     */
    public function getProfilePhotoUrlAttribute()
    {
        return $this->image_path
            ? Storage::disk($this->imageDisk())->url($this->image_path)
            : $this->defaultImageUrl();
    }

    /**
     * Get the default profile photo URL if no profile photo has been uploaded.
     *
     * @return string
     */
    protected function defaultImageUrl()
    {
        return '';
    }

    /**
     * Get the disk that profile photos should be stored on.
     *
     * @return string
     */
    protected function imageDisk()
    {
        return isset($_ENV['VAPOR_ARTIFACT_NAME']) ? 's3' : config('filesystems.default', 'public');
    }
}
