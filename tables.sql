DROP TABLE bs_Book_Category;
DROP TABLE bs_Book;
DROP TABLE bs_Customer;
DROP TABLE bs_Order;
DROP TABLE bs_Order_Items;
DROP TABLE bs_Staff;
DROP TABLE bs_Order_History;
DROP TABLE bs_Book_Inventory;

CREATE TABLE bs_Book_Category (
    Category_ID NUMBER(10) PRIMARY KEY,
    Category_Name VARCHAR2(100) NOT NULL
);

CREATE TABLE bs_Book (
    ISBN VARCHAR2(20) PRIMARY KEY,
    Title VARCHAR2(100) NOT NULL,
    Author VARCHAR2(20) NOT NULL,
    Publisher VARCHAR2(100) NOT NULL,
    Price NUMBER(10, 2) NOT NULL,
    Category_ID NUMBER(10) NOT NULL,
    Added_By VARCHAR2(20) NOT NULL,
    CONSTRAINT bs_book_fk_category FOREIGN KEY (Category_ID) REFERENCES bs_Book_Category (category_id),
    CONSTRAINT bs_book_fk_staff FOREIGN KEY (Added_By) REFERENCES bs_Staff (ID)
);
ALTER TABLE bs_Book MODIFY ( Author VARCHAR2(50));

CREATE TABLE bs_Customer (
    ID NUMBER(10) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Address VARCHAR2(255) NOT NULL,
    Email VARCHAR2(100) NOT NULL,
    Phone VARCHAR2(15) NOT NULL
);

CREATE TABLE bs_Order (
  Order_No NUMBER(10) GENERATED ALWAYS AS IDENTITY,
  Customer_ID NUMBER(10) NOT NULL,
  Order_Date DATE,
  CONSTRAINT bs_order_pk PRIMARY KEY (Order_No),
  CONSTRAINT bs_order_fk_customer FOREIGN KEY (Customer_ID) REFERENCES bs_Customer (ID)
);


CREATE TABLE bs_Order_Items (
  Order_No NUMBER(10),
  ISBN VARCHAR2(20),
  Quantity NUMBER(10) NOT NULL,
  CONSTRAINT bs_order_items_fk_order FOREIGN KEY (Order_No) REFERENCES bs_Order (Order_No),
  CONSTRAINT bs_order_items_fk_book FOREIGN KEY (ISBN) REFERENCES bs_Book (ISBN)
);


CREATE TABLE bs_Staff (
    ID VARCHAR2(20) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Address VARCHAR2(255) NOT NULL,
    Email VARCHAR2(100) NOT NULL,
    Phone VARCHAR2(15) NOT NULL
);

CREATE TABLE bs_Order_History (
    Order_No NUMBER(10) PRIMARY KEY,
    Customer_ID NUMBER(10),
    ISBN VARCHAR2(20),
    Order_Date DATE NOT NULL,
    CONSTRAINT bs_orderhistory_fk_customer FOREIGN KEY (Customer_ID) REFERENCES bs_Customer (ID),
    CONSTRAINT bs_orderhistory_fk_book FOREIGN KEY (ISBN) REFERENCES bs_Book (ISBN)
);

CREATE TABLE bs_Book_Inventory (
    ISBN VARCHAR2(20) PRIMARY KEY,
    Quantity NUMBER(10) NOT NULL,
    CONSTRAINT bs_inventory_fk_book FOREIGN KEY (ISBN) REFERENCES bs_Book (ISBN)
);
