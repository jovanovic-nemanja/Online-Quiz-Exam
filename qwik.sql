-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 01, 2021 at 06:49 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qwik`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `code`, `slug`, `short_description`, `description`, `image_path`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Live Assessment', 'cat_WgRTGpk2jhw', 'test-category', NULL, NULL, NULL, 1, '2021-09-28 06:41:59', '2021-10-07 19:34:34', NULL),
(2, 'Scheduled Assessment', 'cat_fcP0bSjPYOa', 'scheduled-assessment', NULL, NULL, NULL, 1, '2021-10-07 19:34:40', '2021-10-07 19:34:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comprehension_passages`
--

CREATE TABLE `comprehension_passages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `difficulty_levels`
--

CREATE TABLE `difficulty_levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `difficulty_levels`
--

INSERT INTO `difficulty_levels` (`id`, `name`, `code`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Very Easy', 'VERYEASY', 1, NULL, NULL, NULL),
(2, 'Easy', 'EASY', 1, NULL, NULL, NULL),
(3, 'Medium', 'MEDIUM', 1, NULL, NULL, NULL),
(4, 'High', 'HIGH', 1, NULL, NULL, NULL),
(5, 'Very High', 'VERYHIGH', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `disc`
--

CREATE TABLE `disc` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_code` text NOT NULL,
  `question_id` int(11) NOT NULL,
  `current_question` int(11) NOT NULL,
  `answer` varchar(256) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `disc`
--

INSERT INTO `disc` (`id`, `user_id`, `session_code`, `question_id`, `current_question`, `answer`, `created_at`, `updated_at`) VALUES
(28, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 12, 0, 'not_answered', NULL, NULL),
(29, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 13, 1, 'not_answered', NULL, NULL),
(30, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 14, 2, 'not_answered', NULL, NULL),
(31, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 15, 3, '2', NULL, '2021-10-30 16:33:43'),
(32, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 16, 4, 'not_answered', NULL, NULL),
(33, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 17, 5, 'not_answered', NULL, NULL),
(34, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 18, 6, 'not_answered', NULL, NULL),
(35, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 19, 7, 'not_answered', NULL, NULL),
(36, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 20, 8, 'not_answered', NULL, NULL),
(37, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 21, 9, 'not_answered', NULL, NULL),
(38, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 22, 10, 'not_answered', NULL, NULL),
(39, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 23, 11, 'not_answered', NULL, NULL),
(40, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 24, 12, 'not_answered', NULL, NULL),
(41, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 25, 13, 'not_answered', NULL, NULL),
(42, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 26, 14, 'not_answered', NULL, NULL),
(43, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 27, 15, 'not_answered', NULL, NULL),
(44, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 28, 16, 'not_answered', NULL, NULL),
(45, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 29, 17, 'not_answered', NULL, NULL),
(46, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 30, 18, 'not_answered', NULL, NULL),
(47, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 31, 19, 'not_answered', NULL, NULL),
(48, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 32, 20, 'not_answered', NULL, NULL),
(49, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 33, 21, 'not_answered', NULL, NULL),
(50, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 34, 22, 'not_answered', NULL, NULL),
(51, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 35, 23, 'not_answered', NULL, NULL),
(52, 3, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 36, 24, 'not_answered', NULL, NULL),
(53, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 12, 0, '1', NULL, '2021-10-30 23:37:43'),
(54, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 13, 1, '2', NULL, '2021-10-30 23:37:47'),
(55, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 14, 2, '3', NULL, '2021-10-30 23:37:49'),
(56, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 15, 3, '4', NULL, '2021-10-30 23:37:50'),
(57, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 16, 4, '2', NULL, '2021-10-30 23:37:52'),
(58, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 17, 5, 'not_answered', NULL, NULL),
(59, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 18, 6, 'not_answered', NULL, NULL),
(60, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 19, 7, 'not_answered', NULL, NULL),
(61, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 20, 8, 'not_answered', NULL, NULL),
(62, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 21, 9, '2', NULL, '2021-10-30 23:37:57'),
(63, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 22, 10, '1', NULL, '2021-10-30 23:37:59'),
(64, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 23, 11, '4', NULL, '2021-10-30 23:38:00'),
(65, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 24, 12, 'not_answered', NULL, NULL),
(66, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 25, 13, '4', NULL, '2021-10-30 23:38:03'),
(67, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 26, 14, '1', NULL, '2021-10-30 23:38:05'),
(68, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 27, 15, '1', NULL, '2021-10-30 23:38:06'),
(69, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 28, 16, '2', NULL, '2021-10-30 23:38:08'),
(70, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 29, 17, '3', NULL, '2021-10-30 23:38:11'),
(71, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 30, 18, '4', NULL, '2021-10-30 23:38:14'),
(72, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 31, 19, '2', NULL, '2021-10-30 23:38:16'),
(73, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 32, 20, 'not_answered', NULL, NULL),
(74, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 33, 21, 'not_answered', NULL, NULL),
(75, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 34, 22, '3', NULL, '2021-10-30 23:38:19'),
(76, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 35, 23, '3', NULL, '2021-10-30 23:38:21'),
(77, 3, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 36, 24, '1', NULL, '2021-10-30 23:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2018_11_06_222923_create_transactions_table', 1),
(5, '2018_11_07_192923_create_transfers_table', 1),
(6, '2018_11_07_202152_update_transfers_table', 1),
(7, '2018_11_15_124230_create_wallets_table', 1),
(8, '2018_11_19_164609_update_transactions_table', 1),
(9, '2018_11_20_133759_add_fee_transfers_table', 1),
(10, '2018_11_22_131953_add_status_transfers_table', 1),
(11, '2018_11_22_133438_drop_refund_transfers_table', 1),
(12, '2019_05_13_111553_update_status_transfers_table', 1),
(13, '2019_06_25_103755_add_exchange_status_transfers_table', 1),
(14, '2019_07_29_184926_decimal_places_wallets_table', 1),
(15, '2019_08_19_000000_create_failed_jobs_table', 1),
(16, '2019_10_02_193759_add_discount_transfers_table', 1),
(17, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(18, '2020_10_30_193412_add_meta_wallets_table', 1),
(19, '2021_01_19_122742_create_sessions_table', 1),
(20, '2021_01_26_103623_create_permission_tables', 1),
(21, '2021_01_26_145101_create_user_groups_table', 1),
(22, '2021_02_01_111346_create_categories_table', 1),
(23, '2021_02_01_123941_create_sub_categories_table', 1),
(24, '2021_03_11_165355_create_sections_table', 1),
(25, '2021_03_11_165427_create_skills_table', 1),
(26, '2021_03_11_165437_create_topics_table', 1),
(27, '2021_03_11_170421_create_difficulty_levels_table', 1),
(28, '2021_03_11_170645_create_question_types_table', 1),
(29, '2021_03_11_171040_create_comprehension_passages_table', 1),
(30, '2021_03_11_171818_create_questions_table', 1),
(31, '2021_05_06_170328_create_sub_category_types_table', 1),
(32, '2021_05_13_105405_create_quiz_types_table', 1),
(33, '2021_05_13_133602_create_quizzes_table', 1),
(34, '2021_05_13_162316_create_quiz_questions_table', 1),
(35, '2021_05_13_174530_create_practice_sets_table', 1),
(36, '2021_05_13_174705_create_practice_set_questions_table', 1),
(37, '2021_05_17_165018_create_settings_table', 1),
(38, '2021_05_18_094439_create_general_settings', 1),
(39, '2021_05_20_120637_create_sub_category_sections_table', 1),
(40, '2021_05_24_115523_create_practice_sessions_table', 1),
(41, '2021_05_25_153658_create_practice_session_questions', 1),
(42, '2021_06_06_121703_create_quiz_sessions_table', 1),
(43, '2021_06_06_122342_create_quiz_session_questions_table', 1),
(44, '2021_06_16_130734_create_quiz_schedules_table', 1),
(45, '2021_06_18_120842_create_user_group_users_table', 1),
(46, '2021_06_18_121246_create_user_group_quiz_schedules_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 6),
(2, 'App\\Models\\User', 7),
(2, 'App\\Models\\User', 8),
(2, 'App\\Models\\User', 9),
(2, 'App\\Models\\User', 10),
(2, 'App\\Models\\User', 11),
(2, 'App\\Models\\User', 12),
(3, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 13),
(3, 'App\\Models\\User', 14),
(3, 'App\\Models\\User', 15),
(3, 'App\\Models\\User', 16),
(3, 'App\\Models\\User', 17),
(3, 'App\\Models\\User', 18),
(3, 'App\\Models\\User', 19),
(3, 'App\\Models\\User', 20),
(3, 'App\\Models\\User', 21),
(3, 'App\\Models\\User', 22),
(3, 'App\\Models\\User', 23),
(3, 'App\\Models\\User', 24),
(3, 'App\\Models\\User', 25),
(3, 'App\\Models\\User', 26),
(3, 'App\\Models\\User', 27),
(3, 'App\\Models\\User', 28),
(3, 'App\\Models\\User', 29),
(3, 'App\\Models\\User', 30),
(3, 'App\\Models\\User', 31),
(3, 'App\\Models\\User', 32),
(3, 'App\\Models\\User', 33),
(3, 'App\\Models\\User', 34),
(3, 'App\\Models\\User', 35),
(3, 'App\\Models\\User', 36),
(3, 'App\\Models\\User', 37),
(3, 'App\\Models\\User', 38),
(3, 'App\\Models\\User', 39),
(3, 'App\\Models\\User', 40),
(3, 'App\\Models\\User', 41),
(3, 'App\\Models\\User', 42),
(3, 'App\\Models\\User', 43),
(3, 'App\\Models\\User', 44),
(3, 'App\\Models\\User', 45),
(3, 'App\\Models\\User', 46),
(3, 'App\\Models\\User', 47),
(3, 'App\\Models\\User', 48),
(3, 'App\\Models\\User', 49),
(3, 'App\\Models\\User', 50),
(3, 'App\\Models\\User', 51),
(3, 'App\\Models\\User', 52),
(3, 'App\\Models\\User', 53),
(3, 'App\\Models\\User', 54),
(5, 'App\\Models\\User', 4);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_sessions`
--

CREATE TABLE `practice_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `practice_set_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `total_time_taken` int(11) NOT NULL DEFAULT 0,
  `percentage_completed` decimal(5,2) NOT NULL DEFAULT 0.00,
  `total_points_earned` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'started',
  `completed_at` datetime DEFAULT NULL,
  `results` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_session_questions`
--

CREATE TABLE `practice_session_questions` (
  `practice_session_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `original_question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_answer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correct_answer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unanswered',
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken` int(11) NOT NULL DEFAULT 0,
  `points_earned` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_sets`
--

CREATE TABLE `practice_sets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_questions` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `auto_grading` tinyint(1) NOT NULL DEFAULT 1,
  `correct_marks` int(10) UNSIGNED DEFAULT NULL,
  `allow_rewards` tinyint(1) NOT NULL DEFAULT 1,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_set_questions`
--

CREATE TABLE `practice_set_questions` (
  `practice_set_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_type_id` bigint(20) UNSIGNED NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `correct_answer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_marks` int(11) NOT NULL DEFAULT 1,
  `default_time` int(11) NOT NULL DEFAULT 60,
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `topic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `difficulty_level_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `preferences` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `has_attachment` tinyint(1) NOT NULL DEFAULT 0,
  `attachment_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comprehension_passage_id` bigint(20) UNSIGNED DEFAULT NULL,
  `attachment_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `solution` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `solution_video` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `hint` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avg_time_taken` int(11) NOT NULL DEFAULT 0,
  `total_attempts` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `code`, `question_type_id`, `question`, `options`, `correct_answer`, `default_marks`, `default_time`, `skill_id`, `topic_id`, `difficulty_level_id`, `preferences`, `has_attachment`, `attachment_type`, `comprehension_passage_id`, `attachment_options`, `solution`, `solution_video`, `hint`, `avg_time_taken`, `total_attempts`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(12, 'que_Vyj72qQuhme', 9, '<p>Choose the word that you&nbsp;feel describes you best.</p>', '[{\"option\":\"<p>Restrained: Holds back, does not share<\\/p>\",\"partial_weightage\":0},{\"option\":\"<p>Forceful: Able to persuade<\\/p>\",\"partial_weightage\":0},{\"option\":\"<p>Careful: Deliberate, slow<\\/p>\",\"partial_weightage\":0},{\"option\":\"<p>Expressive: To reveal and show emotion<\\/p>\",\"partial_weightage\":0}]', 'N;', 1, 60, 1, 1, 1, '[]', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:28:50', '2021-10-13 18:28:59', NULL),
(13, 'que_nvgGhXyhKon', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Restrained\\nHolds back, does not share\",\"partial_weightage\":0},{\"option\":\"Forceful\\nAble to persuade\",\"partial_weightage\":0},{\"option\":\"Careful\\nDeliberate, slow\",\"partial_weightage\":0},{\"option\":\"Expressive\\nTo reveal and show emotion\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(14, 'que_EaT3pOwBWsf', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Pioneering\\nWill try new ideas\",\"partial_weightage\":0},{\"option\":\"Correct\\nPrecise\",\"partial_weightage\":0},{\"option\":\"Exciting\\nEager\",\"partial_weightage\":0},{\"option\":\"Satisfied\\nContended\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(15, 'que_oz2AS02Nurn', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Willing\\nGlad to help others\",\"partial_weightage\":0},{\"option\":\"Animated\\nLively and Active\",\"partial_weightage\":0},{\"option\":\"Bold\\nDaring to take risk\",\"partial_weightage\":0},{\"option\":\"Precise\\nDoing things accurately\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(16, 'que_Mr81pN6d3Lo', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Argumentative\\nQuarrels with others\",\"partial_weightage\":0},{\"option\":\"Doubting\\nWants to see proof\\/evidence\",\"partial_weightage\":0},{\"option\":\"Indecisive\\nHard to make a decision\",\"partial_weightage\":0},{\"option\":\"Unpredictable\\nAlways different\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(17, 'que_1KV9PlZ4e6T', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Respectful\\nRegard for others\",\"partial_weightage\":0},{\"option\":\"Outgoing\\nNot shy, talkative, shares thoughts\",\"partial_weightage\":0},{\"option\":\"Patient\\nListens and remains calm\",\"partial_weightage\":0},{\"option\":\"Daring\\nCourage to do something\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(18, 'que_Ouqhd2BfgxP', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Persuasive\\nCan convince others\",\"partial_weightage\":0},{\"option\":\"Self-reliant\\nDoesn\\u2019t depend on others\",\"partial_weightage\":0},{\"option\":\"Logical\\nCorrect reasoning, thinking cause\\/effect\",\"partial_weightage\":0},{\"option\":\"Gentle\\nKind to others\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(19, 'que_5AtUBd3TgmX', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Cautious\\nCareful\",\"partial_weightage\":0},{\"option\":\"Even-tempered\\nNot easily angered\",\"partial_weightage\":0},{\"option\":\"Decisive\\nCertain in making decisions\",\"partial_weightage\":0},{\"option\":\"Life-of-the-party\\nFunny and playful\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(20, 'que_flgR6O3LWgX', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Popular\\nWell known and liked by all\",\"partial_weightage\":0},{\"option\":\"Assertive\\nConfidently forceful\",\"partial_weightage\":0},{\"option\":\"Perfectionist\\nMust do things exact and correct\",\"partial_weightage\":0},{\"option\":\"Generous\\nNot selfish\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(21, 'que_3wCY6XHSZYM', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Colorful\\nLively, cheerful, unique, standing out\",\"partial_weightage\":0},{\"option\":\"Modest\\nReserved, shy, not causing attention to self\",\"partial_weightage\":0},{\"option\":\"Easy-going\\nRelaxed\",\"partial_weightage\":0},{\"option\":\"Unyielding\\nNot flexible, not willing to change\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(22, 'que_vxkMokwA8Fy', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Systematic\\nOrderly\",\"partial_weightage\":0},{\"option\":\"Optimistic\\nLooks on favorable side\",\"partial_weightage\":0},{\"option\":\"Persistent\\nRefuses to give up\",\"partial_weightage\":0},{\"option\":\"Accommodating\\nTo do a favor for, to make room for\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(23, 'que_wCX0R0bR3Nf', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Relentless\\nWanting change\",\"partial_weightage\":0},{\"option\":\"Humble\\nNot too proud\",\"partial_weightage\":0},{\"option\":\"Neighborly\\nInterested in people\",\"partial_weightage\":0},{\"option\":\"Talkative\\nLikes to talk\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(24, 'que_LsrN2jFhuad', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Friendly\\nKind, easy to approach\",\"partial_weightage\":0},{\"option\":\"Observant\\nPerceptive, alert\",\"partial_weightage\":0},{\"option\":\"Playful\\nWanting to have fun\",\"partial_weightage\":0},{\"option\":\"Strong-willed\\nSticks to decisions\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(25, 'que_wbbYFZP3VCG', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Charming\\nInteresting person\",\"partial_weightage\":0},{\"option\":\"Adventurous\\nWill try new ideas\",\"partial_weightage\":0},{\"option\":\"Disciplined\\nWorks well within rules\",\"partial_weightage\":0},{\"option\":\"Deliberate\\nPurposeful\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(26, 'que_N5OfYLNGfze', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Restrained\\nHolding back, not sharing thoughts\",\"partial_weightage\":0},{\"option\":\"Steady\\nConsistent, dependable\",\"partial_weightage\":0},{\"option\":\"Aggressive\\nAct in forceful way\",\"partial_weightage\":0},{\"option\":\"Attractive\\nPleasing to others\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(27, 'que_be8sTURrXd7', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Enthusiastic\\nFull of energy and motivation\",\"partial_weightage\":0},{\"option\":\"Analytical\\nAble to break down whole into steps\",\"partial_weightage\":0},{\"option\":\"Sympathetic\\nUnderstands feeling\",\"partial_weightage\":0},{\"option\":\"Determined\\nDoing it your way\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(28, 'que_dejFVghdMNB', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Commanding\\nControlling, dominating\",\"partial_weightage\":0},{\"option\":\"Impulsive\\nSpontaneous, acting without thinking\",\"partial_weightage\":0},{\"option\":\"Slow-paced\\nMoving at a rate less than usual\",\"partial_weightage\":0},{\"option\":\"Critical\\nJudgmental, finding faults\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(29, 'que_Fla6YMPObvA', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Consistent\\nNot changing, dependable\",\"partial_weightage\":0},{\"option\":\"Force-of-character\\nGets others to do things\",\"partial_weightage\":0},{\"option\":\"Lively\\nActive, cheerful\",\"partial_weightage\":0},{\"option\":\"Laid-back\\nRelaxed, not in a hurry\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(30, 'que_DcF7eArBVhe', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Influential\\nEffecting, changing others\",\"partial_weightage\":0},{\"option\":\"Kind\\nWilling to help\",\"partial_weightage\":0},{\"option\":\"Independent\\nConfident and able to do by self\",\"partial_weightage\":0},{\"option\":\"Orderly\\nSystematic, organized\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(31, 'que_vD7ohGYQoE2', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Idealistic\\nWants the perfect, best model\\/form\",\"partial_weightage\":0},{\"option\":\"Popular\\nWell liked\",\"partial_weightage\":0},{\"option\":\"Pleasant\\nKind and friendly\",\"partial_weightage\":0},{\"option\":\"Out-spoken\\nSpeaks openly and boldly\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(32, 'que_KMDL1VaDyKO', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Impatient\\nRestless, eager to do something\",\"partial_weightage\":0},{\"option\":\"Serious\\nSincere, earnest, not joking\",\"partial_weightage\":0},{\"option\":\"Procrastinator\\nPuts off to the last minute\",\"partial_weightage\":0},{\"option\":\"Emotional\\nEasily shows emotion\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(33, 'que_qfsSo1YCvo4', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Competitive\\nInclined to compete\",\"partial_weightage\":0},{\"option\":\"Spontaneous\\nNot needing to plan\",\"partial_weightage\":0},{\"option\":\"Loyal\\nTrue to friends\",\"partial_weightage\":0},{\"option\":\"Thoughtful\\nConsiderate\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(34, 'que_U1X4KycBgW0', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Self-sacrificing\\nYielding own interest\",\"partial_weightage\":0},{\"option\":\"Considerate\\nThoughtful of others\",\"partial_weightage\":0},{\"option\":\"Convincing\\nGetting agreement\",\"partial_weightage\":0},{\"option\":\"Courageous\\nUnafraid\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(35, 'que_MvXtz5kzFOx', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Dependent\\nTo rely on others\",\"partial_weightage\":0},{\"option\":\"Flighty\\nGiven to sudden change, at a whim\",\"partial_weightage\":0},{\"option\":\"Stoic\\nShowing little emotion\",\"partial_weightage\":0},{\"option\":\"Pushy\\nAggressive and persistent\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(36, 'que_ReEqe7fdlEQ', 9, 'Choose the word that you feel describes you best.', '[{\"option\":\"Tolerant\\nAccepting\",\"partial_weightage\":0},{\"option\":\"Conventional\\nUsual way to do things\",\"partial_weightage\":0},{\"option\":\"Stimulating\\nCauses to think and do\",\"partial_weightage\":0},{\"option\":\"Directing\\nTo order, supervise\",\"partial_weightage\":0}]', 'N;', 1, 15, 1, NULL, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-13 18:36:58', '2021-10-13 18:36:58', NULL),
(37, 'que_MjTsc1fbhdI', 1, '<p>Test Question</p>', '[{\"option\":\"<p>Test1<\\/p>\",\"partial_weightage\":0},{\"option\":\"<p>Test2<\\/p>\",\"partial_weightage\":0},{\"option\":\"<p>Test3<\\/p>\",\"partial_weightage\":0},{\"option\":\"<p>Test4<\\/p>\",\"partial_weightage\":0}]', 'i:1;', 1, 60, 1, NULL, 1, '[]', 0, 'comprehension', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, '2021-10-14 09:16:42', '2021-10-14 09:17:22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `question_types`
--

CREATE TABLE `question_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `question_types`
--

INSERT INTO `question_types` (`id`, `name`, `code`, `type`, `icon_path`, `short_description`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Multiple Choice Single Answer', 'MSA', 'objective', 'msa.png', 'This question type is easy to set up and is the most frequent MCQ question in online exams. Users are allowed to pick just one answer from a list of given options.', 1, NULL, NULL, NULL),
(2, 'Multiple Choice Multiple Answers', 'MMA', 'objective', 'mma.png', 'Multiple Choice Multiple Answers type question allows users to select one or several answers from a list of given options.', 1, NULL, NULL, NULL),
(3, 'True or False', 'TOF', 'objective', 'tof.png', 'A true or false question consists of a statement that requires a true or false response. We can also format the options such as: Yes/No, Correct/Incorrect, and Agree/Disagree.', 1, NULL, NULL, NULL),
(4, 'Short Answer', 'SAQ', 'objective', 'saq.png', 'Short answer questions allow users to provide text or numeric answers. These responses will be validated against the provided possible answers.', 1, NULL, NULL, NULL),
(5, 'Match the Following', 'MTF', 'objective', 'mtf.png', 'A matching question is two adjacent lists of related words, phrases, pictures, or symbols. Each item in one list is paired with at least one item in the other list.', 1, NULL, NULL, NULL),
(6, 'Ordering/Sequence', 'ORD', 'objective', 'ord.png', 'An ordering/sequence question consists of a scrambled list of related words, phrases, pictures, or symbols. The User needs to arrange them in a logical order/sequence.', 1, NULL, NULL, NULL),
(7, 'Fill in the Blanks', 'FIB', 'objective', 'fib.png', 'A Fill in the Blank question consists of a phrase, sentence, or paragraph with a blank space where a student provides the missing word or words.', 1, NULL, NULL, NULL),
(8, 'Long Answer/Paragraph', 'LAQ', 'subjective', 'laq.png', 'In Long answer or paragraph question type is equivalent to essay writing where a student provides a text box to write his response.', 0, NULL, NULL, NULL),
(9, 'Personality', 'PQ', 'objective', 'laq.png', 'The user needs to know that the letter of the option they are choosing If they chose the first one, they need to know it\'s A\r\n', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `quiz_type_id` bigint(20) UNSIGNED NOT NULL,
  `total_questions` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `total_duration` int(10) UNSIGNED DEFAULT NULL,
  `total_marks` double(5,2) DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT 0,
  `price` bigint(20) UNSIGNED DEFAULT NULL,
  `can_redeem` tinyint(1) NOT NULL DEFAULT 0,
  `points_required` int(10) UNSIGNED DEFAULT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `title`, `slug`, `code`, `description`, `sub_category_id`, `quiz_type_id`, `total_questions`, `total_duration`, `total_marks`, `is_paid`, `price`, `can_redeem`, `points_required`, `settings`, `is_private`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3, 'Practice One Quiz', 'practice-one-quiz', 'quiz_KN3eiyPOVkV', '<p>dsfsadfsdf</p>', 1, 7, 2, 13920, 2.00, 0, NULL, 0, NULL, '{\"cutoff\": 60, \"auto_grading\": true, \"auto_duration\": false, \"correct_marks\": null, \"hide_solutions\": false, \"list_questions\": true, \"negative_marks\": null, \"no_of_attempts\": null, \"total_duration\": 232, \"restrict_attempts\": false, \"disable_finish_button\": false, \"negative_marking_type\": \"fixed\", \"enable_negative_marking\": false, \"disable_question_navigation\": false}', 1, 1, '2021-09-30 05:19:14', '2021-10-07 19:31:34', '2021-10-07 19:31:34'),
(4, 'Personality Type Quiz', 'personality-type-quiz', 'quiz_t0jSdF9OGeB', '<p>sdafsadfsadfsadfsadfsa</p>', 1, 7, 4, 240, 4.00, 0, NULL, 0, NULL, '{\"cutoff\": 0, \"auto_grading\": true, \"auto_duration\": true, \"correct_marks\": null, \"hide_solutions\": false, \"list_questions\": true, \"negative_marks\": null, \"no_of_attempts\": null, \"total_duration\": null, \"restrict_attempts\": false, \"disable_finish_button\": false, \"negative_marking_type\": \"fixed\", \"enable_negative_marking\": false, \"disable_question_navigation\": false}', 0, 1, '2021-09-30 20:36:58', '2021-10-07 19:31:36', '2021-10-07 19:31:36'),
(6, 'Testing', 'testing', 'quiz_9ZjG1mvI6eO', NULL, 1, 7, 4, 240, 4.00, 0, NULL, 0, NULL, '{\"cutoff\": 60, \"auto_grading\": true, \"auto_duration\": true, \"correct_marks\": null, \"hide_solutions\": false, \"list_questions\": true, \"negative_marks\": null, \"no_of_attempts\": null, \"total_duration\": null, \"restrict_attempts\": false, \"disable_finish_button\": false, \"negative_marking_type\": \"fixed\", \"enable_negative_marking\": false, \"disable_question_navigation\": false}', 0, 1, '2021-10-01 04:45:33', '2021-10-07 19:31:37', '2021-10-07 19:31:37'),
(8, 'Zoom Quiz', 'zoom-quiz', 'quiz_4PQfxnaov0Z', '<p>sadfsadf</p>', 1, 7, 4, 240, 4.00, 0, NULL, 0, NULL, '{\"cutoff\": 60, \"auto_grading\": true, \"auto_duration\": true, \"correct_marks\": null, \"hide_solutions\": false, \"list_questions\": true, \"negative_marks\": null, \"no_of_attempts\": null, \"total_duration\": null, \"restrict_attempts\": false, \"disable_finish_button\": false, \"negative_marking_type\": \"fixed\", \"enable_negative_marking\": false, \"disable_question_navigation\": false}', 1, 1, '2021-10-02 07:52:15', '2021-10-07 19:31:38', '2021-10-07 19:31:38'),
(9, 'DISC Survey', 'disc-survey', 'quiz_1dG1pvr0JRK', NULL, 1, 7, 25, 420, 25.00, 0, NULL, 0, NULL, '{\"restrict_attempts\":false,\"no_of_attempts\":null,\"disable_question_navigation\":false,\"list_questions\":true,\"auto_duration\":true,\"total_duration\":null,\"auto_grading\":true,\"correct_marks\":null,\"cutoff\":60,\"enable_negative_marking\":false,\"negative_marking_type\":\"fixed\",\"negative_marks\":null,\"disable_finish_button\":false,\"hide_solutions\":true}', 0, 1, '2021-10-13 18:37:40', '2021-10-13 18:39:13', NULL),
(10, 'Test Quiz', 'test-quiz', 'quiz_RAnoxCbLu2V', '<p>Test</p>', 1, 1, 1, 60, 1.00, 0, NULL, 0, NULL, '{\"restrict_attempts\":false,\"no_of_attempts\":null,\"disable_question_navigation\":false,\"list_questions\":true,\"auto_duration\":true,\"total_duration\":null,\"auto_grading\":true,\"correct_marks\":null,\"cutoff\":60,\"enable_negative_marking\":false,\"negative_marking_type\":\"fixed\",\"negative_marks\":null,\"disable_finish_button\":false,\"hide_solutions\":false}', 0, 1, '2021-10-14 09:18:52', '2021-10-14 09:38:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `quiz_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_questions`
--

INSERT INTO `quiz_questions` (`quiz_id`, `question_id`) VALUES
(9, 12),
(9, 13),
(9, 14),
(9, 15),
(9, 16),
(9, 17),
(9, 18),
(9, 19),
(9, 20),
(9, 21),
(9, 22),
(9, 23),
(9, 24),
(9, 25),
(9, 26),
(9, 27),
(9, 28),
(9, 29),
(9, 30),
(9, 31),
(9, 32),
(9, 33),
(9, 34),
(9, 35),
(9, 36),
(10, 37);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_schedules`
--

CREATE TABLE `quiz_schedules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quiz_id` bigint(20) UNSIGNED NOT NULL,
  `schedule_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `start_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `grace_period` int(11) NOT NULL DEFAULT 5,
  `send_email` tinyint(1) NOT NULL DEFAULT 0,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_schedules`
--

INSERT INTO `quiz_schedules` (`id`, `code`, `quiz_id`, `schedule_type`, `start_date`, `start_time`, `end_date`, `end_time`, `grace_period`, `send_email`, `settings`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(14, 'qsd_9sO1VuS5xpd', 9, 'flexible', '2021-10-13', '00:00:00', '2021-10-31', '00:00:00', 5, 0, NULL, 'active', '2021-10-13 18:39:38', '2021-10-13 18:39:38', NULL),
(15, 'qsd_A55rLFVOez3', 9, 'flexible', '2021-10-14', '00:00:00', '2021-10-31', '00:00:00', 5, 0, NULL, 'active', '2021-10-14 09:23:58', '2021-10-14 09:23:58', NULL),
(16, 'qsd_vsJ1CMdtNqd', 9, 'flexible', '2021-10-14', '00:00:00', '2021-10-31', '00:00:00', 5, 0, NULL, 'active', '2021-10-14 09:32:49', '2021-10-14 09:32:49', NULL),
(17, 'qsd_3Y5p9GSUs1t', 10, 'flexible', '2021-10-14', '00:05:00', '2021-10-23', '00:15:00', 5, 0, NULL, 'active', '2021-10-14 09:38:51', '2021-10-14 09:38:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_sessions`
--

CREATE TABLE `quiz_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quiz_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `quiz_schedule_id` bigint(20) UNSIGNED DEFAULT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `total_time_taken` int(11) NOT NULL DEFAULT 0,
  `current_question` int(11) NOT NULL DEFAULT 0,
  `results` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'started',
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_sessions`
--

INSERT INTO `quiz_sessions` (`id`, `code`, `quiz_id`, `user_id`, `quiz_schedule_id`, `starts_at`, `ends_at`, `total_time_taken`, `current_question`, `results`, `status`, `completed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(23, '2b1163fe-fad1-41fa-ab36-d42a32c08454', 9, 3, NULL, '2021-10-30 18:23:26', '2021-10-30 18:30:26', 613, 3, '{\"score\":0,\"marks_earned\":0,\"marks_deducted\":0,\"percentage\":0,\"cutoff\":60,\"pass_or_fail\":\"Failed\",\"speed\":23,\"accuracy\":0,\"total_questions\":25,\"total_duration\":7,\"total_marks\":25,\"answered_questions\":4,\"unanswered_questions\":21,\"correct_answered_questions\":0,\"wrong_answered_questions\":4,\"total_time_taken\":{\"seconds\":613,\"short_readable\":\"0:10:13\",\"detailed_readable\":\"10 Min 13 Sec\"},\"time_taken_for_answered\":{\"seconds\":613,\"short_readable\":\"0:10:13\",\"detailed_readable\":\"10 Min 13 Sec\"},\"time_taken_for_other\":{\"seconds\":0,\"short_readable\":\"0:0:0\",\"detailed_readable\":\"0 Sec\"},\"time_taken_for_correct_answered\":{\"seconds\":0,\"short_readable\":\"0:0:0\",\"detailed_readable\":\"0 Sec\"},\"time_taken_for_wrong_answered\":{\"seconds\":613,\"short_readable\":\"0:10:13\",\"detailed_readable\":\"10 Min 13 Sec\"},\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko\\/20100101 Firefox\\/93.0\",\"ip_address\":\"127.0.0.1\"}', 'completed', '2021-10-30 18:35:03', '2021-10-30 16:23:26', '2021-10-30 16:35:03', NULL),
(24, '9436e1d8-3cfe-40ec-90a1-ff71cd5e8ca9', 9, 3, NULL, '2021-10-31 01:36:30', '2021-10-31 01:43:30', 109, 24, '{\"score\":0,\"marks_earned\":0,\"marks_deducted\":0,\"percentage\":0,\"cutoff\":60,\"pass_or_fail\":\"Failed\",\"speed\":594,\"accuracy\":0,\"total_questions\":25,\"total_duration\":7,\"total_marks\":25,\"answered_questions\":18,\"unanswered_questions\":7,\"correct_answered_questions\":0,\"wrong_answered_questions\":18,\"total_time_taken\":{\"seconds\":109,\"short_readable\":\"0:1:49\",\"detailed_readable\":\"1 Min 49 Sec\"},\"time_taken_for_answered\":{\"seconds\":103,\"short_readable\":\"0:1:43\",\"detailed_readable\":\"1 Min 43 Sec\"},\"time_taken_for_other\":{\"seconds\":6,\"short_readable\":\"0:0:6\",\"detailed_readable\":\"6 Sec\"},\"time_taken_for_correct_answered\":{\"seconds\":0,\"short_readable\":\"0:0:0\",\"detailed_readable\":\"0 Sec\"},\"time_taken_for_wrong_answered\":{\"seconds\":103,\"short_readable\":\"0:1:43\",\"detailed_readable\":\"1 Min 43 Sec\"},\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko\\/20100101 Firefox\\/93.0\",\"ip_address\":\"127.0.0.1\"}', 'completed', '2021-10-31 01:38:26', '2021-10-30 23:36:31', '2021-10-30 23:38:26', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_session_questions`
--

CREATE TABLE `quiz_session_questions` (
  `quiz_session_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `original_question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_answer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correct_answer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unanswered',
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken` int(11) NOT NULL DEFAULT 0,
  `marks_earned` double(5,2) NOT NULL DEFAULT 0.00,
  `marks_deducted` double(5,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_session_questions`
--

INSERT INTO `quiz_session_questions` (`quiz_session_id`, `question_id`, `original_question`, `options`, `user_answer`, `correct_answer`, `status`, `is_correct`, `time_taken`, `marks_earned`, `marks_deducted`) VALUES
(23, 12, '<p>Choose the word that you&nbsp;feel describes you best.</p>', 'a:4:{i:0;s:45:\"<p>Restrained: Holds back, does not share</p>\";i:1;s:33:\"<p>Forceful: Able to persuade</p>\";i:2;s:32:\"<p>Careful: Deliberate, slow</p>\";i:3;s:45:\"<p>Expressive: To reveal and show emotion</p>\";}', 'i:2;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 251, 0.00, 0.00),
(23, 13, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:37:\"Restrained\nHolds back, does not share\";i:1;s:25:\"Forceful\nAble to persuade\";i:2;s:24:\"Careful\nDeliberate, slow\";i:3;s:37:\"Expressive\nTo reveal and show emotion\";}', 'i:2;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 103, 0.00, 0.00),
(23, 14, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:29:\"Pioneering\nWill try new ideas\";i:1;s:15:\"Correct\nPrecise\";i:2;s:14:\"Exciting\nEager\";i:3;s:19:\"Satisfied\nContended\";}', 'i:4;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 167, 0.00, 0.00),
(23, 15, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:27:\"Willing\nGlad to help others\";i:1;s:26:\"Animated\nLively and Active\";i:2;s:24:\"Bold\nDaring to take risk\";i:3;s:31:\"Precise\nDoing things accurately\";}', 'i:2;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 92, 0.00, 0.00),
(23, 16, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:34:\"Argumentative\nQuarrels with others\";i:1;s:36:\"Doubting\nWants to see proof/evidence\";i:2;s:34:\"Indecisive\nHard to make a decision\";i:3;s:30:\"Unpredictable\nAlways different\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 17, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:28:\"Respectful\nRegard for others\";i:1;s:44:\"Outgoing\nNot shy, talkative, shares thoughts\";i:2;s:32:\"Patient\nListens and remains calm\";i:3;s:30:\"Daring\nCourage to do something\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 18, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:30:\"Persuasive\nCan convince others\";i:1;s:39:\"Self-reliant\nDoesn’t depend on others\";i:2;s:48:\"Logical\nCorrect reasoning, thinking cause/effect\";i:3;s:21:\"Gentle\nKind to others\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 19, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:16:\"Cautious\nCareful\";i:1;s:32:\"Even-tempered\nNot easily angered\";i:2;s:36:\"Decisive\nCertain in making decisions\";i:3;s:35:\"Life-of-the-party\nFunny and playful\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 20, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:35:\"Popular\nWell known and liked by all\";i:1;s:30:\"Assertive\nConfidently forceful\";i:2;s:46:\"Perfectionist\nMust do things exact and correct\";i:3;s:20:\"Generous\nNot selfish\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 21, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:47:\"Colorful\nLively, cheerful, unique, standing out\";i:1;s:51:\"Modest\nReserved, shy, not causing attention to self\";i:2;s:18:\"Easy-going\nRelaxed\";i:3;s:46:\"Unyielding\nNot flexible, not willing to change\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 22, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:18:\"Systematic\nOrderly\";i:1;s:34:\"Optimistic\nLooks on favorable side\";i:2;s:29:\"Persistent\nRefuses to give up\";i:3;s:49:\"Accommodating\nTo do a favor for, to make room for\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 23, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:25:\"Relentless\nWanting change\";i:1;s:20:\"Humble\nNot too proud\";i:2;s:31:\"Neighborly\nInterested in people\";i:3;s:23:\"Talkative\nLikes to talk\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 24, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:31:\"Friendly\nKind, easy to approach\";i:1;s:27:\"Observant\nPerceptive, alert\";i:2;s:27:\"Playful\nWanting to have fun\";i:3;s:33:\"Strong-willed\nSticks to decisions\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 25, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:27:\"Charming\nInteresting person\";i:1;s:30:\"Adventurous\nWill try new ideas\";i:2;s:35:\"Disciplined\nWorks well within rules\";i:3;s:21:\"Deliberate\nPurposeful\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 26, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:45:\"Restrained\nHolding back, not sharing thoughts\";i:1;s:29:\"Steady\nConsistent, dependable\";i:2;s:30:\"Aggressive\nAct in forceful way\";i:3;s:29:\"Attractive\nPleasing to others\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 27, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:42:\"Enthusiastic\nFull of energy and motivation\";i:1;s:46:\"Analytical\nAble to break down whole into steps\";i:2;s:31:\"Sympathetic\nUnderstands feeling\";i:3;s:28:\"Determined\nDoing it your way\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 28, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:34:\"Commanding\nControlling, dominating\";i:1;s:46:\"Impulsive\nSpontaneous, acting without thinking\";i:2;s:43:\"Slow-paced\nMoving at a rate less than usual\";i:3;s:35:\"Critical\nJudgmental, finding faults\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 29, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:35:\"Consistent\nNot changing, dependable\";i:1;s:43:\"Force-of-character\nGets others to do things\";i:2;s:23:\"Lively\nActive, cheerful\";i:3;s:33:\"Laid-back\nRelaxed, not in a hurry\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 30, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:38:\"Influential\nEffecting, changing others\";i:1;s:20:\"Kind\nWilling to help\";i:2;s:44:\"Independent\nConfident and able to do by self\";i:3;s:29:\"Orderly\nSystematic, organized\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 31, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:45:\"Idealistic\nWants the perfect, best model/form\";i:1;s:18:\"Popular\nWell liked\";i:2;s:26:\"Pleasant\nKind and friendly\";i:3;s:35:\"Out-spoken\nSpeaks openly and boldly\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 32, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:41:\"Impatient\nRestless, eager to do something\";i:1;s:36:\"Serious\nSincere, earnest, not joking\";i:2;s:42:\"Procrastinator\nPuts off to the last minute\";i:3;s:30:\"Emotional\nEasily shows emotion\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 33, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:31:\"Competitive\nInclined to compete\";i:1;s:31:\"Spontaneous\nNot needing to plan\";i:2;s:21:\"Loyal\nTrue to friends\";i:3;s:22:\"Thoughtful\nConsiderate\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 34, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:38:\"Self-sacrificing\nYielding own interest\";i:1;s:32:\"Considerate\nThoughtful of others\";i:2;s:28:\"Convincing\nGetting agreement\";i:3;s:19:\"Courageous\nUnafraid\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 35, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:27:\"Dependent\nTo rely on others\";i:1;s:41:\"Flighty\nGiven to sudden change, at a whim\";i:2;s:28:\"Stoic\nShowing little emotion\";i:3;s:31:\"Pushy\nAggressive and persistent\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(23, 36, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:18:\"Tolerant\nAccepting\";i:1;s:35:\"Conventional\nUsual way to do things\";i:2;s:34:\"Stimulating\nCauses to think and do\";i:3;s:29:\"Directing\nTo order, supervise\";}', NULL, 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', NULL, 0, 0.00, 0.00),
(24, 12, '<p>Choose the word that you&nbsp;feel describes you best.</p>', 'a:4:{i:0;s:45:\"<p>Restrained: Holds back, does not share</p>\";i:1;s:33:\"<p>Forceful: Able to persuade</p>\";i:2;s:32:\"<p>Careful: Deliberate, slow</p>\";i:3;s:45:\"<p>Expressive: To reveal and show emotion</p>\";}', 'i:1;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 69, 0.00, 0.00),
(24, 13, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:37:\"Restrained\nHolds back, does not share\";i:1;s:25:\"Forceful\nAble to persuade\";i:2;s:24:\"Careful\nDeliberate, slow\";i:3;s:37:\"Expressive\nTo reveal and show emotion\";}', 'i:2;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 4, 0.00, 0.00),
(24, 14, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:29:\"Pioneering\nWill try new ideas\";i:1;s:15:\"Correct\nPrecise\";i:2;s:14:\"Exciting\nEager\";i:3;s:19:\"Satisfied\nContended\";}', 'i:3;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 15, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:27:\"Willing\nGlad to help others\";i:1;s:26:\"Animated\nLively and Active\";i:2;s:24:\"Bold\nDaring to take risk\";i:3;s:31:\"Precise\nDoing things accurately\";}', 'i:4;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 16, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:34:\"Argumentative\nQuarrels with others\";i:1;s:36:\"Doubting\nWants to see proof/evidence\";i:2;s:34:\"Indecisive\nHard to make a decision\";i:3;s:30:\"Unpredictable\nAlways different\";}', 'i:2;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 1, 0.00, 0.00),
(24, 17, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:28:\"Respectful\nRegard for others\";i:1;s:44:\"Outgoing\nNot shy, talkative, shares thoughts\";i:2;s:32:\"Patient\nListens and remains calm\";i:3;s:30:\"Daring\nCourage to do something\";}', 'N;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', 0, 2, 0.00, 0.00),
(24, 18, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:30:\"Persuasive\nCan convince others\";i:1;s:39:\"Self-reliant\nDoesn’t depend on others\";i:2;s:48:\"Logical\nCorrect reasoning, thinking cause/effect\";i:3;s:21:\"Gentle\nKind to others\";}', 'N;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', 0, 1, 0.00, 0.00),
(24, 19, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:16:\"Cautious\nCareful\";i:1;s:32:\"Even-tempered\nNot easily angered\";i:2;s:36:\"Decisive\nCertain in making decisions\";i:3;s:35:\"Life-of-the-party\nFunny and playful\";}', 'N;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', 0, 0, 0.00, 0.00),
(24, 20, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:35:\"Popular\nWell known and liked by all\";i:1;s:30:\"Assertive\nConfidently forceful\";i:2;s:46:\"Perfectionist\nMust do things exact and correct\";i:3;s:20:\"Generous\nNot selfish\";}', 'N;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', 0, 1, 0.00, 0.00),
(24, 21, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:47:\"Colorful\nLively, cheerful, unique, standing out\";i:1;s:51:\"Modest\nReserved, shy, not causing attention to self\";i:2;s:18:\"Easy-going\nRelaxed\";i:3;s:46:\"Unyielding\nNot flexible, not willing to change\";}', 'i:2;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 22, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:18:\"Systematic\nOrderly\";i:1;s:34:\"Optimistic\nLooks on favorable side\";i:2;s:29:\"Persistent\nRefuses to give up\";i:3;s:49:\"Accommodating\nTo do a favor for, to make room for\";}', 'i:1;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 1, 0.00, 0.00),
(24, 23, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:25:\"Relentless\nWanting change\";i:1;s:20:\"Humble\nNot too proud\";i:2;s:31:\"Neighborly\nInterested in people\";i:3;s:23:\"Talkative\nLikes to talk\";}', 'i:4;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 24, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:31:\"Friendly\nKind, easy to approach\";i:1;s:27:\"Observant\nPerceptive, alert\";i:2;s:27:\"Playful\nWanting to have fun\";i:3;s:33:\"Strong-willed\nSticks to decisions\";}', 'N;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', 0, 0, 0.00, 0.00),
(24, 25, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:27:\"Charming\nInteresting person\";i:1;s:30:\"Adventurous\nWill try new ideas\";i:2;s:35:\"Disciplined\nWorks well within rules\";i:3;s:21:\"Deliberate\nPurposeful\";}', 'i:4;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 26, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:45:\"Restrained\nHolding back, not sharing thoughts\";i:1;s:29:\"Steady\nConsistent, dependable\";i:2;s:30:\"Aggressive\nAct in forceful way\";i:3;s:29:\"Attractive\nPleasing to others\";}', 'i:1;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 27, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:42:\"Enthusiastic\nFull of energy and motivation\";i:1;s:46:\"Analytical\nAble to break down whole into steps\";i:2;s:31:\"Sympathetic\nUnderstands feeling\";i:3;s:28:\"Determined\nDoing it your way\";}', 'i:1;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 28, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:34:\"Commanding\nControlling, dominating\";i:1;s:46:\"Impulsive\nSpontaneous, acting without thinking\";i:2;s:43:\"Slow-paced\nMoving at a rate less than usual\";i:3;s:35:\"Critical\nJudgmental, finding faults\";}', 'i:2;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 29, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:35:\"Consistent\nNot changing, dependable\";i:1;s:43:\"Force-of-character\nGets others to do things\";i:2;s:23:\"Lively\nActive, cheerful\";i:3;s:33:\"Laid-back\nRelaxed, not in a hurry\";}', 'i:3;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 3, 0.00, 0.00),
(24, 30, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:38:\"Influential\nEffecting, changing others\";i:1;s:20:\"Kind\nWilling to help\";i:2;s:44:\"Independent\nConfident and able to do by self\";i:3;s:29:\"Orderly\nSystematic, organized\";}', 'i:4;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 31, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:45:\"Idealistic\nWants the perfect, best model/form\";i:1;s:18:\"Popular\nWell liked\";i:2;s:26:\"Pleasant\nKind and friendly\";i:3;s:35:\"Out-spoken\nSpeaks openly and boldly\";}', 'i:2;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 32, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:41:\"Impatient\nRestless, eager to do something\";i:1;s:36:\"Serious\nSincere, earnest, not joking\";i:2;s:42:\"Procrastinator\nPuts off to the last minute\";i:3;s:30:\"Emotional\nEasily shows emotion\";}', 'N;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', 0, 1, 0.00, 0.00),
(24, 33, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:31:\"Competitive\nInclined to compete\";i:1;s:31:\"Spontaneous\nNot needing to plan\";i:2;s:21:\"Loyal\nTrue to friends\";i:3;s:22:\"Thoughtful\nConsiderate\";}', 'N;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'not_answered', 0, 1, 0.00, 0.00),
(24, 34, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:38:\"Self-sacrificing\nYielding own interest\";i:1;s:32:\"Considerate\nThoughtful of others\";i:2;s:28:\"Convincing\nGetting agreement\";i:3;s:19:\"Courageous\nUnafraid\";}', 'i:3;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 1, 0.00, 0.00),
(24, 35, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:27:\"Dependent\nTo rely on others\";i:1;s:41:\"Flighty\nGiven to sudden change, at a whim\";i:2;s:28:\"Stoic\nShowing little emotion\";i:3;s:31:\"Pushy\nAggressive and persistent\";}', 'i:3;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00),
(24, 36, 'Choose the word that you feel describes you best.', 'a:4:{i:0;s:18:\"Tolerant\nAccepting\";i:1;s:35:\"Conventional\nUsual way to do things\";i:2;s:34:\"Stimulating\nCauses to think and do\";i:3;s:29:\"Directing\nTo order, supervise\";}', 'i:1;', 'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}', 'answered', 0, 2, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_types`
--

CREATE TABLE `quiz_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_types`
--

INSERT INTO `quiz_types` (`id`, `name`, `code`, `slug`, `description`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Quiz', 'qtp_lLvoMjFoKRf', 'quiz', NULL, 1, NULL, NULL, NULL),
(2, 'Contest', 'qtp_uqQvsmXRube', 'contest', NULL, 1, NULL, NULL, NULL),
(3, 'Daily Challenge', 'qtp_xJnjmbmgV5E', 'daily-challenge', NULL, 1, NULL, NULL, NULL),
(4, 'Daily Task', 'qtp_dJ7t7b2onxc', 'daily-task', NULL, 1, NULL, NULL, NULL),
(5, 'Hackathon', 'qtp_pALr8tBpML7', 'hackathon', NULL, 1, NULL, NULL, NULL),
(6, 'Assignment', 'qtp_ok3cIEqIHg4', 'assignment', NULL, 1, NULL, NULL, NULL),
(7, 'Personality', 'qtp_ok3cIEqIHg362', 'personality', NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2021-09-28 06:31:02', '2021-09-28 06:31:02'),
(2, 'instructor', 'web', '2021-09-28 06:31:02', '2021-09-28 06:31:02'),
(3, 'student', 'web', '2021-09-28 06:31:02', '2021-09-28 06:31:02'),
(4, 'parent', 'web', '2021-09-28 06:31:02', '2021-09-28 06:31:02'),
(5, 'guest', 'web', '2021-09-28 06:31:02', '2021-09-28 06:31:02'),
(6, 'employee', 'web', '2021-09-28 06:31:02', '2021-09-28 06:31:02'),
(7, 'institute', 'web', '2021-09-28 06:31:02', '2021-09-28 06:31:02'),
(8, 'candidate', 'web', '2021-09-28 06:31:02', '2021-09-28 06:31:02');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `name`, `code`, `slug`, `short_description`, `icon_path`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Siniora Team', 'sec_f5nlOS8sSgX', 'test-section', NULL, NULL, 1, '2021-09-28 06:42:32', '2021-10-07 19:33:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0XW1kcfi56hzMCUukbDL5Ly6WoId7I7rnjrm3mlg', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMkw3aVhUN1lwR0xvaFNzTGlHYXFHcnZ3NW9MS0NXMDhQeGtTY0dJSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly93d3cuc2luaW9yYS55b3R0YS5zb2x1dGlvbnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1633689758),
('2hOc3t8KsdcgKpdozg0MIp4t4AKGcUw2JGLdpLql', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU29WTXBSVDhLSGFtaktORkQ0SVFvYVBFeWhielEyTVJBdjVpTzZUTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633546543),
('4FiT3rf2OuMKBNbiZih3EQio3tXN7bsCtMNhzZwW', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNTdQZFJ3cEcwRGZXbUhsNEd2RDQxTzA2TTFTUEVXTk4zdVIwdGZWSSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633725173),
('4uP5idDrK6BV5pMcwk9cIBogNMdbnerdHvV2X4pw', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaElneUd1NUhvejJVNGlKTjQyajNsdllHc1NQWUtSeDJmNnNQUVZoQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633630577),
('51hnhrSFs3H94PU8u0oOrYqz4uWs6k1EBy0YyHLW', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiazNWY2VZeDluNEt2Z2tKaGg2dmNYUUcwVFkwYVpvbVJUWFBxTG43MiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633631509),
('6AoRUxkq5PmUowSYB190veLejr8FyhARJuq02cPW', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidEN5Z1g0dEM4ZjIyNThZMDZMM2h4OVI4dEJQSHBpbUd2aTVEWG93UCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633633075),
('6CZ1UOZNZ6edGTCfEDPsq2xrc7LbKI0ZeBnsS947', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTFFPSmVMTDR5OElrZW5IcDNucHBFUEJQdVpjanFBS1dYbVNRZzdYciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633863133),
('6F1WgLWX8hGf4V8wKGfPXySkaE6FWevqkvLxADiA', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNTlKU21CRGp3OWo2a0s4SjF6aDY3aUF1UDdaY3dFTWpTUW16TzJJQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucy9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1634149448),
('6tH4BObIPppDkbx0XuWLDCXj3l0WVwjFxfcJ4Gyk', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVWt2QU5oUTg2T2l0NDhLU1ZMbWJ0N2F4alo5c2xtMm90d0tRcVBiYyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633633486),
('7e7DQd8JtezRFEJTxPWAg5IYFRCVYxrT4oARz9fA', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaDVJd0ZzMGxDakppQUp1RWRHTERsM2QxVkxRV2VWN3hUM3lrSnhzYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634633),
('7kgDqS3G59k3FobgkFcdNQpx4CxLP1DB8IBOPL4p', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiRXY1TWhjaE1BMzVtc2NUTERZa3RlVDF2S1hqMFBCUjlHbXJndmRoTyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633658473),
('8fvizUJqA9KyyYDzEdkabNnfIbROeOEPDMbixTLO', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibEl4UWduclhvaGNqYzBWa3FSVUJKTUEwdGpJV0JUN01DUUR5M1JOaSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633725199),
('8qoEkjQ3AlmGkBM4wtgNzDriqD4LwxK2sblWiaDc', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYlg0b05OdDZ5Q0llbnVnNzc1RTVCUzF4MTFmRXJURGJJY3JiaFpQMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633547395),
('9fz6Y684zlFjGlmEYnPcBQmYmHGUwvLZCKI1SxOf', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiS0FQQ1dtbFF2WHp1VXZMN3k0VW9OaHVPaVBEZ21MbFBGTXg3RVMwUCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633610856),
('9QkefbpOsAbHLY8vGZ9wm8b0Y0unDM7RBX9qHLba', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMzFZZENBd1BEVnZnMWNnT3ZzRlVia250QjVZeVo5Y2YzR3JqaW54WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633545615),
('AblDzkgU4PeNeQSr9ztyg6d2TsCQrx37zNJSBiIL', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiR2JjbjNFY3g4OEpQR3hDOWxNOEtvbTVveXhoY2xBMmZBcFFZdEpITyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633658996),
('ANTDKLEaxd05Pna9250oJ6lQreptLnSY7vpYGFAz', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTFlckhXT29yQkpJSk1kdzRNcEVvT0hBMG1FWENBYXRSU2JSbVQ4USI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucy9mb28iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1633546179),
('aQbkaCe6j9eS9l41nT0numGcuyzv9bXzcjqXiins', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNUZRVW5LR2RDZUJoekdaQmUxczFvT2t5V25xYUQ2ZEthSG1hc0FVcCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633631348),
('b2qJAQ9LScxGje7WbH4BGUErQhqX7FrLpMVZbbHL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko/20100101 Firefox/93.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUkI5bllrZWRVWnZIcUhJVjhmVGZJd1NZNjV0NE5lbUR2WG1HTG1KUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1635610222),
('bAvBQxGFjC5qIcUR8OgGLzmeLKFLVfjnwWk0SYIG', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSnhhR3hRNWNsQ3lnUzdERDdMNGpOdlpIQ3RQSXpEcHR5ZGw2QnpGTiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1NzoiaHR0cDovL3NpbmlvcmEueW90dGEuc29sdXRpb25zL2FkbWluL21haW50ZW5hbmNlLXNldHRpbmdzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633659643),
('BGFMlPeGbMmwNkJJxlhXSQs0TZ8fhBmD7UjFiq0M', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVWRIUElleThoNlRySmpRMk52TkNFc3JjbmhGaXhTMHE3Y3M5UU9zaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucy9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1634149462),
('BgM6JWJggF3t8IFiaNEpNQix0h0PIwsnTg9dElmK', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRXNGTURQd1lmcFFyRnNEZ1JnbXJ5ZlBPVlJRcDM3N3lMbVhjWnY1OSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610847),
('Bm1xg008zG2yQiIWD95jKOqMvEd20w3cuVr2X73t', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV3ZEN3c1MUZrclpmSGtGOTVsWW1jY1JmMGxnc0Y5N0JtMkFKMWpLSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610474),
('BM2v3v2l2QvD93REi20OssyMvk6Od58nDTuwkJNp', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoib2F5UXlKdkt2RWZzNElzU0xXZDNIV0xIZzc0VldqOGlCVEJkYmlxdSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEwJHA5Z2IwS3F1VllFQjQ0MHhINWFOa2V3c1Rja1BvQ2F1ZFRncVcyRnlSYUZ3V1gyRDQ0WVN5IjtzOjIxOiJwYXNzd29yZF9oYXNoX3NhbmN0dW0iO3M6NjA6IiQyeSQxMCRwOWdiMEtxdVZZRUI0NDB4SDVhTmtld3NUY2tQb0NhdWRUZ3FXMkZ5UmFGd1dYMkQ0NFlTeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi9xdWl6L2Rpc2Mtc3VydmV5L3Jlc3VsdHMvOTQzNmUxZDgtM2NmZS00MGVjLTkwYTEtZmY3MWNkNWU4Y2E5Ijt9fQ==', 1635645149),
('bMLNHdbocKNXjKIA1RrIlEZIl3XUruEMk6tdn1QE', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiajdPMjFWOTJhdEVWQ2xaUnYzNkh0VXl0STNUcEg4eUQxTmJHVFNVZCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633632847),
('bNtSS68WgA0FGPI5hzmW7ROezdeFdxxpPZ7efRL9', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibllMV0VhUmxDall3THVOREhlM1FqYktWdHJYaWNkWjY3ekNuZ2NNQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631577),
('BvaDVszHu2SH4OyC77Uzha6r5LOYM6QwRVOGDHQE', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQWtNaGcyb2pFeUVUMWtKelhQU2ZTN2d5dnZRcUNkMEZRVjZRR2psVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631285),
('BZmcEGfOcvPBveYF2EOWz7vhafM7VVHMb5JM2UDa', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic3NHYzA5RHpWRjN4Mmx0SlBOT1MwNzJRMVl6SWlOc3NHYzMwbXA0ZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633662686),
('CeV5gaJufvXDyoWIxY8RtdnOHKzo4HW1kJP4OOU7', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUUZjN0hDTFY2dWZGSFF6NWYxOWlZQldKa1A2RGpBajhVdmJTWlh3ViI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633631430),
('cM6NisJMp5hIuepaiVQ4LTDFi0vsLsoycU9LLFet', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnNHNU5uVGxEU3h1NzI2Tkp5SUNWaW56Wndrb1NGeHJCcTBIZWVkVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631291),
('cZA6JafwtJuiJ9LfOeUaKPg1E9iQTsdRlDpDPS0q', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidzlocWs0MU1Sbk03U0Vmc3pZQzVpdXJ3NFRhVjM5RWN5bTlJVFhPTSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633659810),
('D4QiBfntE1n6zS72lYXmXGM8XPWJOJ92dzG7vUwO', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoicm5NV3FBd0lpMHNmcVhPZVRjSXBReXBGNklrN2VXdXNGUHFSb3ZzRyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633547391),
('DBNbQbtdmqgG8XD8F9keVJZEqnsv1BzeTd4BDBj4', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSHF6anhHZ25WclhJbzBsRU13Q2JmV0dPNWxRYjA0eGptTHBBaU5WQiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633633461),
('dFBgPbpmGV8mbEvScR2JnIiQKBMUVU1ZZ7Q5qZWZ', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRUU2cEZXNWdlTFk2UGl5NWZjQVdib0FSZWpkckZEelFJUGFXdm9kUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658275),
('DLARUcwlJycYJTMi7fIDOMl10W3tZzDFreTtmj7X', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZUpjOFZVUWxGdkE4UWgxU0l5eEZscngyb0hBVFB1N3JCamV3dWJkNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633689175),
('dowkv4bSCHuQfEjbVAX902SSTwFD3NCdbFVFinu3', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOGFBSFlYVmhKT0tQeldva3VXMHF2SWZmNmxNRTVVNzlSNkJiQ0loOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631166),
('DPcZbnHas8Xv8McnMHE8TiYrEMK3qjZtWJLOJ6M7', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicTNKQm5paGpkNkRmbzlpUVdxTnFzOHBMcUt5bDZjV0RzeEwwNkVMZiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2NjoiaHR0cHM6Ly95b3R0YS5zb2x1dGlvbnMvZGVtby9zaW5pb3JhL3B1YmxpYy9hZG1pbi9nZW5lcmFsLXNldHRpbmdzIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHBzOi8veW90dGEuc29sdXRpb25zL2RlbW8vc2luaW9yYS9wdWJsaWMvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1633374486),
('DrEzeHOkcZRmumSa8aDjST90QhXXszXEiiQak0Fx', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRXZ2SFZya2FKTWVRbnlHdWR1YktOdlNCR3hURG1NaWZwdGR1a1NBNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633725201),
('e2EQv7sBPbsC4RD2aUYBGLJaEn13RQ0w8MPeSFai', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUHp1UUNOc2tma1EzQWtNdkhtWEtxRW44MUo0bzhRcUJ3VHlJT2FMRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610469),
('E2T9GYPWgJ6t15nV7JYYvNYzFyCfXuDTFPZAIpMl', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVzN6cVdIelpHaDhBZnFVbVNzQnh4dFZjVlZOZE1yNXdiM1AxUUlqeSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633697347),
('E9mC4Po568lzLvq17Cm5aER8Koca99FJWgwU5o2m', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZWlvdDgwNUViRGIyanM1a1pOcVpMZnA5S0xmeHdjd1Y1aFgyb1pwSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658003),
('ecj8hkOyAEqjoS05f8TNYBSTdZCRHA0FflLlXSE6', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZXU0MmFGWmNkd3ZlV0xyZE5HUHAxVWJvZzN2WGV2dndLbXhIejk1dCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633610993),
('eiJRVubJSbTK6p3nsT3aH6RWO3JIkCE3XgP5i0QS', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYm93NUhWdmZ5WUNCcHp2dFRmU0QwdUJoMFlkdER3REJyOVE2UGp3ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658101),
('EKllu4eh1mebECB5xsXos94aefZYiRRvhxXpWN3O', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRnljUm5UUnpXRGN3ZzNxYXRWUmlsU29mUk1KSm81REVoUUpxZWhCayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634662),
('EOLpQm8EQM3jHxU56BTjwpdv8GgEaAmPWBnm2lLy', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiRkJ0TVllVnFuTWU0RldvN3FKZE1VWU1OQmJ6NUtZNHRPOUVFbnZQQiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633659653),
('EovypMjCaojqPPISjjyTR1Pa0L6KWst4YtON8LNW', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoib0FGaE5HNndKTWxibllRbm9hT3FTQ2NVb2lpWnZZNFJEVkJKV1NicSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633631283),
('EPf4RpWsGex27QddiX8dfOVVuyoQ8OH9qNKnNTzL', NULL, '86.182.157.93', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZW9XeEVsWXo2WU1TWDh0RnpqTVZobkpBWVpBNDZWZHZQaW41YzI2ZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1634722223),
('ErwTI9vUBsOlHYMQe8eo118PDxhZTAKKwHw0TnAu', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY2NiQ1BYVHRteElscU1qeTVYMUtPN3RiUEY3Y1Vaa3JxUVltVnFtMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610910),
('f29lQ0gAgt1s9eYg6XMItqBmms40izKSQyAAN3e9', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUXlONHpxUmZOV1dRMUp1aHZIUEtBS01oSE85b3E4UG4yd0I5T2Y3UCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658307),
('FHEkDoHG98bd4pZU0bzxVyS9YvpfKwsuDdE4qolt', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidnVjUnNUQVdoS0Nya3BUaE5YaEVHTHcwbVNWcTFNM05wc2NXZldxNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633688319),
('FkWc5n1ofl5BaXKk2lCyifB4YfEDyQDPEAJrHodN', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiWXU2bTBYWjB4VUZQdThIZGdLV0JLaDVudGxXdmZjSXBYQmhSOEFMViI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634284944),
('flMjOPKnnDagDCUytDcyUFt3UdRiXEuZ8qYw5HEb', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZW1uTUQ5Vm4wMUFvZ29jd3VBMmJkV3hybmtXSlNIU3l3UDU4b2NiSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610723),
('fmeXw3BhceEKvqdGClLcDaXoFRTlwpmpOlrvCoCt', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaGFWanBGbm1qMGVKVHdUSTlnSDJzd1Awb0JBelFpVlVCZkNQaktvVSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0NjoiaHR0cDovL3NpbmlvcmEueW90dGEuc29sdXRpb25zL2FkbWluL2Rhc2hib2FyZCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM2OiJodHRwOi8vc2luaW9yYS55b3R0YS5zb2x1dGlvbnMvbG9naW4iO319', 1633635384),
('fNSkLeUdh53nQj8WarP03fpufXtXVDCldp2CUq2r', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWW5jMGw4Q1JYaWtyMktQUzVlUUIzWGZGbVRTR2pIekYwVzl0NUZYdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658203),
('FrFrDS2IphrCONpul7XmY81capllzijKGibh6bjC', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnNRZlE0VzRXVFY2TEFwM2dYRnhZVGpyZlE3MHlWaHZVRHFyZThQdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658245),
('fVombKyoUgVk6piDDuyBnO0d2ze9ZcRjRC5Y2m96', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiblBvSjk1bTRaNGlCZEFORE1zU2ZtTXg4NzNNRThWdW9vWUhBd1NRSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633657889),
('fW0M09kCAtJyp1KPVES8ObfSJmt8qu2NuYdaw0lc', NULL, '103.131.187.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko/20100101 Firefox/93.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicjA2M1R3aVlXdTJhMnpqT21rbkNmd0dsM3BoRlFNcVhtbkZPSVlpMCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0NDoiaHR0cDovL3NpbmlvcmEueW90dGEuc29sdXRpb25zL2FkbWluL3F1aXp6ZXMiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNjoiaHR0cDovL3NpbmlvcmEueW90dGEuc29sdXRpb25zL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634198629),
('fZBA3sjWEdkmdq7nQvzklUCW8QXq9dm1SnyHhOAY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko/20100101 Firefox/93.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTlBKdmJ1V3p2OEZCQ0VuNUw2UE1vSUpqRnN2ZTMxSUpwMEc0VDJjOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1635607855),
('g3H28ZipkNK3DxTPAMhNvmDyQwl0go23b9kgddxn', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidzJURzExNHhMclBzVUplbDFWUlpMR2FKckhlWkd0bmFwbEd0RFBQciI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633660174),
('Gvks9a3yuvzYxrmBwWB35dklxJJgFPpEBw16LAhO', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQk1qemFBS0pyNVRweEhvNWw5OEZ5R09jaldneVhZeXN4c09jMXZDVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucy9mb28iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1633546270),
('GWbN9zNiCTLwWYgYRHBlpohn0UXORMcRRtZXD6kx', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibXZQczJzMjRFSE94Q3dPNVdxQ1M4VUJFdXdjdFU1TGlITXg1ZmhhdSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633610905),
('haO7l5aclrzppFzgvyWoA1SXhcrfuxElHrQZWbhO', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0NqVXkyYnUwbEw4MHdvVnRHU3h1ZWpIdGJGbXVVejE2aWw0Q3l1ViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucy9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633659649),
('hhm4eH3sZDdFKxQ11tqBp430umEfJqMweytSy7CF', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSnZTcjNFQ1k0enhlSHE2OUJvODN5YlY2TVdPd2tmdWtOTjduREVlcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634334),
('hNfXhXggZ0lKPjyNYAriRpXmdBjv6p5ARJY6sROz', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVHRIazBPNmtRd2tteWZqcjd0Vk5NeWdiMmo2b0pQaWhzRUZzZ1dkdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633657942),
('hRbKnxJ1TDTmnRFI898GocIHnUfpWwiOJl11GB4k', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoia1k0Q2ZDWFdndm9JVWJiUzh6eTd5UUszaDNnMVV1Y1A3ZVpieExNOCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633632966),
('HVtCRgdfvVzlWBmO2UUu0TG5sqyw2Kpbyh6LPjIs', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVmdtcmozVG1neWlFb09GSnIxMkRvck9lYXYwMXVOTHk1MWFzZ2w4YyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633657998),
('Ihlv9AZIfGPR1emUOeyC019WSeYsEfHtTwKfHDvN', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVUQydmVuVE9QbTl1bFBzRUxFRzVOWmJzMXA0Q2pYMkQzcm1Qa1hKbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610845),
('Iisd6iBmf3czKiimGcTnaBTy5qAs8VsPPJ7ZTiqC', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWUNqU0V6eUhVUVFzS21TY3RHVFY3NHlBSmJzbEh6MUptYkNETFhOMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610977),
('Ioj8UltKARUPRv9iZyey5SJNpqT7Akx8Uj2RhAgN', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWR6TVRWR05FdVJzQkMweE9WYUN6eHlLWWRFdmlWa3BtUGg4UmZvViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610797),
('J2I0eWg72IEPDsCpYjQRSr6IC0YhaUuPE2zGtC2t', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN3hPWm9PRWpDS09VMDgxS3F2U2gwbFdNOXNoN2xCUGpNelp3OTU5aCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658383),
('JhTL0U1rxNOC1BrcS0tBoPZ8QuPYbWdH4GkWhben', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS28yc2ZsZ2dld0pubXQ0Ym5hSDl0MDgzRTNUQ2QxeWdTeTBET2ZrZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634632),
('jK8uVswuW5I9ZTVP0HWInVC4spL5rdWMf2Sn4Rms', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiek0zbE5qQnVRMHgyOHpSbWhOdWpGc2ZmblI5bHMzcU1WbVQ1WnBUVyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633659643),
('jPMdLblTPJbRuUGnsdT9gDqsbXEY9QCViRcKnges', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieWlJcTU5Y1poeHFDWEs2SFM0aWROTTBxZGRFRURnR0phWEViclc2YyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633688847),
('jPoENEjKVn92vgH6GfrpsbszwqxmomeTGu4FZtqg', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidXdGRW5yQTdPallLU05mMlY0dndQWDE5cGNxSVcwMXBFdUZ6V013ZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634652),
('jSkL3SHoCluxmnW0TEpd7fsa69USI1U558Bsly9w', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiMFlWbHl4TUhDNVl5RzNyTEE0NEJpbWZhaDlwcjZ4Mzc2VElmWXFaRSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634457744),
('jtulMpBvvLcOeqTQ5Lis8T7D3EUWjS3tNHxILt6k', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiRE1hdUc0S2pGb05MT0FiM2tkaFJOalJHZjBoT2lyZEdHT0s3SVF6ciI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634149473),
('ju4mVFo7JJY6QKvHkzJ9pTGPtMNTBRxpL3OdE1SQ', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibzQ3NjhaZWhwTWRMbFZ0VG9hY2ZaR296Vm9OUDRrb2dwdVRoSnh2byI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633631581),
('JZsku4bsR79ujFsmQPcXZccRfPv1MWW2ZLfhcyYJ', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoicUxnN0JOOEpVQVhZeHJpSXJjOGtFNTBpY01zZWxVWVNwaVdvVTJReiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633633469),
('k6RhZbcSZD2tsIUEBXCMoC4QEhch3bopM6MhcyvK', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOTlMVm8zZ0NoUzYwaEtTOWJVaWFWVFFBWHVPSFVXdHNoSG9LTE1sSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633689176),
('KIzFi0uC9JzYkbYx0nO497iqIVnDKsYu0CboC9Ca', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRkhUTmVMQkxyRW9FSE1SNzlPbTM1emZOUWY0WmRybG54YUpJbDZQWSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly93d3cuc2luaW9yYS55b3R0YS5zb2x1dGlvbnMiO319', 1633689746),
('kkNldwwNig6bRsdGyApD4PO2qCdGv4WiHNKPan9j', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiRldqUG5GSXMyUFBlelZGbnJtZ1RXYUwwTG9pTGt5d3JPaXhMMTZiUCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633863140),
('klFEQ3H75kX5CbLGL8waCDGscNn7tF3mVuWu43Yl', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemxZc2VOMFdkZmMwODE1S2ROZFVCUEp1bVdYUkJsYXNlVXFaaU5SbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucy9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633633481),
('KyoMuyq6OYBhFuEAJbdCrcwfZ8Y3XYZ0DqfC4ENW', NULL, '86.182.157.93', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNG9TcVdEYWFkaXFEa0thbkxOdlZhTnFCR3k0NTFqM0dSbHhrTU9MaiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634312132),
('LckJZXwvcLuL3tKgiJcAALs0PlXTqbKBBpbjmLnS', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTFhWDA3cEJQNlVFMktISDBiS0hRalI0akhKV0g2UUlvSEpwcW5XaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633545766),
('LE0AwnFUXFhCXypoOST0k5J1y1mNm8FsmGt5lRtq', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibkR5bE1sdWFUWGhjcGtEaDRod1lKMUVNc3pldTY4dUNkZnVTVUczSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633632260),
('LnBvtp6j1FQaimCS1MzlVTtolFldwdk6gaqGjy4o', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoicG02NDVTRlZRYmdpTXhwZEc1SUF1N0UwOVM3ZmFob01LVXVQWmRQZCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633547417),
('lyyhHilb73ooCSYokxrPAdVfIg0y6fT3SJYQZNBp', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko/20100101 Firefox/93.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQjZrRmQzdTByUTZrekY0cW1aVUdXa2RQQWZINDY2Rk5wN3g2Y2RJYiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo4MzoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL3F1aXovZGlzYy1zdXJ2ZXkvcmVzdWx0cy9hYTE0OWMxMC00ZWQ4LTRlNGUtYmQxZC0yOWRjMmRjMjgxODgiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo4MzoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL3F1aXovZGlzYy1zdXJ2ZXkvcmVzdWx0cy9hYTE0OWMxMC00ZWQ4LTRlNGUtYmQxZC0yOWRjMmRjMjgxODgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1635610222),
('McnFU8EJ2m4rLmZ6KAsWvD2NJRHBZ8ZPCCA5f8ZX', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYUp0WFVyQVNWaDIxR2ptQ1NiYURZQlNybGxqRkYyajRDWXVTSWplbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610472),
('mhxfJcN0o6kVXLPBU53TiulPjIILmmca7gGFJGkX', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko/20100101 Firefox/93.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiT2pxNzFWZG5ncjJXNlAyVXduVElQT1lCMjRiVExVV01XOWVoU09McCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9xdWl6L2Rpc2Mtc3VydmV5L2luc3RydWN0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjM7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMCRaWUpSNC5TRGZta0sxVnNxdjJOTy51dmJtOG5obXEwbEZ5WlVVTHA5MjdMbldvUVR1OUw0VyI7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTAkWllKUjQuU0RmbWtLMVZzcXYyTk8udXZibThuaG1xMGxGeVpVVUxwOTI3TG5Xb1FUdTlMNFciO30=', 1635644307),
('Mj2tAB4XRAVdgdDMBGT31fwlTvBAvmTtDlXHA9v6', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT1ZyVnpqVW1WMWZyek9oU3hBSkJDclRadlBHeTk5cGhCYWo5VWlXcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633512354),
('mVDe2tQMaKDyqCNuOgP6wgmMhEIWtsvdCHVqyH3s', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiOFAwVERQdG8wV0VJNUg5UEdKWUJWa2JNM2RXUVpNQURyZzRkV3RoSCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634544144),
('N7nJvBfXcaUpio3VBbmZTb2OxfUzbmT9LRFTpmCD', NULL, '51.38.71.55', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibEF1b1ZUWTV1MDBsZlJHYWJnR0wxeGMwMmRwYXB1elNyalZtQ01sWiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634663466),
('nczT74eAAUptxl0m0s2NB3rTZfZfVeySst6lIwFO', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0JodlBzQmtqQnNvY2xmdlhFTm1Zd3RiaElzUzYya3FBTGh4eHZmUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658311),
('NxIbB62HEtFEQ7N78c9aH4m9g5fS7v9NHvLLaKJ5', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNzdMaHJqY3NPdHZ0STJKQXZpZW5tcGdPSlIyZ0JuUzBQYnV5b3U4aiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633512359),
('o1iECljWYiyFLtLA369dV5xQhrU8zHFcqwFxlree', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZzRpb2cya2E0OGN5ZHBEemVxemJmaUNxalc1NWhpQzdXbEZGODdNYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633657617),
('oeo7wXlzOxYBs5bYDU51gzssgRA23HYQBvY2GuvR', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidVdYaUdrNHpaTld3VHFjTDFiRkw0YnNWUXcwUzJmaExwbXJ4UEw1aiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633632266),
('ORRi4cSYLQLpUIrUgI7nXckPpiMhsqkHHLg3liyd', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWZPQzJKUWRqMGJxUWVRZWpobzAzT09NQVhWZVptT3J4NkNBS29oVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634663),
('ou0AAUMt5KQGwUDnOGfhPBKoxWQHma8oldJu2NSa', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFQzMnVNRTRZUVJNaDgyMGVWdVBSU2pzTW1BVEFaWWZEZmc2YVhtbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610473),
('OWpSJy3Wf7QOvlG5UA9G0bDEQ7AKKpqksEvR2b3O', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkUwSktUQ1doeDJZNk1RZnh2bzdEcTZLWE5jb3VnNjFhZjBKM24weCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658303),
('OZBTRVkI9Gi1QL3lRL1PSq0jRdwm2TOBU6ZYDZRi', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoielZ1V1BKcUpSUFdZSVdMdHBKdU9zWGd2S2FnaUEwZGxvWFpxTzNXcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631502),
('pCk7OoxepO6bHBnbguULb3wKzRthPv0URluwh4Qz', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoialphVVZlSnRFOVoxSGZGYzFBTDNka1hRbHBPejNNTnlpVGxSVnpabCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634371344),
('pev79wamhvOpobCbPC2avmH4ZzKsMflwKy2JOYW1', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSWx6QnlNOVZMcU5qUkZ1NHVnbmpCMW9vbTJmMjBROGJwTjJVcHR6aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658199),
('PFRKRtmteGzLXMiuHsMEjHNY19PtQ1OT0EN8HZRp', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic2JRUWlScFdkTlBuT2RuT3pXdHhVdFlNWUZHY2pCdGxodWVOOUtaVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633688846),
('pgnH5nhTIrkPVkKTctAXm5CoMhPfIaK4oAOgfAl4', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRDZmVkl2Qnh4Zzd6Q0Rnd2c5Q2ZqY1k3enJ1RWF1OWpyMDRZc1FEcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8veW90dGEuc29sdXRpb25zL2RlbW8vc2luaW9yYS9wdWJsaWMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1633373733),
('PHslKzdOB31vR0NZjzD29FaK0P7Im1MJcGR7lpme', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZlR3N1JzRXUxOUdvVW9NczBQM1U3V3dJQUM5QWtWVVo3eTZIeHJtSSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633631173),
('PKtZmX4uAQjTWYJfHPywMSFxBVkj9V7B3xSPE5uW', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQm4xMGRkNE02enJISm9zRkpUMTEwNE1taGIwUXp2QXZSQjhBYXdPNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucy9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633633464),
('prKG9TxIohO0dbKxNANCHO58q4tSy3ffBFnaTHmP', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiWlJVaTd0UnhJUkxpSUVPdGI5MjAzd1ZLdURwSlN6b2V6SWNaaGxUOCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633610915),
('Pug9A7bZr8eWA4GwJ6EzZRMVOnnQP3tfUUcNRi31', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiM2ZBbDJOUEZyU2JJMlBsaVJscEZSNnZoRk1LUDdTUWFQcmVOWDJvRiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634716945),
('pwc1sRBq8lIO2IfnIo8Nwkdzan2k2JSCurQlVLNj', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNWI0endBRk00TDczQnVIQ29UZlA1dlNCNTRKVVJGMlNzbE5CUUJUZyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633512334),
('pXD3eBCrOSi29lTKk9enOgXSitNSK6GaofNhykA7', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVmFJQjNiN2RTeWVoNDZDR1J1Z1ZqSmg1WWdIZDF1d200WVhRUklFTyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634112144),
('QhLHmrVLWQeHcAtC3AYS4epetKh5G8P8y6OkdDaz', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUcxZlJjUWxJM3VSWmVEY2dpZXo1Z1JIenRqb0czN2ZlTllNYkdOcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633657900),
('QJwSOt62Wr34j8T9ufUflsaYo7UkHjiTVFbo3wEZ', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiTzRsbWtocDBCY1BWTG5iTjNPWERReWJVOUZwMXJ6eEtPR1ZEeEdRcSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633632234),
('qnvbAThhL8rBqvInwJCjWTHnfFZdpgCJGXc44KAo', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnVxbkNLUmYzeUxvU1RBTjYwTzVhOERiYVBERzZnajFFVEJCS1E2biI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610471),
('Quo0NSQiQCWAzYCPHhsCiI2vpP84zvB2HwuDZGw2', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM1JQeGdibGZpeXVhbnBRYjJFaHBacHJvdzVFRXFNRGdvSjdwRDh5ZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631692),
('QzuxePeRyuhDxlgA9AGqGpzCowZi8WuuZf8UtFCX', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzlaTndKQmpZYk1ZVXlRRmxGcFRUYkhpaHo3Zzl4UmFlWWFVR0JlSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633660027);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('r30c94qWnZWxfjUxCOF9tWULz8FWeIqBbCSWuOTX', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZzdzWkZFejZmZTJQM1F5N3IxZENBTGhWR0x5Qmp3cWQ3MWZ5NEw0UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633545485),
('rbgrK1UGhl3BBebfWtcxhe5QxJMXp1ucR2MZkdQH', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMEdPNGN6Ymp2V3d0NUI1VG01MGhwUWVVOTM3MldwdEVXYUdEamhoayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631423),
('RcpmxFGIfGAoM1uAJTwFdssJwiDLucjinXwr1ZZ0', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoia3pGOEJsNldkUnpra29YTlFEMnpsdFloeHdHSm91cWc0NzBDbmRkdCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633610872),
('rKHsq1slN2r3R3JM5EYOyD6gkTBjNJMyaXoFXdMV', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSkNUVDBYZDVIeHhJRHUwVkUyM2NNaVRwSndkU0hIVmpTcG1ZTmkwQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucy9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633633473),
('RKusszJokTnLGBMO6ZwLC4nMGXTj5o9NiX2cHDZS', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWXZPOHpqTVFCc3dENHNJNjZ6V1FwY1lMWHl4VW5lWWlzc1J4OWxiSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634684),
('rodviMkYXN15ADqVUo7A85daGPzrAdAMrtIpgXht', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZnd1VUIxRVQ3RG9obk1LYXVYUXI5ZmtoQWJwWjVIWlMyajRldk1XUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631278),
('s5Oz741XIUTDWPsA021DBRPi0TGmITF12I6E0O7Z', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNjVQRlU3ZEg0TVA5RmlUendmSGF1ZnJ0UG9jMDYzUDB3THFFbThZcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633512308),
('s7rj43vk1fBToME0pZVha23DW62uyMEK7kH9G9Im', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTkh2WHpxa1d3dTBHQThmdVBlSkRBdGRoeHhvdGpESnlVZXVhdm5ycCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634654),
('SkQxZUeMSVLyazytW66Iu8lDwIqnfVzmQWPzX3M1', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic3U3eUtycHAwRGlsOGRxdTBESGprb253SVoyYTlUQm1kVXB6eVJIRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633633970),
('SMjV4QVkiNmIuzntQwHV9iKKExrjuYfG2qitvSsf', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoickxCbmp1d0R1ODkzYTRrUWMxemVwSGdTZFd3cnBjYjNVSHRPY3E0aCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610895),
('t86KUWYgOo3T5IAy88V4ZOSTeeia5xPtMngQ4wkB', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEt4dHF0c0Nna2J5cmNXQnNmYkJsbFN5eEo2U1BHYzBnYk82V2lTcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631342),
('Tl45zeoRQTSM3wZehXIFMeicVWZRt1OA5utRByGk', NULL, '103.131.187.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNnhWRlBzVkRLcnhzUzFYQnJ0S051QkZXTnN6SFpST0FJaEFmZjJuWCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0NjoiaHR0cDovL3NpbmlvcmEueW90dGEuc29sdXRpb25zL2FkbWluL2Rhc2hib2FyZCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM2OiJodHRwOi8vc2luaW9yYS55b3R0YS5zb2x1dGlvbnMvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1634200876),
('TneXLabvMtdEFajyapF1Y4zLwFauVm0nQqJCqwKK', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSDlOMm5yMDBGYWVvSEJPRER4WUlMdFBmVGE0anNYdGtIOGpPbmpsbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633633985),
('tq1QbpZx7sZtR6yzZOGGs8neUQ4Pv8EqweFeej86', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT3ZFTmNyZkxiQUlpTHp2UTdEUlVybEhQdFc0MkkwMDVtSGNiNVhQeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633689172),
('tRTMVLuISxalUsZqUBduQI3U9jOKTH91ZQHR7gcm', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT0h1RjNnSUZHbzd4VDdmNnNzOE10MXZrVkRsbW9ZUWdaNTlsTjBoYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658463),
('U13Do2etn9qG5F1sIow2ahLFoGHiWxN9KFrEcvCN', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiRm5lOUlLbWlsR3ZRUUl4RWxkaHVyQmIwV3B2UnhGOGVCcHlNa0l2QyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633939344),
('Ufuwj2e0xicyCG7e1Hfj5QwlodVWqsfcp2JpQGVQ', NULL, '206.84.146.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVks4NDY2am1HaGpIRlg1Smx6aEdIbEpOYVdjTXdLOExxdkdoNkpVNSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633547402),
('UIHCBkZFusS9PI57D7TgiXFsyhMSCDa8iln9Tq3o', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWXhPcnNUZU1yb2E4UXYxbU4xbnJLcUVKd2kxdlZXV3RjWFVscXBJMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633688293),
('UNTkV6LPhkcKolV4QqEGYV2v5JMXdphSOY9Prd14', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTFVsZWxGSWg0ZUtwVWVPZGhkOUJ1WGV0QnY1RmlOZlZMeVZOelFHYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633610416),
('URczzS1YNTDA5VWlbVssZTCxJLsKF2Rp7vNDj17K', NULL, '42.113.92.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicEcweWxLaGV5VjVybXVmdmpiNnJwdnJYR0dPekhkZ211SlVBZnZoRiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2MToiaHR0cDovL3NpbmlvcmEueW90dGEuc29sdXRpb25zL2FkbWluL3F1aXp6ZXMvOS9vdmVyYWxsLXJlcG9ydCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM2OiJodHRwOi8vc2luaW9yYS55b3R0YS5zb2x1dGlvbnMvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1634201971),
('UsSNiwvr4x37iDC2WR8fiomZKjxnFTtZpUDbt7Y5', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiOUJjZHlFOFA0UFAwOUtkbzViUjlYd0FreW9sa3YySkJFMjd1RUFLMSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634198543),
('vHSzWzfYeMPXDD6lq82wM8f1EtPzKyKxk8ACEvb5', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiYmpEY3FWTHFOaHpaWkZtbjNXTXFzaEJvU0g4N1lUd0hJejJBa1JINyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633688329),
('VSeCdK4c0OMxlGDlTIbqGAvrC913MJnemipbkKVF', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWmdKTHJzeENkTnVxSWtFRHRlWktBR2h2Y3hwZTlHanBIUHZaaTV6eCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633632955),
('vZaByvPU6s42MbtwEwlHmeajWkWQBLc8g8YXCiMr', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUjQzamxYN1FtZHFRdE9zME9RakNvM0RJRVRTTGVmTGIzTGRCdjFOQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634661),
('VzEOcyrICyP7DqE1gz5GG7NRNiLxq3B5q06Krt7b', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3g2WlBMelVBNUQ1T0tiU1dySUIyd2JBb01JakVqa2czRzdFQU5zRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633631691),
('vZRcg1UA64I1uo6eRf3KHyKqTpCKq9PDCRYKM67d', NULL, '86.182.157.93', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWDlqOVF6S0pvR1cxQmZ6ZnJxZFJha1dtS3BvNWh4cE5NeGxnWlhWaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1634722219),
('Wb7Qn5scOMXrgD9xekNZ2aJExggzBhkF8PYWpSRQ', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiWU11MURuRjlSSnE0ODRDaGpyOG8wY0pxbTRrQ1NxYUFYZ2o2emVHdSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633659647),
('WHwohmHgwg49yHA6E0stDoolJd9EdEWg2bXy4jVJ', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiS1BhUUdYZDN0OVBMR202OTRoUmp6WVRGRkJxY0tyTjYzY0x2aTR3OCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634630544),
('WwfUxLHriQLHPxidM2YMbrKt42fadPlOUZbZpCY9', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTVZYM3ZEeTkwVVFlaHpwQURGYmxnQjdndUpUQWFRUW5QSkJPUk9FYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658259),
('wYIohhpsXVA9S4ionigitjTpbAzkItzX5QgR59YF', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSE5pbDdUbHdJQ21JSWszV2RZZFRFd2d4Rjkyb1hEYURNcndzcEpOQSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633635008),
('Wz5xAJmXyxOVQCkaxpw03oS64NzBw5f6lc4uqHfj', NULL, '35.246.65.127', 'Go-http-client/1.1', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiM0JNYkdiMEFrNmNESVpBZGhLS0dvZDg1QzhySUNlck81eDE1dVE4diI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634025744),
('XBkm9MrmXmhWPtjcN7I3BmVy8bZTUsgc5hm48CKm', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSmNGbkxpVHhiTjdqN1VhNE9lT1lWWEp4d1pNSnJFTWM2dGpTN2gydiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633512330),
('XFy4oGSTM6y0oseUVbdLhokWVJZhretVzryUSBGI', NULL, '41.227.20.194', 'Mozilla/5.0 (Linux; Android 10; LYA-L29) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaDRXdFpOOW50TGxxQ0VaSVhtOHRIQ2dlcUtKSnlKa29NRmtucUNzNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly93d3cuc2luaW9yYS55b3R0YS5zb2x1dGlvbnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1633669566),
('xry0afglBazDHhvZrSujDAZQktSyvZFSsQwWrmBT', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZzJjeDAxRGlKVm9CcHVVS05UZVNMc3diOGd0Zmt1NXdaVXFWVGhnUiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633630584),
('XvcOYRZyevLD45B8dRF1OZ6KIKGcL1UAR3t3CP8p', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUEtNZ2hSdFAwcU5GZllKOGtkbjYzWXBad3ZPTGRCbDQ2SXRYSnNZYSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633633079),
('xzdcWURKJSwpe0kF9FjhuhrpeLdpz6m7SBnB9hMJ', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0tickN1aDVSZ3NjcUdwRmV0OFNrSXBiNFZxMExRMjdaVHYxSWIzWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633634660),
('Y6zj232QvCBN1817ayxIYQvfJ5mACPym45jxcai5', 4, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiUFVjQjlPMGVFZnlVVjZ3cW9xTmRCb3RwZ2xodGt2V2gyY212RmdGNCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NDtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEwJGc0VDd2ZXlwUTdpeGpKemtyTmwzT2VEd3BnWlM5QXc0RVFkMW9xdi9pSi8vVkl4U016c09tIjtzOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjM5OiJodHRwOi8vMWI0OC0yMDYtODQtMTQ2LTMzLm5ncm9rLmlvL2hvbWUiO31zOjIxOiJwYXNzd29yZF9oYXNoX3NhbmN0dW0iO3M6NjA6IiQyeSQxMCRnNFQ3dmV5cFE3aXhqSnprck5sM09lRHdwZ1pTOUF3NEVRZDFvcXYvaUovL1ZJeFNNenNPbSI7fQ==', 1633082801),
('yEIpXmvMkvLBqj8Cx0gC5qGGdLKDA1iEnavWKN9A', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiaTFNTzM3ZUVXb0tvQjBNeDdFVmNjQmRoZGZkUHBTTkZ3NG9SZ0lWNSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1633689198),
('YElMAR2yn265IZp2F144j2al6eB2PtSWtyXF70FH', NULL, '176.33.105.141', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0dHdUpEcFpDcHh4dUxWbXM2MGRKOXFkMnZVYmVNekJ2bU5KYk1VYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633725270),
('YPdTm5vmrIBHrWXBKNZzpFVFzaGwP3Ce0Ftg4Jgb', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOHlldklDdVBiQ1BXQU10ZlVORFF0OUlNc3c4cGtJWG1VdWdudk5QTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658248),
('YqgFAqgPT5jZEAOmtsz6YHnAhGbNj5wmeegywEhT', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiQVJQMUVvRWJGZ1BIT3ZLcjNhZzBDNk9vWUNXY0Ric3pLZzhuWGhJQiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1634149445),
('YYdReD4MAOd7UktLmr5taTTTar047AE571TxeYj7', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVzEyWU1GdTlaWTFFNzVwV1R6VEs3eEVPRFdwTWJPN2JkREp1TzhsZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633658268),
('Z1q04vRs9GlBhkqDNuLoV2TxkSnSzxsfG7uSQpBx', NULL, '86.182.157.93', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRjlmd3VwSkJaMnZ0N3VwZ1V4bzNRbXphYWxndFFkWkFReU8wTlJjcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1634312125),
('zNhP3HgxnQismW56qOTYmMl4vizT1CNtLZV3mpB4', NULL, '86.166.201.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVWJabk1oanN4NVBrYXdLOVJQVGtrMXJmY1NjSGVOSWVSTzBXU1BLMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaW5pb3JhLnlvdHRhLnNvbHV0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1633657935);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `group`, `name`, `locked`, `payload`, `created_at`, `updated_at`) VALUES
(1, 'site', 'app_name', 0, '\"Siniora Assessments Portal\"', '2021-09-28 06:31:01', '2021-10-08 10:28:25'),
(2, 'site', 'tag_line', 0, '\"Prove Your Skills\"', '2021-09-28 06:31:01', '2021-10-08 10:28:25'),
(3, 'site', 'seo_description', 0, '\"Siniora Assessments Portal is an online test and examination software to conduct web and mobile-based exams.\"', '2021-09-28 06:31:01', '2021-10-08 10:28:25'),
(4, 'site', 'logo_path', 0, '\"site\\/logo.png\"', '2021-09-28 06:31:01', '2021-10-08 10:28:25'),
(5, 'site', 'can_register', 0, 'true', '2021-09-28 06:31:01', '2021-10-08 10:28:25'),
(6, 'site', 'favicon_path', 0, '\"site\\/favicon.png\"', '2021-09-28 06:31:01', '2021-10-08 10:28:25'),
(7, 'home_page', 'hero_title', 0, '\"Siniora Assessments Platform\"', '2021-09-28 06:31:01', '2021-10-07 19:35:56'),
(8, 'home_page', 'hero_subtitle', 0, '\"Take online assessments. Assess your performance. Learn and improve.\"', '2021-09-28 06:31:01', '2021-10-07 19:35:56'),
(9, 'home_page', 'hero_cta_text', 0, '\"Get Started\"', '2021-09-28 06:31:01', '2021-10-07 19:35:56'),
(10, 'home_page', 'hero_image_path', 0, '\"site\\/hero_image_bg.jpg\"', '2021-09-28 06:31:01', '2021-10-07 19:35:56'),
(11, 'localization', 'default_locale', 0, '\"en\"', '2021-09-28 06:31:01', '2021-10-08 02:20:28'),
(12, 'localization', 'default_timezone', 0, '\"Asia\\/Amman\"', '2021-09-28 06:31:01', '2021-10-08 02:20:28'),
(13, 'email', 'host', 0, '\"smtp.mailtrap.io\"', '2021-09-28 06:31:01', '2021-10-20 09:35:00'),
(14, 'email', 'port', 0, '\"2525\"', '2021-09-28 06:31:01', '2021-10-20 09:35:00'),
(15, 'email', 'username', 0, '\"username\"', '2021-09-28 06:31:01', '2021-10-20 09:35:00'),
(16, 'email', 'password', 0, '\"password\"', '2021-09-28 06:31:01', '2021-10-20 09:35:00'),
(17, 'email', 'encryption', 0, '\"tls\"', '2021-09-28 06:31:01', '2021-10-20 09:35:00'),
(18, 'email', 'from_address', 0, '\"admin@siniorafood.com\"', '2021-09-28 06:31:01', '2021-10-20 09:35:00'),
(19, 'email', 'from_name', 0, '\"Siniora Food\"', '2021-09-28 06:31:01', '2021-10-20 09:35:00');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `name`, `code`, `slug`, `section_id`, `short_description`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Improvement', 'skl_ZuaXdAeACvb', 'test-skill', 1, NULL, 1, '2021-09-28 06:42:42', '2021-09-28 06:42:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `sub_category_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(5000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `name`, `code`, `slug`, `category_id`, `sub_category_type_id`, `short_description`, `description`, `image_path`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Improvment', 'sub_7GeojsBQ0ZB', 'test-sub-category', 1, '1', NULL, NULL, NULL, 1, '2021-09-28 06:42:13', '2021-10-07 19:34:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sub_category_sections`
--

CREATE TABLE `sub_category_sections` (
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_category_types`
--

CREATE TABLE `sub_category_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_category_types`
--

INSERT INTO `sub_category_types` (`id`, `name`, `code`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Course', 'course', 1, NULL, NULL, NULL),
(2, 'Certification', 'certification', 1, NULL, NULL, NULL),
(3, 'Class', 'class', 1, NULL, NULL, NULL),
(4, 'Exam', 'exam', 1, NULL, NULL, NULL),
(5, 'Grade', 'grade', 1, NULL, NULL, NULL),
(6, 'Standard', 'standard', 1, NULL, NULL, NULL),
(7, 'Stream', 'stream', 1, NULL, NULL, NULL),
(8, 'Level', 'level', 1, NULL, NULL, NULL),
(9, 'Skill', 'skill', 1, NULL, NULL, NULL),
(10, 'Branch', 'branch', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`id`, `name`, `code`, `slug`, `skill_id`, `short_description`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Test Skill', 'top_kwbZuxbFedU', 'test-skill', 1, NULL, 1, '2021-09-28 06:43:09', '2021-09-28 06:43:09', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payable_id` bigint(20) UNSIGNED NOT NULL,
  `wallet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('deposit','withdraw') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(64,0) NOT NULL,
  `confirmed` tinyint(1) NOT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `from_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_id` bigint(20) UNSIGNED NOT NULL,
  `to_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('exchange','transfer','paid','refund','gift') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'transfer',
  `status_last` enum('exchange','transfer','paid','refund','gift') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_id` bigint(20) UNSIGNED NOT NULL,
  `withdraw_id` bigint(20) UNSIGNED NOT NULL,
  `discount` decimal(64,0) NOT NULL DEFAULT 0,
  `fee` decimal(64,0) NOT NULL DEFAULT 0,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_verified_at` timestamp NULL DEFAULT NULL,
  `verification_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification_code_expires_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `user_name`, `email`, `email_verified_at`, `mobile`, `mobile_verified_at`, `verification_code`, `verification_code_expires_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `remember_token`, `current_team_id`, `profile_photo_path`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Siniora', 'Admin', 'admin', 'admin@siniorafood.com', '2021-09-28 06:31:02', NULL, NULL, NULL, NULL, '$2y$10$63WFwdELJ3yzIIeTLrUtEOV5uK7RuCLVza5/yFXzAikVmGhBMtrhq', NULL, NULL, 'mRnVyRQFnyMTLmJjpO24Z5sV9eZGN3EereS7mTzpxlbinNBbBpcwdWGgjCRh', NULL, NULL, 1, '2021-09-28 06:31:02', '2021-10-08 02:22:25', NULL),
(2, 'Siniora', 'Supervisor', 'supervisor', 'supervisor@siniorafood.com', '2021-09-28 06:31:02', NULL, NULL, NULL, NULL, '$2y$10$p9gb0KquVYEB440xH5aNkewsTckPoCaudTgqW2FyRaFwWX2D44YSy', NULL, NULL, NULL, NULL, NULL, 1, '2021-09-28 06:35:21', '2021-10-08 02:24:09', NULL),
(3, 'Siniora', 'Employee', 'employee', 'employee@siniorafood.com', '2021-09-28 06:31:02', NULL, NULL, NULL, NULL, '$2y$10$ZYJR4.SDfmkK1Vsqv2NO.uvbm8nhmq0lFyZUULp927LnWoQTu9L4W', NULL, NULL, 'tnme4D1sUW9fF5u9BN7hy72z8SHBt5ydkiJ8uIISqFISsAYOQAlHtRDn6btm', NULL, NULL, 1, '2021-09-30 05:21:59', '2021-10-08 02:21:46', NULL),
(6, 'Hatem', 'Afifi', 'hatemafifi', 'hatem@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$HPw/kuK0JomD7m1eU/y/numx2uDVstwRO0nRel7B7VNwxDe.wkb.W', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:06:53', '2021-10-19 19:06:53', NULL),
(7, 'Nahed', 'Sabri', 'nahedsabri', 'naheb@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$2Tc9pgbDhp9gj2uNQBsZt.xztIMMKTfuFsSMEiwFyQpHO6QZer8/G', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:16:55', '2021-10-19 19:16:55', NULL),
(8, 'Khaled', 'AlMuhtaseb', 'khaledalmuhtasib', 'khaled@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$5ZfPlD32imfrNIQwWP8wtu87C1oBZm2hxLcUeq0KP/rydCi0xVueq', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:17:20', '2021-10-19 19:17:20', NULL),
(9, 'Ismael', 'Izhiman', 'ismaelizhiman', 'ismael@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$2fMB/ko4L4XK97LFWzWEmOhtIrlyfIQFHztkqMb4k9C7GBf8RSmxS', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:19:28', '2021-10-19 19:19:28', NULL),
(10, 'Khaled', 'Saleh', 'khaledsaleh', 'khaledsaleh@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$FfaWaoxiWxGgnIBQdkBol.JX.yd0s/qxP8NpLfhCqQuj9WXfUzZMi', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:19:55', '2021-10-19 19:19:55', NULL),
(11, 'Ahmad', 'Yahya', 'ahmadyahya', 'ahmad@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$XH2ekcBpGEgduocN59oHZOHKo49yT9vagQT9W/85Dtylm.ra589F.', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:20:26', '2021-10-19 19:20:26', NULL),
(12, 'Raafat', 'Abu Khizaran', 'raafatabukihzaran', 'raafat@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$l2QVfuqavU04pgSi9CnRGO2EdYQzzujtI79Cv53JkbWUiIlyPxhui', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:21:07', '2021-10-19 19:21:07', NULL),
(13, 'عمر عبدالكريم', 'علي قاسم', 'omarqasem', 'omar@siniorafood', NULL, NULL, NULL, NULL, NULL, '$2y$10$OTPqCkXj47Fd6Yi1V6h7XezubEWEN/Hajd/hJlC15WcvFhPEN8NHO', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:22:20', '2021-10-19 19:22:20', NULL),
(14, 'عمر بلال', 'موسى عبد الفتاح', 'omarbilal', 'omar@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$ScA5Ufs7PConzY2nvHDREus.v5stYHcLTb6l7EKGqT66LOEm54Z.G', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:22:58', '2021-10-19 19:22:58', NULL),
(15, 'سوزان شاهر', 'غيث', 'suzangaith', 'suzan@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$yz2SncDEJO3DKNDcgrNx.udgPl0Pi7CsIadXm5lfRRtrD3mzzKvmu', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:23:52', '2021-10-19 19:23:52', NULL),
(16, 'انس عبد الهادي', 'صالح عوض', 'anasawad', 'anas@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$ewusLQo.aRe2aEExnygUI.PI0aU3ny3oW7tDjY6nAm.682jk2HYPC', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:24:43', '2021-10-19 19:24:43', NULL),
(17, 'Osama', 'Muhsen', 'osamamuhsen', 'osama@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$F2ddK.dIKPPZvZEXHqLYgeJQt5X8a/xGviLoKiB3SH0WyvV014ooW', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:25:06', '2021-10-19 19:25:06', NULL),
(18, 'مراد محمد', 'موسى يوسف', 'muradyousef', 'muradyousef@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$ntO4BWEFYBRYYZuWZXm/aekEFI87oXDjClpzT7/CH/3ygTr5/zlw.', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:25:41', '2021-10-19 19:25:41', NULL),
(19, 'Bahaa', 'AL Qashash', 'bahaaqashash', 'bahaa@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$dVQL51dTyxuqno.ThVZIyeqYe.xE.ZNiUrl.g0M08mV11k4ggTAgC', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:26:16', '2021-10-19 19:26:16', NULL),
(20, 'Luay Labib', 'Hafez Al Dajani', 'luaydajani', 'luay@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$YVux.JLc0rql.7.wobxEwOp6H6vvZcUwrCLq/oNhqpH/x/nXDVz0W', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:26:43', '2021-10-19 19:26:43', NULL),
(21, 'ايهاب', 'اسماعيل الرجبي', 'ehabrajbi', 'ehab@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$uf3vl42sd6WzQI6VPGmwKe.Qqp9ZM6HJWxybbNAIbWPce5nl1BP.W', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:27:30', '2021-10-19 19:27:30', NULL),
(22, 'Tawfiq', 'Odeh', 'tawfiqodeh', 'tawfiq@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$8iM6ITJvurFf0.qyQvzi7eUd8PuAs.NCiNTnuE.KJtYiqA2Fdk2yK', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:28:05', '2021-10-19 19:28:05', NULL),
(23, 'Ahmed Ibrahim', 'Ahmed Natour', 'ahmednatour', 'ahmednatour@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$4VqBw1OOI7FQCYICTb61ge7huBysVVRpQCePLfKsenlAMqdHUEuEy', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:28:30', '2021-10-19 19:28:30', NULL),
(24, 'فؤاد احمد', 'صالح حسن', 'fouadhasan', 'fouadhasan@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$of/WFccgUdGYf8n97dvQKeQQfjRhhJIM10iIBO8/uK9bTRU.977py', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-19 19:31:42', '2021-10-19 19:31:42', NULL),
(25, 'يسرى', 'محمد سلهب', 'yusrasalhab', 'yusra@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$/D46dXmIIG1m5bzJyhaxPuyPhy1zXX6aK/rgs0KaLFefmh4Z5o6Ky', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:38:06', '2021-10-20 08:38:06', NULL),
(26, 'Ahmad', 'Raba', 'ahmadraba', 'ahmadraba@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$AjkZ1YKQymakP6jYzSO5uubt.02tZYiTpWg5D/zj2Hl2bG5Pn7Fga', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:38:25', '2021-10-20 08:38:25', NULL),
(27, 'حسين وهيب', 'حسين رابعة', 'husseinrabaa', 'hussein@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$KuV0DkYsbXP9fcw545qxlOW6BTuksI/Cq6e0om8.HZ3cl0RZue5o.', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:38:55', '2021-10-20 08:38:55', NULL),
(28, 'عصام', 'جبرائيل', 'isamjibrael', 'isam@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$Pv/7OV99gc8Ed0tXBpJM3OdSe2XQt6m1GkbdMG7bywAXjClIBcvTm', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:39:33', '2021-10-20 08:39:33', NULL),
(29, 'اسماعيل محمد', 'احمد داود', 'ismaildaoud', 'ismail@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$6NzEFX9Phtp3R1fEz5qO4e1IPsyOjzfisz9C2jw6GcItezFONRSxu', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:40:19', '2021-10-20 08:40:19', NULL),
(30, 'Firas', 'Khatib', 'firaskhatib', 'firas@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$CIz0tZn7B8J6W.ASHyG2Cep8GoPdnI0A.p0GpmayxpKvJK22Ejj.m', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:40:41', '2021-10-20 08:40:41', NULL),
(31, 'بسام محمد', 'شحادة زيد', 'bassamzaid', 'bassamzaid@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$O0ba1ilN4cC6PEVZz/kzWOB5yyPyJOrBHUkw6p0I1pnFucpXtISP2', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:41:59', '2021-10-20 08:41:59', NULL),
(32, 'احمد', 'عليان', 'ahmadalayan', 'ahmadalayan@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$IT/vglhYcYHqUW.xrRdNouTN6TmWNAuBNzMAUKrtnYibqubBMaEMe', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:42:25', '2021-10-20 08:42:25', NULL),
(33, 'خالد', 'حمزة', 'khaledhamza', 'khaledhamza@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$LiZe1VUKeZEXk.Vs7AmE4eNgwJpF58JLqc49p3RCl2foAZTfRtEPi', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:43:20', '2021-10-20 08:43:20', NULL),
(34, 'محمد داود', 'صادق الرمحي', 'mohammadramhi', 'mohammadramhi@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$xaVxtFi7uDlXn8nXCfnJT.4LC0G9F1k3LKkVEfPgJ5iOASCqZS1K6', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:43:58', '2021-10-20 08:43:58', NULL),
(35, 'علاء رمضان', 'عبد الجليل', 'alaajaleel', 'alaajaleel@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$mvAvmLH/vigAchmKxW4KR.PfQ5Fsa/oe..PHrmnmiTom0ZqNUc/cy', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:44:39', '2021-10-20 08:44:39', NULL),
(36, 'ريما احمد', 'محمد الشوبكي', 'rimashobaki', 'rimashobaki@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$O77VqZ7cXu.QcQSZt.eRKuQuka9TvynAFncJKL797fUrYVuTPvgU2', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:45:17', '2021-10-20 08:45:17', NULL),
(37, 'خلدون سليمان', 'علي عبدالهادي', 'khaldounabd', 'khaldoun@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$Qwb8fhZhJJHaDUM8Z/P9fec19oz.ysT.1oCt41jlMhEY9x3YmvHhu', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:45:53', '2021-10-20 08:45:53', NULL),
(38, 'ايمن محمد', 'عبدالسلام الحوراني', 'aymanhourani', 'aymanhourani@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$UsauNt8.wZzokwxgEBcm../bRnwKGsox8cAuhzUyxiiH3Ma0MKqTy', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:46:24', '2021-10-20 08:46:24', NULL),
(39, 'محمد عبدالفتاح', 'محمد مغنم', 'mohammadmeghnem', 'mohammadmeghnem@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$mh6lOi2DHYA9Ug.mG8/BFOcq2G7Kr7cdbQ0D8kEHo2MQSzTW42oMC', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 08:46:57', '2021-10-20 08:46:57', NULL),
(40, 'محمود احمد', 'محمود عبدالهادي', 'mahmoudabd', 'mahmoudabd@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$vxDHAQPPZqFnc/c.yGiOsuqUhBi7XUQbECFY3r3ktV2lZ/RjgL3W2', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:21:04', '2021-10-20 09:21:04', NULL),
(41, 'رائد سميح', 'خالد حباق', 'raedhabaq', 'raedhabaq@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$ViHlxF8G8xxMkFJXncntteX/2seTLvTA6YBt.nthdDOn/dcvCGHQm', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:21:27', '2021-10-20 09:21:27', NULL),
(42, 'احمد وليد', 'عبد الجواد العزة', 'ahmadezza', 'ahmadezza@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$EOiY7drxfRG3NLZDo.c2heKqWsgSO46CepTOZbziPHEkCGapfsSie', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:21:50', '2021-10-20 09:21:50', NULL),
(43, 'ريما محمود', 'يوسف أبو شويمة', 'rimashweimeh', 'rima@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$uojVRUmfswql6OHp/V6hDemlg7lSj6PplyyajUZVUw8Tb7MWORkQO', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:22:14', '2021-10-20 09:22:14', NULL),
(44, 'هاني يونس', 'سالم السميري', 'hanisamiri', 'hani@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$ProOmSzWnTRdCuB95MNfVujfoLiEYWWeyuTLu8Bs0Hi40TGoA2Lo6', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:22:38', '2021-10-20 09:22:38', NULL),
(45, 'بلال', 'صالح العمري', 'bilalomari', 'bilal@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$NcqTERwYM.h7VXV2d/JCdeF.AlDsNjOo1BsPWhGa3bEBuDSS3MwdK', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:23:10', '2021-10-20 09:23:10', NULL),
(46, 'صالح عبد الرحمن', 'صالح فراح', 'salehfarrah', 'salehfarrah@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$Rbz4hqUYQoZ8Cfv2G3k/Au1.iTxlxtDtCbdCYCbbbRqANThwBhBAK', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:23:36', '2021-10-20 09:23:36', NULL),
(47, 'زهدي', 'الجمل', 'zahdijamal', 'zahdi@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$KVSdsthlW69PgLe4WWY4YOiTTdOnk2h4wC.UxIp./EewGKN0UehU2', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:24:02', '2021-10-20 09:24:02', NULL),
(48, 'أحمد تيسير', 'محمد شاهر الشريف', 'ahmadsharif', 'ahmadsharif@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$ZchyDrPPxKKwQQWA6aUQgOfR7CcRrWaNPdbwgsV2RMGSq8V.PX3Cu', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:24:29', '2021-10-20 09:24:29', NULL),
(49, 'علاء محمد عزام', 'محمد طاهر الشريف', 'alaasharif', 'alaasharif@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$0B9bgU9SynQI5LBwkNo4Tei3huAqK5NN2NzeK2MbFvxU7Q5p9v0A6', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:24:55', '2021-10-20 09:24:55', NULL),
(50, 'يوسف محمد', 'عبيد', 'yousefabed', 'yousefabed@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$nT09xbHTuVnfBGuwo2fuZ.Gfc6i.7i.Vpr1Zd8oOMdhGpyA5BVou.', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:26:30', '2021-10-20 09:26:30', NULL),
(51, 'رائد عبد الحميد', 'عوض اصبيح', 'raedesbaih', 'raedesbaih@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$cqPXoDVQJCQJ3yN0IQrkEOnFub3oaeS9Nu3MATwK9ghIDAwXhBHVy', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:26:53', '2021-10-20 09:26:53', NULL),
(52, 'اياد', 'ابو عنزة', 'eyadabuanzeh', 'eyadabuanzeh@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$94zNY5YtsxNf/Dj7YjFc8uwuVm/pcPP2rM7e/qbxvznn5Co/iRTjS', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:27:13', '2021-10-20 09:27:13', NULL),
(53, 'محمد', 'نضال حسن', 'mohammadhasan', 'mohammadhasan@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$PP6B1p0xKBEkFhff8fJD5u1I.O7kFUOh1Vt47pcHZ/rXz7MRGg5Rq', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:27:51', '2021-10-20 09:27:51', NULL),
(54, 'صهيب محمد', 'فارس حسن', 'suhaibhasan', 'suhaibhasan@siniorafood.com', NULL, NULL, NULL, NULL, NULL, '$2y$10$W3XaqluPqpkTaj5zVJpxDe6cRd8P8dbD/GFfK0F/7KBKzeDLQcpD2', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-20 09:28:08', '2021-10-20 09:28:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_groups`
--

INSERT INTO `user_groups` (`id`, `name`, `code`, `slug`, `description`, `is_private`, `is_active`, `settings`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'Director', 'ugp_VZvcZSTg6E2', 'director', NULL, 0, 1, NULL, '2021-10-19 18:53:32', '2021-10-19 18:53:32', NULL),
(3, 'Manager', 'ugp_g7zGXtlS1fM', 'manager', NULL, 0, 1, NULL, '2021-10-19 18:53:36', '2021-10-19 18:53:36', NULL),
(4, 'Supervisor', 'ugp_mKzgzwhvAuP', 'supervisor', NULL, 0, 1, NULL, '2021-10-19 18:53:51', '2021-10-19 18:53:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_quiz_schedules`
--

CREATE TABLE `user_group_quiz_schedules` (
  `quiz_schedule_id` bigint(20) UNSIGNED NOT NULL,
  `user_group_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_group_users`
--

CREATE TABLE `user_group_users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `user_group_id` bigint(20) UNSIGNED NOT NULL,
  `joined_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_group_users`
--

INSERT INTO `user_group_users` (`user_id`, `user_group_id`, `joined_at`) VALUES
(1, 2, NULL),
(2, 2, NULL),
(3, 2, NULL),
(6, 2, NULL),
(7, 2, NULL),
(8, 2, NULL),
(9, 2, NULL),
(10, 2, NULL),
(11, 2, NULL),
(12, 2, NULL),
(13, 3, NULL),
(14, 3, NULL),
(15, 3, NULL),
(16, 3, NULL),
(17, 3, NULL),
(18, 3, NULL),
(19, 3, NULL),
(20, 3, NULL),
(21, 3, NULL),
(22, 3, NULL),
(23, 3, NULL),
(24, 3, NULL),
(25, 3, NULL),
(26, 3, NULL),
(27, 3, NULL),
(28, 3, NULL),
(29, 3, NULL),
(30, 3, NULL),
(31, 3, NULL),
(32, 3, NULL),
(33, 3, NULL),
(34, 3, NULL),
(35, 3, NULL),
(36, 3, NULL),
(37, 4, NULL),
(38, 4, NULL),
(39, 4, NULL),
(40, 4, NULL),
(41, 4, NULL),
(42, 4, NULL),
(43, 4, NULL),
(44, 4, NULL),
(45, 4, NULL),
(46, 4, NULL),
(47, 4, NULL),
(48, 4, NULL),
(49, 4, NULL),
(50, 4, NULL),
(51, 4, NULL),
(52, 4, NULL),
(53, 4, NULL),
(54, 4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `holder_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `holder_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `balance` decimal(64,0) NOT NULL DEFAULT 0,
  `decimal_places` smallint(6) NOT NULL DEFAULT 2,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`id`, `holder_type`, `holder_id`, `name`, `slug`, `description`, `meta`, `balance`, `decimal_places`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'Default Wallet', 'default', NULL, '[]', '0', 2, '2021-09-28 06:34:14', '2021-09-28 06:34:14'),
(2, 'App\\Models\\User', 2, 'Default Wallet', 'default', NULL, '[]', '0', 2, '2021-09-28 06:35:40', '2021-09-28 06:35:40'),
(3, 'App\\Models\\User', 3, 'Default Wallet', 'default', NULL, '[]', '0', 2, '2021-09-30 05:22:24', '2021-09-30 05:22:24'),
(4, 'App\\Models\\User', 4, 'Default Wallet', 'default', NULL, '[]', '0', 2, '2021-10-01 05:06:26', '2021-10-01 05:06:26'),
(5, 'App\\Models\\User', 6, 'Default Wallet', 'default', NULL, '[]', '0', 2, '2021-10-19 19:07:01', '2021-10-19 19:07:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_code_unique` (`code`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`);

--
-- Indexes for table `comprehension_passages`
--
ALTER TABLE `comprehension_passages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `comprehension_passages_code_unique` (`code`);

--
-- Indexes for table `difficulty_levels`
--
ALTER TABLE `difficulty_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `difficulty_levels_code_unique` (`code`);

--
-- Indexes for table `disc`
--
ALTER TABLE `disc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `practice_sessions`
--
ALTER TABLE `practice_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `practice_sessions_code_unique` (`code`),
  ADD KEY `practice_sessions_status_index` (`status`);

--
-- Indexes for table `practice_session_questions`
--
ALTER TABLE `practice_session_questions`
  ADD PRIMARY KEY (`practice_session_id`,`question_id`);

--
-- Indexes for table `practice_sets`
--
ALTER TABLE `practice_sets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `practice_sets_slug_unique` (`slug`),
  ADD UNIQUE KEY `practice_sets_code_unique` (`code`),
  ADD KEY `practice_sets_skill_id_foreign` (`skill_id`),
  ADD KEY `practice_sets_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `practice_set_questions`
--
ALTER TABLE `practice_set_questions`
  ADD PRIMARY KEY (`practice_set_id`,`question_id`),
  ADD KEY `practice_set_questions_question_id_foreign` (`question_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `questions_code_unique` (`code`),
  ADD KEY `questions_skill_id_foreign` (`skill_id`),
  ADD KEY `questions_topic_id_foreign` (`topic_id`),
  ADD KEY `questions_comprehension_passage_id_foreign` (`comprehension_passage_id`);

--
-- Indexes for table `question_types`
--
ALTER TABLE `question_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `question_types_code_unique` (`code`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quizzes_slug_unique` (`slug`),
  ADD UNIQUE KEY `quizzes_code_unique` (`code`),
  ADD KEY `quizzes_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`quiz_id`,`question_id`),
  ADD KEY `quiz_questions_question_id_foreign` (`question_id`);

--
-- Indexes for table `quiz_schedules`
--
ALTER TABLE `quiz_schedules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quiz_schedules_code_unique` (`code`);

--
-- Indexes for table `quiz_sessions`
--
ALTER TABLE `quiz_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quiz_sessions_code_unique` (`code`),
  ADD KEY `quiz_sessions_status_index` (`status`);

--
-- Indexes for table `quiz_session_questions`
--
ALTER TABLE `quiz_session_questions`
  ADD PRIMARY KEY (`quiz_session_id`,`question_id`);

--
-- Indexes for table `quiz_types`
--
ALTER TABLE `quiz_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quiz_types_code_unique` (`code`),
  ADD UNIQUE KEY `quiz_types_slug_unique` (`slug`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sections_code_unique` (`code`),
  ADD UNIQUE KEY `sections_slug_unique` (`slug`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_group_index` (`group`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `skills_code_unique` (`code`),
  ADD UNIQUE KEY `skills_slug_unique` (`slug`),
  ADD KEY `skills_section_id_foreign` (`section_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sub_categories_code_unique` (`code`),
  ADD UNIQUE KEY `sub_categories_slug_unique` (`slug`),
  ADD KEY `sub_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `sub_category_sections`
--
ALTER TABLE `sub_category_sections`
  ADD PRIMARY KEY (`sub_category_id`,`section_id`),
  ADD KEY `sub_category_sections_section_id_foreign` (`section_id`);

--
-- Indexes for table `sub_category_types`
--
ALTER TABLE `sub_category_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sub_category_types_code_unique` (`code`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `topics_code_unique` (`code`),
  ADD UNIQUE KEY `topics_slug_unique` (`slug`),
  ADD KEY `topics_skill_id_foreign` (`skill_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transactions_uuid_unique` (`uuid`),
  ADD KEY `transactions_payable_type_payable_id_index` (`payable_type`,`payable_id`),
  ADD KEY `payable_type_ind` (`payable_type`,`payable_id`,`type`),
  ADD KEY `payable_confirmed_ind` (`payable_type`,`payable_id`,`confirmed`),
  ADD KEY `payable_type_confirmed_ind` (`payable_type`,`payable_id`,`type`,`confirmed`),
  ADD KEY `transactions_type_index` (`type`),
  ADD KEY `transactions_wallet_id_foreign` (`wallet_id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transfers_uuid_unique` (`uuid`),
  ADD KEY `transfers_from_type_from_id_index` (`from_type`,`from_id`),
  ADD KEY `transfers_to_type_to_id_index` (`to_type`,`to_id`),
  ADD KEY `transfers_deposit_id_foreign` (`deposit_id`),
  ADD KEY `transfers_withdraw_id_foreign` (`withdraw_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_user_name_unique` (`user_name`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_mobile_unique` (`mobile`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_groups_code_unique` (`code`),
  ADD UNIQUE KEY `user_groups_slug_unique` (`slug`);

--
-- Indexes for table `user_group_quiz_schedules`
--
ALTER TABLE `user_group_quiz_schedules`
  ADD PRIMARY KEY (`quiz_schedule_id`,`user_group_id`),
  ADD KEY `user_group_quiz_schedules_user_group_id_foreign` (`user_group_id`);

--
-- Indexes for table `user_group_users`
--
ALTER TABLE `user_group_users`
  ADD PRIMARY KEY (`user_id`,`user_group_id`),
  ADD KEY `user_group_users_user_group_id_foreign` (`user_group_id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wallets_holder_type_holder_id_slug_unique` (`holder_type`,`holder_id`,`slug`),
  ADD KEY `wallets_holder_type_holder_id_index` (`holder_type`,`holder_id`),
  ADD KEY `wallets_slug_index` (`slug`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `comprehension_passages`
--
ALTER TABLE `comprehension_passages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `difficulty_levels`
--
ALTER TABLE `difficulty_levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `disc`
--
ALTER TABLE `disc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `practice_sessions`
--
ALTER TABLE `practice_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `practice_sets`
--
ALTER TABLE `practice_sets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `question_types`
--
ALTER TABLE `question_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `quiz_schedules`
--
ALTER TABLE `quiz_schedules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `quiz_sessions`
--
ALTER TABLE `quiz_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `quiz_types`
--
ALTER TABLE `quiz_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sub_category_types`
--
ALTER TABLE `sub_category_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `practice_sets`
--
ALTER TABLE `practice_sets`
  ADD CONSTRAINT `practice_sets_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`),
  ADD CONSTRAINT `practice_sets_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`);

--
-- Constraints for table `practice_set_questions`
--
ALTER TABLE `practice_set_questions`
  ADD CONSTRAINT `practice_set_questions_practice_set_id_foreign` FOREIGN KEY (`practice_set_id`) REFERENCES `practice_sets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `practice_set_questions_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_comprehension_passage_id_foreign` FOREIGN KEY (`comprehension_passage_id`) REFERENCES `comprehension_passages` (`id`),
  ADD CONSTRAINT `questions_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`),
  ADD CONSTRAINT `questions_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`);

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`);

--
-- Constraints for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD CONSTRAINT `quiz_questions_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `skills`
--
ALTER TABLE `skills`
  ADD CONSTRAINT `skills_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`);

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `sub_category_sections`
--
ALTER TABLE `sub_category_sections`
  ADD CONSTRAINT `sub_category_sections_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sub_category_sections_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `topics`
--
ALTER TABLE `topics`
  ADD CONSTRAINT `topics_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `transfers_deposit_id_foreign` FOREIGN KEY (`deposit_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transfers_withdraw_id_foreign` FOREIGN KEY (`withdraw_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_group_quiz_schedules`
--
ALTER TABLE `user_group_quiz_schedules`
  ADD CONSTRAINT `user_group_quiz_schedules_quiz_schedule_id_foreign` FOREIGN KEY (`quiz_schedule_id`) REFERENCES `quiz_schedules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_group_quiz_schedules_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_group_users`
--
ALTER TABLE `user_group_users`
  ADD CONSTRAINT `user_group_users_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_group_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
