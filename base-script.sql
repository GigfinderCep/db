use gigfinder;

IF OBJECT_ID('dbo.Messages', 'U') IS NOT NULL DROP TABLE dbo.Messages;
IF OBJECT_ID('dbo.ChatRooms', 'U') IS NOT NULL DROP TABLE dbo.ChatRooms;
IF OBJECT_ID('dbo.Aplications', 'U') IS NOT NULL DROP TABLE dbo.Aplications;
IF OBJECT_ID('dbo.Ratings', 'U') IS NOT NULL DROP TABLE dbo.Ratings;
IF OBJECT_ID('dbo.Events', 'U') IS NOT NULL DROP TABLE dbo.Events;
IF OBJECT_ID('dbo.Musicians', 'U') IS NOT NULL DROP TABLE dbo.Musicians;
IF OBJECT_ID('dbo.Locals', 'U') IS NOT NULL DROP TABLE dbo.Locals;
IF OBJECT_ID('dbo.Attachments', 'U') IS NOT NULL DROP TABLE dbo.Attachments;
IF OBJECT_ID('dbo.Files', 'U') IS NOT NULL DROP TABLE dbo.Files;
IF OBJECT_ID('dbo.UserGenres', 'U') IS NOT NULL DROP TABLE dbo.UserGenres;
IF OBJECT_ID('dbo.Genres', 'U') IS NOT NULL DROP TABLE dbo.Genres;
IF OBJECT_ID('dbo.Incidences', 'U') IS NOT NULL DROP TABLE dbo.Incidences;
IF OBJECT_ID('dbo.UsersDesktop', 'U') IS NOT NULL DROP TABLE dbo.UsersDesktop;

IF OBJECT_ID('dbo.Languages', 'U') IS NOT NULL DROP TABLE dbo.Languages;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;


CREATE TABLE dbo.Users (
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(100) NOT NULL,
	description NVARCHAR(500) NOT NULL,
	email VARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	type VARCHAR(5) NOT NULL,
	avg_rating TINYINT NOT NULL DEFAULT 0,
	profile_image_identifier VARCHAR(100) DEFAULT '',
	CONSTRAINT CHECK_USER_TYPE CHECK (type IN ('local','music')),
	CONSTRAINT CHECK_AVGRATING CHECK (avg_rating BETWEEN 0 AND 5)
);

