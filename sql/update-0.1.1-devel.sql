-- Check if parent_id column exists
SELECT COUNT(*) AS column_exists
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'posts' AND COLUMN_NAME = 'parent_id';

-- Add parent_id column and constraint if needed
ALTER TABLE posts
ADD COLUMN IF NOT EXISTS parent_id INT;

-- Add foreign key constraint if needed
ALTER TABLE posts
ADD CONSTRAINT IF NOT EXISTS fk_parent_id FOREIGN KEY (parent_id) REFERENCES posts(id) ON DELETE SET NULL;
