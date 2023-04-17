-- Trigger for automatically moving reserved stock back to the available stock after cancellation.
CREATE OR REPLACE FUNCTION move_stock()
RETURNS trigger
AS $$
DECLARE pdt_id INT;
DECLARE qty INT;
BEGIN
    SELECT quantity INTO qty FROM customer_order WHERE order_id = OLD.order_id; 
    SELECT product_id INTO pdt_id FROM orders WHERE order_id = OLD.order_id; 
    UPDATE product SET stock = stock + qty WHERE product_id = pdt_id;
    UPDATE product SET reserved_stock = reserved_stock - qty WHERE product_id = pdt_id;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER replace_stock
AFTER UPDATE ON customer_order
FOR EACH ROW
WHEN (OLD.status IS DISTINCT FROM 'CANCELLED' AND NEW.status = 'CANCELLED')
EXECUTE PROCEDURE move_stock();
