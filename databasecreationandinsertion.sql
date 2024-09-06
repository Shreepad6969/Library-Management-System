USE LibraryManagement;

CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    publish_year INT,
    copies_available INT DEFAULT 1,
    total_copies INT DEFAULT 1
);

CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

CREATE TABLE Book_Authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15),
    join_date DATETIME DEFAULT NOW()
);

CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATETIME DEFAULT NOW(),
    return_date DATE,
    due_date DATE,
    returned BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE
);

INSERT INTO Authors (first_name, last_name) VALUES
('J. B.', 'Gupta'),
('R. K.', 'Bansal'),
('A. P.', 'Malvino'),
('David A.', 'Patterson'),
('John L.', 'Hennessy'),
('S.', 'Chand'),
('N.', 'Subramanian'),
('Amit', 'Sharma'),
('M.', 'Krishna'),
('A. K.', 'Jain'),
('Satish', 'Sharma'),
('D.', 'Ramakrishna');

INSERT INTO Books (title, genre, publish_year, copies_available, total_copies) VALUES
('Electrical Machines', 'Electrical Engineering', 2007, 5, 10),
('Fluid Mechanics', 'Mechanical Engineering', 2010, 4, 6),
('Electronic Principles', 'Electronics Engineering', 2005, 7, 8),
('Computer Architecture: A Quantitative Approach', 'Computer Engineering', 2017, 3, 5),
('Engineering Mechanics', 'Civil Engineering', 2012, 10, 12),
('Structural Analysis', 'Civil Engineering', 2011, 6, 10),
('Basic Electronics', 'Electronics Engineering', 2009, 4, 8),
('Advanced Fluid Mechanics', 'Mechanical Engineering', 2018, 3, 5),
('Thermodynamics', 'Mechanical Engineering', 2016, 7, 9),
('Reinforced Concrete Design', 'Civil Engineering', 2013, 4, 6),
('Power Systems', 'Electrical Engineering', 2015, 9, 10),
('Digital Signal Processing', 'Electronics Engineering', 2014, 5, 7);

INSERT INTO Book_Authors (book_id, author_id) VALUES
(1, 1), -- 'Electrical Machines' by J. B. Gupta
(2, 2), -- 'Fluid Mechanics' by R. K. Bansal
(3, 3), -- 'Electronic Principles' by A. P. Malvino
(4, 4), -- 'Computer Architecture' by David A. Patterson
(4, 5), -- 'Computer Architecture' by John L. Hennessy
(5, 6), -- 'Engineering Mechanics' by S. Chand
(6, 7), -- 'Structural Analysis' by N. Subramanian
(7, 8), -- 'Basic Electronics' by Amit Sharma
(8, 2), -- 'Advanced Fluid Mechanics' by R. K. Bansal
(9, 9), -- 'Thermodynamics' by M. Krishna
(10, 10), -- 'Reinforced Concrete Design' by A. K. Jain
(11, 11), -- 'Power Systems' by Satish Sharma
(12, 12); -- 'Digital Signal Processing' by D. Ramakrishna

INSERT INTO Members (first_name, last_name, email, phone) VALUES
('Aarav', 'Verma', 'aarav.verma@example.com', '555-1111'),
('Ishaan', 'Reddy', 'ishaan.reddy@example.com', '555-2222'),
('Ananya', 'Sharma', 'ananya.sharma@example.com', '555-3333'),
('Aditya', 'Mehta', 'aditya.mehta@example.com', '555-4444'),
('Sneha', 'Patel', 'sneha.patel@example.com', '555-5555'),
('Kavya', 'Singh', 'kavya.singh@example.com', '555-6666'),
('Aryan', 'Bose', 'aryan.bose@example.com', '555-7777'),
('Rohit', 'Kapoor', 'rohit.kapoor@example.com', '555-8888'),
('Neha', 'Iyer', 'neha.iyer@example.com', '555-9999'),
('Pranav', 'Gupta', 'pranav.gupta@example.com', '555-1010');

INSERT INTO Loans (book_id, member_id, loan_date, due_date, returned) VALUES
(1, 1, '2024-09-01', '2024-09-15', FALSE), -- Aarav borrows 'Electrical Machines'
(2, 2, '2024-09-03', '2024-09-17', FALSE), -- Ishaan borrows 'Fluid Mechanics'
(4, 3, '2024-09-05', '2024-09-20', FALSE), -- Ananya borrows 'Computer Architecture'
(5, 4, '2024-09-02', '2024-09-16', FALSE), -- Aditya borrows 'Engineering Mechanics'
(6, 5, '2024-09-07', '2024-09-21', TRUE),  -- Sneha borrows 'Structural Analysis'
(7, 6, '2024-09-08', '2024-09-22', FALSE), -- Kavya borrows 'Basic Electronics'
(9, 7, '2024-09-10', '2024-09-25', TRUE),  -- Aryan borrows 'Thermodynamics'
(11, 8, '2024-09-12', '2024-09-26', FALSE),-- Rohit borrows 'Power Systems'
(12, 9, '2024-09-13', '2024-09-27', TRUE), -- Neha borrows 'Digital Signal Processing'
(10, 10, '2024-09-14', '2024-09-28', FALSE);-- Pranav borrows 'Reinforced Concrete Design'

SELECT * FROM Books WHERE copies_available > 0;
