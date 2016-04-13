/*
CSERE:
EZT: VARCHAR2 (
ERRE: VARCHAR(
(igen ott extra szokoz van a number elott)
EZT:  NUMBER
ERRE:  INT
TOROLNI:
NOT DEREFERRABLE

ADMIN USER: USERNAME: admin 
			PASSWORD: admin
TEST USER: USERNAME: teszt
		   PASSWORD: teszt
*/

DROP DATABASE IF EXISTS unizon;

CREATE DATABASE unizon CHARACTER SET UTF8;

USE unizon;

CREATE TABLE ADDRESS
  (
    ADDRESS_ID INT NOT NULL ,
    ZIP        VARCHAR(10) NOT NULL ,
    COUNTRY    VARCHAR(100) NOT NULL ,
    CITY       VARCHAR(100) NOT NULL ,
    STREET     VARCHAR(100) NOT NULL ,
    STR_NUMBER INT NOT NULL ,
    FLOOR      INT ,
    DOOR       INT
  ) ;
ALTER TABLE ADDRESS ADD CONSTRAINT ADDRESS_PK PRIMARY KEY ( ADDRESS_ID ) ;
ALTER TABLE ADDRESS ADD CONSTRAINT ADDRESS__UN UNIQUE ( ZIP , COUNTRY , CITY , STREET , STR_NUMBER , FLOOR , DOOR ) ;


CREATE TABLE ADDRESS_TO_USER
  (
    USER_ID    INT NOT NULL ,
    ADDRESS_ID INT NOT NULL
  ) ;
ALTER TABLE ADDRESS_TO_USER ADD CONSTRAINT ADDRESSES_OF_USER_PK PRIMARY KEY ( USER_ID, ADDRESS_ID ) ;


CREATE TABLE ADMINISTRATOR
  ( USER_ID INT NOT NULL
  ) ;
ALTER TABLE ADMINISTRATOR ADD CONSTRAINT ADMINISTRATOR_PK PRIMARY KEY ( USER_ID ) ;


CREATE TABLE CATEGORY
  (
    CATEGORY_ID INT NOT NULL ,
    NAME        VARCHAR(100) NOT NULL
  ) ;
ALTER TABLE CATEGORY ADD CONSTRAINT CATEGORY_PK PRIMARY KEY ( CATEGORY_ID ) ;
ALTER TABLE CATEGORY ADD CONSTRAINT CATEGORY_UNIQUE UNIQUE ( NAME ) ;


CREATE TABLE CAT_TO_PROD
  (
    PRODUCT_ID  INT NOT NULL ,
    CATEGORY_ID INT NOT NULL
  ) ;
ALTER TABLE CAT_TO_PROD ADD CONSTRAINT CAT_TO_PROD_PK PRIMARY KEY ( PRODUCT_ID, CATEGORY_ID ) ;


CREATE TABLE IMAGE
  ( IMAGE_ID INT NOT NULL , IMAGE_URL VARCHAR(1000)
  ) ;
ALTER TABLE IMAGE ADD CONSTRAINT IMAGE_PK PRIMARY KEY ( IMAGE_ID ) ;
ALTER TABLE IMAGE ADD CONSTRAINT IMAGE__UN UNIQUE ( IMAGE_URL ) ;


CREATE TABLE PHONE_NUMBER
  (
    PHONE_NUMBER_ID INT NOT NULL ,
    PHONE_NUMBER    VARCHAR(100) NOT NULL
  ) ;
ALTER TABLE PHONE_NUMBER ADD CONSTRAINT PHONE_NUMBER_PK PRIMARY KEY ( PHONE_NUMBER_ID ) ;
ALTER TABLE PHONE_NUMBER ADD CONSTRAINT PHONE_NUMBER__UNIQUE UNIQUE ( PHONE_NUMBER ) ;


CREATE TABLE PRODUCT
  (
    PRODUCT_ID       INT NOT NULL ,
    TITLE            VARCHAR(100) NOT NULL ,
    PRICE            INT ,
    AMOUNT           INT ,
    DESCRIPTION      VARCHAR(1000) ,
    DEFAULT_IMAGE_ID INT NOT NULL
  ) ;
ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_PK PRIMARY KEY ( PRODUCT_ID ) ;


