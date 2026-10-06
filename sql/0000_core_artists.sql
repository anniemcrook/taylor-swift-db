-- Bootstrap: the handful of artists so foundational to the catalog
-- that nearly every dated seed file looks them up by name without
-- ever inserting them fresh. On a clean rebuild they need to exist
-- before any of the 20XX_*.sql files run — hence the 0000 prefix,
-- sorting ahead of everything else including the 0001/0002 schema
-- migrations.

INSERT INTO artists (name) VALUES ('Taylor Swift');
INSERT INTO artists (name) VALUES ('Max Martin');
INSERT INTO artists (name) VALUES ('Shellback');
INSERT INTO artists (name) VALUES ('Nathan Chapman');
