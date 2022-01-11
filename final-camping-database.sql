DROP DATABASE IF EXISTS camping_database;
CREATE DATABASE camping_database;
USE camping_database;

CREATE TABLE IF NOT EXISTS customer (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    phoneNumber VARCHAR(15) NOT NULL,
    email VARCHAR(75),
    campingKey BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS discount (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    discountPrice INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS campPosition (
    id CHAR(2) NOT NULL PRIMARY KEY,
    adjacent_to VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS payment (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    paymentDate DATE NOT NULL,
    price INT NOT NULL,
    customerId INT NOT NULL,
    discountId INT NOT NULL,
    FOREIGN KEY (customerId) REFERENCES customer(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (discountId) REFERENCES discount(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS visit (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    cancel BOOLEAN DEFAULT FALSE,
    arrival_date DATE NOT NULL,
    departure_date DATE NOT NULL,
    num_of_people INT NOT NULL,
    id_payment INT NOT NULL,
    id_customer INT NOT NULL,
    id_discount INT NOT NULL,
    id_position CHAR(2) NOT NULL,
    FOREIGN KEY (id_payment) REFERENCES payment(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_customer) REFERENCES customer(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_discount) REFERENCES discount(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_position) REFERENCES campPosition(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS feedback (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    feedback_date DATE,
    feedback varchar(255),
    id_visit INT NOT NULL,
    FOREIGN KEY (id_visit) REFERENCES visit(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS equipment (
    id CHAR(2) NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    low_period_price INT NOT NULL,
    high_period_price INT NOT NULL
);

CREATE TABLE IF NOT EXISTS associated_with (
    paymentId INT NOT NULL,
    equipmentId CHAR(2) NOT NULL,
    PRIMARY KEY (paymentId,equipmentId),
    FOREIGN KEY (paymentId) REFERENCES payment(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (equipmentId) REFERENCES equipment(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS room (
    id CHAR(2) NOT NULL PRIMARY KEY,
    roomType VARCHAR(30) NOT NULL,
    low_period_price INT NOT NULL,
    high_period_price INT NOT NULL,
    FOREIGN KEY (id) REFERENCES campPosition(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS campsite_spot (
    id CHAR(2) NOT NULL PRIMARY KEY,
    low_period_price INT NOT NULL,
    high_period_price INT NOT NULL,
    FOREIGN KEY (id) REFERENCES campPosition(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS personal_equipment (
    id CHAR(2) NOT NULL PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES equipment(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS supplied_from_camping (
    id CHAR(2) NOT NULL PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES equipment(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS connected (
    id_equipment CHAR(2) NOT NULL,
    id_visit INT NOT NULL,
    PRIMARY KEY(id_equipment,id_visit),
    FOREIGN KEY (id_equipment) REFERENCES equipment(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_visit) REFERENCES visit(id) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Colas', 'Russon', '903-518-0758', 'crusson0@ihg.com', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Korrie', 'Mell', '953-553-3197', 'kmell1@comcast.net', true);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Eugenio', 'De Few', '849-653-4616', 'edefew2@freewebs.com', true);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Tibold', 'Meus', '566-728-5522', 'tmeus3@ifeng.com', true);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Jeddy', 'Wadforth', '320-849-4136', 'jwadforth4@networksolutions.com', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Justis', 'Grayley', '620-561-4913', 'jgrayley5@ow.ly', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Tomkin', 'Isworth', '257-657-7740', 'tisworth6@de.vu', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Ammamaria', 'Habron', '188-145-3042', 'ahabron7@behance.net', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Abby', 'Burthom', '310-366-9325', 'aburthom8@lycos.com', true);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Ediva', 'Farlamb', '376-576-1419', 'efarlamb9@theatlantic.com', true);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Twila', 'Simpole', '400-154-4372', 'tsimpolea@cyberchimps.com', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Willabella', 'Blenkinship', '252-224-2354', 'wblenkinshipb@photobucket.com', true);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Amery', 'McCreery', '856-602-9232', 'amccreeryc@bluehost.com', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Ollie', 'Rundall', '970-257-0939', 'orundalld@sbwire.com', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Traci', 'Lemerle', '794-889-6132', 'tlemerlee@newyorker.com', true);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Marrissa', 'Amyes', '424-852-9793', 'mamyesf@artisteer.com', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Ginelle', 'Ousby', '818-315-2487', 'gousbyg@live.com', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Consalve', 'Elderbrant', '391-128-7761', 'celderbranth@people.com.cn', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Dotti', 'Bilby', '175-295-3757', 'dbilbyi@fastcompany.com', false);
insert into customer (fname, lname, phoneNumber, email, campingKey) values ('Jason', 'Kinrade', '776-346-1872', 'jkinradej@jugem.jp', true);

insert into discount (discountPrice) values (10);
insert into discount (discountPrice) values (0);
insert into discount (discountPrice) values (5);
insert into discount (discountPrice) values (5);
insert into discount (discountPrice) values (40);
insert into discount (discountPrice) values (30);
insert into discount (discountPrice) values (25);
insert into discount (discountPrice) values (20);
insert into discount (discountPrice) values (30);
insert into discount (discountPrice) values (5);
insert into discount (discountPrice) values (30);
insert into discount (discountPrice) values (5);
insert into discount (discountPrice) values (0);
insert into discount (discountPrice) values (20);
insert into discount (discountPrice) values (35);
insert into discount (discountPrice) values (30);
insert into discount (discountPrice) values (35);
insert into discount (discountPrice) values (20);
insert into discount (discountPrice) values (15);
insert into discount (discountPrice) values (10);

insert into campPosition (id, adjacent_to) values ('1', '2');
insert into campPosition (id, adjacent_to) values ('2', '1,3');
insert into campPosition (id, adjacent_to) values ('3', '2,4');
insert into campPosition (id, adjacent_to) values ('4', '3,5');
insert into campPosition (id, adjacent_to) values ('5', '4,6');
insert into campPosition (id, adjacent_to) values ('6', '5,7');
insert into campPosition (id, adjacent_to) values ('7', '6,8');
insert into campPosition (id, adjacent_to) values ('8', '7,9');
insert into campPosition (id, adjacent_to) values ('9', '8,10');
insert into campPosition (id, adjacent_to) values ('10', '9,11');
insert into campPosition (id, adjacent_to) values ('11', '10,12');
insert into campPosition (id, adjacent_to) values ('12', '11,13');
insert into campPosition (id, adjacent_to) values ('13', '12,14');
insert into campPosition (id, adjacent_to) values ('14', '13,15');
insert into campPosition (id, adjacent_to) values ('15', '14,16');
insert into campPosition (id, adjacent_to) values ('16', '15,17');
insert into campPosition (id, adjacent_to) values ('17', '16,18');
insert into campPosition (id, adjacent_to) values ('18', '17,19');
insert into campPosition (id, adjacent_to) values ('19', '18,20');
insert into campPosition (id, adjacent_to) values ('20', '19,21');
insert into campPosition (id, adjacent_to) values ('21', '20,22');
insert into campPosition (id, adjacent_to) values ('22', '21,23');
insert into campPosition (id, adjacent_to) values ('23', '22,24');
insert into campPosition (id, adjacent_to) values ('24', '23,25');
insert into campPosition (id, adjacent_to) values ('25', '24,26');
insert into campPosition (id, adjacent_to) values ('26', '25,27');
insert into campPosition (id, adjacent_to) values ('27', '26,28');
insert into campPosition (id, adjacent_to) values ('28', '27,29');
insert into campPosition (id, adjacent_to) values ('29', '28,30');
insert into campPosition (id, adjacent_to) values ('30', '29');
insert into campPosition (id, adjacent_to) values ('A1', 'A2');
insert into campPosition (id, adjacent_to) values ('A2', 'A1,A3');
insert into campPosition (id, adjacent_to) values ('A3', 'A2,A4');
insert into campPosition (id, adjacent_to) values ('A4', 'A3,A5');
insert into campPosition (id, adjacent_to) values ('A5', 'A4');
insert into campPosition (id, adjacent_to) values ('B1', 'B2');
insert into campPosition (id, adjacent_to) values ('B2', 'B1,B3');
insert into campPosition (id, adjacent_to) values ('B3', 'B2,B4');
insert into campPosition (id, adjacent_to) values ('B4', 'B3,B5');
insert into campPosition (id, adjacent_to) values ('B5', 'B4');

insert into room (id, roomType, low_period_price, high_period_price) values ('A1', 'triple', 50, 70);
insert into room (id, roomType, low_period_price, high_period_price) values ('A2', 'single', 35, 55);
insert into room (id, roomType, low_period_price, high_period_price) values ('A3', 'double', 40, 60);
insert into room (id, roomType, low_period_price, high_period_price) values ('A4', 'single', 35, 55);
insert into room (id, roomType, low_period_price, high_period_price) values ('A5', 'triple', 50, 70);
insert into room (id, roomType, low_period_price, high_period_price) values ('B1', 'triple', 50, 70);
insert into room (id, roomType, low_period_price, high_period_price) values ('B2', 'single', 35, 55);
insert into room (id, roomType, low_period_price, high_period_price) values ('B3', 'double', 40, 60);
insert into room (id, roomType, low_period_price, high_period_price) values ('B4', 'single', 35, 55);
insert into room (id, roomType, low_period_price, high_period_price) values ('B5', 'single', 35, 55);

insert into campsite_spot (id, low_period_price, high_period_price) values ('1', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('2', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('3', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('4', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('5', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('6', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('7', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('8', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('9', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('10', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('11', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('12', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('13', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('14', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('15', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('16', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('17', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('18', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('19', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('20', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('21', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('22', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('23', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('24', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('25', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('26', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('27', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('28', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('29', 7, 15);
insert into campsite_spot (id, low_period_price, high_period_price) values ('30', 7, 15);

insert into equipment (id, name, low_period_price, high_period_price) values ('CA', 'car', 2.5, 3);
insert into equipment (id, name, low_period_price, high_period_price) values ('TR', 'trailer', 5, 6.5);
insert into equipment (id, name, low_period_price, high_period_price) values ('BT', 'big tent', 5, 6);
insert into equipment (id, name, low_period_price, high_period_price) values ('ST', 'small tent', 4, 5);
insert into equipment (id, name, low_period_price, high_period_price) values ('MO', 'motorcycle', 2, 2.5);
insert into equipment (id, name, low_period_price, high_period_price) values ('PW', 'power', 4, 4);

insert into personal_equipment (id) values ('CA');
insert into personal_equipment (id) values ('TR');
insert into personal_equipment (id) values ('BT');
insert into personal_equipment (id) values ('ST');
insert into personal_equipment (id) values ('MO');
insert into personal_equipment (id) values ('PW');

insert into supplied_from_camping (id) values ('CA');
insert into supplied_from_camping (id) values ('TR');
insert into supplied_from_camping (id) values ('BT');
insert into supplied_from_camping (id) values ('ST');
insert into supplied_from_camping (id) values ('MO');
insert into supplied_from_camping (id) values ('PW');

-- 7 euro to atomo ypsili / 5 euro xamhlh enhlikas
-- 4.5 euro ypsili / 3 euro xamhlh paidi
insert into payment (paymentDate, price, customerId, discountId) values ('2021-7-27', 230.00, 1, 1);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-9-12', 96.00, 2, 2);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-10-25', 147.00, 3, 3);
insert into payment (paymentDate, price, customerId, discountId) values ('2020-6-9', 135.00, 4, 4);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-4-25', 200.00, 5, 5);
insert into payment (paymentDate, price, customerId, discountId) values ('2020-3-8', 250.00, 6, 6);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-2-13', 300.00, 7, 7);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-12-21', 200.00, 8, 8);
insert into payment (paymentDate, price, customerId, discountId) values ('2020-9-30', 64.00, 9, 9);
insert into payment (paymentDate, price, customerId, discountId) values ('2020-3-17', 104.00, 10, 10);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-8-5', 182.50, 11, 11);
insert into payment (paymentDate, price, customerId, discountId) values ('2020-11-21', 160.00, 12, 12);
insert into payment (paymentDate, price, customerId, discountId) values ('2020-6-28', 120.00, 13, 13);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-9-23', 175.00, 14, 14);
insert into payment (paymentDate, price, customerId, discountId) values ('2020-10-21', 175.00, 15, 15);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-3-21', 252.00, 16, 16);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-7-5', 124.00, 17, 17);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-1-21', 46.00, 18, 18);
insert into payment (paymentDate, price, customerId, discountId) values ('2020-3-6', 84.00, 19, 19);
insert into payment (paymentDate, price, customerId, discountId) values ('2021-8-2', 167.50, 20, 20);

insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2020-7-16','2020-7-21', 4, 1, 1, 1, '1');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-9-8','2021-9-12', 3, 2, 2, 2, '3');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-10-18', '2021-10-25', 2, 3, 3, 3, '7');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (true,'2020-6-4', '2020-6-9', 3, 4, 4, 4, '10');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-4-20', '2021-4-24', 3, 5, 5, 5, 'A1');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2020-3-3', '2020-3-8', 3, 6, 6, 6, 'A5');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-2-5','2021-2-11', 3, 7, 7, 7, 'B1');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-12-16','2021-12-21', 2, 8, 8, 8, 'A3');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2020-9-26','2020-9-30', 1, 9, 9, 9, '11');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2020-3-13','2020-3-17', 2, 10, 10, 10, '25');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-7-31','2021-8-5', 2, 11, 11, 11, '30');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2020-11-17', '2020-11-21', 2, 12, 12, 12, 'B3');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2020-6-22','2020-6-28', 1, 13, 13, 13, '21');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-9-16','2021-9-21', 1, 14, 14, 14, 'A4');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (true,'2020-10-16','2020-10-21', 1, 15, 15, 15, 'B4');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-3-12','2021-3-21', 3, 16, 16, 16, '23');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-7-1','2021-7-5', 1, 17, 17, 17, '12');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-1-19','2021-1-21', 2, 18, 18, 18, '15');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2020-3-2','2020-3-6', 2, 19, 19, 19, '19');
insert into visit (cancel, arrival_date, departure_date, num_of_people,id_payment, id_customer, id_discount, id_position) values (false,'2021-7-27','2021-8-1', 4, 20, 20, 20, '27');

insert into connected (id_equipment, id_visit) values ('CA', 1);
insert into connected (id_equipment, id_visit) values ('TR', 10);
insert into connected (id_equipment, id_visit) values ('ST', 13);
insert into connected (id_equipment, id_visit) values ('ST', 16);
insert into connected (id_equipment, id_visit) values ('MO', 18);
insert into connected (id_equipment, id_visit) values ('PW', 3);
insert into connected (id_equipment, id_visit) values ('CA', 16);
insert into connected (id_equipment, id_visit) values ('TR', 20);
insert into connected (id_equipment, id_visit) values ('BT', 4);
insert into connected (id_equipment, id_visit) values ('ST', 15);
insert into connected (id_equipment, id_visit) values ('MO', 11);
insert into connected (id_equipment, id_visit) values ('PW', 17);
insert into connected (id_equipment, id_visit) values ('CA', 15);
insert into connected (id_equipment, id_visit) values ('PW', 13);
insert into connected (id_equipment, id_visit) values ('ST', 17);
insert into connected (id_equipment, id_visit) values ('ST', 9);
insert into connected (id_equipment, id_visit) values ('ST', 11);
insert into connected (id_equipment, id_visit) values ('PW', 9);
insert into connected (id_equipment, id_visit) values ('PW', 18);
insert into connected (id_equipment, id_visit) values ('TR', 2);
insert into connected (id_equipment, id_visit) values ('ST', 19);
insert into connected (id_equipment, id_visit) values ('PW', 20);

insert into associated_with (equipmentId ,paymentId) values ('CA', 1);
insert into associated_with (equipmentId ,paymentId) values ('TR', 10);
insert into associated_with (equipmentId ,paymentId) values ('ST', 13);
insert into associated_with (equipmentId ,paymentId) values ('ST', 16);
insert into associated_with (equipmentId ,paymentId) values ('MO', 18);
insert into associated_with (equipmentId ,paymentId) values ('PW', 3);
insert into associated_with (equipmentId ,paymentId) values ('CA', 16);
insert into associated_with (equipmentId ,paymentId) values ('TR', 20);
insert into associated_with (equipmentId ,paymentId) values ('BT', 4);
insert into associated_with (equipmentId ,paymentId) values ('ST', 15);
insert into associated_with (equipmentId ,paymentId) values ('MO', 11);
insert into associated_with (equipmentId ,paymentId) values ('PW', 17);
insert into associated_with (equipmentId ,paymentId) values ('CA', 15);
insert into associated_with (equipmentId ,paymentId) values ('PW', 13);
insert into associated_with (equipmentId ,paymentId) values ('ST', 17);
insert into associated_with (equipmentId ,paymentId) values ('ST', 9);
insert into associated_with (equipmentId ,paymentId) values ('ST', 11);
insert into associated_with (equipmentId ,paymentId) values ('PW', 9);
insert into associated_with (equipmentId ,paymentId) values ('PW', 18);
insert into associated_with (equipmentId ,paymentId) values ('TR', 2);
insert into associated_with (equipmentId ,paymentId) values ('ST', 19);
insert into associated_with (equipmentId ,paymentId) values ('PW', 20);

insert into feedback(feedback_date,feedback,id_visit) values ('2021-11-3','Excellent Place!',3);
insert into feedback(feedback_date,feedback,id_visit) values ('2021-05-6','The rooms were clean, very comfortable, and the staff was amazing.',5);
insert into feedback(feedback_date,feedback,id_visit) values ('2020-03-8','The staff at this property are all great! They all go above and beyond to make your stay comfortable',6);
insert into feedback(feedback_date,feedback,id_visit) values ('2021-09-29','Just an amazing place and for star lovers! take your telescope if you can, ther is no light pollution and a wonderful heaven. And sooo calm!',14);