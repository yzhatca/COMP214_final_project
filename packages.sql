CREATE
OR REPLACE PACKAGE online_bookstore_mgmt AS TYPE t_order_item IS RECORD (
  isbn bs_Book.ISBN % TYPE,
  quantity bs_Order_Items.Quantity % TYPE
);

TYPE t_order_items IS TABLE OF t_order_item;

PROCEDURE add_book (
  p_isbn IN bs_Book.ISBN % TYPE,
  p_title IN bs_Book.Title % TYPE,
  p_author IN bs_Book.Author % TYPE,
  p_publisher IN bs_Book.Publisher % TYPE,
  p_price IN bs_Book.Price % TYPE,
  p_category_id IN bs_Book.Category_ID % TYPE,
  p_added_by IN bs_Book.Added_By % TYPE
);

PROCEDURE update_book (
  p_isbn IN bs_Book.ISBN % TYPE,
  p_title IN bs_Book.Title % TYPE,
  p_author IN bs_Book.Author % TYPE,
  p_publisher IN bs_Book.Publisher % TYPE,
  p_price IN bs_Book.Price % TYPE,
  p_category_id IN bs_Book.Category_ID % TYPE,
  p_added_by IN bs_Book.Added_By % TYPE
);

PROCEDURE add_order (
  p_customer_id IN bs_Customer.ID % TYPE,
  p_order_items IN t_order_items
);

PROCEDURE return_books (
  p_customer_id IN bs_Customer.ID % TYPE,
  p_order_no IN bs_Order.Order_No % TYPE,
  p_isbn IN bs_Book.ISBN % TYPE,
  p_quantity IN bs_Returned_Books.Quantity % TYPE
);

FUNCTION total_order_value (p_order_no IN bs_Order.Order_No % TYPE) RETURN bs_Book.Price % TYPE;

FUNCTION total_books_sold (p_isbn IN bs_Book.ISBN % TYPE) RETURN bs_Order_Items.Quantity % TYPE;

FUNCTION search_books_by_title (p_title IN bs_Book.Title % TYPE) RETURN SYS_REFCURSOR;

FUNCTION search_books_by_author (p_author IN bs_Book.Author % TYPE) RETURN SYS_REFCURSOR;

FUNCTION search_orders_by_customer (p_customer_id IN bs_Customer.ID % TYPE) RETURN SYS_REFCURSOR;

END online_bookstore_mgmt;
/

CREATE
OR REPLACE PACKAGE BODY online_bookstore_mgmt AS PROCEDURE add_book (
  p_isbn IN bs_Book.ISBN % TYPE,
  p_title IN bs_Book.Title % TYPE,
  p_author IN bs_Book.Author % TYPE,
  p_publisher IN bs_Book.Publisher % TYPE,
  p_price IN bs_Book.Price % TYPE,
  p_category_id IN bs_Book.Category_ID % TYPE,
  p_added_by IN bs_Book.Added_By % TYPE
) IS BEGIN
INSERT INTO
  bs_Book (
    ISBN,
    Title,
    Author,
    Publisher,
    Price,
    Category_ID,
    Added_By
  )
VALUES
  (
    p_isbn,
    p_title,
    p_author,
    p_publisher,
    p_price,
    p_category_id,
    p_added_by
  );

EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(
  -20001,
  'Error in add_book procedure: ' || SQLERRM
);

END add_book;

PROCEDURE update_book (
  p_isbn IN bs_Book.ISBN % TYPE,
  p_title IN bs_Book.Title % TYPE,
  p_author IN bs_Book.Author % TYPE,
  p_publisher IN bs_Book.Publisher % TYPE,
  p_price IN bs_Book.Price % TYPE,
  p_category_id IN bs_Book.Category_ID % TYPE,
  p_added_by IN bs_Book.Added_By % TYPE
) IS BEGIN
UPDATE
  bs_Book
SET
  Title = p_title,
  Author = p_author,
  Publisher = p_publisher,
  Price = p_price,
  Category_ID = p_category_id,
  Added_By = p_added_by
WHERE
  ISBN = p_isbn;

EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(
  -20002,
  'Error in update_book procedure: ' || SQLERRM
);

END update_book;

PROCEDURE add_order (
  p_customer_id IN bs_Customer.ID % TYPE,
  p_order_items IN t_order_items
) IS v_order_no bs_Order.Order_No % TYPE;

