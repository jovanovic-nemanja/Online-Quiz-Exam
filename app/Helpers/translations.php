<?php
/**
 * File name: translations.php
 * Last modified: 25/01/21, 1:41 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

if (!function_exists('translations')) {
    /**
     * return translation if translation file exists
     *
     * @param $json
     * @return array|mixed
     */
    function translations($json)
    {
        if(!file_exists($json)) {
            return [];
        }
        return json_decode(file_get_contents($json), true);
    }
}
