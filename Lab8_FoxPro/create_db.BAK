*----------------------------------------------------------
* Скрипт створення БД та наповнення даними
*----------------------------------------------------------
CLOSE DATABASES ALL
SET SAFETY OFF && Дозволяємо перезапис файлів без питань
SET DATE GERMAN && Формат дати дд.мм.рррр

* 1. Створення папки та перехід у неї
LOCAL lcPath
lcPath = "C:\VFP_Lab9"

IF !DIRECTORY(lcPath)
    MD (lcPath)
ENDIF
SET DEFAULT TO (lcPath)

* 2. Створення Бази Даних
CREATE DATABASE TktDB_Norm

*----------------------------------------------------------
* 3. Створення Таблиць (CREATE TABLE)
*----------------------------------------------------------

* Таблиця типів вагонів
CREATE TABLE CarTypes ( ;
    ctype_id I AUTOINC PRIMARY KEY, ;
    type_name C(30), ;
    base_cost Y)

* Таблиця станцій
CREATE TABLE Stations ( ;
    stat_id I AUTOINC PRIMARY KEY, ;
    name C(50))

* Таблиця пасажирів
CREATE TABLE Passengers ( ;
    pass_id I AUTOINC PRIMARY KEY, ;
    lname C(30), ;
    fname C(30), ;
    pname C(30))

