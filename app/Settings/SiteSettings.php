<?php
/**
 * File name: SiteSettings.php
 * Last modified: 12/07/21, 9:46 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class SiteSettings extends Settings
{
    public string $app_name;
    public string $tag_line;
    public string $seo_description;
    public string $logo_path;
    public string $favicon_path;
    public bool $can_register;

    public static function group(): string
    {
        return 'site';
    }
}
