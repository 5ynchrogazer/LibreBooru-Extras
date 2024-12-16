CREATE TABLE
    comments (
        comment_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each comment
        post_id INT NOT NULL, -- ID of the related post
        user_id INT NOT NULL, -- ID of the user who made the comment
        content TEXT NOT NULL, -- Content of the comment
        last_edited DATETIME DEFAULT NULL, -- Timestamp of the last edit (if applicable)
        deleted BOOLEAN DEFAULT FALSE, -- Indicates if the comment is deleted
        deleted_by INT DEFAULT NULL, -- ID of the user who deleted the comment
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, -- Time of the comment's creation
        CONSTRAINT fk_comments_post_id FOREIGN KEY (post_id) REFERENCES posts (post_id) ON DELETE CASCADE,
        CONSTRAINT fk_comments_user_id FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
        CONSTRAINT fk_comments_deleted_by FOREIGN KEY (deleted_by) REFERENCES users (user_id) ON DELETE SET NULL
    );

CREATE TABLE
    reputation (
        reputation_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each reputation entry
        user_id INT NOT NULL, -- ID of the user receiving reputation
        giver_id INT NOT NULL, -- ID of the user giving reputation
        given ENUM ('+', '-') NOT NULL, -- Reputation type (+ or -)
        comment TEXT DEFAULT NULL, -- Optional comment for the reputation
        deleted BOOLEAN DEFAULT FALSE, -- Indicates if the reputation entry is deleted
        deleted_by INT DEFAULT NULL, -- ID of the user who deleted the reputation
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, -- Time the reputation was given
        CONSTRAINT fk_reputation_user_id FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
        CONSTRAINT fk_reputation_giver_id FOREIGN KEY (giver_id) REFERENCES users (user_id) ON DELETE CASCADE,
        CONSTRAINT fk_reputation_deleted_by FOREIGN KEY (deleted_by) REFERENCES users (user_id) ON DELETE SET NULL
    );

ALTER TABLE users
ADD COLUMN default_rating ENUM (
    'all',
    'safe',
    'safequestionable',
    'safeexplicit',
    'questionable',
    'questionableexplicit',
    'explicit'
) DEFAULT 'safequestionable';

ALTER TABLE users
ADD COLUMN tag_blacklist TEXT DEFAULT NULL;

CREATE TABLE
    comment_votes (
        id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each vote
        comment_id INT NOT NULL, -- ID of the related comment
        user_id INT NOT NULL, -- ID of the user voting
        vote TINYINT NOT NULL, -- The vote value (e.g., 1 for upvote, -1 for downvote)
        CONSTRAINT fk_comment_votes_comment_id FOREIGN KEY (comment_id) REFERENCES comments (comment_id) ON DELETE CASCADE,
        CONSTRAINT fk_comment_votes_user_id FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
    );

CREATE TABLE
    comment_reports (
        report_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each report
        comment_id INT NOT NULL, -- ID of the related comment
        user_id INT NOT NULL, -- ID of the user reporting the comment
        reason VARCHAR(255) NOT NULL, -- Reason for the report
        status ENUM ('reported', 'approved', 'rejected') DEFAULT 'reported', -- Status of the report
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, -- Time the report was created
        CONSTRAINT fk_comment_reports_comment_id FOREIGN KEY (comment_id) REFERENCES comments (comment_id) ON DELETE CASCADE,
        CONSTRAINT fk_comment_reports_user_id FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
    );

ALTER TABLE wiki
ADD COLUMN kofi VARCHAR(255) DEFAULT NULL;

ALTER TABLE wiki_history
ADD COLUMN kofi VARCHAR(255) DEFAULT NULL;