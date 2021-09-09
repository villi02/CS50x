-- output list of name of songs where the artist is Post Malone

SELECT name FROM songs WHERE artist_id = (SELECT id FROM artists WHERE name = "Post Malone");