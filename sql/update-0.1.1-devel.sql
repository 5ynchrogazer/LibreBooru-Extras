-- Check if parent_id column exists
SET @column_exists = (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'posts' AND COLUMN_NAME = 'parent_id'
);

-- Add column and constraint if they don't exist
IF @column_exists = 0 THEN
    ALTER TABLE posts
    ADD COLUMN parent_id INT, -- ID of the parent post
    ADD CONSTRAINT fk_parent_id FOREIGN KEY (parent_id) REFERENCES posts(id) ON DELETE SET NULL;
END IF;
