# Лабораторна робота №10 - Visual FoxPro

## Опис

Повноцінний додаток для управління залізничними квитками з меню, редагуванням даних, пошуком та складними SQL-запитами.

## Взаємозв'язок з попередніми роботами

Ця лабораторна робота **витікає з Lab9**:
- Lab7 → Lab8 → Lab9 → **Lab10**
- Lab9: Нормалізована БД з формами редагування
- Lab10: Додавання меню, покращений пошук та складні запити

**Відмінності від Lab9:**
- Головна форма з меню (замість кнопок)
- Розділені форми для різних функцій
- Послідовний (LOCATE) та індексний (SEEK) пошук на окремих формах
- SQL-запити за декількома критеріями
- Логічні перегляди з об'єднанням кількох таблиць

## Мета роботи

- Створити повноцінний додаток з меню
- Реалізувати введення, редагування та видалення даних
- Освоїти послідовний (LOCATE) та індексний (SEEK) пошук
- Навчитися створювати SQL-запити за декількома критеріями
- Реалізувати логічні перегляди з об'єднанням таблиць

## Структура проекту

- `create_app_with_menu.prg` - створення головної форми та форми ведення БД
- `create_search_and_queries.prg` - створення форм пошуку
- `create_queries_and_views.prg` - створення форм запитів та переглядів
- `README.md` - документація

## Створювані форми

### 1. frm_main.scx - Головна форма з меню

Центральна форма додатку з меню:

**Меню "Файл":**
- Вихід

**Меню "База Даних":**
- Ведення даних → відкриває frm_database

**Меню "Пошук":**
- Послідовний пошук → відкриває frm_search_seq
- Індексний пошук → відкриває frm_search_idx

**Меню "Запити та перегляди":**
- Запити → відкриває frm_queries
- Перегляди → відкриває frm_views

### 2. frm_database.scx - Форма ведення БД

Багатосторінкова форма для роботи з таблицями:

**Компоненти:**
- PageFrame з 3 сторінками (Станції, Пасажири, Типи вагонів)
- Grid для відображення даних
- TextBox для введення/редагування
- Кнопки: ДОДАТИ, РЕДАГУВАТИ, ВИДАЛИТИ, ОНОВИТИ

**Функціонал:**
```foxpro
* Додавання
SELECT TableName
APPEND BLANK
THISFORM.Refresh()

* Видалення
IF MESSAGEBOX("Видалити?", 4+32) = 6
    DELETE
    SKIP
    IF EOF()
        SKIP -1
    ENDIF
    THISFORM.Refresh()
ENDIF
```

### 3. frm_search_seq.scx - Послідовний пошук

Форма для пошуку за допомогою LOCATE:

**Можливості:**
- Пошук за прізвищем
- Пошук за ім'ям
- Продовження пошуку (CONTINUE)
- Показати всі записи

**Приклад коду:**
```foxpro
SELECT Passengers
GO TOP
LOCATE FOR UPPER(ALLTRIM(lname)) = UPPER(ALLTRIM(введене_значення))
IF FOUND()
    MESSAGEBOX("Знайдено!")
ELSE
    MESSAGEBOX("Не знайдено")
ENDIF
```

### 4. frm_search_idx.scx - Індексний пошук

Форма для швидкого пошуку за індексом:

**Особливості:**
- Використовує SEEK (швидше ніж LOCATE)
- Пошук за ID пасажира
- Працює з індексом pass_id

**Приклад коду:**
```foxpro
USE Passengers ORDER pass_id
SEEK VAL(введене_ID)
IF FOUND()
    MESSAGEBOX("Знайдено!")
ENDIF
```

### 5. frm_queries.scx - SQL-запити

Форма з 2 запитами за декількома критеріями:

**Запит 1: Квитки за вартістю**
- Критерії: мінімальна та максимальна вартість
- SQL: BETWEEN, INNER JOIN
```sql
SELECT R.ticket_id, P.lname, P.fname, R.final_cost
  FROM Reserv R
  INNER JOIN Passengers P ON R.pass_id = P.pass_id
  WHERE R.final_cost BETWEEN мін AND макс
  ORDER BY R.final_cost
```

