-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 01, 2025 at 07:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lmsmukrap`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

CREATE TABLE `assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `instructions` text DEFAULT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `teacher_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('HOMEWORK','QUIZ','EXAM','PROJECT','PRESENTATION') NOT NULL,
  `max_points` int(11) NOT NULL DEFAULT 100,
  `due_date` datetime NOT NULL,
  `available_from` datetime DEFAULT NULL,
  `available_until` datetime DEFAULT NULL,
  `allow_late_submission` tinyint(1) NOT NULL DEFAULT 0,
  `late_penalty_percent` int(11) NOT NULL DEFAULT 0,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `submission_instructions` text DEFAULT NULL,
  `submission_type` enum('FILE','TEXT','BOTH') NOT NULL DEFAULT 'BOTH',
  `is_published` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `marked_by` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `status` enum('PRESENT','ABSENT','LATE','EXCUSED') NOT NULL DEFAULT 'PRESENT',
  `check_in_time` time DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `grade_level` varchar(255) NOT NULL,
  `class_code` varchar(255) NOT NULL,
  `teacher_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `max_students` int(11) NOT NULL DEFAULT 30,
  `room` varchar(255) DEFAULT NULL,
  `schedule` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`schedule`)),
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `class_enrollments`
--

CREATE TABLE `class_enrollments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `enrolled_by` bigint(20) UNSIGNED NOT NULL,
  `enrolled_at` datetime NOT NULL,
  `dropped_at` datetime DEFAULT NULL,
  `status` enum('ACTIVE','DROPPED','COMPLETED') NOT NULL DEFAULT 'ACTIVE',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `assignment_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `graded_by` bigint(20) UNSIGNED DEFAULT NULL,
  `points_earned` decimal(8,2) DEFAULT NULL,
  `points_possible` decimal(8,2) NOT NULL,
  `percentage` decimal(5,2) DEFAULT NULL,
  `letter_grade` varchar(2) DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `submission_files` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`submission_files`)),
  `submission_text` text DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `graded_at` datetime DEFAULT NULL,
  `status` enum('NOT_SUBMITTED','SUBMITTED','GRADED','LATE','MISSING') NOT NULL DEFAULT 'NOT_SUBMITTED',
  `is_late` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_08_30_150815_create_personal_access_tokens_table', 1),