CREATE TABLE PRODUCT_TO_IMAGE
  (
    PRODUCT_ID INT NOT NULL ,
    IMAGE_ID   INT NOT NULL
  ) ;
ALTER TABLE PRODUCT_TO_IMAGE ADD CONSTRAINT PRODUCT_TO_IMAGE_PK PRIMARY KEY ( PRODUCT_ID, IMAGE_ID ) ;


CREATE TABLE PROD_TO_ORDER
  (
    ORDER_ID   INT NOT NULL ,
    PRODUCT_ID INT NOT NULL ,
    AMOUNT     INT NOT NULL
  ) ;
ALTER TABLE PROD_TO_ORDER ADD CONSTRAINT PROD_TO_ORDER_PK PRIMARY KEY ( ORDER_ID, PRODUCT_ID ) ;


CREATE TABLE PROD_TO_TAG
  (
    PRODUCT_ID INT NOT NULL ,
    TAG_ID     INT NOT NULL
  ) ;
ALTER TABLE PROD_TO_TAG ADD CONSTRAINT PROD_TO_TAG_PK PRIMARY KEY ( PRODUCT_ID, TAG_ID ) ;


CREATE TABLE TAG
  ( TAG_ID INT NOT NULL , NAME VARCHAR(100) NOT NULL
  ) ;
ALTER TABLE TAG ADD CONSTRAINT TAG_PK PRIMARY KEY ( TAG_ID ) ;
ALTER TABLE TAG ADD CONSTRAINT TAG_UNIQUE UNIQUE ( NAME ) ;


CREATE TABLE UNI_ORDER
  (
    ORDER_ID            INT NOT NULL ,
    USER_ID             INT NOT NULL ,
    PHONE_NUMBER_ID     INT NOT NULL ,
    ORDER_DATE          DATE NOT NULL ,
    SHIPPING_ADDRESS_ID INT NOT NULL ,
    BILLING_ADDRESS_ID  INT NOT NULL
  ) ;
ALTER TABLE UNI_ORDER ADD CONSTRAINT ORDER_PK PRIMARY KEY ( ORDER_ID ) ;


CREATE TABLE UNI_USER
  (
    USER_ID           INT NOT NULL ,
    USERNAME          VARCHAR(100) NOT NULL ,
    PASSWORD          VARCHAR(100) NOT NULL ,
    E_MAIL            VARCHAR(100) NOT NULL ,
    NAME              VARCHAR(100) NOT NULL ,
    REGISTRATION_DATE DATE NOT NULL
  ) ;
ALTER TABLE UNI_USER ADD CONSTRAINT UNI_USER_PK PRIMARY KEY ( USER_ID ) ;
ALTER TABLE UNI_USER ADD CONSTRAINT UNI_USER_EMAIL UNIQUE ( E_MAIL ) ;
ALTER TABLE UNI_USER ADD CONSTRAINT UNI_USER_USERNAME UNIQUE ( USERNAME ) ;


CREATE TABLE USER_TO_PHONE_NUMBER
  (
    USER_ID         INT NOT NULL ,
    PHONE_NUMBER_ID INT NOT NULL
  ) ;
ALTER TABLE USER_TO_PHONE_NUMBER ADD CONSTRAINT USER_TO_PHONE_NUMBER_PK PRIMARY KEY ( USER_ID, PHONE_NUMBER_ID ) ;


ALTER TABLE ADDRESS_TO_USER ADD CONSTRAINT ADDRESS_TO_USER_ADDRESS_FK FOREIGN KEY ( ADDRESS_ID ) REFERENCES ADDRESS ( ADDRESS_ID ) ;

ALTER TABLE ADDRESS_TO_USER ADD CONSTRAINT ADDRESS_TO_USER_UNI_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES UNI_USER ( USER_ID ) ;

ALTER TABLE ADMINISTRATOR ADD CONSTRAINT ADMINISTRATOR_UNI_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES UNI_USER ( USER_ID ) ;

ALTER TABLE CAT_TO_PROD ADD CONSTRAINT CAT_TO_PROD_CATEGORY_FK FOREIGN KEY ( CATEGORY_ID ) REFERENCES CATEGORY ( CATEGORY_ID ) ;

ALTER TABLE CAT_TO_PROD ADD CONSTRAINT CAT_TO_PROD_PRODUCT_FK FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT ( PRODUCT_ID ) ;

