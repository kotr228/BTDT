*----------------------------------------------------------
* ВИПРАВЛЕНИЙ ГЕНЕРАТОР ФАЙЛІВ ФОРМ (.SCX)
* Виправляє проблему пустих Grid (відкриває таблиці в Load)
*----------------------------------------------------------
CLOSE DATABASES ALL
CLEAR ALL
SET SAFETY OFF
SET TALK OFF

LOCAL lcPath
lcPath = "C:\VFP_Lab9"

IF !DIRECTORY(lcPath)
    MD (lcPath)
ENDIF
SET DEFAULT TO (lcPath)

MESSAGEBOX("Починаємо виправлення форм." + CHR(13) + ;
           "Будь ласка, НЕ ЧІПАЙТЕ мишку та клавіатуру!", 48, "Увага")

*==========================================================
* 1. ГОЛОВНЕ МЕНЮ (frm_menu.scx) - тут все було добре
*==========================================================
DELETE FILE frm_menu.scx
DELETE FILE frm_menu.sct

CREATE FORM frm_menu NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Головне Меню (Лаб 9)"
    .AutoCenter = .T.
    .Width = 300
    .Height = 250

    .AddObject("cmdDB", "CommandButton")
    .cmdDB.Caption = "База Даних"
    .cmdDB.Top = 30
    .cmdDB.Left = 50
    .cmdDB.Width = 200
    .cmdDB.Height = 40
    .cmdDB.Visible = .T.
    .cmdDB.WriteMethod("Click", "DO FORM frm_data")

    .AddObject("cmdSearch", "CommandButton")
    .cmdSearch.Caption = "Пошук"
    .cmdSearch.Top = 90
    .cmdSearch.Left = 50
    .cmdSearch.Width = 200
    .cmdSearch.Height = 40
    .cmdSearch.Visible = .T.
    .cmdSearch.WriteMethod("Click", "DO FORM frm_search")

    .AddObject("cmdQuery", "CommandButton")
    .cmdQuery.Caption = "Запити та Перегляди"
    .cmdQuery.Top = 150
    .cmdQuery.Left = 50
    .cmdQuery.Width = 200
    .cmdQuery.Height = 40
    .cmdQuery.Visible = .T.
    .cmdQuery.WriteMethod("Click", "DO FORM frm_queries")
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

*==========================================================
* 2. ФОРМА РЕДАГУВАННЯ (frm_data.scx) - ВИПРАВЛЕНО LOAD
*==========================================================
DELETE FILE frm_data.scx
DELETE FILE frm_data.sct

CREATE FORM frm_data NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Редагування БД"
    .Width = 600
    .Height = 500
    .AutoCenter = .T.
    .DataSession = 2 && Private DataSession

    * --- ВАЖЛИВО: Відкриваємо таблиці в LOAD (до Grid) ---
    LOCAL lcLoadCode
    lcLoadCode = [SET EXCLUSIVE OFF] + CHR(13) + ;
                 [OPEN DATABASE "TktDB_Norm" SHARED] + CHR(13) + ;
                 [USE Stations IN 0 SHARED] + CHR(13) + ;
                 [USE Passengers IN 0 SHARED]
    .WriteMethod("Load", lcLoadCode)

    * Додавання PageFrame
    .AddObject("pgf1", "PageFrame")
    .pgf1.PageCount = 2
    .pgf1.Width = 580
    .pgf1.Height = 480
    .pgf1.Top = 10
    .pgf1.Left = 10
    .pgf1.Visible = .T.

    * --- Page 1 (Станції) ---
    WITH .pgf1.Page1
        .Caption = "Станції"

        .AddObject("grd1", "Grid")
        .grd1.Width = 300
        .grd1.Height = 400
        .grd1.Top = 10
        .grd1.Left = 10
        .grd1.RecordSourceType = 1 && Alias
        .grd1.RecordSource = "Stations"
        .grd1.Visible = .T.

        .AddObject("lbl1", "Label")
        .lbl1.Caption = "Назва:"
        .lbl1.Left = 320
        .lbl1.Top = 20
        .lbl1.Visible = .T.

        .AddObject("txt1", "TextBox")
        .txt1.ControlSource = "Stations.name"
        .txt1.Left = 320
        .txt1.Top = 40
        .txt1.Visible = .T.

        .AddObject("cmdAdd", "CommandButton")
        .cmdAdd.Caption = "ДОДАТИ"
        .cmdAdd.Top = 100
        .cmdAdd.Left = 320
        .cmdAdd.Visible = .T.
        .cmdAdd.WriteMethod("Click", [APPEND BLANK] + CHR(13) + [THISFORM.pgf1.Page1.grd1.Refresh])

        .AddObject("cmdDel", "CommandButton")
        .cmdDel.Caption = "ВИДАЛИТИ"
        .cmdDel.Top = 140
        .cmdDel.Left = 320
        .cmdDel.Visible = .T.
        .cmdDel.WriteMethod("Click", [SELECT Stations] + CHR(13) + [DELETE] + CHR(13) + [SKIP] + CHR(13) + [IF EOF()] + CHR(13) + [SKIP -1] + CHR(13) + [ENDIF] + CHR(13) + [THISFORM.Refresh])
    ENDWITH

    * --- Page 2 (Пасажири) ---
    WITH .pgf1.Page2
        .Caption = "Пасажири"

        .AddObject("grd2", "Grid")
        .grd2.Width = 300
        .grd2.Height = 400
        .grd2.Top = 10
        .grd2.Left = 10
        .grd2.RecordSourceType = 1
        .grd2.RecordSource = "Passengers"
        .grd2.Visible = .T.

        .AddObject("cmdAdd", "CommandButton")
        .cmdAdd.Caption = "ДОДАТИ"
        .cmdAdd.Top = 100
        .cmdAdd.Left = 320
        .cmdAdd.Visible = .T.
        .cmdAdd.WriteMethod("Click", [APPEND BLANK] + CHR(13) + [THISFORM.Refresh])
    ENDWITH
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

