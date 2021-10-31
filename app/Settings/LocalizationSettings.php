<?php
/**
 * File name: LocalizationSettings.php
 * Last modified: 21/06/21, 11:22 AM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class LocalizationSettings extends Settings
{
    public string $default_locale;
    public string $default_timezone;

    public static function group(): string
    {
        return 'localization';
    }
}