BEGIN
INSERT INTO
  bs_Order (Customer_ID, Order_Date)
VALUES
  (p_customer_id, SYSDATE) RETURNING Order_No INTO v_order_no;

FOR i IN 1..p_order_items.COUNT LOOP
INSERT INTO
  bs_Order_Items (Order_No, ISBN, Quantity)
VALUES
  (
    v_order_no,
    p_order_items(i).isbn,
    p_order_items(i).quantity
  );

END LOOP;

EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(
  -20003,
  'Error in add_order procedure: ' || SQLERRM
);

END add_order;

PROCEDURE return_books (
  p_customer_id IN bs_Customer.ID % TYPE,
  p_order_no IN bs_Order.Order_No % TYPE,
  p_isbn IN bs_Book.ISBN % TYPE,
  p_quantity IN bs_Returned_Books.Quantity % TYPE
) IS BEGIN
INSERT INTO
  bs_Returned_Books (
    Customer_ID,
    Order_No,
    ISBN,
    Quantity,
    Return_Date
  )
VALUES
  (
    p_customer_id,
    p_order_no,
    p_isbn,
    p_quantity,
    SYSDATE
  );

UPDATE
  bs_Book_Inventory
SET
  Quantity = Quantity + p_quantity
WHERE
  ISBN = p_isbn;

COMMIT;

EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(
  -20004,
  'Error in return_books procedure: ' || SQLERRM
);

END return_books;

FUNCTION total_order_value (p_order_no IN bs_Order.Order_No % TYPE) RETURN bs_Book.Price % TYPE IS v_total_value bs_Book.Price % TYPE;

BEGIN
SELECT
  SUM(b.Price * oi.Quantity) INTO v_total_value
FROM
  bs_Order_Items oi
  JOIN bs_Book b ON oi.ISBN = b.ISBN
WHERE
  oi.Order_No = p_order_no
GROUP BY
  oi.Order_No;

RETURN v_total_value;

EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(
  -20005,
  'Error in total_order_value function: ' || SQLERRM
);

RETURN NULL;

END total_order_value;

FUNCTION total_books_sold (p_isbn IN bs_Book.ISBN % TYPE) RETURN bs_Order_Items.Quantity % TYPE IS v_total_sold bs_Order_Items.Quantity % TYPE;

BEGIN
SELECT
  SUM(Quantity) INTO v_total_sold
FROM
  bs_Order_Items
WHERE
  ISBN = p_isbn;

RETURN v_total_sold;

EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(
  -20006,
  'Error in total_books_sold function: ' || SQLERRM
);

RETURN NULL;

END total_books_sold;

FUNCTION search_books_by_title (p_title IN bs_Book.Title % TYPE) RETURN SYS_REFCURSOR IS v_search_result SYS_REFCURSOR;

BEGIN OPEN v_search_result FOR
SELECT
  *
FROM
  bs_Book
WHERE
  LOWER(Title) LIKE '%' || LOWER(p_title) || '%';

RETURN v_search_result;

EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(
  -20007,
  'Error in search_books_by_title function: ' || SQLERRM
);

RETURN NULL;

END search_books_by_title;

FUNCTION search_books_by_author (p_author IN bs_Book.Author % TYPE) RETURN SYS_REFCURSOR IS v_search_result SYS_REFCURSOR;

BEGIN OPEN v_search_result FOR
SELECT
  *
FROM
  bs_Book
WHERE
  LOWER(Author) LIKE '%' || LOWER(p_author) || '%';

RETURN v_search_result;

EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(
  -20008,
  'Error in search_books_by_author function:' || SQLERRM
);

RETURN NULL;

END search_books_by_author;

FUNCTION search_orders_by_customer (p_customer_id IN bs_Customer.ID % TYPE) RETURN SYS_REFCURSOR IS v_search_result SYS_REFCURSOR;

BEGIN OPEN v_search_result FOR
SELECT
  o.Order_No,
  o.Order_Date,
  b.ISBN,
  b.Title,
  oi.Quantity
FROM
  bs_Order o
  JOIN bs_Order_Items oi ON o.Order_No = oi.Order_No
  JOIN bs_Book b ON oi.ISBN = b.ISBN
WHERE
  o.Customer_ID = p_customer_id;

RETURN v_search_result;

EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(
  -20009,
  'Error in search_orders_by_customer function: ' || SQLERRM
);

RETURN NULL;

END search_orders_by_customer;

END online_bookstore_mgmt;