*==========================================================
* 3. ФОРМА ПОШУКУ (frm_search.scx) - ВИПРАВЛЕНО LOAD
*==========================================================
DELETE FILE frm_search.scx
DELETE FILE frm_search.sct

CREATE FORM frm_search NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Пошук"
    .Width = 400
    .Height = 300
    .AutoCenter = .T.
    .DataSession = 2

    * ВАЖЛИВО: Відкриваємо в Load
    LOCAL lcLoad
    lcLoad = [SET EXCLUSIVE OFF] + CHR(13) + ;
             [OPEN DATABASE "TktDB_Norm" SHARED] + CHR(13) + ;
             [USE Passengers ORDER pass_id SHARED IN 0] + CHR(13) + ;
             [SELECT Passengers]
    .WriteMethod("Load", lcLoad)

    .AddObject("lbl1", "Label")
    .lbl1.Caption = "ID Пасажира:"
    .lbl1.Visible = .T.
    .lbl1.Top = 20
    .lbl1.Left = 20

    .AddObject("txtID", "TextBox")
    .txtID.Visible = .T.
    .txtID.Top = 40
    .txtID.Left = 20

    .AddObject("cmdSeek", "CommandButton")
    .cmdSeek.Caption = "Знайти (Index)"
    .cmdSeek.Visible = .T.
    .cmdSeek.Left = 150
    .cmdSeek.Top = 38
    .cmdSeek.WriteMethod("Click", [SEEK VAL(THISFORM.txtID.Value)] + CHR(13) + [IF FOUND()] + CHR(13) + [MESSAGEBOX('Знайдено!')] + CHR(13) + [THISFORM.grdRes.Refresh] + CHR(13) + [ELSE] + CHR(13) + [MESSAGEBOX('Не знайдено')] + CHR(13) + [ENDIF])

    .AddObject("grdRes", "Grid")
    .grdRes.RecordSource = "Passengers"
    .grdRes.Visible = .T.
    .grdRes.Top = 100
    .grdRes.Left = 20
    .grdRes.Width = 350
    .grdRes.Height = 180
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

*==========================================================
* 4. ФОРМА ЗАПИТІВ (frm_queries.scx) - OK
*==========================================================
DELETE FILE frm_queries.scx
DELETE FILE frm_queries.sct

CREATE FORM frm_queries NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Запити"
    .Width = 600
    .Height = 400
    .AutoCenter = .T.
    .DataSession = 2
    .WriteMethod("Load", [OPEN DATABASE "TktDB_Norm" SHARED])

    .AddObject("cmdQ1", "CommandButton")
    .cmdQ1.Caption = "Запит: Розклад"
    .cmdQ1.Visible = .T.
    .cmdQ1.Top = 20
    .cmdQ1.Left = 20
    .cmdQ1.Width = 150

    LOCAL lcSQL
    lcSQL = "SELECT * FROM Schedules INTO CURSOR curRes" + CHR(13) + ;
            "THISFORM.grd1.RecordSource = ''" + CHR(13) + ;
            "THISFORM.grd1.RecordSource = 'curRes'"

    .cmdQ1.WriteMethod("Click", lcSQL)

    .AddObject("grd1", "Grid")
    .grd1.Visible = .T.
    .grd1.Top = 70
    .grd1.Left = 20
    .grd1.Width = 550
    .grd1.Height = 300
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

MESSAGEBOX("ГОТОВО! Форми виправлено." + CHR(13) + ;
           "Запустіть frm_menu.scx, тепер дані в Grid повинні бути.", 64, "Успіх")