**Запит 2: Маршрути**
- Критерії: відстань, назва станції
- SQL: INNER JOIN, WHERE, LIKE, підзапит
```sql
SELECT R.route_id, R.route_name, S1.name, S2.name,
       (SELECT COUNT(*) FROM Schedules WHERE route_id = R.route_id)
  FROM Routes R
  INNER JOIN Stations S1 ON R.orig_id = S1.stat_id
  INNER JOIN Stations S2 ON R.dest_id = S2.stat_id
  WHERE S1.name LIKE "%станція%"
```

### 6. frm_views.scx - Логічні перегляди

Форма з 2 переглядами:

**Перегляд 1: Повна інформація про квитки**
- Об'єднання 5 таблиць
- Інформація про пасажира, місце, вагон, тип, вартість
```sql
SELECT R.ticket_id, P.lname + " " + P.fname AS passenger,
       S.seat_num, C.car_num, CT.type_name, R.final_cost
  FROM Reserv R
  INNER JOIN Passengers P ON R.pass_id = P.pass_id
  INNER JOIN Seats S ON R.seat_id = S.seat_id
  INNER JOIN Cars C ON S.car_id = C.car_id
  INNER JOIN CarTypes CT ON C.ctype_id = CT.ctype_id
```

**Перегляд 2: Розклад руху потягів**
- Об'єднання 4 таблиць
- Розрахунок часу в дорозі
```sql
SELECT Sch.train_num, R.route_name, S1.name, S2.name,
       Sch.time_dep, Sch.time_arr,
       CAST((Sch.time_arr - Sch.time_dep) * 24 AS I) AS hours
  FROM Schedules Sch
  INNER JOIN Routes R ON Sch.route_id = R.route_id
  INNER JOIN Stations S1 ON R.orig_id = S1.stat_id
  INNER JOIN Stations S2 ON R.dest_id = S2.stat_id
```

## Використання

### Передумови

Переконайтеся, що виконано Lab9:
```foxpro
* Має існувати:
C:\VFP_Lab9\TktDB_Norm.dbc
```

### Крок 1: Створення форм

Виконайте всі 3 скрипти послідовно:

```foxpro
* Частина 1: Головна форма та ведення БД
DO create_app_with_menu.prg

* Частина 2: Форми пошуку
DO create_search_and_queries.prg

* Частина 3: Запити та перегляди
DO create_queries_and_views.prg
```

### Крок 2: Запуск додатку

```foxpro
SET DEFAULT TO "C:\VFP_Lab10"
DO FORM frm_main
```

### Крок 3: Робота з додатком

1. **База Даних → Ведення даних:**
   - Перейдіть на потрібну вкладку (Станції/Пасажири/Типи вагонів)
   - Натисніть "ДОДАТИ" для нового запису
   - Заповніть поля
   - Або виберіть запис і натисніть "РЕДАГУВАТИ"
   - Натисніть "ВИДАЛИТИ" для видалення

2. **Пошук → Послідовний пошук:**
   - Введіть прізвище або ім'я
   - Натисніть "Шукати"
   - Використайте "Продовжити пошук" для наступного запису

3. **Пошук → Індексний пошук:**
   - Введіть ID пасажира
   - Натисніть "SEEK" для швидкого пошуку

4. **Запити та перегляди → Запити:**
   - Запит 1: Введіть діапазон вартості, виконайте
   - Запит 2: Введіть критерії пошуку маршрутів

5. **Запити та перегляди → Перегляди:**
   - Натисніть "Завантажити перегляд" для кожного

## Ключові концепції

### 1. Меню в VFP

Меню створюється програмно або через Menu Designer:
```foxpro
* Структура меню:
- MenuBar (головне меню)
  - Menu (пункт меню "Файл")
    - MenuItem (підпункт "Вихід")
  - Menu (пункт меню "База Даних")
    - MenuItem (підпункт "Ведення даних")
```

### 2. Послідовний vs Індексний пошук

| Характеристика | LOCATE | SEEK |
|----------------|--------|------|
| Швидкість | Повільно | Швидко |
| Потрібен індекс | Ні | Так |
| Гнучкість | Будь-які умови | Тільки по індексу |
| Використання | LOCATE FOR умова | SEEK значення |

