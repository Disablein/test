DROP TABLE IF EXISTS Loans CASCADE;
DROP TABLE IF EXISTS Book_Authors CASCADE;
DROP TABLE IF EXISTS Books CASCADE;
DROP TABLE IF EXISTS Authors CASCADE;
DROP TABLE IF EXISTS Readers CASCADE;

CREATE TABLE Readers (
    reader_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    phone     VARCHAR(30)  NOT NULL UNIQUE
);

CREATE TABLE Books (
    isbn         VARCHAR(20) PRIMARY KEY,
    title        VARCHAR(255) NOT NULL,
    publish_year INTEGER CHECK (publish_year BETWEEN 1400 AND 2100)
);

CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL
);

CREATE TABLE Book_Authors (
    isbn      VARCHAR(20) NOT NULL,
    author_id INTEGER     NOT NULL,
    PRIMARY KEY (isbn, author_id),
    FOREIGN KEY (isbn)      REFERENCES Books(isbn)       ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

CREATE TABLE Loans (
    loan_id            SERIAL PRIMARY KEY,
    reader_id          INTEGER NOT NULL REFERENCES Readers(reader_id),
    isbn               VARCHAR(20) NOT NULL REFERENCES Books(isbn),
    loan_date          DATE NOT NULL,
    due_date           DATE NOT NULL,
    actual_return_date DATE,
    CHECK (due_date >= loan_date),
    CHECK (actual_return_date IS NULL OR actual_return_date >= loan_date)
);

INSERT INTO Readers (full_name, phone) VALUES
('Анна Петрова',   '+7-900-111-22-33'),
('Иван Соколов',   '+7-900-222-33-44'),
('Мария Ким',      '+7-900-333-44-55'),
('Олег Васильев',  '+7-900-444-55-66');

INSERT INTO Authors (full_name) VALUES
('Михаил Булгаков'),
('Федор Достоевский'),
('Лев Толстой'),
('Илья Ильф'),
('Евгений Петров'),
('Аркадий Стругацкий'),
('Борис Стругацкий');

INSERT INTO Books (isbn, title, publish_year) VALUES
('978-5-17-118366-8', 'Мастер и Маргарита',       1967),
('978-5-389-06256-6', 'Преступление и наказание', 1866),
('978-5-04-116716-3', 'Война и мир',              1869),
('978-5-699-12014-7', 'Золотой теленок',          1931),
('978-5-389-03713-7', 'Пикник на обочине',        1972);

INSERT INTO Book_Authors (isbn, author_id) VALUES
('978-5-17-118366-8', 1),
('978-5-389-06256-6', 2),
('978-5-04-116716-3', 3),
('978-5-699-12014-7', 4),
('978-5-699-12014-7', 5),
('978-5-389-03713-7', 6),
('978-5-389-03713-7', 7);

INSERT INTO Loans (reader_id, isbn, loan_date, due_date, actual_return_date) VALUES
(1, '978-5-17-118366-8', '2024-01-10', '2024-02-10', '2024-02-05'),
(1, '978-5-389-06256-6', '2024-03-01', '2024-04-01', NULL),
(2, '978-5-04-116716-3', '2024-02-15', '2024-03-15', '2024-03-10'),
(3, '978-5-699-12014-7', '2024-03-05', '2024-04-05', NULL),
(4, '978-5-389-03713-7', '2024-01-20', '2024-02-20', '2024-02-18'),
(3, '978-5-17-118366-8', '2024-03-15', '2024-04-15', NULL);

UPDATE Readers
SET phone = '+7-900-999-88-77'
WHERE reader_id = 2;

UPDATE Loans
SET actual_return_date = CURRENT_DATE
WHERE loan_id = 2
  AND actual_return_date IS NULL;

INSERT INTO Readers (full_name, phone) VALUES
('Тестовый Читатель', '+7-900-000-00-00');

DELETE FROM Readers
WHERE phone = '+7-900-000-00-00';