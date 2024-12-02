-- Adding a parent_id column to the posts table for parent and child posts
ALTER TABLE posts
ADD COLUMN parent_id INT, -- ID of the parent post
ADD CONSTRAINT fk_parent_id FOREIGN KEY (parent_id) REFERENCES posts (post_id) ON DELETE SET NULL;

ALTER TABLE favourites
ADD COLUMN test INT;