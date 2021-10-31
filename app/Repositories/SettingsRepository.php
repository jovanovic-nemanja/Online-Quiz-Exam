<?php
/**
 * File name: SettingsRepository.php
 * Last modified: 19/07/21, 5:05 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Repositories;


use App\Settings\HomePageSettings;
use App\Settings\SiteSettings;
use Illuminate\Http\UploadedFile;

class SettingsRepository
{
    /**
     * Upload Site Logo
     *
     * @param UploadedFile $logo
     */
    public function updateSiteLogo(UploadedFile $logo)
    {
        $settings = app(SiteSettings::class);
        tap($settings->logo_path, function ($previous) use ($logo, $settings) {
            $settings->logo_path = $logo->storePubliclyAs(
                'site', 'logo.'.$logo->clientExtension(), ['disk' => 'public']
            );
            $settings->save();
        });
    }

    /**
     * Upload Site Favicon
     *
     * @param UploadedFile $favicon
     */
    public function updateFavicon(UploadedFile $favicon)
    {
        $settings = app(SiteSettings::class);
        tap($settings->favicon_path, function ($previous) use ($favicon, $settings) {
            $settings->favicon_path = $favicon->storePubliclyAs(
                'site', 'favicon.'.$favicon->clientExtension(), ['disk' => 'public']
            );
            $settings->save();
        });
    }

    /**
     * Upload Site Hero Background Image
     *
     * @param UploadedFile $image
     */
    public function updateHeroImage(UploadedFile $image)
    {
        $settings = app(HomePageSettings::class);
        tap($settings->hero_image_path, function ($previous) use ($image, $settings) {
            $settings->hero_image_path = $image->storePubliclyAs(
                'site', 'hero_image_bg.'.$image->clientExtension(),  ['disk' => 'public']
            );
            $settings->save();
        });
    }

}
