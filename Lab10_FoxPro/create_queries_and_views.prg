*----------------------------------------------------------
* Лабораторна робота №10 - Частина 3
* Створення форм запитів та переглядів
*----------------------------------------------------------
CLOSE DATABASES ALL
CLEAR ALL
SET SAFETY OFF
SET TALK OFF

SET DEFAULT TO "C:\VFP_Lab10"

MESSAGEBOX("Створюємо форми запитів та переглядів...", 48, "Lab 10 - Частина 3")

*==========================================================
* 5. ФОРМА ЗАПИТІВ (frm_queries.scx)
*==========================================================
DELETE FILE frm_queries.scx
DELETE FILE frm_queries.sct

CREATE FORM frm_queries NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Запити до БД"
    .Width = 750
    .Height = 600
    .AutoCenter = .T.
    .DataSession = 2

    * Відкриваємо БД
    LOCAL lcLoad
    lcLoad = [SET EXCLUSIVE OFF] + CHR(13) + ;
             [SET DEFAULT TO "C:\VFP_Lab9"] + CHR(13) + ;
             [OPEN DATABASE "TktDB_Norm" SHARED]
    .WriteMethod("Load", lcLoad)

    * Заголовок
    .AddObject("lblTitle", "Label")
    .lblTitle.Caption = "SQL-запити з критеріями"
    .lblTitle.FontBold = .T.
    .lblTitle.FontSize = 12
    .lblTitle.Top = 10
    .lblTitle.Left = 20
    .lblTitle.Width = 300
    .lblTitle.Visible = .T.

    * PageFrame для запитів
    .AddObject("pgfQueries", "PageFrame")
    .pgfQueries.PageCount = 2
    .pgfQueries.Width = 720
    .pgfQueries.Height = 520
    .pgfQueries.Top = 45
    .pgfQueries.Left = 15
    .pgfQueries.Visible = .T.

    * --- Запит 1: Вартість квитків в діапазоні ---
    WITH .pgfQueries.Page1
        .Caption = "Запит 1: Квитки за вартістю"

        .AddObject("lblDesc", "Label")
        .lblDesc.Caption = "Знайти квитки з вартістю в діапазоні:"
        .lblDesc.FontBold = .T.
        .lblDesc.Top = 15
        .lblDesc.Left = 20
        .lblDesc.Width = 300
        .lblDesc.Visible = .T.

        * Мінімальна вартість
        .AddObject("lblMin", "Label")
        .lblMin.Caption = "Від:"
        .lblMin.Top = 50
        .lblMin.Left = 20
        .lblMin.Width = 50
        .lblMin.Visible = .T.

        .AddObject("txtMin", "TextBox")
        .txtMin.Top = 48
        .txtMin.Left = 80
        .txtMin.Width = 100
        .txtMin.Value = "100"
        .txtMin.Visible = .T.

        * Максимальна вартість
        .AddObject("lblMax", "Label")
        .lblMax.Caption = "До:"
        .lblMax.Top = 50
        .lblMax.Left = 200
        .lblMax.Width = 50
        .lblMax.Visible = .T.

        .AddObject("txtMax", "TextBox")
        .txtMax.Top = 48
        .txtMax.Left = 260
        .txtMax.Width = 100
        .txtMax.Value = "500"
        .txtMax.Visible = .T.

        * Кнопка виконання запиту
        .AddObject("cmdExecute", "CommandButton")
        .cmdExecute.Caption = "Виконати запит"
        .cmdExecute.Top = 46
        .cmdExecute.Left = 380
        .cmdExecute.Width = 140
        .cmdExecute.Height = 28
        .cmdExecute.Visible = .T.
        .cmdExecute.WriteMethod("Click", ;
            [LOCAL lnMin, lnMax] + CHR(13) + ;
            [lnMin = VAL(THISFORM.pgfQueries.Page1.txtMin.Value)] + CHR(13) + ;
            [lnMax = VAL(THISFORM.pgfQueries.Page1.txtMax.Value)] + CHR(13) + ;
            [SELECT R.ticket_id, P.lname, P.fname, R.final_cost, R.purch_date ] + CHR(13) + ;
            [  FROM Reserv R ] + CHR(13) + ;
            [  INNER JOIN Passengers P ON R.pass_id = P.pass_id ] + CHR(13) + ;
            [  WHERE R.final_cost BETWEEN lnMin AND lnMax ] + CHR(13) + ;
            [  ORDER BY R.final_cost ] + CHR(13) + ;
            [  INTO CURSOR curQuery1] + CHR(13) + ;
            [THISFORM.pgfQueries.Page1.grdResult.RecordSource = ""] + CHR(13) + ;
            [THISFORM.pgfQueries.Page1.grdResult.RecordSource = "curQuery1"] + CHR(13) + ;
            [MESSAGEBOX("Знайдено записів: " + TRANSFORM(RECCOUNT("curQuery1")), 64, "Результат")])

        * Інфо про запит
        .AddObject("lblSQL", "Label")
        .lblSQL.Caption = "SQL: SELECT з BETWEEN та INNER JOIN"
        .lblSQL.Top = 85
        .lblSQL.Left = 20
        .lblSQL.Width = 400
        .lblSQL.ForeColor = RGB(0, 0, 150)
        .lblSQL.Visible = .T.

        * Grid для результатів
        .AddObject("grdResult", "Grid")
        .grdResult.Top = 115
        .grdResult.Left = 20
        .grdResult.Width = 670
        .grdResult.Height = 350
        .grdResult.ReadOnly = .T.
        .grdResult.Visible = .T.
    ENDWITH

    * --- Запит 2: Маршрути за відстанню та станціями ---
    WITH .pgfQueries.Page2
        .Caption = "Запит 2: Маршрути"

        .AddObject("lblDesc", "Label")
        .lblDesc.Caption = "Знайти маршрути за критеріями:"
        .lblDesc.FontBold = .T.
        .lblDesc.Top = 15
        .lblDesc.Left = 20
        .lblDesc.Width = 300
        .lblDesc.Visible = .T.

        * Мінімальна відстань
        .AddObject("lblDist", "Label")
        .lblDist.Caption = "Відстань більше (км):"
        .lblDist.Top = 50
        .lblDist.Left = 20
        .lblDist.Width = 150
        .lblDist.Visible = .T.

        .AddObject("txtDistance", "TextBox")
        .txtDistance.Top = 48
        .txtDistance.Left = 180
        .txtDistance.Width = 100
        .txtDistance.Value = "0"
        .txtDistance.Visible = .T.

        * Фільтр за станцією
        .AddObject("lblStation", "Label")
        .lblStation.Caption = "Станція (частина назви):"
        .lblStation.Top = 85
        .lblStation.Left = 20
        .lblStation.Width = 150
        .lblStation.Visible = .T.

        .AddObject("txtStation", "TextBox")
        .txtStation.Top = 83
        .txtStation.Left = 180
        .txtStation.Width = 200
        .txtStation.Value = ""
        .txtStation.Visible = .T.

        * Кнопка виконання
        .AddObject("cmdExecute", "CommandButton")
        .cmdExecute.Caption = "Виконати запит"
        .cmdExecute.Top = 46
        .cmdExecute.Left = 400
        .cmdExecute.Width = 140
        .cmdExecute.Height = 28
        .cmdExecute.Visible = .T.
        .cmdExecute.WriteMethod("Click", ;
            [LOCAL lnDist, lcStation] + CHR(13) + ;
            [lnDist = VAL(THISFORM.pgfQueries.Page2.txtDistance.Value)] + CHR(13) + ;
            [lcStation = ALLTRIM(THISFORM.pgfQueries.Page2.txtStation.Value)] + CHR(13) + ;
            [IF EMPTY(lcStation)] + CHR(13) + ;
            [   SELECT R.route_id, R.route_name, S1.name AS origin, S2.name AS destination, ] + CHR(13) + ;
            [          (SELECT COUNT(*) FROM Schedules WHERE route_id = R.route_id) AS sched_count ] + CHR(13) + ;
            [     FROM Routes R ] + CHR(13) + ;
            [     INNER JOIN Stations S1 ON R.orig_id = S1.stat_id ] + CHR(13) + ;
            [     INNER JOIN Stations S2 ON R.dest_id = S2.stat_id ] + CHR(13) + ;
            [     INTO CURSOR curQuery2] + CHR(13) + ;
            [ELSE] + CHR(13) + ;
            [   SELECT R.route_id, R.route_name, S1.name AS origin, S2.name AS destination ] + CHR(13) + ;
            [     FROM Routes R ] + CHR(13) + ;
            [     INNER JOIN Stations S1 ON R.orig_id = S1.stat_id ] + CHR(13) + ;
            [     INNER JOIN Stations S2 ON R.dest_id = S2.stat_id ] + CHR(13) + ;
            [     WHERE UPPER(S1.name) LIKE UPPER("%"+lcStation+"%") ] + CHR(13) + ;
            [        OR UPPER(S2.name) LIKE UPPER("%"+lcStation+"%") ] + CHR(13) + ;
            [     INTO CURSOR curQuery2] + CHR(13) + ;
            [ENDIF] + CHR(13) + ;
            [THISFORM.pgfQueries.Page2.grdResult.RecordSource = ""] + CHR(13) + ;
            [THISFORM.pgfQueries.Page2.grdResult.RecordSource = "curQuery2"] + CHR(13) + ;
            [MESSAGEBOX("Знайдено маршрутів: " + TRANSFORM(RECCOUNT("curQuery2")), 64)])

        .AddObject("lblSQL", "Label")
        .lblSQL.Caption = "SQL: SELECT з INNER JOIN та підзапитом"
        .lblSQL.Top = 120
        .lblSQL.Left = 20
        .lblSQL.Width = 400
        .lblSQL.ForeColor = RGB(0, 0, 150)
        .lblSQL.Visible = .T.

        .AddObject("grdResult", "Grid")
        .grdResult.Top = 150
        .grdResult.Left = 20
        .grdResult.Width = 670
        .grdResult.Height = 315
        .grdResult.ReadOnly = .T.
        .grdResult.Visible = .T.
    ENDWITH

    * Закрити
    .AddObject("cmdClose", "CommandButton")
    .cmdClose.Caption = "Закрити"
    .cmdClose.Top = 570
    .cmdClose.Left = 325
    .cmdClose.Width = 100
    .cmdClose.Visible = .T.
    .cmdClose.WriteMethod("Click", "THISFORM.Release()")
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