* Таблиця адрес (Зв'язок з пасажирами)
CREATE TABLE Address ( ;
    addr_id I AUTOINC PRIMARY KEY, ;
    pass_id I REFERENCES Passengers TAG pass_id, ;
    addr_type C(20), ;
    city C(30), ;
    street C(50), ;
    zipcode C(10))

* Таблиця телефонів
CREATE TABLE PhoneNums ( ;
    phone_id I AUTOINC PRIMARY KEY, ;
    pass_id I REFERENCES Passengers TAG pass_id, ;
    phone_type C(20), ;
    phone_num C(20))

* Таблиця маршрутів (Зв'язок зі станціями)
CREATE TABLE Routes ( ;
    route_id I AUTOINC PRIMARY KEY, ;
    route_name C(50), ;
    orig_id I REFERENCES Stations TAG orig_id, ;
    dest_id I REFERENCES Stations TAG dest_id)

* Таблиця розкладу
CREATE TABLE Schedules ( ;
    sched_id I AUTOINC PRIMARY KEY, ;
    route_id I REFERENCES Routes TAG route_id, ;
    train_num C(10), ;
    time_dep T, ;
    time_arr T)

* Таблиця поїздок (конкретні дати)
CREATE TABLE Trips ( ;
    trip_id I AUTOINC PRIMARY KEY, ;
    sched_id I REFERENCES Schedules TAG sched_id, ;
    trip_date D, ;
    status C(20))

* Таблиця вагонів у поїздці
CREATE TABLE Cars ( ;
    car_id I AUTOINC PRIMARY KEY, ;
    trip_id I REFERENCES Trips TAG trip_id, ;
    ctype_id I REFERENCES CarTypes TAG ctype_id, ;
    car_num I)

* Таблиця місць
CREATE TABLE Seats ( ;
    seat_id I AUTOINC PRIMARY KEY, ;
    car_id I REFERENCES Cars TAG car_id, ;
    seat_num C(5), ;
    seat_info C(30))

* Таблиця бронювань/квитків
CREATE TABLE Reserv ( ;
    ticket_id I AUTOINC PRIMARY KEY, ;
    pass_id I REFERENCES Passengers TAG pass_id, ;
    seat_id I REFERENCES Seats TAG seat_id, ;
    final_cost Y, ;
    purch_date T)

*----------------------------------------------------------
* 4. Наповнення даними (INSERT INTO)
*----------------------------------------------------------

* Типи вагонів
INSERT INTO CarTypes (type_name, base_cost) VALUES ("Плацкарт", 200.00)       && ID 1
INSERT INTO CarTypes (type_name, base_cost) VALUES ("Купе", 450.00)           && ID 2
INSERT INTO CarTypes (type_name, base_cost) VALUES ("Люкс (СВ)", 1200.00)     && ID 3
INSERT INTO CarTypes (type_name, base_cost) VALUES ("Сидячий 1-клас", 350.00) && ID 4
INSERT INTO CarTypes (type_name, base_cost) VALUES ("Сидячий 2-клас", 180.00) && ID 5

* Станції
INSERT INTO Stations (name) VALUES ("Київ-Пасажирський") && ID 1
INSERT INTO Stations (name) VALUES ("Львів-Головний")    && ID 2
INSERT INTO Stations (name) VALUES ("Одеса-Головна")     && ID 3
INSERT INTO Stations (name) VALUES ("Харків-Пас")        && ID 4
INSERT INTO Stations (name) VALUES ("Дніпро-Головний")   && ID 5

* Пасажири
INSERT INTO Passengers (lname, fname, pname) VALUES ("Шевченко", "Тарас", "Григорович")   && ID 1
INSERT INTO Passengers (lname, fname, pname) VALUES ("Франко", "Іван", "Якович")          && ID 2
INSERT INTO Passengers (lname, fname, pname) VALUES ("Українка", "Леся", "Петрівна")      && ID 3
INSERT INTO Passengers (lname, fname, pname) VALUES ("Котляревський", "Іван", "Петрович") && ID 4
INSERT INTO Passengers (lname, fname, pname) VALUES ("Костенко", "Ліна", "Василівна")     && ID 5

* Адреси
INSERT INTO Address (pass_id, addr_type, city, street, zipcode) VALUES (1, "Дім", "Канів", "Тарасова Гора 1", "19000")
INSERT INTO Address (pass_id, addr_type, city, street, zipcode) VALUES (2, "Робота", "Львів", "Вул. Каменярів 5", "79000")
INSERT INTO Address (pass_id, addr_type, city, street, zipcode) VALUES (3, "Дім", "Луцьк", "Вул. Поетична 10", "43000")
INSERT INTO Address (pass_id, addr_type, city, street, zipcode) VALUES (4, "Дім", "Полтава", "Вул. Соборна 2", "36000")
INSERT INTO Address (pass_id, addr_type, city, street, zipcode) VALUES (5, "Дача", "Київ", "Вул. Банкова 1", "01000")

* Телефони
INSERT INTO PhoneNums (pass_id, phone_type, phone_num) VALUES (1, "Мобільний", "050-111-11-11")
INSERT INTO PhoneNums (pass_id, phone_type, phone_num) VALUES (2, "Домашній", "032-222-22-22")
INSERT INTO PhoneNums (pass_id, phone_type, phone_num) VALUES (3, "Мобільний", "067-333-33-33")
INSERT INTO PhoneNums (pass_id, phone_type, phone_num) VALUES (4, "Робочий", "053-444-44-44")
INSERT INTO PhoneNums (pass_id, phone_type, phone_num) VALUES (5, "Мобільний", "063-555-55-55")

* Маршрути (використовуємо ID станцій)
INSERT INTO Routes (route_name, orig_id, dest_id) VALUES ("Київ - Львів", 1, 2)   && ID 1
INSERT INTO Routes (route_name, orig_id, dest_id) VALUES ("Київ - Одеса", 1, 3)   && ID 2
INSERT INTO Routes (route_name, orig_id, dest_id) VALUES ("Харків - Київ", 4, 1)  && ID 3
INSERT INTO Routes (route_name, orig_id, dest_id) VALUES ("Дніпро - Львів", 5, 2) && ID 4
INSERT INTO Routes (route_name, orig_id, dest_id) VALUES ("Одеса - Харків", 3, 4) && ID 5

* Розклад
* Примітка: використовуємо літерали DATETIME {^yyyy-mm-dd hh:mm:ss}
INSERT INTO Schedules (route_id, train_num, time_dep, time_arr) VALUES (1, "091К", {^2000-01-01 22:30:00}, {^2000-01-02 06:00:00}) && ID 1
INSERT INTO Schedules (route_id, train_num, time_dep, time_arr) VALUES (2, "105Ч", {^2000-01-01 21:00:00}, {^2000-01-02 05:30:00}) && ID 2
INSERT INTO Schedules (route_id, train_num, time_dep, time_arr) VALUES (3, "064О", {^2000-01-01 06:00:00}, {^2000-01-01 12:00:00}) && ID 3
INSERT INTO Schedules (route_id, train_num, time_dep, time_arr) VALUES (4, "041П", {^2000-01-01 14:00:00}, {^2000-01-02 08:00:00}) && ID 4
INSERT INTO Schedules (route_id, train_num, time_dep, time_arr) VALUES (5, "007Ш", {^2000-01-01 19:00:00}, {^2000-01-02 09:00:00}) && ID 5

* Поїздки
INSERT INTO Trips (sched_id, trip_date, status) VALUES (1, {^2025-12-01}, "За розкладом")   && ID 1
INSERT INTO Trips (sched_id, trip_date, status) VALUES (2, {^2025-12-01}, "Затримано 10хв") && ID 2
INSERT INTO Trips (sched_id, trip_date, status) VALUES (3, {^2025-12-02}, "За розкладом")   && ID 3
INSERT INTO Trips (sched_id, trip_date, status) VALUES (4, {^2025-12-02}, "Скасовано")      && ID 4
INSERT INTO Trips (sched_id, trip_date, status) VALUES (5, {^2025-12-03}, "За розкладом")   && ID 5

* Вагони
INSERT INTO Cars (trip_id, ctype_id, car_num) VALUES (1, 2, 1) && ID 1 (Купе в поїздці 1)
INSERT INTO Cars (trip_id, ctype_id, car_num) VALUES (1, 1, 2) && ID 2 (Плацкарт в поїздці 1)
INSERT INTO Cars (trip_id, ctype_id, car_num) VALUES (2, 3, 3) && ID 3 (Люкс в поїздці 2)
INSERT INTO Cars (trip_id, ctype_id, car_num) VALUES (3, 4, 4) && ID 4 (Сидячий в поїздці 3)
INSERT INTO Cars (trip_id, ctype_id, car_num) VALUES (5, 1, 5) && ID 5 (Плацкарт в поїздці 5)

* Місця
INSERT INTO Seats (car_id, seat_num, seat_info) VALUES (1, "01", "Нижнє")
INSERT INTO Seats (car_id, seat_num, seat_info) VALUES (2, "02", "Верхнє")
INSERT INTO Seats (car_id, seat_num, seat_info) VALUES (3, "03", "Люкс")
INSERT INTO Seats (car_id, seat_num, seat_info) VALUES (4, "04A", "Біля вікна")
INSERT INTO Seats (car_id, seat_num, seat_info) VALUES (5, "05", "Нижнє бокове")

* Бронювання (Квитки)
* Примітка: pass_id та seat_id збігаються з порядковими номерами 1..5
INSERT INTO Reserv (pass_id, seat_id, final_cost, purch_date) VALUES (1, 1, 450.00, DATETIME())
INSERT INTO Reserv (pass_id, seat_id, final_cost, purch_date) VALUES (2, 2, 200.00, DATETIME())
INSERT INTO Reserv (pass_id, seat_id, final_cost, purch_date) VALUES (3, 3, 1200.00, DATETIME())
INSERT INTO Reserv (pass_id, seat_id, final_cost, purch_date) VALUES (4, 4, 350.00, DATETIME())
INSERT INTO Reserv (pass_id, seat_id, final_cost, purch_date) VALUES (5, 5, 180.00, DATETIME())

CLOSE DATABASES ALL
MESSAGEBOX("База даних успішно створена у папці C:\VFP_Lab9 !", 64, "Готово")
