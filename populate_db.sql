v-- Insert Users (3 Musicians, 3 Locals), password is pass
INSERT INTO dbo.Users (name, description, email, password, type, avg_rating)
VALUES 
('John Doe', 'A talented guitarist and singer.', 'johndoe@example.com', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOCIsImV4cCI6MTc3NDM3NTM5MCwiaXNzIjoiZ2lnZmluZGVyIiwiYXVkIjoiZ2lnZmluZGVyIn0.3ASIUHfHk-Mhy0YRm8SfRn4u4KzstrcS1Rv9R2KQ2ic', 'music', 4),
('Alice Smith', 'An amazing violinist with classical roots.', 'alicesmith@example.com', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOCIsImV4cCI6MTc3NDM3NTM5MCwiaXNzIjoiZ2lnZmluZGVyIiwiYXVkIjoiZ2lnZmluZGVyIn0.3ASIUHfHk-Mhy0YRm8SfRn4u4KzstrcS1Rv9R2KQ2ic', 'music', 5),
('Mike Johnson', 'A drummer specializing in jazz and rock.', 'mikejohnson@example.com', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOCIsImV4cCI6MTc3NDM3NTM5MCwiaXNzIjoiZ2lnZmluZGVyIiwiYXVkIjoiZ2lnZmluZGVyIn0.3ASIUHfHk-Mhy0YRm8SfRn4u4KzstrcS1Rv9R2KQ2ic', 'music', 3),
('The Grand Hall', 'A spacious venue for large events.', 'grandhall@example.com', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOCIsImV4cCI6MTc3NDM3NTM5MCwiaXNzIjoiZ2lnZmluZGVyIiwiYXVkIjoiZ2lnZmluZGVyIn0.3ASIUHfHk-Mhy0YRm8SfRn4u4KzstrcS1Rv9R2KQ2ic', 'local', 5),
('Downtown Pub', 'A cozy spot for live performances.', 'downtownpub@example.com', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOCIsImV4cCI6MTc3NDM3NTM5MCwiaXNzIjoiZ2lnZmluZGVyIiwiYXVkIjoiZ2lnZmluZGVyIn0.3ASIUHfHk-Mhy0YRm8SfRn4u4KzstrcS1Rv9R2KQ2ic', 'local', 4),
('Skyline Club', 'A high-energy nightclub with live DJs.', 'skylineclub@example.com', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOCIsImV4cCI6MTc3NDM3NTM5MCwiaXNzIjoiZ2lnZmluZGVyIiwiYXVkIjoiZ2lnZmluZGVyIn0.3ASIUHfHk-Mhy0YRm8SfRn4u4KzstrcS1Rv9R2KQ2ic', 'local', 3);

-- Insert Locals
INSERT INTO dbo.Locals (id, capacity, x_coordination, y_coordination)
VALUES 
(4, 500, 40.7128, -74.0060),
(5, 150, 34.0522, -118.2437),
(6, 300, 51.5074, -0.1278);

-- Insert Languages
INSERT INTO dbo.Languages (lang)
VALUES 
('en'),
('es'),
('fr');

-- Insert Musicians
INSERT INTO dbo.Musicians (id, size, price, songs_lang)
VALUES 
(1, 4, 2000, 1),
(2, 3, 1500, 2),
(3, 5, 2500, 3);

-- Insert Genres
INSERT INTO dbo.Genres (name)
VALUES 
('Rock'),
('Jazz'),
('Classical');

-- Insert UserGenres (associating musicians with genres)
INSERT INTO dbo.UserGenres (user_id, genre_id)
VALUES 
(1, 1), (1, 2), -- John Doe (Rock, Jazz)
(2, 3), -- Alice Smith (Classical)
(3, 1), (3, 2); -- Mike Johnson (Rock, Jazz)

-- Insert Events
INSERT INTO dbo.Events (musician_id, local_id, date_start, date_end, opened_offer, price, description, canceled, cancel_msg, genre_id)
VALUES 
(1, 4, '2025-03-15 19:00:00', '2025-03-15 22:00:00', 1, 3000, 'Live Rock Concert', 0, '', 1),
(2, 5, '2025-04-10 20:00:00', '2025-04-10 23:00:00', 0, 2500, 'Classical Night with Alice', 0, '', 3),
(3, 6, '2025-05-05 21:00:00', '2025-05-05 23:30:00', 1, 2800, 'Jazz Fusion Live', 0, '', 2);

-- Insert Ratings
INSERT INTO dbo.Ratings (user_id, event_id, avg_rating)
VALUES 
(4, 1, 5),
(5, 2, 4),
(6, 3, 3);

-- Insert Applications
INSERT INTO dbo.Aplications (user_id, event_id, description, status)
VALUES 
(1, 1, 'Looking forward to rocking the night!', 'accepted'),
(2, 2, 'Excited to perform classical music.', 'accepted'),
(3, 3, 'Jazz drums at their best!', 'accepted');
