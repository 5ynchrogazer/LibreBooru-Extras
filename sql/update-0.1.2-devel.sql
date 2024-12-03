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