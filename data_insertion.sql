-- File containing data insertions

INSERT INTO brand(brand_name) VALUES
('Yamaha'),
('Hertz'),
('Philips'),
('Ajanta'),
('Titan'),
('Borosil'),
('Tupperware'),
('Boat'),
('American Tourister'),
('Adidas'),
('Pears'),
('Axe'),
('Puma'),
('Voltas'),
('LG');

INSERT INTO category(category_name, parent_id, depth) VALUES
('Home & Kitchen', NULL, 0),
('Self Care', NULL, 0),
('Miscellaneous', NULL, 0),
('Appliances', 1, 1),
('Electronics', 1, 1),
('Storage & Containers', 1, 1),
('Beauty & Hygiene', 2, 1),
('Clothing & Accessories', 2, 1),
('Recreation', 2, 1),
('Music', 9, 2),
('Sports & Fitness', 9, 2),
('Travel', 9, 2);

INSERT INTO product(product_name, description, mrp, selling_price, stock, reserved_stock) VALUES
('Yamaha Guitar', 'A musical instrument.', 3500, 3500, 10, 1),
('Hertz Guitar', 'A musical instrument.', 4000, 3900, 10, 0),
('Philips Light Bulb', 'Lights up your life.', 300, 270, 15, 0),
('Ajanta Clock', 'Shows time.', 500, 460, 10, 0),
('Titan Clock', 'Time to shine.', 650, 650, 15, 0),
('Borosil Water Bottle', 'Stores water.', 149, 149, 25, 0),
('Tupperware Water Bottle', 'Storing water has never been easier.', 159, 140, 18, 0),
('Boat Earphones', 'Listen to music.', 499, 450, 5, 0),
('American Tourister Backpack', 'Bag for school & travel.', 1500, 1200, 13, 5),
('Adidas Wallet', 'Carry money + other essentials.', 750, 700, 20, 0),
('Pears Soap', 'Bathing Soap', 100, 80, 50, 0),
('Axe Deodorant', '300ml body deodorant.', 350, 350, 23, 0),
('Puma Shoes', 'Sports shoes: Sizes in range 5 - 9.', 1000, 900, 20, 0),
('Voltas AC', '1.4T, 5* air conditioner.', 40000, 37500, 5, 0),
('LG Refrigerator', '200L 4* double door refrigerator', 20000, 18000, 10, 0),
('LG TV', 'LG 43-inch UHD TV', 40000, 39000, 8, 0),
('Adidas Shoe', 'Shoe sizes in range 6 - 9.', 1200, 1200, 15, 0),
('Titan Sunglasses', 'Premium sunglasses.', 500, 450, 10, 0),
('Puma Mask', 'Protect your family.', 100, 75, 100, 0),
('Boat Smart Watch', 'Be smart by wearing a boat watch.', 2500, 2000, 15, 0);

INSERT INTO product_brand(product_id, brand_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 15),
(17, 10),
(18, 5),
(19, 13),
(20, 8);

INSERT INTO product_category(product_id, category_id) VALUES
(1, 10),
(2, 10),
(3, 4),
(4, 5),
(5, 5),
(6, 6),
(7, 6),
(8, 10),
(9, 12),
(10, 8),
(11, 7),
(12, 7),
(13, 11),
(14, 4),
(15, 4),
(16, 4),
(17, 11),
(18, 8),
(19, 8),
(20, 11);

INSERT INTO supplier(name, address, contact_number, email) VALUES
('Adar Baneerjee', 'L 10, APMC Market, Phase I, Danab, Navi Mumbai', 6864252212, 'adar@gmail.com'),
('Eva Aris', '487 Murad Mansion, SVP Road, Girgaum, Mumbai', 5682145769, 'eva@gamil.com'),
('Ishwar Das', '32/3204 Beadon Pura, Karol Bagh, Delhi', 9861312234, 'ishwar@hotmail.com'),
('Krishna Chakraborty', 'Opp. Tempo Stand, Majiwada, Thane (West)', 5646562845, 'krishna@yahoo.com'),
('Steve Clarke', '218, Veena Lbs Marg, Vikhroli, Mumbai', 9697125890, 'steve@gmail.com');

INSERT INTO customer(name, address, contact_number, email) VALUES
('Ram Manohar', '27, M R Lane, Manavarthi Pet, Bangalore, Karnataka', 1234537731, 'ram@gmail.com'),
('Kishan Malhotra', '1, Damodar Bhuvan, V Patel Rd, Vile Parle (west), Mumbai, Maharashtra', 2332456734, 'kishan@gmail.com'),
('Adrian Luna', 'P B No 6784, Avenue Road, J M Road, Bangalore, Karnataka', 6657276523, 'adrian@hotmail.com'),
('Alvaro Vazquez', 'Church Road, Jangpura, Delhi', 8574144446, 'alvero@gmail.com'),
('Mehul Patel', 'Shop No 18, Shivaji Nagar Chs, Cst Rd, Opp Swastik Chambers, Chembur, Mumbai', 8642309834, 'mehul@orkut.com'),
('Shreya Srivastava', '40, Shreepal Ind Est, Pawan Baug, Malad (west), Mumbai', 9875977880, 'shreya@gmail.com'),
('Rohit Mukheerjee', 'Sehrawat Bhawan, Nangal Dewat, Delhi', 5438412678, 'rohit@gmail.com'),
('Darshan Chatterjee', 'C/o Factory Store,775 Prerans, Hosakeri Halli, Bangalore', 7665333445, 'darshan@hotmail.com');

INSERT INTO invoice(invoice_date, quantity, bill_amount, status) VALUES
('2008-01-02 10:03:01', 6, 900, 'PAID'),
('2008-01-03 10:25:21', 7, 1000, 'PAID'),
('2008-01-03 13:32:00', 8, 12300, 'NOT PAID'),
('2008-01-04 9:42:01', 9, 4500, 'CANCELLED');

INSERT INTO customer_order(order_date, quantity, amount, status) VALUES
('2008-01-01 09:00:01', 2, 540, 'PAID'),
('2008-01-03 09:24:00', 3, 2700, 'PAID'),
('2008-01-03 10:14:01', 5, 6000, 'NOT PAID'),
('2008-01-04 12:44:31', 1, 3500, 'NOT PAID');

INSERT INTO invoice_payment(invoice_id, amount, payment_date, payment_mode) VALUES
(1, 900, '2008-01-02 15:03:01', 'CASH'),
(2, 1000, '2008-01-03 15:25:21', 'DIGITAL');

INSERT INTO customer_payment(order_id, amount, payment_date, payment_mode) VALUES
(1, 540, '2008-01-01 09:05:01', 'CARD'),
(2, 2700, '2008-01-03 09:29:00', 'CASH');

INSERT INTO supplies(invoice_id, supplier_id, product_id) VALUES
(1, 3, 10),
(2, 5, 5),
(3, 2, 1),
(4, 4, 7);

INSERT INTO orders(order_id, customer_id, product_id) VALUES
(1, 2, 3),
(2, 4, 13),
(3, 6, 9),
(4, 1, 1);
