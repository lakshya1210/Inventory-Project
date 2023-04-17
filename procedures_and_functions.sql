-- Procedures / Functions for our database.

-- Procedure to simulate a customer placing an order.
CREATE OR REPLACE PROCEDURE place_order(cust_id INT, pdt_id INT, qty INT)
AS $$
DECLARE ord_id INT;
DECLARE amt INT;
BEGIN
    BEGIN
        IF (qty <= (SELECT stock FROM product WHERE product_id = pdt_id)) THEN
            -- Calculating the bill amount beforehand.
            SELECT selling_price INTO amt FROM product WHERE product_id = pdt_id;
            amt = amt * qty;
            -- Create a new entry in customer_order, retrieve the generated order_id.
            INSERT INTO customer_order(quantity, amount) VALUES (qty, amt) RETURNING order_id INTO ord_id;
            -- Create a new entry in the orders relational table.
            INSERT INTO orders(order_id, customer_id, product_id) VALUES (ord_id, cust_id, pdt_id);

            -- Move the required amount of stock to reserved_stock.
            UPDATE product SET stock = stock - qty WHERE product_id = pdt_id;
            UPDATE product SET reserved_stock = reserved_stock + qty WHERE product_id = pdt_id;
        ELSE
            RAISE NOTICE 'Insufficient stock. Cannot place an order.';
        END IF;
    COMMIT;
    END;
END;
$$ LANGUAGE plpgsql;

-- Procedure to simulate a customer paying for an order.
CREATE OR REPLACE PROCEDURE pay_order(cust_id INT, ord_id INT, amt NUMERIC(10, 2), mode VARCHAR(50))
AS $$
DECLARE qty INT;
DECLARE pdt_id INT;
BEGIN
    BEGIN
        -- Checking if (order_id, customer_id) is there in orders & order_id = 'NOT PAID'.
        IF (EXISTS(SELECT * FROM orders WHERE order_id = ord_id AND customer_id = cust_id)) THEN

            IF (EXISTS(SELECT * FROM customer_order WHERE order_id = ord_id AND status = 'NOT PAID')) THEN

                SELECT quantity INTO qty FROM customer_order WHERE order_id = ord_id;
                SELECT product_id INTO pdt_id FROM orders WHERE order_id = ord_id;

                -- Checking if amount is correct.
                IF (amt = (SELECT amount FROM customer_order WHERE order_id = ord_id)) THEN
                    -- Inserting the tuple into the customer_payment relation.
                    INSERT INTO customer_payment(order_id, amount, payment_mode) VALUES (ord_id, amt, mode);
                    -- Updating the payment status and sending out the reserved stock.
                    UPDATE customer_order SET status = 'PAID' WHERE order_id = ord_id;
                    UPDATE product SET reserved_stock = reserved_stock - qty WHERE product_id = pdt_id;

                ELSE
                    RAISE NOTICE 'Amount being paid does not correspond to the bill amount, payment has not been made.';
                END IF;
            ELSE
                RAISE NOTICE 'This order has either been cancelled or already paid for.';
            END IF;
        ELSE 
            RAISE NOTICE 'The customer cannot pay for a non - existent order (or an order that is not their own).';
        END IF;
    COMMIT;
    END; 
END;
$$ LANGUAGE plpgsql;

-- Procedure to simulate the store placing an order for supplies (resulting in invoice creation).
CREATE OR REPLACE PROCEDURE place_invoice(sup_id INT, pdt_id INT, qty INT, bill NUMERIC(10, 2))
AS $$
DECLARE inv_id INT;
BEGIN
    BEGIN
        -- Create a new entry in invoice, retrieve the generated invoice_id.
        INSERT INTO invoice(quantity, bill_amount) VALUES (qty, bill) RETURNING invoice_id INTO inv_id;
        -- Create a new entry in the supplies relational table.
        INSERT INTO supplies(supplier_id, product_id, invoice_id) VALUES (sup_id, pdt_id, inv_id);
    COMMIT;
    END;
END;
$$ LANGUAGE plpgsql;

-- Procedure to simulate the store's payment for an invoice.
CREATE OR REPLACE PROCEDURE pay_invoice(sup_id INT, inv_id INT, amt NUMERIC(10, 2), mode VARCHAR(50))
AS $$
DECLARE qty INT;
DECLARE pdt_id INT;
BEGIN
    BEGIN
        -- Checking if (invoice_id, supplier_id) is there in orders & invoice_id = 'NOT PAID'.
        IF (EXISTS(SELECT * FROM supplies WHERE invoice_id = inv_id AND supplier_id = sup_id)) THEN
        
            IF (EXISTS(SELECT * FROM invoice WHERE invoice_id = inv_id AND status = 'NOT PAID')) THEN

                SELECT quantity INTO qty FROM invoice WHERE invoice_id = inv_id;
                SELECT product_id INTO pdt_id FROM supplies WHERE invoice_id = inv_id;

                -- Checking if amount = bill amount on the invoice.
                IF (amt = (SELECT bill_amount FROM invoice WHERE invoice_id = inv_id)) THEN
                    -- Updating the payment status and adding to our stock.
                    UPDATE invoice SET status = 'PAID' WHERE invoice_id = inv_id;
                    UPDATE product SET stock = stock + qty WHERE product_id = pdt_id;

                ELSE
                    RAISE NOTICE 'Amount being paid does not correspond to the bill amount, payment has not been made.';
                END IF;
            ELSE
                RAISE NOTICE 'This invoice has either been cancelled or already paid for.';
            END IF;
        ELSE 
            RAISE NOTICE 'The invoice does not exist or is unrelated to the given supplier.';
        END IF;
    COMMIT;
    END;
END;
$$ LANGUAGE plpgsql;
