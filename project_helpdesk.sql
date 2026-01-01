-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 01, 2026 at 01:58 PM
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
-- Database: `project_helpdesk`
--

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
(4, '2025_12_30_155847_create_organizations_table', 1),
(5, '2025_12_30_160342_create_vessels_table', 1),
(6, '2025_12_30_160346_create_service_lines_table', 1),
(7, '2025_12_30_160352_create_tickets_table', 1),
(8, '2025_12_30_163427_create_personal_access_tokens_table', 1),
(9, '2026_01_01_090124_add_custom_ticket_number_and_other_fields_to_tickets_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'บริษัท เอเชีย มาริไทม์ จำกัด', '2025-12-31 05:31:07', '2025-12-31 05:31:07'),
(2, 'บริษัท ไทย แทงเกอร์ จำกัด', '2025-12-31 05:31:07', '2025-12-31 05:31:07');

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
(1, 'App\\Models\\User', 2, 'helpdesk-token', '8ce5ccb093182a6656ab0536d2c29749458d607155ce9fd6ed678e236f9cf618', '[\"*\"]', NULL, NULL, '2025-12-31 06:44:40', '2025-12-31 06:44:40'),
(2, 'App\\Models\\User', 2, 'helpdesk-token', 'ece3f53771f0c1aca1196981e9e6a1320cad9b8cc2702f0711c93eb704188a73', '[\"*\"]', NULL, NULL, '2025-12-31 12:05:30', '2025-12-31 12:05:30'),
(3, 'App\\Models\\User', 2, 'helpdesk-token', '9be210a22cb687700a83b427c6dac3d86ae50e0bb315489e5058909259c10531', '[\"*\"]', NULL, NULL, '2025-12-31 12:07:03', '2025-12-31 12:07:03'),
(4, 'App\\Models\\User', 2, 'helpdesk-token', '9a5e13dc0ca6f721d4cfe1e2a079d650b875d15214cae901407dad2ff62ab9c5', '[\"*\"]', NULL, NULL, '2025-12-31 22:50:20', '2025-12-31 22:50:20'),
(5, 'App\\Models\\User', 2, 'helpdesk-token', 'c57df6e92e54de7c6b7a5d9ce1b1da8c5c9069a2dacd4519dbf272f00a5090a8', '[\"*\"]', NULL, NULL, '2025-12-31 23:14:04', '2025-12-31 23:14:04'),
(6, 'App\\Models\\User', 2, 'helpdesk-token', '5f5e38387f85297dc22643e0be591b5bb4910d73046fe07be7fc1baba879989b', '[\"*\"]', NULL, NULL, '2025-12-31 23:56:58', '2025-12-31 23:56:58'),
(7, 'App\\Models\\User', 2, 'helpdesk-token', '0efc22b9171216478287eaee06eb887388092fb07d16a76d8e3ee4cdebc529d8', '[\"*\"]', NULL, NULL, '2026-01-01 02:13:12', '2026-01-01 02:13:12'),
(8, 'App\\Models\\User', 2, 'helpdesk-token', '49a27f09a90aade21bf4ec1ea5de1f482d0fa5d0a590d3f2e808f8580689866e', '[\"*\"]', NULL, NULL, '2026-01-01 03:43:39', '2026-01-01 03:43:39'),
(9, 'App\\Models\\User', 2, 'helpdesk-token', 'f28235887df09a50cdb9924daffd16d2cec5efeffe2ca0984af0928bdb11af9d', '[\"*\"]', NULL, NULL, '2026-01-01 03:44:12', '2026-01-01 03:44:12'),
(10, 'App\\Models\\User', 2, 'helpdesk-token', '89ae5b6f97476fafdd7e9dda87e2206e2d406abbffc32ce7387f98ada953edcf', '[\"*\"]', NULL, NULL, '2026-01-01 03:52:10', '2026-01-01 03:52:10'),
(11, 'App\\Models\\User', 2, 'helpdesk-token', '62cf3074d7063e0c805fe55db78c84d4283cb9eb43a0f77262a4830ac6a25b0c', '[\"*\"]', '2026-01-01 05:19:52', NULL, '2026-01-01 03:59:08', '2026-01-01 05:19:52');

-- --------------------------------------------------------

--
-- Table structure for table `service_lines`
--

CREATE TABLE `service_lines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `service_lines`
--

INSERT INTO `service_lines` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Thailand - Singapore', '2025-12-31 05:31:07', '2025-12-31 05:31:07'),
(2, 'Thailand - Japan', '2025-12-31 05:31:07', '2025-12-31 05:31:07');

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

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_number` varchar(7) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `cc_email` varchar(255) DEFAULT NULL,
  `priority` enum('High','Medium','Low') NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Open',
  `organization_id` bigint(20) UNSIGNED NOT NULL,
  `vessel_id` bigint(20) UNSIGNED NOT NULL,
  `service_line_id` bigint(20) UNSIGNED NOT NULL,
  `assigned_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `ticket_number`, `title`, `description`, `contact_email`, `cc_email`, `priority`, `category`, `status`, `organization_id`, `vessel_id`, `service_line_id`, `assigned_user_id`, `created_at`, `updated_at`) VALUES
(1, NULL, 'เครื่องยนต์มีปัญหา', 'เครื่องยนต์หลักมีเสียงดังผิดปกติระหว่างเดินทาง', 'captain@asiamaritime.com', NULL, 'High', NULL, 'Open', 1, 1, 1, 1, '2025-12-31 05:31:07', '2025-12-31 05:31:07'),
(2, NULL, 'ระบบไฟฟ้าขัดข้อง', 'ไฟในห้องเครื่องดับบ่อย', 'engineer@thaitanker.com', NULL, 'Medium', NULL, 'Open', 2, 2, 2, NULL, '2025-12-31 05:31:07', '2025-12-31 05:31:07'),
(600, '#000600', 'test create ticket', 'testtttttttt', 'test@t.co', 'tu@ccmail.co', 'Medium', NULL, 'Open', 1, 1, 2, NULL, '2026-01-01 02:28:07', '2026-01-01 02:28:07'),
(601, '#000601', 'Test ticket', 'test description test description test description', 't@m.c', 'cc@m.c', 'Medium', 'Fish', 'Open', 1, 1, 1, 2, '2026-01-01 04:41:00', '2026-01-01 04:47:09');

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
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@helpdesk.com', NULL, '$2y$12$BufZGZxUWXgA5y1OnzUFUuzaP/rqMZM3MYhC4rAqlFib600eb97/C', NULL, '2025-12-31 05:31:06', '2025-12-31 05:31:06'),
(2, 'Test User', 'test@helpdesk.com', NULL, '$2y$12$y0EQKCd0sB.uxLg7QA.0/./SeV0yIACUnq6eQR.FpMM3nFXNLQXNS', NULL, '2025-12-31 05:31:07', '2025-12-31 05:31:07');

-- --------------------------------------------------------

--
-- Table structure for table `vessels`
--

CREATE TABLE `vessels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vessels`
--

INSERT INTO `vessels` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'MV Asia Star', '2025-12-31 05:31:07', '2025-12-31 05:31:07'),
(2, 'MV Thai Pride', '2025-12-31 05:31:07', '2025-12-31 05:31:07');

--
-- Indexes for dumped tables
--

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
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

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
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
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
-- Indexes for table `service_lines`
--
ALTER TABLE `service_lines`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tickets_ticket_number_unique` (`ticket_number`),
  ADD KEY `tickets_organization_id_foreign` (`organization_id`),
  ADD KEY `tickets_vessel_id_foreign` (`vessel_id`),
  ADD KEY `tickets_service_line_id_foreign` (`service_line_id`),
  ADD KEY `tickets_assigned_user_id_foreign` (`assigned_user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vessels`
--
ALTER TABLE `vessels`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
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
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `service_lines`
--
ALTER TABLE `service_lines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=602;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vessels`
--
ALTER TABLE `vessels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_assigned_user_id_foreign` FOREIGN KEY (`assigned_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tickets_organization_id_foreign` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_service_line_id_foreign` FOREIGN KEY (`service_line_id`) REFERENCES `service_lines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_vessel_id_foreign` FOREIGN KEY (`vessel_id`) REFERENCES `vessels` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