CREATE TABLE dbo.Files (
	id INT IDENTITY(1,1) PRIMARY KEY,
	mimetype VARCHAR(10) NOT NULL,
	path VARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Attachments (
	id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NOT NULL,
	file_identifier INT NOT NULL,
	description VARCHAR(255) NULL,
	CONSTRAINT FK_ATTACHMENTS_FILE FOREIGN KEY (file_identifier) REFERENCES dbo.Files(id),
	CONSTRAINT FK_USER_ATTACHMENTS FOREIGN KEY (user_id) REFERENCES dbo.Users(id)
);

CREATE TABLE dbo.Languages (
	id INT IDENTITY(1,1) PRIMARY KEY,
	lang NVARCHAR(20) NOT NULL,
);

CREATE TABLE dbo.Musicians (
	id INT PRIMARY KEY NOT NULL,
	size TINYINT NOT NULL,
	price INT NOT NULL,
	songs_lang INT NOT NULL,
	CONSTRAINT FK_musician_LANG FOREIGN KEY (songs_lang) REFERENCES dbo.Languages(id),
	CONSTRAINT FK_musician_ID FOREIGN KEY (id) REFERENCES dbo.Users(id) 
);

CREATE TABLE dbo.Locals (
	id INT PRIMARY KEY,
	capacity iNT NOT NULL,
	x_coordination FLOAT NOT NULL, 
	y_coordination FLOAT NOT NULL,
	CONSTRAINT FK_ID_LOCAL FOREIGN KEY (id) REFERENCES dbo.Users(id) 
);

CREATE TABLE dbo.ChatRooms (
	id INT IDENTITY(1,1) PRIMARY KEY, 
	user_id1 INT NOT NULL,
	user_id2 INT NOT NULL,
	CONSTRAINT FK_CHAT_USER_1 FOREIGN KEY (user_id1) REFERENCES dbo.Users(id),
	CONSTRAINT FK_CHAT_USER_2 FOREIGN KEY (user_id2) REFERENCES dbo.Users(id),
	CONSTRAINT UQ_CHAT_USERS UNIQUE (user_id1, user_id2)
);

CREATE TABLE dbo.Messages (
	id INT IDENTITY(1,1) PRIMARY KEY, 
	chat_id INT,
	sender INT NOT NULL,
	content NVARCHAR(255),
	file_identifier INT NULL,
	date SMALLDATETIME NOT NULL, -- SMALLDATETIME most eficient minuts storage YY/MM/DD HH:MI:00
	type VARCHAR(10) NOT NULL,
	CONSTRAINT CHECK_MESSAGE_TYPE CHECK(type IN ('message','audio')),
	CONSTRAINT FK_MSG_CHAT FOREIGN KEY (chat_id) REFERENCES dbo.ChatRooms(id),
	CONSTRAINT FK_MSG_USER FOREIGN KEY (sender) REFERENCES dbo.Users(id),
	CONSTRAINT FK_MESSAGES_FILE FOREIGN KEY (file_identifier) REFERENCES dbo.Files(id)
);

CREATE TABLE dbo.Genres (
	id INT IDENTITY(1,1) PRIMARY KEY, 
	name VARCHAR(20)
);

CREATE TABLE dbo.UserGenres (
	user_id INT,
	genre_id INT,
	CONSTRAINT FK_GENRE_USER FOREIGN KEY (genre_id) REFERENCES dbo.Genres(id),
	CONSTRAINT FK_USER_GENRE FOREIGN KEY (user_id) REFERENCES dbo.Users(id),
	CONSTRAINT PK_USERGENRES PRIMARY KEY(user_id, genre_id)
)

CREATE TABLE dbo.Events (
	id INT IDENTITY(1,1) PRIMARY KEY, 
	musician_id iNT,
	local_id INT NOT NULL,
	date_start SMALLDATETIME NOT NULL,
	date_end SMALLDATETIME NOT NULL,
	opened_offer BIT DEFAULT 1, -- BOOL
	price INT NOT NULL,
	description NVARCHAR(255),
	canceled BIT DEFAULT 0,
	cancel_msg NVARCHAR(255) DEFAULT '',
	genre_id INT NULL,
	CONSTRAINT CHECK_DATE_START_FUTURE CHECK (date_start > GETDATE()),
    CONSTRAINT CHECK_DATE_END_FUTURE CHECK (date_end > GETDATE()),
	CONSTRAINT FK_EVENT_GENRE FOREIGN KEY (genre_id) REFERENCES dbo.Genres(id),
	CONSTRAINT FK_EVENT_musician FOREIGN KEY (musician_id) REFERENCES dbo.Musicians(id),
	CONSTRAINT FK_EVENT_LOCAL FOREIGN KEY (local_id) REFERENCES dbo.Locals(id)
);

CREATE TABLE dbo.Aplications (
	user_id INT,
	event_id INT,
	description NVARCHAR(255),
	status VARCHAR(10),
	CONSTRAINT CHECK_APLICATIONS_STATUS CHECK (status IN('pendent','rejected','accepted')),
	CONSTRAINT FK_EVENT_APLICATIONS FOREIGN KEY (event_id) REFERENCES dbo.Events(id),
	CONSTRAINT FK_USER_APLICATIONS FOREIGN KEY (user_id) REFERENCES dbo.Users(id),
	CONSTRAINT PK_APLICATIONS PRIMARY KEY (user_id, event_id)
);

CREATE TABLE dbo.Ratings (
	user_id INT,
	event_id INT,
	content NVARCHAR(255),
	avg_rating TINYINT NOT NULL DEFAULT 0,
	CONSTRAINT FK_EVENT_RATINGS FOREIGN KEY (event_id) REFERENCES dbo.Events(id),
	CONSTRAINT FK_USER_VALORATIONS FOREIGN KEY (user_id) REFERENCES dbo.Users(id),
	CONSTRAINT PK_RATINGS PRIMARY KEY (user_id, event_id),
	CONSTRAINT CHECK_RATING CHECK (avg_rating BETWEEN 0 AND 5)
);

CREATE TABLE dbo.UsersDesktop (
	id INT IDENTITY(1,1) PRIMARY KEY,
	name NVARCHAR(100) NOT NULL,
	surname NVARCHAR(100) NOT NULL,
	email NVARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	type VARCHAR(5) NOT NULL,
);


CREATE TABLE dbo.Incidences (
	id INT IDENTITY(1,1) PRIMARY KEY, 
	description NVARCHAR(500) DEFAULT '',
	admin_note NVARCHAR(500) DEFAULT '',
	status varchar(10) DEFAULT 'pendent' NOT NULL,
	user_id INT NOT NULL,
	admin_id INT DEFAULT NULL,
	CONSTRAINT CHECK_INCIDENCE_STATUS CHECK (status IN ('pendent','ignores','fixed')),
	CONSTRAINT FK_USER_INCIDENCES FOREIGN KEY (user_id) REFERENCES dbo.Users(id),
	CONSTRAINT FK_ADMIN_INCIDENCES FOREIGN KEY (admin_id) REFERENCES dbo.UsersDesktop(id)
);
