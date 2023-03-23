
-- Listar las pistas (tabla Track) con precio mayor o igual a 1€ 
SELECT T.Name 
FROM dbo.Track T
WHERE T.UnitPrice >1

-- Listar las pistas de más de 4 minutos de duración 
SELECT T.Name 
FROM dbo.Track T
WHERE T.Milliseconds >240000

-- Listar las pistas que tengan entre 2 y 3 minutos de duración 
SELECT T.Name 
FROM dbo.Track T
WHERE T.Milliseconds BETWEEN 120000 AND 180000

-- Listar las pistas que uno de sus compositores (columna Composer) sea Mercury 
SELECT T.Name, t.Composer 
FROM dbo.Track T
WHERE T.Composer LIKE '%Mercury%'

-- Calcular la media de duración de las pistas (Track) de la plataforma 
SELECT AVG(T.Milliseconds) AS Media
FROM dbo.Track T;

-- Listar los clientes (tabla Customer) de USA, Canada y Brazil
SELECT C.FirstName, C.LastName
FROM dbo.Customer C
WHERE C.Country IN ('USA', 'Canada', 'Brazil')

-- Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')
SELECT T.Name, A.Name 
FROM dbo.Track T
INNER JOIN dbo.Artist A
ON T.Composer = A.Name
WHERE A.Name = 'Queen'

-- Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie
SELECT T.Composer, T.Name
FROM dbo.Track T
WHERE T.Composer LIKE '%David Bowie%' 

-- Listar las pistas de la playlist 'Heavy Metal Classic'
SELECT T.Name
FROM dbo.Track T
INNER JOIN dbo.PlaylistTrack PT
ON PT.TrackId = T.TrackId
INNER JOIN DBO.Playlist P
ON PT.PlaylistId = P.PlaylistId
WHERE P.Name = 'Heavy Metal Classic'

-- Listar las playlist junto con el número de pistas que contienen
SELECT P.Name, COUNT(T.Name)
FROM dbo.Track T
INNER JOIN dbo.PlaylistTrack PT
ON PT.TrackId = T.TrackId
INNER JOIN dbo.Playlist P
on  P.PlaylistId = PT.PlaylistId
GROUP BY P.Name

-- Listar las playlist (sin repetir ninguna) que tienen alguna canción de AC/DC
SELECT DISTINCT P.Name
FROM dbo.Track T
INNER JOIN dbo.PlaylistTrack PT
ON PT.TrackId = T.TrackId
INNER JOIN dbo.Playlist P
on  P.PlaylistId = PT.PlaylistId
WHERE T.Composer LIKE '%AC/DC%'
GROUP BY P.Name

-- Listar las playlist que tienen alguna canción del artista Queen, junto con la cantidad que tienen
SELECT P.Name, COUNT(A.Name)
FROM dbo.Track T
INNER JOIN dbo.PlaylistTrack PT
ON PT.TrackId = T.TrackId
INNER JOIN dbo.Playlist P
ON  P.PlaylistId = PT.PlaylistId
INNER JOIN dbo.Artist A
ON T.Composer = A.Name
WHERE A.Name = 'Queen'
GROUP BY P.Name

-- Listar las pistas que no están en ninguna playlist
SELECT *
FROM dbo.Track T
WHERE NOT EXISTS (SELECT NULL
                    FROM dbo.PlaylistTrack PT
                    WHERE PT.TrackId = T.TrackId)

-- Listar los artistas que no tienen album
SELECT A.Name AS ArtistName
FROM dbo.Artist A
LEFT JOIN dbo.Album AL
ON A.ArtistId = AL.ArtistId
WHERE AL.AlbumId IS NULL

-- Listar los artistas con el número de albums que tienen
SELECT A.Name, COUNT(AL.AlbumId) AS NumAlbums
FROM dbo.Artist A
LEFT JOIN dbo.Album AL
ON A.ArtistId = AL.ArtistId
GROUP BY A.Name