(5, '2025_08_30_150824_create_classes_table', 1),
(6, '2025_08_30_150829_create_assignments_table', 1),
(7, '2025_08_30_150840_create_grades_table', 1),
(8, '2025_08_30_150845_create_attendance_table', 1),
(9, '2025_08_30_150850_create_class_enrollments_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', 'c2f372950574ad1f02f8dc235a5d5071fa7ba277a148865933c369c451cc881a', '[\"*\"]', NULL, NULL, '2025-08-30 09:29:30', '2025-08-30 09:29:30'),
(2, 'App\\Models\\User', 1, 'auth_token', 'a0ba34be46a771065706f0c6fe70dd5ca95658e2d889c41cff493f95e7111d3c', '[\"*\"]', NULL, NULL, '2025-08-30 09:37:45', '2025-08-30 09:37:45'),
(3, 'App\\Models\\User', 1, 'auth_token', 'f2e317e0c1057f7a5fc0d6e06c3f6968370a60d923f5218851a703328d3da513', '[\"*\"]', NULL, NULL, '2025-08-30 09:44:42', '2025-08-30 09:44:42'),
(4, 'App\\Models\\User', 1, 'auth_token', 'fe05f532d72df3c8aa033b00cd2d6e00a05cf15c75e9d5bcddb9151ca6676fe3', '[\"*\"]', NULL, NULL, '2025-08-30 09:47:43', '2025-08-30 09:47:43'),
(5, 'App\\Models\\User', 1, 'auth_token', 'aac988963b96e9e8c3a3d8c0937f676013f0435590d31e12f3a53cdb681dad8c', '[\"*\"]', NULL, NULL, '2025-08-30 09:51:38', '2025-08-30 09:51:38'),
(6, 'App\\Models\\User', 1, 'auth_token', 'b0f403b38d06f537431b68646a87154aac6146e558803fbef01f9e5e9d6a8bb6', '[\"*\"]', '2025-08-30 09:51:46', NULL, '2025-08-30 09:51:46', '2025-08-30 09:51:46'),
(7, 'App\\Models\\User', 1, 'auth_token', '24f53a2ceeaf61497a98342c2932dbc9e25efd83cdda1852b7b59209724620ee', '[\"*\"]', NULL, NULL, '2025-08-30 10:27:47', '2025-08-30 10:27:47'),
(8, 'App\\Models\\User', 1, 'auth_token', 'ed240bfe977f51b15d37584d45cb58ae4f22b258019cadc05bf21fc0dfc2b0cf', '[\"*\"]', NULL, NULL, '2025-08-30 10:31:44', '2025-08-30 10:31:44'),
(9, 'App\\Models\\User', 1, 'auth_token', 'd327ac8422c58a94ed3daf8fd172368cb3e54eddcb2399291964ad00a104553e', '[\"*\"]', NULL, NULL, '2025-08-30 10:40:25', '2025-08-30 10:40:25'),
(10, 'App\\Models\\User', 1, 'auth_token', 'ed0f03872f72af48316429cecdf6c3ddc1dce6806704440315fd33abdedd47b1', '[\"*\"]', NULL, NULL, '2025-08-30 10:44:56', '2025-08-30 10:44:56'),
(11, 'App\\Models\\User', 1, 'auth_token', 'ead17cffcd4846ea17ff8a58e3057c0ef8f27df478865137701e55a90037b481', '[\"*\"]', NULL, NULL, '2025-08-30 10:47:47', '2025-08-30 10:47:47'),
(12, 'App\\Models\\User', 1, 'auth_token', '67fa402d70dc8d691afc39b12e5ef725a3cd6b76e694a9f21732c4490cb7d4d1', '[\"*\"]', NULL, NULL, '2025-08-30 10:51:55', '2025-08-30 10:51:55'),
(13, 'App\\Models\\User', 1, 'auth_token', 'e4ebc955923188e243d8c6263bb32224b0b39c489b6b82a784d17ba7aab940e4', '[\"*\"]', '2025-08-30 11:09:26', NULL, '2025-08-30 10:58:27', '2025-08-30 11:09:26'),
(15, 'App\\Models\\User', 1, 'auth_token', 'f1cd5857df1aed04aead59b565b671a8fe2a090ae7edbee72c339e503aef2ada', '[\"*\"]', '2025-08-30 11:15:10', NULL, '2025-08-30 11:09:48', '2025-08-30 11:15:10'),
(16, 'App\\Models\\User', 1, 'auth_token', '669eb0a80d383e279bf8ceef887c1567aa9943e954d626d889004fc5563d4ecc', '[\"*\"]', '2025-08-30 11:11:08', NULL, '2025-08-30 11:10:45', '2025-08-30 11:11:08'),
(17, 'App\\Models\\User', 1, 'auth_token', '7b3863fe190ea65eede715446b93deb796fec5da6d930177192150e488f0c19b', '[\"*\"]', NULL, NULL, '2025-08-31 08:47:18', '2025-08-31 08:47:18'),
(18, 'App\\Models\\User', 1, 'auth_token', '5068cd7f3eb41c6e262a49d51970e05ac861917b29488ffd2da6d8ceea843c82', '[\"*\"]', '2025-08-31 11:05:52', NULL, '2025-08-31 08:47:53', '2025-08-31 11:05:52'),
(20, 'App\\Models\\User', 1, 'auth_token', 'f52959f9a8d9a727f67e7251ce239f300ba6b1c344ef71d93f523d31f14a229f', '[\"*\"]', '2025-08-31 10:14:59', NULL, '2025-08-31 08:50:09', '2025-08-31 10:14:59'),
(21, 'App\\Models\\User', 42, 'auth_token', '4ca16d99e39b41a0ce8ad96305501faebf069af01b2557738539611b9bae25f2', '[\"*\"]', NULL, NULL, '2025-08-31 10:28:05', '2025-08-31 10:28:05'),
(22, 'App\\Models\\User', 43, 'auth_token', 'a7ea2c3702ce73f9675cfa8781feae6e9544cedad31916e8ab6196f4772f87b6', '[\"*\"]', NULL, NULL, '2025-08-31 10:28:11', '2025-08-31 10:28:11'),
(24, 'App\\Models\\User', 43, 'auth_token', '12ac862720886be96e57100e7182ae343a6a234ae2af73ff54bef3847251856b', '[\"*\"]', '2025-08-31 11:09:38', NULL, '2025-08-31 11:09:21', '2025-08-31 11:09:38'),
(26, 'App\\Models\\User', 1, 'auth_token', '72b98ae2dda94952a2340632cf37f61e710bf749331cffab5ccb15fa6be29ab9', '[\"*\"]', '2025-09-01 10:08:58', NULL, '2025-09-01 08:27:30', '2025-09-01 10:08:58');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('6cStAFJOz58jsV9RwnZHv3xI3sJp432TxbRaSsCy', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ0s2Mm83RU9hTklOTHYyTnpiektDNjRkamlET2FLdjBXTjRRQ083VSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYXV0aC9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756571589),
('bSbSUDd8NGXpAtpryIYDt10j46hzPaBajn25Y5oS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEFkelV0UzFIZFlaaE52Y3NnRHdVNWx6eEpFWmhGNnV5emhERGw5MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYXV0aC9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756571957),
('InEoUnuuJyrPwjWOhi8TMYOdIa7VjBO4WIwKm4mb', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; id-ID) WindowsPowerShell/5.1.26100.4768', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTW5EVGlSRmRSOGM0S0IySGJaMkpVczdaTFpJenJLZ29kOVBlaDB5QiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zYW5jdHVtL2NzcmYtY29va2llIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1756571779),
('k8g2uXQpbDunw0TAoYYhZzU5Rpqf0t6Nti8GN2HZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRGpHZU9tVGxEc1VzMW9uaFlwMTFyUldHQ3ZVaTJuaEZVTjBKMVpHMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYXV0aC9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756571588),
('LoFFCZq5bHetMmzlGGVSoXFovPz4kDCKTAENEDDm', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Trae/1.100.3 Chrome/132.0.6834.210 Electron/34.5.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiem1rQUI1c01DTnNGR1VSa3BwMHNOZDNSNU1sZHZRRXNxU1NDd0F0RCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYXV0aC9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756571886),
('nksa9D7FECwUFMqrKQYFjY7DRTb2GDsA3X5oj0Mv', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid1lIb1Y4UWxHVEVVY25JaHMxY3ROOGFOS2tLTkJYZ09hblppMVd1WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYXV0aC9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756571588),
('pFYTcKxgsWDpKq9n0vcE600u21FlCmWuChU9isA4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiamFqNmU5V3E5QnNqU0pQMjZ5RnR5NFAxZUhSem9xU3J0RmFIbkxxbyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1756571480),
('qDvhgEwy3ndelSAGv21ICUvx8l5CdVPBcxmHjHP7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Trae/1.100.3 Chrome/132.0.6834.210 Electron/34.5.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNXNuOG81THAxVEZhTnBvWVlHdWdTaFdZc2lwNDJoSW5vbnd6dGpTUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYXV0aC9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756572358),
('qmDRqmh4Jhgw4t0qWMDFr7sj0hWqSep3vrxp9Qo0', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; id-ID) WindowsPowerShell/5.1.26100.4768', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiejNkNm9CNlhMS2dJUFhNeTg4cjZSVTF1bWNFZGszN295ODg1RlpJaiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1756572395),
('rghF8wbyHnw8mDa4JmsjVcgfLu2KqY9rSWSDkp5S', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Trae/1.100.3 Chrome/132.0.6834.210 Electron/34.5.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWFFSZU10OVRRSm44dUZCOWhxNUM2UjB4ZjNTOWVGd2ZOaGpVN051TSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYXV0aC9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756571886),
('V19CR8FzQd43LO0FOI26Wh3grVeIzZFOaIsCWn3d', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidkVib1FIbTkwaTZLWXZvd3AxTU9JdmlqVHIwZGg1QjlEeFBwUENsQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756575758),
('y6WuGP3KXit5O8Pbi8nUHgy4WTkwRrLgcetd4NEU', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; id-ID) WindowsPowerShell/5.1.26100.4768', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMXFPVW56S1d2NlhUd2o0YTRjSWhiMjJxYjdZeVVEME1wSGJxcVJoYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zYW5jdHVtL2NzcmYtY29va2llIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1756571786),
('ZaTMVa9zc3VwM0EYF4wKsiyifeHYBJOMok2HsBWz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Trae/1.100.3 Chrome/132.0.6834.210 Electron/34.5.1 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOENtMlhvM290MWpsN0xRNk9DbEpkZ3g4SEl6MXFEOGI3VW5nMlZ5ZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYXV0aC9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1756571886);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('SUPER_ADMIN','TEACHER','STUDENT') NOT NULL DEFAULT 'STUDENT',
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('MALE','FEMALE') DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  `teacher_id` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `phone`, `address`, `date_of_birth`, `gender`, `student_id`, `teacher_id`, `profile_picture`, `is_active`, `last_login_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin Demo', 'admin@smamuh1sleman.sch.id', '2025-08-31 10:26:56', '$2y$12$0Vv9naLKUn5BMJLZLdmh7.Y2zD2mlQIMrr/LZ31g9U64BR4RXPDxW', 'SUPER_ADMIN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-09-01 08:37:42', NULL, '2025-08-30 09:29:11', '2025-09-01 08:37:42'),
(2, 'Teacher User', 'teacher@smamuh1sleman.sch.id', NULL, '$2y$12$hIguLYpylUydRDuuEl.71e1UNiKYU9cixLqc1CQLgTL.GKhEubasW', 'TEACHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-30 09:29:11', '2025-08-30 09:29:11'),
(3, 'Student User', 'student@smamuh1sleman.sch.id', NULL, '$2y$12$8QAca1iLUoeGx73qiNQwBeem/byqIsegmvJDGCfFuxS8ucD.GEUJG', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-30 09:29:11', '2025-08-30 09:29:11'),
(7, 'Admin User', 'admin@lms.com', '2025-08-31 10:22:09', '$2y$12$i12UWxMywY0s6hfmqroZzuaVhVYlspKXocTG3kE03quBgJ9B7oBp2', 'SUPER_ADMIN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:09', '2025-08-31 10:22:09'),
(8, 'Dr. Sarah Johnson', 'sarah.johnson@lms.com', '2025-08-31 10:22:09', '$2y$12$rPtvlkj.AribaKHIOUgShesch7WS20vDQaRTHccfn6eI53fB8lE9O', 'TEACHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:09', '2025-08-31 10:22:09'),
(9, 'Prof. Michael Chen', 'michael.chen@lms.com', '2025-08-31 10:22:09', '$2y$12$qoEybh.F6K5JuhTpDSu4K.IN/Pe628Warbp3PUByz8fUHTB2yuQm2', 'TEACHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:09', '2025-08-31 10:22:09'),
(10, 'Dr. Emily Rodriguez', 'emily.rodriguez@lms.com', '2025-08-31 10:22:09', '$2y$12$pc6dFYKIgp9XIeajbUfYiemB8EHn3xAE1WfMD7MlE2wMCm8SJfZji', 'TEACHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:09', '2025-08-31 10:22:09'),
(11, 'Prof. David Wilson', 'david.wilson@lms.com', '2025-08-31 10:22:10', '$2y$12$UUW8ir5Kb4cNI4RGnVDFs.41kmO6f2un9IyBMT4wJepxPga1QbHdW', 'TEACHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:10', '2025-08-31 10:22:10'),
(12, 'Dr. Lisa Anderson', 'lisa.anderson@lms.com', '2025-08-31 10:22:10', '$2y$12$kB17RwCS1n40oPBOGu0Ege2g8IItpkDKO7lmYcjbbmF.0wLH9uHFO', 'TEACHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:10', '2025-08-31 10:22:10'),
(13, 'Prof. James Brown', 'james.brown@lms.com', '2025-08-31 10:22:10', '$2y$12$i6RgohtgS.5zTNU7Y3TrBOTfGhXH2VKlevrcNqdTg0/BakO5z8dwC', 'TEACHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:10', '2025-08-31 10:22:10'),
(14, 'Dr. Maria Garcia', 'maria.garcia@lms.com', '2025-08-31 10:22:10', '$2y$12$QJINq82w7r3TeK7yrJxO5eOzDH.i56EfVM.t8F4bH.YGrRWJaOBn.', 'TEACHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:10', '2025-08-31 10:22:10'),
(15, 'Prof. Robert Taylor', 'robert.taylor@lms.com', '2025-08-31 10:22:10', '$2y$12$tjvyLffz7TXbWbe2cu9.puLTq/8Ftxp5xAvK5R6BFwIP7IhUsEGxW', 'TEACHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:10', '2025-08-31 10:22:10'),
(16, 'Alice Cooper', 'alice.cooper@student.lms.com', '2025-08-31 10:22:11', '$2y$12$KUqszs7GxhDGUcML9T67BOzU5h5.Ik5zSJ4Pxqku9cpJkq.hj1raW', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:11', '2025-08-31 10:22:11'),
(17, 'Bob Smith', 'bob.smith@student.lms.com', '2025-08-31 10:22:11', '$2y$12$/uINaXKRmLrH8LYOuBWKm./QW.8QsrgWqnu.1WF8v7wIIms/0jnvq', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:11', '2025-08-31 10:22:11'),
(18, 'Charlie Davis', 'charlie.davis@student.lms.com', '2025-08-31 10:22:11', '$2y$12$nWF466YDMtdrklkdF8939epDnn5IaFlsvhSRpFyCgazSKX8iCl/rm', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:11', '2025-08-31 10:22:11'),
(19, 'Diana Prince', 'diana.prince@student.lms.com', '2025-08-31 10:22:11', '$2y$12$URbj9mDzDW/JoiGD5kqHYOS0lw1CLIuNVreQVt8L4STFxb3tU557K', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:11', '2025-08-31 10:22:11'),
(20, 'Edward Norton', 'edward.norton@student.lms.com', '2025-08-31 10:22:11', '$2y$12$OQ1tEfpY2jfIDkGpMgxtNesSWqnbdkC5yvW2bOS6ToY5hF9h5W6pG', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:11', '2025-08-31 10:22:11'),
(21, 'Fiona Green', 'fiona.green@student.lms.com', '2025-08-31 10:22:12', '$2y$12$1NGYV7vvl.7r/nVqT2FiK.9.I7L7VMx./vXOtUdzPKemjPXD9J3mS', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:12', '2025-08-31 10:22:12'),
(22, 'George Miller', 'george.miller@student.lms.com', '2025-08-31 10:22:12', '$2y$12$HkCrl0zIyN0YCeToMl1VIOo91sgNJZv7bGMuRRuD0EUvkCQxUq/mi', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:12', '2025-08-31 10:22:12'),
(23, 'Hannah White', 'hannah.white@student.lms.com', '2025-08-31 10:22:12', '$2y$12$NF53WDAxtckPAm8r9dpX7Ol3lBxCQChLPdDYH5nshvmfxdJbQnqES', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:12', '2025-08-31 10:22:12'),
(24, 'Ian Black', 'ian.black@student.lms.com', '2025-08-31 10:22:12', '$2y$12$LOtpQiLUGt4WnY5wfRehTOyJYuEsafKYZkxkxcwELka5ucHgS9sf2', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:12', '2025-08-31 10:22:12'),
(25, 'Julia Roberts', 'julia.roberts@student.lms.com', '2025-08-31 10:22:12', '$2y$12$gaji6zwWWx0W0OVActXjKeFbyyRd4Y8ngW.QTVwqn6UubP4yHFhtK', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:12', '2025-08-31 10:22:12'),
(26, 'Kevin Hart', 'kevin.hart@student.lms.com', '2025-08-31 10:22:13', '$2y$12$wyaphT.a8aO6qnZPp3B0X.ZTST7hN9hg.OfSDIvwdK8962hHIfOw.', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:13', '2025-08-31 10:22:13'),
(27, 'Laura Palmer', 'laura.palmer@student.lms.com', '2025-08-31 10:22:13', '$2y$12$vctW0zwMzvr9xVoTcDNpY.HGLfsgZ60lGeIOpiIRXNauptyOk2YLq', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:13', '2025-08-31 10:22:13'),
(28, 'Mark Johnson', 'mark.johnson@student.lms.com', '2025-08-31 10:22:13', '$2y$12$eX7vHFPyp97MXEgEJH1.H.mUpNvyN0AAQikQxWBbVQM3S31hHlIR6', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:13', '2025-08-31 10:22:13'),
(29, 'Nina Williams', 'nina.williams@student.lms.com', '2025-08-31 10:22:13', '$2y$12$tCmh8P1wFJWQfprAfbRjPe5dpUz6Egt17hqRT4lWgpiT8MZxga85.', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:13', '2025-08-31 10:22:13'),
(30, 'Oscar Martinez', 'oscar.martinez@student.lms.com', '2025-08-31 10:22:14', '$2y$12$iWQCOHcMiNx3GtOd/aCNTOu8sCUOK.uXZe3I8mP/BKZutduGKT1Aq', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:14', '2025-08-31 10:22:14'),
(31, 'Paula Abdul', 'paula.abdul@student.lms.com', '2025-08-31 10:22:14', '$2y$12$Ot1hhmes21.NmOTkKZyM1eu0MJJVn27WVGyTh04nE6kwGBZkMyBTi', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:14', '2025-08-31 10:22:14'),
(32, 'Quinn Fabray', 'quinn.fabray@student.lms.com', '2025-08-31 10:22:14', '$2y$12$MoZX1xP6arrcLjX5xOgQ2eZXqt4UwxFoQd.LtNJ5kI.AVrNPVF.rW', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:14', '2025-08-31 10:22:14'),
(33, 'Rachel Green', 'rachel.green@student.lms.com', '2025-08-31 10:22:14', '$2y$12$Xhcb4JDRCsRhGE3gfRB2/uCbjNTPEobXI61ny.G0EbXXt/YetDP6O', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:14', '2025-08-31 10:22:14'),
(34, 'Steve Rogers', 'steve.rogers@student.lms.com', '2025-08-31 10:22:14', '$2y$12$9JIHHHY5ytuy45qTqSI3MuoLlWUTCMWi5niTaNaR.KWP/d04Afnc2', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:14', '2025-08-31 10:22:14'),
(35, 'Tina Turner', 'tina.turner@student.lms.com', '2025-08-31 10:22:15', '$2y$12$ZvV0RROsjkIKdv2Dluk10eRW/oesQ0UzlJtRA8Mf9l7UYytDcK0TO', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:15', '2025-08-31 10:22:15'),
(36, 'Uma Thurman', 'uma.thurman@student.lms.com', '2025-08-31 10:22:15', '$2y$12$UplH8K0CEWrB.v8j7kpRwOjmT7NG0f6sz/6CfOP7rVYx.ye0VlgNK', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:15', '2025-08-31 10:22:15'),
(37, 'Victor Hugo', 'victor.hugo@student.lms.com', '2025-08-31 10:22:15', '$2y$12$.IVZQGOvX04xrgeSqKBtkeyzMrGnH8zPi1Ui8EjubUNmZ7qh/9p86', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:15', '2025-08-31 10:22:15'),
(38, 'Wendy Darling', 'wendy.darling@student.lms.com', '2025-08-31 10:22:15', '$2y$12$usGh27PRQHtabqA4XFOygOC4dPxmNmhEb0TIQfGV3qTUFgIzD5rvS', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:15', '2025-08-31 10:22:15'),
(39, 'Xavier Woods', 'xavier.woods@student.lms.com', '2025-08-31 10:22:15', '$2y$12$iIg6B/yp7R92kNfG.j95X./sSC/e0GjDSvoOMtX3Kcrw6Y9oAUMMq', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:15', '2025-08-31 10:22:15'),
(40, 'Yara Shahidi', 'yara.shahidi@student.lms.com', '2025-08-31 10:22:16', '$2y$12$.PRnvoraJGCZgi2Kk0uye.SLJK8kr33N1ygUvzCWWGymXYFZe9IMy', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:16', '2025-08-31 10:22:16'),
(41, 'Zoe Saldana', 'zoe.saldana@student.lms.com', '2025-08-31 10:22:16', '$2y$12$LHkw1Xa1nm1JmnXfopdddOX9vIjVIFDsSx7vDPoy9AztcDEDhTrH.', 'STUDENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-08-31 10:22:16', '2025-08-31 10:22:16'),
(42, 'Guru Demo', 'guru@smamuh1sleman.sch.id', '2025-08-31 10:26:56', '$2y$12$rX8AOBlP/vZxwEhYpXAWmeYN3C8pB.QAl0jIawWDVgvOjb7LUfD7W', 'TEACHER', NULL, NULL, NULL, NULL, NULL, 'DEMO_TEACHER_001', NULL, 1, '2025-08-31 10:28:57', NULL, '2025-08-31 10:26:56', '2025-08-31 10:28:57'),
(43, 'Siswa Demo', 'siswa@smamuh1sleman.sch.id', '2025-08-31 10:26:56', '$2y$12$s4Y4JAo7w8Jfl.QiLVZtuexH2.yvTE8/BMvOR9StMNRMSDKkwGUI2', 'STUDENT', NULL, NULL, NULL, NULL, 'DEMO_STUDENT_001', NULL, NULL, 1, '2025-09-01 08:44:57', NULL, '2025-08-31 10:26:56', '2025-09-01 08:44:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignments_class_id_foreign` (`class_id`),
  ADD KEY `assignments_teacher_id_foreign` (`teacher_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attendance_class_id_student_id_date_unique` (`class_id`,`student_id`,`date`),
  ADD KEY `attendance_student_id_foreign` (`student_id`),
  ADD KEY `attendance_marked_by_foreign` (`marked_by`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `classes_class_code_unique` (`class_code`),
  ADD KEY `classes_teacher_id_foreign` (`teacher_id`),
  ADD KEY `classes_created_by_foreign` (`created_by`);

--
-- Indexes for table `class_enrollments`
--
ALTER TABLE `class_enrollments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `class_enrollments_class_id_student_id_unique` (`class_id`,`student_id`),
  ADD KEY `class_enrollments_student_id_foreign` (`student_id`),
  ADD KEY `class_enrollments_enrolled_by_foreign` (`enrolled_by`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `grades_assignment_id_student_id_unique` (`assignment_id`,`student_id`),
  ADD KEY `grades_student_id_foreign` (`student_id`),
  ADD KEY `grades_graded_by_foreign` (`graded_by`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_student_id_unique` (`student_id`),
  ADD UNIQUE KEY `users_teacher_id_unique` (`teacher_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `class_enrollments`
--
ALTER TABLE `class_enrollments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `assignments_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assignments_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendance_marked_by_foreign` FOREIGN KEY (`marked_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendance_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `classes_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `class_enrollments`
--
ALTER TABLE `class_enrollments`
  ADD CONSTRAINT `class_enrollments_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `class_enrollments_enrolled_by_foreign` FOREIGN KEY (`enrolled_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `class_enrollments_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `grades_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `grades_graded_by_foreign` FOREIGN KEY (`graded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `grades_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
