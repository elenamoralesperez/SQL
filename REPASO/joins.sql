CREATE TABLE IF NOT EXISTS users0 (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR (100) NOT NULL,
    last_name VARCHAR (100) NOT NULL,
    email VARCHAR (100) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    register_date TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO users0 (first_name, last_name, email, password)
VALUES ('Ada', 'Lovelace', 'ada@example.com', '123456');

CREATE TABLE IF NOT EXISTS posts0 (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users0(id),
    title VARCHAR (100) NOT NULL,
    body TEXT,
    publish_date TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

DROP TABLE posts0;
DROP TABLE usersx;
DROP TABLE users;

INSERT INTO posts0(user_id, title, body)
VALUES(1, 'First Post', 'Welcome to my feed');

SELECT * FROM users0
INNER JOIN posts0 ON users0.id = posts0.user_id;

CREATE TABLE IF NOT EXISTS comments0 (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users0(id),
    post_id INTEGER NOT NULL REFERENCES posts0(id),
    body TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO comments0(user_id, post_id, body)
VALUES(1, 1, 'My first comment')

SELECT 
    comments0.body,
    posts0.title,
    users0.first_name, 
    users0.last_name
FROM 
    comments0
INNER JOIN 
    posts0 ON posts0.id = comments0.post_id -- Clave foránea correcta: 'post_id'
INNER JOIN 
    users0 ON users0.id = comments0.user_id;
