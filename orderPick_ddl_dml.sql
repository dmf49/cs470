/* DDL */
CREATE DATABASE orderPick;
use orderPick;

CREATE TABLE employee (
  employee_id int PRIMARY KEY NOT NULL,
  first_name varchar(30),
  last_name varchar(30),
  constraint chk_employee_id CHECK ((employee_id>999999 AND employee_id<10000000))
  );

CREATE TABLE device (
  device_id varchar(4) PRIMARY KEY NOT NULL,
  checked_out bit NOT NULL DEFAULT 0,
  checked_in bit NOT NULL DEFAULT 1
  );

CREATE TABLE employee_assigned_device (
  device_id varchar(4) PRIMARY KEY NOT NULL,
  employee_id int NOT NULL,
  constraint fk_employee_assigned_device_device_id_device_device_id FOREIGN KEY (device_id) REFERENCES device(device_id),
  constraint fk_employee_assigned_device_employee_id_employee_employee_id FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
  );

CREATE TABLE sled (
  sled_id int PRIMARY KEY NOT NULL,
  checked_out bit NOT NULL DEFAULT 0,
  checked_in bit NOT NULL DEFAULT 1,
  constraint chk_sled_id CHECK ((sled_id>9 AND sled_id<100))
  );

CREATE TABLE employee_select_sled (
  sled_id int NOT NULL,
  employee_id int NOT NULL,
  constraint fk_employee_select_sled__sled_id_sled_sled_id FOREIGN KEY (sled_id) REFERENCES sled(sled_id),
  constraint fk_employee_select_sled_employee_id_employee_employee_id FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
  );

CREATE TABLE assignment (
  assignment_id bigint PRIMARY KEY NOT NULL,
  batch_num int NOT NULL,
  store_num int NOT NULL,
  assigned bit NOT NULL DEFAULT 0,
  completed bit NOT NULL DEFAULT 0,
  constraint chk_assignment_id CHECK ((assignment_id>999999999 AND assignment_id<10000000000)),
  constraint chk_batch_num CHECK ((batch_num>99 AND batch_num<1000)),
  constraint chk_store_num CHECK ((store_num>9999 AND store_num<100000))
  );

CREATE TABLE sled_holds_assignment (
  sled_id int NOT NULL,
  assignment_id bigint PRIMARY KEY NOT NULL,
  constraint fk_sled_holds_assignment_sled_id_sled_sled_id FOREIGN KEY (sled_id) REFERENCES sled(sled_id),
  constraint fk_sled_holds_assignment_assignment_assignment_id FOREIGN KEY (assignment_id) REFERENCES assignment(assignment_id)
  );

CREATE TABLE tote (
  tote_id bigint PRIMARY KEY NOT NULL,
  tote_num int NOT NULL,
  constraint chk_tote_id CHECK ((tote_id>999999999 AND tote_id<10000000000))
  );

CREATE TABLE assignment_contains_tote (
  assignment_id bigint NOT NULL,
  tote_id bigint PRIMARY KEY NOT NULL,
  constraint fk_assign_contains_tote_assignment_id_assignment_assignment_id FOREIGN KEY (assignment_id) REFERENCES assignment(assignment_id),
  constraint fk_assignment_contains_tote_tote_id_tote_tote_id FOREIGN KEY (tote_id) REFERENCES tote(tote_id)
  );

CREATE TABLE product_type (
  product_id int UNIQUE NOT NULL,
  name varchar(30),
  floor_letter varchar(1) NOT NULL,
  floor_num int NOT NULL,
  bay_num int NOT NULL,
  col_num int NOT NULL,
  row_num int NOT NULL,
  constraint pk_location PRIMARY KEY(floor_letter, floor_num, bay_num, col_num, row_num),
  constraint chk_product_id CHECK ((product_id>99999 AND product_id<1000000)),
  constraint chk_floor_letter CHECK ((floor_letter IN ('A', 'B', 'C', 'D', 'E', 'F'))),
  constraint chk_floor_number CHECK ((floor_num>0 AND floor_num<4)),
  constraint chk_bay CHECK ((bay_num>0 AND bay_num<45)),
  constraint chk_col CHECK ((col_num>0 AND col_num<85 AND col_num%5=0)),
  constraint chk_row CHECK ((row_num>0 AND row_num<7))
  );

CREATE TABLE tote_has_product (
  tote_id bigint NOT NULL,
  product_id int NOT NULL,
  n_products int NOT NULL,
  constraint pk_tote_id_product_id PRIMARY KEY(tote_id, product_id),
  constraint fk_tote_has_product_tote_id_tote_tote_id FOREIGN KEY (tote_id) REFERENCES tote(tote_id), 
  constraint fk_tote_has_product_product_id_product_type_product_id FOREIGN KEY (product_id) REFERENCES product_type(product_id)
  );

/* DML */
INSERT INTO employee (employee_id, first_name, last_name) VALUES
(9497444, 'Emily', 'Foley'),
(3915663, 'Cole', 'Nelson'),
(6980853, 'Debsankar', 'Mukhopadhyay');

INSERT INTO device (device_id) VALUES
('T100'),
('T101'),
('T102');

INSERT INTO sled (sled_id) VALUES
(10),
(11),
(12),
(13),
(14),
(15);

