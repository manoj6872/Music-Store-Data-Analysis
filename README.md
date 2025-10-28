# Music-Store-Data-Analysis

- “This project is about a Music Store Database. It is designed to manage employees, customers, artists, albums, tracks, invoices, and playlists. The main goal is to generate business insights such as best customers, top artists, and popular music genres.”

# 🧠ER Diagram

🔹 “This ER diagram shows how the different entities are related:

- - Customer ↔ Invoice

- - Invoice ↔ Invoice Line ↔ Track

- - Artist ↔ Album ↔ Track

- - Track ↔ Genre

- Employee has a self-relationship (manager → employee). This structure ensures proper organization and relationships in the database.”


# 🧼Database Schema

🔹 “Our schema has multiple tables:

- - Employee: staff details

- - Customer: customer details & location

- - Artist & Album: creators of music

- - Track: songs with price & duration

- - Genre: categories of music

- - Invoice & Invoice Line: purchases & sales

- Playlist: custom track lists This schema helps store and manage all music store data efficiently.”

# ❓SQL Queries & Insights

🔹 “These queries help us analyze business data:

- - Senior-most Employee → shows top-level employee.

- - Countries with Most Invoices → shows top buying countries.

- - Top 3 Invoice Totals → biggest purchases made by customers.

- - City with Best Customers → highest revenue city.

- - Best Customers → top spending customers.

- - Rock Music Listener → customers who listen to Rock.

- - Top 10 Rock Artists → artists with most Rock tracks.

- - Tracks Longer than Average → tracks above average duration.

- - Amount Spent by Each Customer on Each Artist → customer-artist spending analysis.

- - Popular Genre per Country → most popular genre in each country.

- Top Customer per Country → top spenders in every country.”

# Conclusion

- We designed a relational music store database with schema and ER diagram.

- We wrote queries to analyze customer behavior, artist performance, and genre popularity.

- We identified top customers, popular cities & countries, and spending patterns.

- These insights are useful for marketing strategies and business growth.”
