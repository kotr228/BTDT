* =========================================
* Скрипт створення бази даних lab_7_db
* Лабораторна робота №7
* =========================================

SET SAFETY OFF
SET TALK OFF

* Перевірка та видалення старої бази даних
IF FILE("lab_7_db.dbc")
    DELETE DATABASE lab_7_db DELETETABLES
ENDIF

* Створення нової бази даних
CREATE DATABASE lab_7_db

* Відкриття бази даних
OPEN DATABASE lab_7_db EXCLUSIVE

* Створення таблиці customer
CREATE TABLE customer ;
    (id I PRIMARY KEY, ;
     lastname C(50), ;
     firstname C(50), ;
     middlename C(50), ;
     address C(100), ;
     phone C(20), ;
     email C(50), ;
     birthdate D, ;
     notes M)

* Додавання тестових даних
INSERT INTO customer VALUES (1, "Іваненко", "Олександр", "Петрович", "м. Київ, вул. Хрещатик, 25", "+380501234567", "ivanov@mail.com", {^1995-05-15}, "Постійний клієнт")
INSERT INTO customer VALUES (2, "Петренко", "Марія", "Іванівна", "м. Львів, вул. Шевченка, 10", "+380672345678", "petrenko@mail.com", {^1992-08-20}, "VIP клієнт")
INSERT INTO customer VALUES (3, "Сидоренко", "Андрій", "Миколайович", "м. Одеса, пр. Гагаріна, 5", "+380933456789", "sydorenko@mail.com", {^1988-12-10}, "")
INSERT INTO customer VALUES (4, "Коваленко", "Ольга", "Василівна", "м. Харків, вул. Сумська, 30", "+380994567890", "kovalenko@mail.com", {^1990-03-25}, "Новий клієнт")
INSERT INTO customer VALUES (5, "Мельник", "Дмитро", "Олександрович", "м. Дніпро, вул. Набережна, 15", "+380665678901", "melnyk@mail.com", {^1987-07-08}, "")
INSERT INTO customer VALUES (6, "Шевченко", "Тетяна", "Петрівна", "м. Запоріжжя, вул. Соборна, 12", "+380976789012", "shevchenko@mail.com", {^1993-11-30}, "Постійний клієнт")
INSERT INTO customer VALUES (7, "Бондаренко", "Ігор", "Вікторович", "м. Вінниця, вул. Соборна, 8", "+380637890123", "bondarenko@mail.com", {^1991-01-18}, "")
INSERT INTO customer VALUES (8, "Гриценко", "Наталія", "Сергіївна", "м. Полтава, вул. Європейська, 20", "+380688901234", "hrytsenko@mail.com", {^1989-06-22}, "VIP клієнт")
INSERT INTO customer VALUES (9, "Ткаченко", "Василь", "Анатолійович", "м. Чернігів, вул. Мира, 7", "+380939012345", "tkachenko@mail.com", {^1994-09-14}, "")
INSERT INTO customer VALUES (10, "Мусаєв", "Руслан", "Ахмедович", "м. Київ, вул. Лесі Українки, 18", "+380500123456", "musayev@mail.com", {^1992-04-05}, "Постійний клієнт")

* Створення індексу для пошуку
INDEX ON UPPER(lastname) TAG lastname
INDEX ON UPPER(firstname) TAG firstname
INDEX ON UPPER(phone) TAG phone

USE

CLOSE DATABASES

MESSAGEBOX("База даних lab_7_db успішно створена!", 64, "Успіх")

SET SAFETY ON
SET TALK ON
