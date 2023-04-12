CREATE SEQUENCE bs_order_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE bs_category_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE bs_customer_seq
  START WITH 1
  INCREMENT BY 1
  CACHE 20
  NOCYCLE;
DROP SEQUENCE bs_customer_seq;
DROP SEQUENCE bs_order_seq;
DROP SEQUENCE bs_category_seq;

-- 插入Book_Category测试数据
select * from bs_Book_Category;
INSERT INTO bs_Book_Category (Category_ID, Category_Name) VALUES (bs_category_seq.NEXTVAL, 'Fiction');
INSERT INTO bs_Book_Category (Category_ID, Category_Name) VALUES (bs_category_seq.NEXTVAL, 'Science Fiction');
INSERT INTO bs_Book_Category (Category_ID, Category_Name) VALUES (bs_category_seq.NEXTVAL, 'Mystery');
INSERT INTO bs_Book_Category (Category_ID, Category_Name) VALUES (bs_category_seq.NEXTVAL, 'Biography');
INSERT INTO bs_Book_Category (Category_ID, Category_Name) VALUES (bs_category_seq.NEXTVAL, 'History');

-- 插入Customer测试数据
Delete from bs_Customer;
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'Alice', '123 Main St', 'alice@example.com', '555-1234');
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'Bob', '456 Main St', 'bob@example.com', '555-5678');
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'Charlie', '789 Main St', 'charlie@example.com', '555-2468');
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'David', '101 Main St', 'david@example.com', '555-1357');
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'Eva', '121 Main St', 'eva@example.com', '555-8642');
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'Frank', '141 Main St', 'frank@example.com', '555-9753');
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'Grace', '161 Main St', 'grace@example.com', '555-0864');
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'Helen', '181 Main St', 'helen@example.com', '555-9975');
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'Iris', '201 Main St', 'iris@example.com', '555-8108');
INSERT INTO bs_Customer (ID, Name, Address, Email, Phone) VALUES (bs_customer_seq.NEXTVAL, 'Jack', '221 Main St', 'jack@example.com', '555-9219');

--insert staff 
select * from bs_staff;
INSERT INTO bs_Staff (ID, Name, Address, Email, Phone) VALUES ('J1', 'John', '123 Main St, New York, NY', 'johnsmith@email.com', '555-123-4567');
INSERT INTO bs_Staff (ID, Name, Address, Email, Phone) VALUES ('A1', 'Alice', '789 Oak St, Los Angeles, CA', 'alicejohnson@email.com', '555-444-5555');

-- 插入Book测试数据
-- Fiction
select * from bs_Book;
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID, Added_By) VALUES ('ISBN11', 'To Kill a Mockingbird', 'Harper Lee', 'Publisher 11', 110, 1,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN12', 'Pride and Prejudice', 'Jane Austen', 'Publisher 12', 120, 1,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN13', 'The Catcher in the Rye', 'J.D. Salinger', 'Publisher 13', 130, 1,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN14', 'The Great Gatsby', 'F. Scott Fitzgerald', 'Publisher 14', 140, 1,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN15', 'Moby-Dick', 'Herman Melville', 'Publisher 15', 150, 1,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN16', 'Jane Eyre', 'Charlotte Bronte', 'Publisher 16', 160, 1,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN17', 'Wuthering Heights', 'Emily Bronte', 'Publisher 17', 170, 1,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN18', 'Great Expectations', 'Charles Dickens', 'Publisher 18', 180, 1,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN19', 'Crime and Punishment', 'Fyodor Dostoevsky', 'Publisher 19', 190, 1,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN20', 'Catch-22', 'Joseph Heller', 'Publisher 20', 200, 1,'J1');
-- Science Fiction
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN21', 'Dune', 'Frank Herbert', 'Publisher 21', 210, 2,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN22', '1984', 'George Orwell', 'Publisher 22', 220, 2,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN23', 'Galactic Odyssey', 'Arthur C. Clarke', 'Galaxy Publishing', 15.99, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN24', 'Time Paradox', 'H.G. Wells', 'Time Travel Press', 12.99, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN25', 'Alien Encounter', 'Larry Niven', 'Cosmic Publishing', 18.99, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN26', 'Hyperion Dreams', 'Dan Simmons', 'Hyperion Press', 14.99, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN27', 'The Stars My Destination', 'Alfred Bester', 'Orion Books', 19.99, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN28', 'The Martian Chronicles', 'Ray Bradbury', 'Red Planet Publishing', 16.99, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN29', 'Neuromancer', 'William Gibson', 'Cyberpunk House', 21.99, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN30', 'Foundation Trilogy', 'Isaac Asimov', 'Universe Press', 28.99, 5,'J1');

