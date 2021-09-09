-- output single row and column with avrage energy of drakes songs

SELECT AVG(energy) FROM songs WHERE artist_id = (SELECT id FROM artists WHERE name = "Drake");