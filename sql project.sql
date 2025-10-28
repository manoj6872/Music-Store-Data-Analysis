CREATE DATABASE MusicStore12;
drop database musicstore12;


USE MusicStore12;

-- employee table
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(120),
    first_name VARCHAR(120),
    title VARCHAR(120),
    reports_to INT,
    levels VARCHAR(255),
    birthdate DATE,
    hire_date DATE,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    phone VARCHAR(50),
    fax VARCHAR(50),
    email VARCHAR(100),
    FOREIGN KEY (reports_to) REFERENCES Employee(employee_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Genre
CREATE TABLE Genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(120)
    );
    
   

-- Customers
CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(150),
    Country VARCHAR(100),
    company varchar(150), 
    city varchar(100),
    state varchar(100),
    postalcode varchar(20)
);

-- Artists
CREATE TABLE Artist (
    ArtistId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(150)
);

-- Albums
CREATE TABLE Album (
    AlbumId INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(200),
    ArtistId INT,
    FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId) ON DELETE CASCADE
);

-- Tracks
CREATE TABLE Track (
    TrackId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(200),
    AlbumId INT,
    Genre VARCHAR(100),
    Composer VARCHAR(150),
    Milliseconds INT,
    Bytes INT,
    UnitPrice DECIMAL(5,2),
    FOREIGN KEY (AlbumId) REFERENCES Album(AlbumId) ON DELETE CASCADE
);

-- Invoices
CREATE TABLE Invoice (
    InvoiceId INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT,
    InvoiceDate DATE,
    BillingCountry VARCHAR(100),
    Total DECIMAL(10,2),
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId) ON DELETE CASCADE
);

-- Invoice Items
CREATE TABLE InvoiceLine (
    InvoiceLineId INT PRIMARY KEY AUTO_INCREMENT,
    InvoiceId INT,
    TrackId INT,
    UnitPrice DECIMAL(5,2),
    Quantity INT,
    FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId) ON DELETE CASCADE,
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId) ON DELETE CASCADE
);
CREATE TABLE Playlist (
    PlaylistId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(120)
);


select * from customer;
select * from artist;
select * from employee;
select * from genre;
select * from invoice;
select * from invoiceline;
select * from playlist;
select * from track;

-- 1. Senior most employee based on job title

SELECT first_name, last_name, title
FROM Employee
ORDER BY levels DESC
LIMIT 1;


-- 2. Countries with the most invoices

SELECT billing_country, COUNT(*) AS total_invoices
FROM Invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;


-- 3. Top 3 values of total invoice

SELECT total
FROM Invoice
ORDER BY total DESC
LIMIT 3;


-- 4. City with the best customers (highest invoice total)

SELECT billing_city, SUM(total) AS total_sales
FROM Invoice
GROUP BY billing_city
ORDER BY total_sales DESC
LIMIT 1;


-- 5. Best customer (highest spender)
SELECT c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;


-- 6. Rock music listeners (email, name, genre)

SELECT DISTINCT c.email, c.first_name, c.last_name, g.name AS genre
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
JOIN Track t ON il.track_id = t.track_id
JOIN Genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
ORDER BY c.email ASC;


-- 7. Top 10 rock artists (by track count)

SELECT 
    a.artist_id,
    a.name AS artist_name, 
    COUNT(t.track_id) AS total_tracks
FROM Artist a
JOIN Album al ON a.artist_id = al.artist_id
JOIN Track t ON al.album_id = t.album_id
JOIN Genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY a.artist_id, a.name
ORDER BY total_tracks DESC
LIMIT 10;


-- 8. Tracks longer than average length

SELECT name, milliseconds
FROM Track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM Track)
ORDER BY milliseconds DESC;


-- 9. Amount spent by each customer on each artist

SELECT 
    c.customer_id,
    c.first_name, 
    c.last_name, 
    a.artist_id,
    a.name AS artist_name, 
    SUM(il.unit_price * il.quantity) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
JOIN Track t ON il.track_id = t.track_id
JOIN Album al ON t.album_id = al.album_id
JOIN Artist a ON al.artist_id = a.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.artist_id, a.name
ORDER BY total_spent DESC;


-- 10. Most popular genre per country

SELECT country, genre, purchases
FROM (
    SELECT c.country, g.name AS genre, COUNT(il.quantity) AS purchases,
           RANK() OVER (PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS rnk
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
    JOIN Track t ON il.track_id = t.track_id
    JOIN Genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
) AS ranked
WHERE rnk = 1;


-- 11. Top customer per country

SELECT 
    c.country,
    c.first_name,
    c.last_name,
    SUM(i.total) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.country, c.customer_id, c.first_name, c.last_name
ORDER BY c.country, total_spent DESC;