INSERT INTO assignment (assignment_id, batch_num, store_num) VALUES
(2766071659, 300, 38051),
(9543348813, 300, 24821),
(7619894240, 300, 10665),
(3896247876, 300, 80654),
(3440843296, 301, 38051),
(5107890084, 301, 24821),
(2278397635, 301, 10665),
(6748993528, 301, 80654),
(5975588194, 302, 38051),
(8290277172, 302, 24821),
(6954810292, 302, 10665);

INSERT INTO tote (tote_id, tote_num) VALUES
(9131165160, 1),
(3202830973, 2),
(8377472049, 3),
(8691667874, 4),
(2489697111, 5),
(1047605944, 6),
(2612026443, 7),
(1769580216, 8),
(1504770190, 9),
(8535978366, 10),
(7589820971, 1),
(9663155190, 2),
(8243751075, 1),
(3378490353, 2),
(6351888075, 3),
(6768249480, 4),
(4402194177, 5),
(6132319263, 6),
(6187605491, 7),
(1880843555, 8),
(1362614203, 9),
(4545599371, 10),
(8590224330, 11),
(2473695860, 12),
(5510012539, 13),
(2518482881, 14),
(2270885802, 15),
(1518453003, 16),
(1892221083, 17),
(3632328134, 18),
(3863325209, 19),
(7830169257, 20),
(6904348014, 1),
(8561946938, 1),
(7962820305, 2),
(3620255643, 3),
(8224062556, 4),
(8904204936, 5),
(7928427104, 6),
(3707423831, 7),
(4904356513, 1),
(4590941113, 2),
(3652554340, 3),
(3983524208, 4),
(5159671394, 5),
(2193227815, 6),
(2161087477, 1),
(1975791527, 2),
(7568844880, 3),
(7793439220, 4),
(9065939713, 5),
(3819828504, 6),
(5579013535, 7),
(9177460310, 8),
(6004543551, 9),
(4125408007, 10),
(3136916781, 11),
(7618572491, 12),
(8238613082, 13),
(2665312640, 14),
(4062447387, 15),
(9338270719, 1),
(2558770183, 2),
(8032661559, 3),
(3290899347, 4),
(3091450156, 1),
(6693560050, 2),
(2969084359, 3),
(5456917812, 4),
(1181035225, 5),
(8845798021, 6),
(3717746139, 7),
(4526045495, 8),
(1973745561, 9),
(4788708050, 10),
(6505053701, 11),
(8453450528, 12),
(8226157573, 1),
(9989508037, 2),
(8423802340, 3),
(2585960708, 4),
(3474957638, 5),
(3316909932, 6),
(7028739993, 7),
(9681266813, 8),
(8353571844, 9),
(4159377743, 10),
(3745267364, 11),
(9322421339, 12),
(3835580469, 13),
(9826741273, 14),
(7608851284, 15),
(8436466007, 16),
(3877992782, 17),
(7195539802, 18),
(7413598049, 19),
(5522913217, 20),
(2085346702, 21),
(3649029096, 22),
(2252505613, 1),
(7896807132, 2),
(3294611261, 3),
(9842480392, 4),
(6892364354, 5),
(3793107691, 6),
(8469851782, 7),
(3419396978, 8),
(8421453738, 9);

INSERT INTO product_type (product_id, name, floor_letter, floor_num, bay_num, col_num, row_num) VALUES
(928255, 'GHIR DRK RSP BAR', 'A', 2, 44, 65, 5),
(794834, 'TWIX MINI 9.7OZ BAG', 'A', 2, 44, 55, 5),
(280154, 'TWIZZ STRAW BIG BAG', 'A', 2, 44, 55, 4),
(724186, 'MENTOS MXD FRUIT', 'A', 2, 44, 50, 2),
(521476, 'AIRHD XTRM BITES', 'A', 2, 44, 30, 2),
(154089, 'FERRERO GFT BOX', 'A', 2, 44, 25, 5),
(879975, 'M&M FUDGE SHARE', 'A', 2, 44, 20, 1),
(132608, 'SOUR PTCH THTR BOX', 'A', 2, 44, 20, 3),
(570478, 'LINDT WHT TRUF', 'A', 2, 44, 15, 4),
(131193, 'SMARTIES GIANT', 'A', 2, 44, 5, 1);

INSERT INTO assignment_contains_tote (assignment_id, tote_id) VALUES
(2766071659, 7589820971),
(2766071659, 9663155190),
(7619894240, 6904348014);

INSERT INTO tote_has_product (tote_id, product_id, n_products) VALUES
(7589820971, 928255, 10),
(7589820971, 794834, 4),
(7589820971, 280154, 1),
(7589820971, 724186, 15),
(7589820971, 570478, 2),
(7589820971, 131193, 5),
(9663155190, 928255, 8),
(9663155190, 794834, 1),
(9663155190, 280154, 3),
(9663155190, 724186, 30),
(9663155190, 570478, 3),
(9663155190, 131193, 6),
(6904348014, 521476, 4),
(6904348014, 154089, 1),
(6904348014, 879975, 2),
(6904348014, 132608, 2),
(6904348014, 570478, 4),
(6904348014, 131193, 6);