*==========================================================
* 6. ФОРМА ПЕРЕГЛЯДІВ (frm_views.scx)
*==========================================================
DELETE FILE frm_views.scx
DELETE FILE frm_views.sct

CREATE FORM frm_views NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Перегляди БД"
    .Width = 750
    .Height = 550
    .AutoCenter = .T.
    .DataSession = 2

    * Відкриваємо БД
    LOCAL lcLoad
    lcLoad = [SET EXCLUSIVE OFF] + CHR(13) + ;
             [SET DEFAULT TO "C:\VFP_Lab9"] + CHR(13) + ;
             [OPEN DATABASE "TktDB_Norm" SHARED]
    .WriteMethod("Load", lcLoad)

    * Заголовок
    .AddObject("lblTitle", "Label")
    .lblTitle.Caption = "Логічні перегляди даних"
    .lblTitle.FontBold = .T.
    .lblTitle.FontSize = 12
    .lblTitle.Top = 10
    .lblTitle.Left = 20
    .lblTitle.Visible = .T.

    * PageFrame для переглядів
    .AddObject("pgfViews", "PageFrame")
    .pgfViews.PageCount = 2
    .pgfViews.Width = 720
    .pgfViews.Height = 470
    .pgfViews.Top = 45
    .pgfViews.Left = 15
    .pgfViews.Visible = .T.

    * --- Перегляд 1: Повна інформація про квитки ---
    WITH .pgfViews.Page1
        .Caption = "Перегляд 1: Інформація про квитки"

        .AddObject("lblDesc", "Label")
        .lblDesc.Caption = "Повна інформація про бронювання та квитки"
        .lblDesc.FontBold = .T.
        .lblDesc.Top = 15
        .lblDesc.Left = 20
        .lblDesc.Width = 400
        .lblDesc.Visible = .T.

        .AddObject("cmdLoad", "CommandButton")
        .cmdLoad.Caption = "Завантажити перегляд"
        .cmdLoad.Top = 12
        .cmdLoad.Left = 450
        .cmdLoad.Width = 180
        .cmdLoad.Height = 28
        .cmdLoad.Visible = .T.
        .cmdLoad.WriteMethod("Click", ;
            [SELECT R.ticket_id, ] + CHR(13) + ;
            [       P.lname + " " + P.fname AS passenger, ] + CHR(13) + ;
            [       S.seat_num, S.seat_info, ] + CHR(13) + ;
            [       C.car_num, CT.type_name, ] + CHR(13) + ;
            [       R.final_cost, R.purch_date ] + CHR(13) + ;
            [  FROM Reserv R ] + CHR(13) + ;
            [  INNER JOIN Passengers P ON R.pass_id = P.pass_id ] + CHR(13) + ;
            [  INNER JOIN Seats S ON R.seat_id = S.seat_id ] + CHR(13) + ;
            [  INNER JOIN Cars C ON S.car_id = C.car_id ] + CHR(13) + ;
            [  INNER JOIN CarTypes CT ON C.ctype_id = CT.ctype_id ] + CHR(13) + ;
            [  ORDER BY R.purch_date DESC ] + CHR(13) + ;
            [  INTO CURSOR curView1] + CHR(13) + ;
            [THISFORM.pgfViews.Page1.grdResult.RecordSource = ""] + CHR(13) + ;
            [THISFORM.pgfViews.Page1.grdResult.RecordSource = "curView1"] + CHR(13) + ;
            [MESSAGEBOX("Завантажено записів: " + TRANSFORM(RECCOUNT("curView1")), 64)])

        .AddObject("lblInfo", "Label")
        .lblInfo.Caption = "Об'єднання 5 таблиць: Reserv, Passengers, Seats, Cars, CarTypes"
        .lblInfo.Top = 50
        .lblInfo.Left = 20
        .lblInfo.Width = 500
        .lblInfo.ForeColor = RGB(0, 100, 0)
        .lblInfo.Visible = .T.

        .AddObject("grdResult", "Grid")
        .grdResult.Top = 80
        .grdResult.Left = 20
        .grdResult.Width = 670
        .grdResult.Height = 360
        .grdResult.ReadOnly = .T.
        .grdResult.Visible = .T.
    ENDWITH

    * --- Перегляд 2: Розклад з інформацією про маршрути ---
    WITH .pgfViews.Page2
        .Caption = "Перегляд 2: Розклад руху"

        .AddObject("lblDesc", "Label")
        .lblDesc.Caption = "Повний розклад руху потягів"
        .lblDesc.FontBold = .T.
        .lblDesc.Top = 15
        .lblDesc.Left = 20
        .lblDesc.Width = 300
        .lblDesc.Visible = .T.

        .AddObject("cmdLoad", "CommandButton")
        .cmdLoad.Caption = "Завантажити перегляд"
        .cmdLoad.Top = 12
        .cmdLoad.Left = 450
        .cmdLoad.Width = 180
        .cmdLoad.Height = 28
        .cmdLoad.Visible = .T.
        .cmdLoad.WriteMethod("Click", ;
            [SELECT Sch.train_num, ] + CHR(13) + ;
            [       R.route_name, ] + CHR(13) + ;
            [       S1.name AS origin, ] + CHR(13) + ;
            [       S2.name AS destination, ] + CHR(13) + ;
            [       Sch.time_dep, Sch.time_arr, ] + CHR(13) + ;
            [       CAST((Sch.time_arr - Sch.time_dep) * 24 AS I) AS hours ] + CHR(13) + ;
            [  FROM Schedules Sch ] + CHR(13) + ;
            [  INNER JOIN Routes R ON Sch.route_id = R.route_id ] + CHR(13) + ;
            [  INNER JOIN Stations S1 ON R.orig_id = S1.stat_id ] + CHR(13) + ;
            [  INNER JOIN Stations S2 ON R.dest_id = S2.stat_id ] + CHR(13) + ;
            [  ORDER BY Sch.train_num ] + CHR(13) + ;
            [  INTO CURSOR curView2] + CHR(13) + ;
            [THISFORM.pgfViews.Page2.grdResult.RecordSource = ""] + CHR(13) + ;
            [THISFORM.pgfViews.Page2.grdResult.RecordSource = "curView2"] + CHR(13) + ;
            [MESSAGEBOX("Завантажено розкладів: " + TRANSFORM(RECCOUNT("curView2")), 64)])

        .AddObject("lblInfo", "Label")
        .lblInfo.Caption = "Об'єднання 4 таблиць з розрахунком часу в дорозі"
        .lblInfo.Top = 50
        .lblInfo.Left = 20
        .lblInfo.Width = 400
        .lblInfo.ForeColor = RGB(0, 100, 0)
        .lblInfo.Visible = .T.

        .AddObject("grdResult", "Grid")
        .grdResult.Top = 80
        .grdResult.Left = 20
        .grdResult.Width = 670
        .grdResult.Height = 360
        .grdResult.ReadOnly = .T.
        .grdResult.Visible = .T.
    ENDWITH

    * Закрити
    .AddObject("cmdClose", "CommandButton")
    .cmdClose.Caption = "Закрити"
    .cmdClose.Top = 520
    .cmdClose.Left = 325
    .cmdClose.Width = 100
    .cmdClose.Visible = .T.
    .cmdClose.WriteMethod("Click", "THISFORM.Release()")
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

MESSAGEBOX("ГОТОВО! Всі форми створено успішно!" + CHR(13) + CHR(13) + ;
           "Створено 6 форм:" + CHR(13) + ;
           "1. frm_main.scx - головна з меню" + CHR(13) + ;
           "2. frm_database.scx - ведення БД" + CHR(13) + ;
           "3. frm_search_seq.scx - послідовний пошук" + CHR(13) + ;
           "4. frm_search_idx.scx - індексний пошук" + CHR(13) + ;
           "5. frm_queries.scx - SQL-запити" + CHR(13) + ;
           "6. frm_views.scx - перегляди" + CHR(13) + CHR(13) + ;
           "Запустіть: DO FORM frm_main", 64, "Lab 10 - Успіх!")
