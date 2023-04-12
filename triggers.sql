-- Trigger 1: Inserting a new book into bs_Book_Inventory with Quantity 1 when a new book is added to bs_Book
CREATE OR REPLACE TRIGGER trg_insert_book_inventory
AFTER INSERT ON bs_Book
FOR EACH ROW
BEGIN
  INSERT INTO bs_Book_Inventory (ISBN, Quantity)
  VALUES (:new.ISBN, 1);
END;
/

-- Trigger 2: Updating bs_Book_Inventory when a book is updated in bs_Book
CREATE OR REPLACE TRIGGER trg_update_book_inventory
AFTER UPDATE ON bs_Book
FOR EACH ROW
BEGIN
  UPDATE bs_Book_Inventory
  SET ISBN = :new.ISBN
  WHERE ISBN = :old.ISBN;
END;
/

-- Trigger 3: Decreasing the Quantity in bs_Book_Inventory when a new order is created in bs_Order
CREATE OR REPLACE TRIGGER trg_update_inventory
AFTER INSERT ON bs_Order_Items
FOR EACH ROW
BEGIN
  UPDATE bs_Book_Inventory
  SET Quantity = Quantity - :new.Quantity
  WHERE ISBN = :new.ISBN;
END;
/


CREATE OR REPLACE TRIGGER trg_bs_book_added_by_check
BEFORE INSERT OR UPDATE ON bs_Book
FOR EACH ROW
DECLARE
  invalid_added_by EXCEPTION;
BEGIN
  IF :NEW.Added_By != 'J1' AND :NEW.Added_By != 'A1' THEN
    RAISE invalid_added_by;
  END IF;
EXCEPTION
  WHEN invalid_added_by THEN
    RAISE_APPLICATION_ERROR(-20001, 'Invalid Added_By value. Must be a Staff');
END;
/

CREATE OR REPLACE TRIGGER bs_customer_id_trigger
BEFORE INSERT ON bs_Customer
FOR EACH ROW
BEGIN
  IF :new.ID IS NULL THEN
    SELECT bs_customer_seq.NEXTVAL INTO :new.ID FROM DUAL;
  END IF;
END;
/

