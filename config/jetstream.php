<?php

use Laravel\Jetstream\Features;

return [

    /*
    |--------------------------------------------------------------------------
    | Components Stack
    |--------------------------------------------------------------------------
    |
    | This configuration value informs Components which "stack" you will be
    | using for your application. In general, this value is set for you
    | during installation and will not need to be changed after that.
    |
    */

    'stack' => 'inertia',

    /*
     |--------------------------------------------------------------------------
     | Components Route Middleware
     |--------------------------------------------------------------------------
     |
     | Here you may specify which middleware Components will assign to the routes
     | that it registers with the application. When necessary, you may modify
     | these middleware; however, this default value is usually sufficient.
     |
     */

    'middleware' => ['web'],

    /*
    |--------------------------------------------------------------------------
    | Features
    |--------------------------------------------------------------------------
    |
    | Some of Components's features are optional. You may disable the features
    | by removing them from this array. You're free to only remove some of
    | these features or you can even remove all of these if you need to.
    |
    */

    'features' => [
//         Features::termsAndPrivacyPolicy(),
         Features::profilePhotos(),
//        Features::api(),
//        Features::teams(['invitations' => true]),
//        Features::accountDeletion(),
    ],

];
