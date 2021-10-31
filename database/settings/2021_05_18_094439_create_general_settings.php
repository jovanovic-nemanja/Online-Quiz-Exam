<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateGeneralSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('site.app_name', 'QwikTest');
        $this->migrator->add('site.tag_line', 'Everything You Need For Your Exam Preparation.');
        $this->migrator->add('site.seo_description', 'Qwiktest Pro is an online test examination software and assessment tool that assists educational institutions,corporate companies to create and conduct web and mobile based exams.');
        $this->migrator->add('site.logo_path', 'site/logo.png');
        $this->migrator->add('site.can_register', true);
        $this->migrator->add('site.favicon_path', 'site/favicon.png');
        $this->migrator->add('home_page.hero_title', 'Learn & Upgrade Your Skills on Your Schedule');
        $this->migrator->add('home_page.hero_subtitle', 'Anywhere, anytime. Everything You Need For Your Exam Preparation');
        $this->migrator->add('home_page.hero_cta_text', 'Get Started');
        $this->migrator->add('home_page.hero_image_path', 'site/hero_image_bg.png');
        $this->migrator->add('localization.default_locale', 'en');
        $this->migrator->add('localization.default_timezone', 'UTC');
        $this->migrator->add('email.host', 'smtp.mailtrap.io');
        $this->migrator->add('email.port', 2525);
        $this->migrator->add('email.username', 'username');
        $this->migrator->add('email.password', 'password');
        $this->migrator->add('email.encryption', 'tls');
        $this->migrator->add('email.from_address', 'admin@qwiktest.com');
        $this->migrator->add('email.from_name', 'QwikTest');
    }
}
