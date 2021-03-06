
--creating a copy of the database so that we dont break the the production db 
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;

--create the authors table
CREATE TABLE authors (id SERIAL PRIMARY KEY, name VARCHAR(255));

--selects all of the authors
INSERT INTO authors(name) SELECT DISTINCT author FROM books;

-- create a column author_db which will be used to realte to the author table
ALTER TABLE books ADD COLUMN author_id INT;

-- insert the id into the book tablew form the author table where the author name matfhes the author column
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;

-- deletes the author column from book since we no longer need it
ALTER TABLE books DROP COLUMN author;

--this command adds a function the requires the coluimn of author_id to always be set to a real id from the authors table and permantently ties them together
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);