ALTER TABLE UNI_ORDER ADD CONSTRAINT ORDER_BI_ADDRESS_FK FOREIGN KEY ( BILLING_ADDRESS_ID ) REFERENCES ADDRESS ( ADDRESS_ID ) ;

ALTER TABLE UNI_ORDER ADD CONSTRAINT ORDER_PHONE_NUMBER_FK FOREIGN KEY ( PHONE_NUMBER_ID ) REFERENCES PHONE_NUMBER ( PHONE_NUMBER_ID ) ;

ALTER TABLE UNI_ORDER ADD CONSTRAINT ORDER_SH_ADDRESS_FK FOREIGN KEY ( SHIPPING_ADDRESS_ID ) REFERENCES ADDRESS ( ADDRESS_ID ) ;

ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_IMAGE_FK FOREIGN KEY ( DEFAULT_IMAGE_ID ) REFERENCES IMAGE ( IMAGE_ID ) ;

ALTER TABLE PRODUCT_TO_IMAGE ADD CONSTRAINT PRODUCT_TO_IMAGE_IMAGE_FK FOREIGN KEY ( IMAGE_ID ) REFERENCES IMAGE ( IMAGE_ID ) ;

ALTER TABLE PRODUCT_TO_IMAGE ADD CONSTRAINT PRODUCT_TO_IMAGE_PRODUCT_FK FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT ( PRODUCT_ID ) ;

ALTER TABLE PROD_TO_ORDER ADD CONSTRAINT PROD_TO_ORDER_ORDER_FK FOREIGN KEY ( ORDER_ID ) REFERENCES UNI_ORDER ( ORDER_ID ) ;

ALTER TABLE PROD_TO_ORDER ADD CONSTRAINT PROD_TO_ORDER_PRODUCT_FK FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT ( PRODUCT_ID ) ;

ALTER TABLE PROD_TO_TAG ADD CONSTRAINT PROD_TO_TAG_PRODUCT_FK FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT ( PRODUCT_ID ) ;

ALTER TABLE PROD_TO_TAG ADD CONSTRAINT PROD_TO_TAG_TAG_FK FOREIGN KEY ( TAG_ID ) REFERENCES TAG ( TAG_ID ) ;

ALTER TABLE UNI_ORDER ADD CONSTRAINT UNI_ORDER_UNI_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES UNI_USER ( USER_ID ) ;

ALTER TABLE USER_TO_PHONE_NUMBER ADD CONSTRAINT USER_TO_PHONE_NUMBER_FK1 FOREIGN KEY ( PHONE_NUMBER_ID ) REFERENCES PHONE_NUMBER ( PHONE_NUMBER_ID ) ;

ALTER TABLE USER_TO_PHONE_NUMBER ADD CONSTRAINT USER_TO_PHONE_NUMBER_FK2 FOREIGN KEY ( USER_ID ) REFERENCES UNI_USER ( USER_ID ) ;

INSERT INTO UNI_USER VALUES(1,'admin', 'cveqGRZfe2VtNuO0yDGhYviUTZWxmiIt3aZmzqm80n8=$NaOrIMoClDCyLPGoVsClrEYLGKw7U5uYFJkrhAhC0R4=','admin@gmail.com','admin','2016-04-09');
INSERT INTO UNI_USER VALUES(2,'teszt','KIkvsQZnyEk0LQLlYred1uylvnldBomKstriJL95CsE=$rQWuk868O5zFfigoWjnG+Hlmy6bpMnXjslZw+mOzV2Y=','teszt@gmail.com','teszt', '2016-04-09');

INSERT INTO ADMINISTRATOR VALUES(1);

INSERT INTO ADDRESS VALUES(1, 5342, 'Hungary', 'Debrecen', 'Kassai út', 1, 4, 2); 
INSERT INTO ADDRESS VALUES(2, 3321, 'Hungary', 'Budapest', 'Pesti utca', 12, 10, 32); 
INSERT INTO ADDRESS VALUES(3, 3300, 'Hungary', 'Eger', 'Dobó utca', 10, 122, 10);

INSERT INTO ADDRESS_TO_USER VALUES(1, 1);
INSERT INTO ADDRESS_TO_USER VALUES(2, 2);
INSERT INTO ADDRESS_TO_USER VALUES(2, 3);

