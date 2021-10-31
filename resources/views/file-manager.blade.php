<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>File Manager - {{ config('app.name', 'QwikTest') }} Admin</title>

        <!-- Styles -->
        <link rel="stylesheet" href="{{ asset('vendor/font-awesome/all.css') }}">
        <link rel="stylesheet" href="{{ asset('vendor/bootstrap/bootstrap.min.css') }}">
        <link rel="stylesheet" href="{{ asset('vendor/file-manager/css/file-manager.css') }}">
    </head>
    <body class="font-sans antialiased">
        <div class="vh-100">
            <div id="fm"></div>
        </div>
        <!-- Scripts -->
        <script src="{{ asset('vendor/file-manager/js/file-manager.js') }}"></script>
    </body>
</html>
