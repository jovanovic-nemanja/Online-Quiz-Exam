<?php
/**
 * File name: EmailSettings.php
 * Last modified: 18/05/21, 2:44 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class EmailSettings extends Settings
{
    public string $host;
    public string $port;
    public string $username;
    public string $password;
    public string $encryption;
    public string $from_address;
    public string $from_name;

    public static function group(): string
    {
        return 'email';
    }
}
