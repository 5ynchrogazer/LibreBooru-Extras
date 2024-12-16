-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 16, 2024 at 04:17 PM
-- Server version: 8.0.40-0ubuntu0.24.04.1
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `openbooru`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `last_edited` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` int DEFAULT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comment_reports`
--

CREATE TABLE `comment_reports` (
  `report_id` int NOT NULL,
  `comment_id` int NOT NULL,
  `user_id` int NOT NULL,
  `reason` varchar(255) NOT NULL,
  `status` enum('reported','approved','rejected') DEFAULT 'reported',
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comment_votes`
--

CREATE TABLE `comment_votes` (
  `id` int NOT NULL,
  `comment_id` int NOT NULL,
  `user_id` int NOT NULL,
  `vote` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moderation_log`
--

CREATE TABLE `moderation_log` (
  `log_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `action` enum('delete_post','ban_user','approve_post','edit_tag','approve_post_report','reject_post_report','approve_comment_report','reject_comment_report') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `target_id` int DEFAULT NULL,
  `description` text,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `file_size` int DEFAULT NULL,
  `file_extension` varchar(10) DEFAULT NULL,
  `rating` enum('safe','questionable','explicit') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'questionable',
  `source` varchar(255) DEFAULT NULL,
  `post_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text,
  `is_approved` tinyint(1) DEFAULT '1',
  `approved_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` int DEFAULT NULL,
  `deleted_message` varchar(255) DEFAULT NULL,
  `parent_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_reports`
--

CREATE TABLE `post_reports` (
  `report_id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `reason` varchar(255) NOT NULL,
  `status` enum('reported','approved','rejected') DEFAULT 'reported',
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_votes`
--

CREATE TABLE `post_votes` (
  `id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `vote` tinyint NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `reputation`
--

CREATE TABLE `reputation` (
  `reputation_id` int NOT NULL,
  `user_id` int NOT NULL,
  `giver_id` int NOT NULL,
  `given` enum('+','-') NOT NULL,
  `comment` text,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` int DEFAULT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(255) NOT NULL,
  `user_id` int DEFAULT NULL,
  `ip_address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `tag_id` int NOT NULL,
  `tag_name` varchar(255) NOT NULL,
  `category` enum('copyright','character','artist','general','meta','other') NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `locked_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag_edit_history`
--

CREATE TABLE `tag_edit_history` (
  `id` int NOT NULL,
  `tag_name` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `locked` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag_history`
--

CREATE TABLE `tag_history` (
  `history_id` int NOT NULL,
  `post_id` int DEFAULT NULL,
  `tag_id` int DEFAULT NULL,
  `action` enum('add','remove','stay') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `commit_id` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `registration_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `user_level` int DEFAULT '2',
  `is_banned` tinyint(1) DEFAULT '0',
  `profile_picture` varchar(255) DEFAULT NULL,
  `default_rating` enum('all','safe','safequestionable','safeexplicit','questionable','questionableexplicit','explicit') DEFAULT 'safequestionable',
  `tag_blacklist` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_levels`
--

CREATE TABLE `user_levels` (
  `level_id` int NOT NULL,
  `level_name` varchar(255) NOT NULL,
  `permissions` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_levels`
--

INSERT INTO `user_levels` (`level_id`, `level_name`, `permissions`) VALUES
(1, 'Guest', 'view'),
(2, 'User', 'view, post, vote, comment, tag, wiki, report, judge'),
(3, 'Mod', 'view, post, vote, comment, tag, wiki, moderate, report, judge'),
(4, 'Admin', 'view, post, vote, comment, tag, wiki, moderate, admin, report, judge');

-- --------------------------------------------------------

--
-- Table structure for table `wiki`
--

CREATE TABLE `wiki` (
  `id` int NOT NULL,
  `wiki_term` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `creation_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `pixiv_id` varchar(50) DEFAULT NULL,
  `patreon` varchar(255) DEFAULT NULL,
  `twitter_id` varchar(50) DEFAULT NULL,
  `fanbox_id` varchar(50) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT '0',
  `locked_by` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `kofi` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_history`
--

CREATE TABLE `wiki_history` (
  `id` int NOT NULL,
  `wiki_term` varchar(255) NOT NULL,
  `old_content` text NOT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int NOT NULL,
  `pixiv_id` varchar(50) DEFAULT NULL,
  `patreon` varchar(255) DEFAULT NULL,
  `twitter_id` varchar(50) DEFAULT NULL,
  `fanbox_id` varchar(50) DEFAULT NULL,
  `kofi` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `fk_comments_post_id` (`post_id`),
  ADD KEY `fk_comments_user_id` (`user_id`),
  ADD KEY `fk_comments_deleted_by` (`deleted_by`);

--
-- Indexes for table `comment_reports`
--
ALTER TABLE `comment_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `fk_comment_reports_comment_id` (`comment_id`),
  ADD KEY `fk_comment_reports_user_id` (`user_id`);

--
-- Indexes for table `comment_votes`
--
ALTER TABLE `comment_votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_comment_votes_comment_id` (`comment_id`),
  ADD KEY `fk_comment_votes_user_id` (`user_id`);

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `moderation_log`
--
ALTER TABLE `moderation_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `target_id` (`target_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_deleted_by` (`deleted_by`),
  ADD KEY `fk_approved_by` (`approved_by`),
  ADD KEY `fk_parent_id` (`parent_id`);

--
-- Indexes for table `post_reports`
--
ALTER TABLE `post_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `fk_post_reports_post_id` (`post_id`),
  ADD KEY `fk_post_reports_user_id` (`user_id`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`post_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `post_votes`
--
ALTER TABLE `post_votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reputation`
--
ALTER TABLE `reputation`
  ADD PRIMARY KEY (`reputation_id`),
  ADD KEY `fk_reputation_user_id` (`user_id`),
  ADD KEY `fk_reputation_giver_id` (`giver_id`),
  ADD KEY `fk_reputation_deleted_by` (`deleted_by`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `tag_name` (`tag_name`),
  ADD KEY `fk_locked_by_tags` (`locked_by`);

--
-- Indexes for table `tag_edit_history`
--
ALTER TABLE `tag_edit_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tag_history`
--
ALTER TABLE `tag_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `tag_id` (`tag_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_levels`
--
ALTER TABLE `user_levels`
  ADD PRIMARY KEY (`level_id`);

--
-- Indexes for table `wiki`
--
ALTER TABLE `wiki`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wiki_term` (`wiki_term`),
  ADD KEY `fk_locked_by` (`locked_by`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- Indexes for table `wiki_history`
--
ALTER TABLE `wiki_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_wiki_term` (`wiki_term`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comment_reports`
--
ALTER TABLE `comment_reports`
  MODIFY `report_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comment_votes`
--
ALTER TABLE `comment_votes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favourites`
--
ALTER TABLE `favourites`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `moderation_log`
--
ALTER TABLE `moderation_log`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_reports`
--
ALTER TABLE `post_reports`
  MODIFY `report_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_votes`
--
ALTER TABLE `post_votes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reputation`
--
ALTER TABLE `reputation`
  MODIFY `reputation_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tag_edit_history`
--
ALTER TABLE `tag_edit_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tag_history`
--
ALTER TABLE `tag_history`
  MODIFY `history_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_levels`
--
ALTER TABLE `user_levels`
  MODIFY `level_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `wiki`
--
ALTER TABLE `wiki`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wiki_history`
--
ALTER TABLE `wiki_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_comments_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `comment_reports`
--
ALTER TABLE `comment_reports`
  ADD CONSTRAINT `fk_comment_reports_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comment_reports_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `comment_votes`
--
ALTER TABLE `comment_votes`
  ADD CONSTRAINT `fk_comment_votes_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comment_votes_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `favourites`
--
ALTER TABLE `favourites`
  ADD CONSTRAINT `favourites_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favourites_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `moderation_log`
--
ALTER TABLE `moderation_log`
  ADD CONSTRAINT `moderation_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `moderation_log_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `posts` (`post_id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `posts` (`post_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `post_reports`
--
ALTER TABLE `post_reports`
  ADD CONSTRAINT `fk_post_reports_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_post_reports_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD CONSTRAINT `post_tags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE;

--
-- Constraints for table `post_votes`
--
ALTER TABLE `post_votes`
  ADD CONSTRAINT `post_votes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_votes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `reputation`
--
ALTER TABLE `reputation`
  ADD CONSTRAINT `fk_reputation_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_reputation_giver_id` FOREIGN KEY (`giver_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reputation_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `tags`
--
ALTER TABLE `tags`
  ADD CONSTRAINT `fk_locked_by_tags` FOREIGN KEY (`locked_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `tag_edit_history`
--
ALTER TABLE `tag_edit_history`
  ADD CONSTRAINT `tag_edit_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `tag_history`
--
ALTER TABLE `tag_history`
  ADD CONSTRAINT `tag_history_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tag_history_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tag_history_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `wiki`
--
ALTER TABLE `wiki`
  ADD CONSTRAINT `fk_locked_by` FOREIGN KEY (`locked_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `wiki_history`
--
ALTER TABLE `wiki_history`
  ADD CONSTRAINT `wiki_history_ibfk_1` FOREIGN KEY (`wiki_term`) REFERENCES `wiki` (`wiki_term`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
