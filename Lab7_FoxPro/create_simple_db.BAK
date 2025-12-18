*----------------------------------------------------------
* Лабораторна робота №7 - Створення простої БД
* Створення бази даних з базовими таблицями
*----------------------------------------------------------
CLOSE DATABASES ALL
SET SAFETY OFF
SET DATE GERMAN
SET TALK OFF

LOCAL lcPath
lcPath = "C:\VFP_Lab7"

* Створення робочої папки
IF !DIRECTORY(lcPath)
    MD (lcPath)
ENDIF
SET DEFAULT TO (lcPath)

* Створення Бази Даних
CREATE DATABASE TktDB_Simple

*----------------------------------------------------------
* Створення базових таблиць
*----------------------------------------------------------

* Таблиця станцій
CREATE TABLE Stations ( ;
    stat_id I AUTOINC PRIMARY KEY, ;
    name C(50), ;
    city C(30), ;
    region C(30))

* Таблиця типів вагонів
CREATE TABLE CarTypes ( ;
    ctype_id I AUTOINC PRIMARY KEY, ;
    type_name C(30), ;
    base_cost Y, ;
    capacity I)

* Таблиця пасажирів
CREATE TABLE Passengers ( ;
    pass_id I AUTOINC PRIMARY KEY, ;
    lname C(30), ;
    fname C(30), ;
    pname C(30), ;
    phone C(20), ;
    email C(50))

* Таблиця маршрутів
CREATE TABLE Routes ( ;
    route_id I AUTOINC PRIMARY KEY, ;
    route_name C(50), ;
    orig_station C(50), ;
    dest_station C(50), ;
    distance I)

*----------------------------------------------------------
* Наповнення таблиць даними
*----------------------------------------------------------

* Станції
INSERT INTO Stations (name, city, region) VALUES ("Київ-Пасажирський", "Київ", "Київська обл.")
INSERT INTO Stations (name, city, region) VALUES ("Львів-Головний", "Львів", "Львівська обл.")
INSERT INTO Stations (name, city, region) VALUES ("Одеса-Головна", "Одеса", "Одеська обл.")
INSERT INTO Stations (name, city, region) VALUES ("Харків-Пасажирський", "Харків", "Харківська обл.")
INSERT INTO Stations (name, city, region) VALUES ("Дніпро-Головний", "Дніпро", "Дніпропетровська обл.")
INSERT INTO Stations (name, city, region) VALUES ("Запоріжжя-1", "Запоріжжя", "Запорізька обл.")
INSERT INTO Stations (name, city, region) VALUES ("Вінниця", "Вінниця", "Вінницька обл.")
INSERT INTO Stations (name, city, region) VALUES ("Полтава-Південна", "Полтава", "Полтавська обл.")

* Типи вагонів
INSERT INTO CarTypes (type_name, base_cost, capacity) VALUES ("Плацкарт", 200.00, 54)
INSERT INTO CarTypes (type_name, base_cost, capacity) VALUES ("Купе", 450.00, 36)
INSERT INTO CarTypes (type_name, base_cost, capacity) VALUES ("Люкс (СВ)", 1200.00, 18)
INSERT INTO CarTypes (type_name, base_cost, capacity) VALUES ("Сидячий 1-клас", 350.00, 68)
INSERT INTO CarTypes (type_name, base_cost, capacity) VALUES ("Сидячий 2-клас", 180.00, 80)

* Пасажири (українські письменники)
INSERT INTO Passengers (lname, fname, pname, phone, email) VALUES ("Шевченко", "Тарас", "Григорович", "050-111-11-11", "t.shevchenko@ukr.net")
INSERT INTO Passengers (lname, fname, pname, phone, email) VALUES ("Франко", "Іван", "Якович", "067-222-22-22", "i.franko@ukr.net")
INSERT INTO Passengers (lname, fname, pname, phone, email) VALUES ("Українка", "Леся", "Петрівна", "063-333-33-33", "l.ukrainka@ukr.net")
INSERT INTO Passengers (lname, fname, pname, phone, email) VALUES ("Котляревський", "Іван", "Петрович", "095-444-44-44", "i.kotliarevskyi@ukr.net")
INSERT INTO Passengers (lname, fname, pname, phone, email) VALUES ("Костенко", "Ліна", "Василівна", "099-555-55-55", "l.kostenko@ukr.net")
INSERT INTO Passengers (lname, fname, pname, phone, email) VALUES ("Стус", "Василь", "Семенович", "050-666-66-66", "v.stus@ukr.net")
INSERT INTO Passengers (lname, fname, pname, phone, email) VALUES ("Рильський", "Максим", "Тадейович", "067-777-77-77", "m.rylskyi@ukr.net")

* Маршрути
INSERT INTO Routes (route_name, orig_station, dest_station, distance) VALUES ("Київ - Львів", "Київ-Пасажирський", "Львів-Головний", 540)
INSERT INTO Routes (route_name, orig_station, dest_station, distance) VALUES ("Київ - Одеса", "Київ-Пасажирський", "Одеса-Головна", 440)
INSERT INTO Routes (route_name, orig_station, dest_station, distance) VALUES ("Київ - Харків", "Київ-Пасажирський", "Харків-Пасажирський", 480)
INSERT INTO Routes (route_name, orig_station, dest_station, distance) VALUES ("Львів - Одеса", "Львів-Головний", "Одеса-Головна", 790)
INSERT INTO Routes (route_name, orig_station, dest_station, distance) VALUES ("Харків - Дніпро", "Харків-Пасажирський", "Дніпро-Головний", 220)

CLOSE DATABASES ALL

MESSAGEBOX("Базу даних успішно створено!" + CHR(13) + ;
           "Створено 4 таблиці:" + CHR(13) + ;
           "- Stations (8 записів)" + CHR(13) + ;
           "- CarTypes (5 записів)" + CHR(13) + ;
           "- Passengers (7 записів)" + CHR(13) + ;
           "- Routes (5 записів)", 64, "Lab 7 - Готово")
