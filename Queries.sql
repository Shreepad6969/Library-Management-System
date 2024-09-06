-- Find the total number of books each author has written, along with the author’s full name.
SELECT CONCAT(A.first_name, ' ', A.last_name) AS author_name, COUNT(B.book_id) AS total_books
FROM Authors A
JOIN Book_Authors BA ON A.author_id = BA.author_id
JOIN Books B ON BA.book_id = B.book_id
GROUP BY A.author_id
ORDER BY total_books DESC;

-- List the members who have borrowed more than 2 books.
SELECT M.first_name, M.last_name, COUNT(L.loan_id) AS total_loans
FROM Members M
JOIN Loans L ON M.member_id = L.member_id
WHERE L.returned = FALSE
GROUP BY M.member_id
HAVING total_loans > 2;

-- Find all books that have not been borrowed in the last 6 months.

SELECT B.title
FROM Books B
WHERE B.book_id NOT IN (
    SELECT L.book_id
    FROM Loans L
    WHERE L.loan_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
);

-- Find the book with the highest number of copies available.

SELECT title
FROM Books
WHERE copies_available = (
    SELECT MAX(copies_available)
    FROM Books
);

-- Get the names of members who have borrowed the most books, along with the number of books they borrowed.

SELECT M.first_name, M.last_name, total_loans
FROM Members M
JOIN (
    SELECT member_id, COUNT(loan_id) AS total_loans
    FROM Loans
    GROUP BY member_id
) AS L ON M.member_id = L.member_id
ORDER BY total_loans DESC
LIMIT 1;

-- List all members and the titles of the books they have currently borrowed, along with the due date.

SELECT M.first_name, M.last_name, B.title, L.due_date
FROM Members M
JOIN Loans L ON M.member_id = L.member_id
JOIN Books B ON L.book_id = B.book_id
WHERE L.returned = FALSE;

-- Find the details of the book that has been borrowed the most times.

SELECT B.title, B.genre, B.publish_year
FROM Books B
WHERE B.book_id = (
    SELECT L.book_id
    FROM Loans L
    GROUP BY L.book_id
    ORDER BY COUNT(L.loan_id) DESC
    LIMIT 1
);

-- List all members who have borrowed books authored by "J. B. Gupta."

SELECT M.first_name, M.last_name
FROM Members M
WHERE EXISTS (
    SELECT 1
    FROM Loans L
    JOIN Book_Authors BA ON L.book_id = BA.book_id
    JOIN Authors A ON BA.author_id = A.author_id
    WHERE M.member_id = L.member_id
    AND A.first_name = 'J. B.'
    AND A.last_name = 'Gupta'
);

-- Find the title and genre of the most popular book (the one with the most loans).
SELECT B.title, B.genre
FROM Books B
WHERE B.book_id = (
    SELECT book_id
    FROM Loans
    GROUP BY book_id
    ORDER BY COUNT(loan_id) DESC
    LIMIT 1
);

-- Find the average number of books borrowed by members who have joined the library in the last year.

SELECT AVG(book_count) AS average_books_borrowed
FROM (
    SELECT COUNT(L.loan_id) AS book_count
    FROM Members M
    JOIN Loans L ON M.member_id = L.member_id
    WHERE M.join_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    GROUP BY M.member_id
) AS recent_member_loans;

