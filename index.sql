-- Index 1: Index on the Title column of the bs_Book table
CREATE INDEX idx_bs_book_title ON bs_Book (LOWER(Title));

-- Index 2: Index on the Author column of the bs_Book table
CREATE INDEX idx_bs_book_author ON bs_Book (LOWER(Author));

-- Index 3: Index on the Publisher column of the bs_Book table
CREATE INDEX idx_bs_book_publisher ON bs_Book (LOWER(Publisher));
