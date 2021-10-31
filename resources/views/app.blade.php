<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'QwikTest') }}</title>
        <meta name="description" content="{{ app(\App\Settings\SiteSettings::class)->seo_description }}">
        <link rel="icon" href="{{ url('storage/'.app(\App\Settings\SiteSettings::class)->favicon_path) }}">

        <!-- Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap">

        <!-- Styles -->
        <link rel="stylesheet" href="{{ asset('vendor/primeicons/primeicons.css') }}">
        <link rel="stylesheet" href="{{ asset('vendor/nprogress/nprogress.css') }}">
        <link rel="stylesheet" href="{{ asset('vendor/katex/katex.min.css') }}">
        <link rel="stylesheet" href="{{ asset('css/app.css') }}">

        <!-- Scripts -->
        @routes
        <script>
            window.CKEditorURL = "{{ asset('vendor/ckeditor/ckeditor.js') }}";
        </script>
        <script src="{{ asset('vendor/katex/katex.min.js') }}"></script>
        <script src="{{ asset('vendor/katex/contrib/auto-render.min.js') }}"></script>
        <script src="{{ asset('js/manifest.js') }}" defer></script>
        <script src="{{ asset('js/vendor.js') }}" defer></script>
        <script src="{{ asset('js/app.js') }}" defer></script>
    </head>
    <body class="font-sans antialiased bg-blue-50">
        @inertia
    </body>
</html>
