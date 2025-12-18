*----------------------------------------------------------
* Лабораторна робота №7 - Робота з даними
* Демонстрація основних команд для роботи з БД
*----------------------------------------------------------
CLOSE DATABASES ALL
SET SAFETY OFF
SET TALK OFF

SET DEFAULT TO "C:\VFP_Lab7"

* Відкриття бази даних
OPEN DATABASE TktDB_Simple SHARED

*----------------------------------------------------------
* Демонстрація команд роботи з даними
*----------------------------------------------------------

* 1. Перегляд всіх станцій
SELECT Stations
USE Stations
BROWSE TITLE "Станції України" NOWAIT

* 2. Перегляд пасажирів
SELECT Passengers
USE Passengers
BROWSE TITLE "Список пасажирів" NOWAIT

* 3. Фільтрація даних - Станції в Київській області
SELECT Stations
SET FILTER TO region = "Київська обл."
GO TOP
MESSAGEBOX("Відфільтровано станції Київської області", 64, "Фільтр")
BROWSE TITLE "Станції Київської області" NOWAIT

* 4. Пошук конкретного пасажира
SELECT Passengers
LOCATE FOR lname = "Шевченко"
IF FOUND()
    MESSAGEBOX("Знайдено: " + ALLTRIM(fname) + " " + ALLTRIM(lname) + CHR(13) + ;
               "Телефон: " + ALLTRIM(phone), 64, "Пошук")
ELSE
    MESSAGEBOX("Пасажира не знайдено", 48, "Пошук")
ENDIF

* 5. Підрахунок кількості записів
SELECT Passengers
COUNT TO lnCount
MESSAGEBOX("Всього пасажирів: " + TRANSFORM(lnCount), 64, "Статистика")

* 6. Перегляд маршрутів довших за 500 км
SELECT Routes
USE Routes
SET FILTER TO distance > 500
GO TOP
BROWSE TITLE "Маршрути > 500 км" NOWAIT

* 7. Додавання нового запису (приклад)
* SELECT Passengers
* APPEND BLANK
* REPLACE lname WITH "Тестовий", fname WITH "Користувач", pname WITH "Прізвищевич"
* MESSAGEBOX("Додано новий запис", 64, "Додавання")

MESSAGEBOX("Демонстрація завершена!" + CHR(13) + ;
           "Закрийте вікна перегляду та спробуйте:" + CHR(13) + ;
           "- Відредагувати дані" + CHR(13) + ;
           "- Додати нові записи" + CHR(13) + ;
           "- Видалити непотрібні записи", 64, "Lab 7")

* Примітка: Не закриваємо БД, щоб користувач міг працювати з даними