### 3. SQL-запити за критеріями

**Приклад з BETWEEN:**
```foxpro
SELECT * FROM Reserv
  WHERE final_cost BETWEEN ?lnMin AND ?lnMax
```

**Приклад з LIKE:**
```foxpro
SELECT * FROM Stations
  WHERE name LIKE "%Київ%"
```

**Приклад з підзапитом:**
```foxpro
SELECT R.*,
       (SELECT COUNT(*) FROM Schedules WHERE route_id = R.route_id)
  FROM Routes R
```

### 4. DataSession = 2

Кожна форма має Private DataSession:
- Ізоляція даних між формами
- Незалежне відкриття таблиць
- Немає конфліктів при одночасній роботі

### 5. PageFrame для організації даних

```foxpro
.AddObject("pgfData", "PageFrame")
.pgfData.PageCount = 3  && 3 сторінки

* Доступ до сторінок:
THISFORM.pgfData.Page1.grdData.Refresh()
THISFORM.pgfData.Page2.txtName.Value = "Test"
```

## Вимоги до звіту

При оформленні звіту дотримуйтесь вимог:
- Формат А4
- Поля: верхнє, нижнє, ліве – 20 мм, праве – 10 мм
- Міжрядковий інтервал: 1.5 для тексту, 1.0 для коду
- Шрифт Times New Roman, 12-14 пт
- Таблиці та рисунки підписувати
- Включити лістинги коду та скріншоти

### Структура звіту:
1. Титульна сторінка
2. Мета роботи
3. Теоретична частина
4. Опис виконання (з кодом)
5. Результати (скріншоти)
6. Висновки

## Порівняння лабораторних робіт

| Функція | Lab7 | Lab8 | Lab9 | Lab10 |
|---------|------|------|------|-------|
| Створення БД | Проста (4 табл) | - | Нормалізована (11 табл) | - |
| Форми | - | Перегляд | Редагування | Меню + все |
| Пошук | BROWSE | LOCATE | SEEK | LOCATE + SEEK |
| Запити | - | - | SQL прості | SQL складні |
| Перегляди | - | - | - | ✓ (JOIN) |
| Меню | - | - | - | ✓ |
| PageFrame | - | - | ✓ | ✓ |

## Приклади SQL-запитів

### Запит з INNER JOIN
```foxpro
SELECT P.lname, P.fname, R.final_cost
  FROM Passengers P
  INNER JOIN Reserv R ON P.pass_id = R.pass_id
  WHERE R.final_cost > 300
```

### Запит з GROUP BY
```foxpro
SELECT CT.type_name, COUNT(*) AS cnt, AVG(R.final_cost) AS avg_cost
  FROM Reserv R
  INNER JOIN Seats S ON R.seat_id = S.seat_id
  INNER JOIN Cars C ON S.car_id = C.car_id
  INNER JOIN CarTypes CT ON C.ctype_id = CT.ctype_id
  GROUP BY CT.type_name
```

### Запит з підзапитом
```foxpro
SELECT * FROM Passengers
  WHERE pass_id IN (SELECT pass_id FROM Reserv WHERE final_cost > 500)
```

## Вимоги

- Visual FoxPro 6.0 або новіша версія
- Виконана Lab9 (наявність БД TktDB_Norm)
- Windows (для шляхів `C:\VFP_Lab9` та `C:\VFP_Lab10`)

## Примітки

- Меню краще створювати через Menu Designer для зручності
- Використовуйте DataSession = 2 для ізоляції даних
- SEEK працює тільки з відкритим індексом
- Запити з BETWEEN ефективні для діапазонів значень
- INNER JOIN об'єднує тільки записи з відповідностями
- Курсори (INTO CURSOR) - тимчасові таблиці для результатів запитів

## Завдання для самостійної роботи

1. Додайте пункт меню "Довідка" з інформацією про програму
2. Реалізуйте запит "Найдорожчі квитки за останній місяць"
3. Створіть перегляд "Статистика по типах вагонів"
4. Додайте гарячі клавіші для меню (Ctrl+D, Ctrl+S)
5. Реалізуйте експорт результатів запитів у файл