INSERT INTO PHONE_NUMBER VALUES(1, '+3630213334');
INSERT INTO PHONE_NUMBER VALUES(2, '+3620183420');
INSERT INTO PHONE_NUMBER VALUES(3, '+3670690664');

INSERT INTO USER_TO_PHONE_NUMBER VALUES(1, 1);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(2, 2);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(2, 3);

INSERT INTO `unizon`.`image`
(`IMAGE_ID`,
`IMAGE_URL`)
VALUES
(5,
"http://www.nikecipo-webshop.hu/wp-content/uploads/S.729809_011-1-546x480.jpg");

INSERT INTO `unizon`.`image`
(`IMAGE_ID`,
`IMAGE_URL`)
VALUES
(4,
"http://www.intersport.si/wcsstore/Intersport/images/products/a081/887231908882_01_mega.jpg");

INSERT INTO `unizon`.`image`
(`IMAGE_ID`,
`IMAGE_URL`)
VALUES
(6,
"http://s3emagst.akamaized.net/products/1072/1071426/images/res_43dcd7b9f15c65c4e7cc3ce1427b3eec_350x350c_spnr.jpg?v2");

INSERT INTO `unizon`.`image`
(`IMAGE_ID`,
`IMAGE_URL`)
VALUES
(3,
"http://www.adidascenter.com/img/p/6735-11143-thickbox.jpg");

INSERT INTO `unizon`.`image`
(`IMAGE_ID`,
`IMAGE_URL`)
VALUES
(1,
"http://www.trusteegaps.com/images/large/nikefreefutcip/Adidas-Cip-Feh-r-K-k-Piros-472ie3860_02_LRG.jpg");

INSERT INTO `unizon`.`image`
(`IMAGE_ID`,
`IMAGE_URL`)
VALUES
(2,
"http://playersroom.hu/upload_files/products/AO2891_5.jpg");


INSERT INTO `unizon`.`image`
(`IMAGE_ID`,
`IMAGE_URL`)
VALUES
(8,
"http://www.eshop-gyorsan.hu/fotky2550/fotos/_vyrn_164Beige-2014-wholesale-GEL-Running-Shoes-for-women-and-Men-girl-Ourdoor-casual-Shoes-brand-Noosa-tri.jpg");

INSERT INTO `unizon`.`image`
(`IMAGE_ID`,
`IMAGE_URL`)
VALUES
(7,
"http://sportwebshop.net/sites/default/files/asics_knit_noi_kapucnis_pulover_2015.jpg");


INSERT INTO PRODUCT VALUES(1,'Adidas pulcsi', 2100,210,'fehér/fekete',1);
INSERT INTO PRODUCT VALUES(2,'Adidas cipő', 2990,210,'piros/fekete',2);
INSERT INTO PRODUCT VALUES(3,'Adidas nadrág', 3990,210,'piros/kék',3);
INSERT INTO PRODUCT VALUES(4,'Nike pulcsi', 12990,210,'piros/fekete',4);
INSERT INTO PRODUCT VALUES(5,'Nike cipő', 22990,210,'piros/fekete',5);
INSERT INTO PRODUCT VALUES(6,'Nike nadrág', 29490,210,'piros/kék',6);
INSERT INTO PRODUCT VALUES(7,'Asics pulcsi', 1290,210,'piros/zöld',7);
INSERT INTO PRODUCT VALUES(8,'Asics cipő', 2990,210,'zöld/fekete',8);

INSERT INTO CATEGORY VALUES(1,'Cipő');
INSERT INTO CATEGORY VALUES(2,'Pulcsi');
INSERT INTO CATEGORY VALUES(3,'Nadrág');

INSERT INTO CAT_TO_PROD VALUES(1, 2);
INSERT INTO CAT_TO_PROD VALUES(2, 1);
INSERT INTO CAT_TO_PROD VALUES(3, 3);
INSERT INTO CAT_TO_PROD VALUES(4, 2);
INSERT INTO CAT_TO_PROD VALUES(5, 1);
INSERT INTO CAT_TO_PROD VALUES(6, 3);
INSERT INTO CAT_TO_PROD VALUES(7, 2);
INSERT INTO CAT_TO_PROD VALUES(8, 1);

COMMIT;