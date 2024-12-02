-- Adding a parent_id column to the posts table for parent and child posts
ALTER TABLE posts
ADD COLUMN parent_id INT, -- ID of the parent post
ADD CONSTRAINT fk_parent_id FOREIGN KEY (parent_id) REFERENCES posts (post_id) ON DELETE SET NULL;

CREATE TABLE post_reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each report
    post_id INT NOT NULL,                     -- ID of the reported post
    user_id INT NOT NULL,                     -- ID of the user making the report
    reason VARCHAR(255) NOT NULL,             -- Reason for the report
    status ENUM('reported', 'approved', 'rejected') DEFAULT 'reported', -- Status of the report
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, -- Time of the report
    CONSTRAINT fk_post_reports_post_id FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    CONSTRAINT fk_post_reports_user_id FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