-- Mystery
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN31', 'The Adventures of Sherlock Holmes', 'Arthur Conan Doyle', 'Publisher 31', 310, 3,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN32', 'Murder on the Orient Express', 'Agatha Christie', 'Publisher 32', 320, 3,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN33', 'The Maltese Falcon', 'Dashiell Hammett', 'Publisher 33', 330, 3,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN34', 'The Hound of the Baskervilles', 'Arthur Conan Doyle', 'Publisher 34', 340, 3,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN35', 'The Girl with the Dragon Tattoo', 'Stieg Larsson', 'Publisher 35', 350, 3,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN36', 'Gone Girl', 'Gillian Flynn', 'Publisher 36', 360, 3,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN37', 'The Da Vinci Code', 'Dan Brown', 'Publisher 37', 370, 3,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN38', 'The Cuckoo''s Calling', 'Robert Galbraith', 'Publisher 38', 380, 3,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN39', 'The No. 1 Ladies'' Detective Agency', 'Alexander McCall Smith', 'Publisher 39', 390, 3,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN40', 'In the Woods', 'Tana French', 'Publisher 40', 400, 3,'J1');

-- Biography
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN41', 'Steve Jobs', 'Walter Isaacson', 'Publisher 41', 410, 4,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN42', 'The Autobiography of Benjamin Franklin', 'Benjamin Franklin', 'Publisher 42', 420, 4,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN43', 'The Wright Brothers', 'David McCullough', 'Publisher 43', 430, 4,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN44', 'Becoming', 'Michelle Obama', 'Publisher 44', 440, 4,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN45', 'The Glass Universe', 'Dava Sobel', 'Publisher 45', 450, 4,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN46', 'Team of Rivals: The Political Genius of Abraham Lincoln', 'Doris Kearns Goodwin', 'Publisher 46', 460, 4,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN47', 'Einstein: His Life and Universe', 'Walter Isaacson', 'Publisher 47', 470, 4,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN48', 'The Immortal Life of Henrietta Lacks', 'Rebecca Skloot', 'Publisher 48', 480, 4,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN49', 'Into the Wild', 'Jon Krakauer', 'Publisher 49', 490, 4,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN50', 'Unbroken: A World War II Story of Survival, Resilience, and Redemption', 'Laura Hillenbrand', 'Publisher 50', 500, 4,'J1');

-- History
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN51', 'Guns, Germs, and Steel: The Fates of Human Societies', 'Jared Diamond', 'Publisher 51', 510, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN52', 'The Rise and Fall of the Third Reich: A History of Nazi Germany', 'William L. Shirer', 'Publisher 52', 520, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN53', 'The World Is Flat: A Brief History of the Twenty-first Century', 'Thomas L. Friedman', 'Publisher 53', 530, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN54', 'A People''s History of the United States', 'Howard Zinn', 'Publisher 54', 540, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN55', 'The Silk Roads: A New History of the World', 'Peter Frankopan', 'Publisher 55', 550, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN56', 'The Making of the Atomic Bomb', 'Richard Rhodes', 'Publisher 56', 560, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN57', 'The Swerve: How the World Became Modern', 'Stephen Greenblatt', 'Publisher 57', 570, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN58', 'The Guns of August', 'Barbara W. Tuchman', 'Publisher 58', 580, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN59', 'Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 'Publisher 59', 590, 5,'J1');
INSERT INTO bs_Book (ISBN, Title, Author, Publisher, Price, Category_ID,Added_By) VALUES ('ISBN60', 'A Short History of Nearly Everything', 'Bill Bryson', 'Publisher 60', 600, 5,'J1');

select * from bs_Book_Inventory;
--insert data into bs_Book_Inventory
DECLARE
  v_isbn VARCHAR2(50);
BEGIN
  FOR i IN 11..60 LOOP
    v_isbn := 'ISBN' || TO_CHAR(i);
    INSERT INTO bs_Book_Inventory (ISBN, Quantity)
    VALUES (v_isbn, TRUNC(DBMS_RANDOM.VALUE(2, 21)));
  END LOOP;
  COMMIT;
END;
/