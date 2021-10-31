<?php
/**
 * File name: HomePageSettings.php
 * Last modified: 19/05/21, 7:39 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class HomePageSettings extends Settings
{
    public string $hero_title;
    public string $hero_subtitle;
    public string $hero_cta_text;
    public string $hero_image_path;

    public static function group(): string
    {
        return 'home_page';
    }
}
