-- Test script for triggers and package functionalities

SET SERVEROUTPUT ON;
select * from bs_staff;
-- Test Package Procedure: Add_Book
BEGIN
  online_bookstore_mgmt.Add_Book('ISBN101', 'Test Book 1', 'Test Author', 'Test Publisher', 12.99, 1, 'J1');
  DBMS_OUTPUT.PUT_LINE('Add_Book procedure executed successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Test Package Procedure: Add_Book who is not a staff
BEGIN
  online_bookstore_mgmt.Add_Book('ISBN102', 'Test Book 2', 'Test Author2', 'Test Publisher1', 15.99, 4, 'A1');
  DBMS_OUTPUT.PUT_LINE('Add_Book procedure executed successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Verify if the trigger trg_insert_book_inventory has worked correctly
SELECT * FROM bs_Book_Inventory WHERE ISBN = 'ISBN102';
update bs_Book_Inventory set quantity = 12 where ISBN = 'ISBN102';
-- Test Package Procedure: Update_Book
BEGIN
  online_bookstore_mgmt.Update_Book('ISBN101', 'Test Book 1 Updated', 'Test Author Updated', 'Test Publisher Updated', 15.99, 1, 'A1');
  DBMS_OUTPUT.PUT_LINE('Update_Book procedure executed successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
SELECT * FROM bs_Book WHERE ISBN = 'ISBN101';


-- Verify if the trigger trg_update_book_inventory has worked correctly
SELECT * FROM bs_Book_Inventory WHERE ISBN = 'ISBN101';

-- Test Package Procedure: Add_Order
DECLARE
  v_customer_id bs_Customer.ID%TYPE;
  order_items online_bookstore_mgmt.t_order_items;
BEGIN
  -- Create a test customer
  INSERT INTO bs_Customer (Name, Address, Email, Phone)
  VALUES ('Zhihao', '101 Back St', 'john.doe@example.com', '555-4321')
  RETURNING ID INTO v_customer_id;

  -- Prepare the order items
  order_items := online_bookstore_mgmt.t_order_items();
  order_items.EXTEND;
  order_items(1).isbn := 'ISBN102';
  order_items(1).quantity := 4;

  -- Call the add_order procedure
  online_bookstore_mgmt.add_order(v_customer_id, order_items);
  DBMS_OUTPUT.PUT_LINE('Add_Order procedure executed successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

select * from bs_order;
select * from bs_customer;
select * from bs_order_items;

-- Test Package Function: Total_Order_Value
DECLARE
  v_total_value NUMBER(10, 2);
BEGIN
  v_total_value := online_bookstore_mgmt.total_order_value(1);
  DBMS_OUTPUT.PUT_LINE('Total_Order_Value function executed successfully. Total value: ' || v_total_value);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Test Package Function: Search_Books_By_Title
DECLARE
  v_search_result SYS_REFCURSOR;
  v_book bs_Book%ROWTYPE;
BEGIN
  v_search_result := online_bookstore_mgmt.search_books_by_title('Test Book 1');
  
  LOOP
    FETCH v_search_result INTO v_book;
    EXIT WHEN v_search_result%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Found book: ' || v_book.Title);
  END LOOP;
  CLOSE v_search_result;
  DBMS_OUTPUT.PUT_LINE('Search_Books_By_Title function executed successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
SELECT * FROM bs_book WHERE LOWER(Title) LIKE LOWER('%Test Book 1%');

-- Test Package Function: Search_Books_By_Author
DECLARE
  v_search_result SYS_REFCURSOR;
  v_book bs_Book%ROWTYPE;
BEGIN
  v_search_result := online_bookstore_mgmt.search_books_by_author('Test Author');
  
  LOOP
    FETCH v_search_result INTO v_book;
    EXIT WHEN v_search_result%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Found book: ' || v_book.Title);
  END LOOP;
  CLOSE v_search_result;
DBMS_OUTPUT.PUT_LINE('Search_Books_By_Author function executed successfully');
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Test Package Function: Total_Books_Sold
DECLARE
v_total_books_sold NUMBER(10);
BEGIN
v_total_books_sold := online_bookstore_mgmt.total_books_sold('ISBN101');
DBMS_OUTPUT.PUT_LINE('Total_Books_Sold function executed successfully. Total books sold: ' || v_total_books_sold);
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Test Package Function: Total_Order_Value
DECLARE
  v_total_order_value bs_Book.Price%TYPE;
  v_order_no bs_Order.Order_No%TYPE := 3; 
BEGIN
  v_total_order_value := online_bookstore_mgmt.total_order_value(v_order_no);
  DBMS_OUTPUT.PUT_LINE('Total_Order_Value function executed successfully. Order total value: ' || v_total_order_value);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Test Package Function: Search_Orders_By_Customer
DECLARE
  TYPE order_info_type IS RECORD (
    Order_No bs_Order.Order_No%TYPE,
    Order_Date bs_Order.Order_Date%TYPE,
    ISBN bs_Book.ISBN%TYPE,
    Title bs_Book.Title%TYPE,
    Quantity bs_Order_Items.Quantity%TYPE
  );
  v_search_result SYS_REFCURSOR;
  v_order_record order_info_type;
BEGIN
  v_search_result := online_bookstore_mgmt.search_orders_by_customer(1); -- Replace 1 with the desired customer ID
  
  LOOP
    FETCH v_search_result INTO v_order_record;
    EXIT WHEN v_search_result%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Order No: ' || v_order_record.Order_No || ', Order Date: ' || v_order_record.Order_Date || ', ISBN: ' || v_order_record.ISBN || ', Title: ' || v_order_record.Title || ', Quantity: ' || v_order_record.Quantity);
  END LOOP;
  CLOSE v_search_result;
  DBMS_OUTPUT.PUT_LINE('Search_Orders_By_Customer function executed successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

select * from bs_order_items;
select * from bs_Returned_Books;

DECLARE
  v_customer_id bs_Customer.ID%TYPE := 1; -- Replace with a valid customer ID
  v_order_no bs_Order.Order_No%TYPE := 3; -- Replace with a valid order number
  v_isbn bs_Book.ISBN%TYPE := 'ISBN102'; -- Replace with a valid ISBN
  v_quantity NUMBER := 1; -- Replace with the quantity of books to return
BEGIN
  -- First, let's find an order placed by the customer containing the book they want to return
  BEGIN
    SELECT o.Order_No
    INTO v_order_no
    FROM bs_Order o
    JOIN bs_Order_Items oi ON o.Order_No = oi.Order_No
    WHERE o.Customer_ID = v_customer_id AND oi.ISBN = v_isbn
    AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Error: No matching order found for the given ISBN and customer ID');
      RETURN;
  END;

  -- Add a returned book record
  online_bookstore_mgmt.return_books(v_customer_id, v_order_no, v_isbn, v_quantity);
  DBMS_OUTPUT.PUT_LINE('Return_Books procedure executed successfully');

  -- Check if the book inventory has been updated
  DECLARE
    v_inventory_quantity bs_Book_Inventory.Quantity%TYPE;
  BEGIN
    SELECT Quantity
    INTO v_inventory_quantity
    FROM bs_Book_Inventory
    WHERE ISBN = v_isbn;

    IF v_inventory_quantity >= v_quantity THEN
      DBMS_OUTPUT.PUT_LINE('Book inventory updated successfully. Current quantity: ' || v_inventory_quantity);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Error: Book inventory not updated');
    END IF;
  END;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


