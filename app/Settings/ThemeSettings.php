<?php
/**
 * File name: ThemeSettings.php
 * Last modified: 18/05/21, 2:44 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class ThemeSettings extends Settings
{
    public string $primary_color;
    public string $secondary_color;

    public static function group(): string
    {
        return 'theme';
    }
}
