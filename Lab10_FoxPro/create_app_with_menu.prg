*----------------------------------------------------------
* Лабораторна робота №10 - Створення додатку з меню
* Повноцінний додаток з меню, редагуванням, пошуком та запитами
*----------------------------------------------------------
CLOSE DATABASES ALL
CLEAR ALL
SET SAFETY OFF
SET TALK OFF

LOCAL lcPath
lcPath = "C:\VFP_Lab10"

IF !DIRECTORY(lcPath)
    MD (lcPath)
ENDIF
SET DEFAULT TO (lcPath)

MESSAGEBOX("Створюємо додаток з меню та формами." + CHR(13) + ;
           "Це може зайняти декілька хвилин...", 48, "Lab 10")

*==========================================================
* 1. ГОЛОВНА ФОРМА З МЕНЮ (frm_main.scx)
*==========================================================
DELETE FILE frm_main.scx
DELETE FILE frm_main.sct

CREATE FORM frm_main NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Система управління залізничними квитками - Lab 10"
    .AutoCenter = .T.
    .Width = 700
    .Height = 500
    .ShowWindow = 2  && As Top Level Form

    * Заголовок
    .AddObject("lblTitle", "Label")
    .lblTitle.Caption = "Система управління залізничними квитками"
    .lblTitle.FontBold = .T.
    .lblTitle.FontSize = 14
    .lblTitle.Top = 200
    .lblTitle.Left = 100
    .lblTitle.Width = 500
    .lblTitle.Height = 30
    .lblTitle.Alignment = 2
    .lblTitle.Visible = .T.

    .AddObject("lblSubtitle", "Label")
    .lblSubtitle.Caption = "Використовуйте меню для навігації"
    .lblSubtitle.FontSize = 10
    .lblSubtitle.Top = 240
    .lblSubtitle.Left = 150
    .lblSubtitle.Width = 400
    .lblSubtitle.Height = 20
    .lblSubtitle.Alignment = 2
    .lblSubtitle.Visible = .T.

    * Створення меню програмно
    LOCAL lcMenuCode
    lcMenuCode = ;
        [LOCAL oMenuBar, oMenu1, oMenu2, oMenu3, oMenu4] + CHR(13) + ;
        [] + CHR(13) + ;
        [* Головне меню] + CHR(13) + ;
        [oMenuBar = CREATEOBJECT("MenuBar")] + CHR(13) + ;
        [] + CHR(13) + ;
        [* Меню "Файл"] + CHR(13) + ;
        [oMenu1 = CREATEOBJECT("Menu")] + CHR(13) + ;
        [oMenu1.Caption = "\<Файл"] + CHR(13) + ;
        [oMenu1.AddItem("\<Вихід", "THISFORM.Release()")] + CHR(13) + ;
        [oMenuBar.AddMenu(oMenu1)] + CHR(13) + ;
        [] + CHR(13) + ;
        [* Меню "База Даних"] + CHR(13) + ;
        [oMenu2 = CREATEOBJECT("Menu")] + CHR(13) + ;
        [oMenu2.Caption = "\<База Даних"] + CHR(13) + ;
        [oMenu2.AddItem("\<Ведення даних", "DO FORM frm_database")] + CHR(13) + ;
        [oMenuBar.AddMenu(oMenu2)] + CHR(13) + ;
        [] + CHR(13) + ;
        [* Меню "Пошук"] + CHR(13) + ;
        [oMenu3 = CREATEOBJECT("Menu")] + CHR(13) + ;
        [oMenu3.Caption = "\<Пошук"] + CHR(13) + ;
        [oMenu3.AddItem("\<Послідовний пошук", "DO FORM frm_search_seq")] + CHR(13) + ;
        [oMenu3.AddItem("\<Індексний пошук", "DO FORM frm_search_idx")] + CHR(13) + ;
        [oMenuBar.AddMenu(oMenu3)] + CHR(13) + ;
        [] + CHR(13) + ;
        [* Меню "Запити та перегляди"] + CHR(13) + ;
        [oMenu4 = CREATEOBJECT("Menu")] + CHR(13) + ;
        [oMenu4.Caption = "\<Запити та перегляди"] + CHR(13) + ;
        [oMenu4.AddItem("\<Запити", "DO FORM frm_queries")] + CHR(13) + ;
        [oMenu4.AddItem("\<Перегляди", "DO FORM frm_views")] + CHR(13) + ;
        [oMenuBar.AddMenu(oMenu4)] + CHR(13) + ;
        [] + CHR(13) + ;
        [oMenuBar.Activate()]

    * Примітка: У VFP меню краще створювати через Menu Designer
    * Тут показано концептуально, як має виглядати структура

ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

*==========================================================
* 2. ФОРМА ВЕДЕННЯ БД (frm_database.scx)
*==========================================================
DELETE FILE frm_database.scx
DELETE FILE frm_database.sct

CREATE FORM frm_database NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Ведення бази даних"
    .Width = 750
    .Height = 550
    .AutoCenter = .T.
    .DataSession = 2

    * Відкриваємо БД в Load
    LOCAL lcLoad
    lcLoad = [SET EXCLUSIVE OFF] + CHR(13) + ;
             [SET DEFAULT TO "C:\VFP_Lab9"] + CHR(13) + ;
             [OPEN DATABASE "TktDB_Norm" SHARED] + CHR(13) + ;
             [USE Stations IN 0 SHARED] + CHR(13) + ;
             [USE Passengers IN 0 SHARED] + CHR(13) + ;
             [USE CarTypes IN 0 SHARED]
    .WriteMethod("Load", lcLoad)

    * PageFrame для різних таблиць
    .AddObject("pgfData", "PageFrame")
    .pgfData.PageCount = 3
    .pgfData.Width = 720
    .pgfData.Height = 480
    .pgfData.Top = 10
    .pgfData.Left = 15
    .pgfData.Visible = .T.

    * --- Сторінка 1: Станції ---
    WITH .pgfData.Page1
        .Caption = "Станції"

        * Grid
        .AddObject("grdData", "Grid")
        .grdData.RecordSourceType = 1
        .grdData.RecordSource = "Stations"
        .grdData.Width = 400
        .grdData.Height = 380
        .grdData.Top = 10
        .grdData.Left = 10
        .grdData.Visible = .T.

        * Поля для редагування
        .AddObject("lblName", "Label")
        .lblName.Caption = "Назва станції:"
        .lblName.Top = 20
        .lblName.Left = 430
        .lblName.Width = 100
        .lblName.Visible = .T.

        .AddObject("txtName", "TextBox")
        .txtName.ControlSource = "Stations.name"
        .txtName.Top = 40
        .txtName.Left = 430
        .txtName.Width = 250
        .txtName.Visible = .T.

        * Кнопки управління
        .AddObject("cmdAdd", "CommandButton")
        .cmdAdd.Caption = "ДОДАТИ"
        .cmdAdd.Top = 100
        .cmdAdd.Left = 430
        .cmdAdd.Width = 120
        .cmdAdd.Height = 30
        .cmdAdd.Visible = .T.
        .cmdAdd.WriteMethod("Click", ;
            [SELECT Stations] + CHR(13) + ;
            [APPEND BLANK] + CHR(13) + ;
            [THISFORM.Refresh()])

        .AddObject("cmdEdit", "CommandButton")
        .cmdEdit.Caption = "РЕДАГУВАТИ"
        .cmdEdit.Top = 140
        .cmdEdit.Left = 430
        .cmdEdit.Width = 120
        .cmdEdit.Height = 30
        .cmdEdit.Visible = .T.
        .cmdEdit.WriteMethod("Click", ;
            [MESSAGEBOX("Відредагуйте дані в полях та натисніть Enter", 64)])

        .AddObject("cmdDel", "CommandButton")
        .cmdDel.Caption = "ВИДАЛИТИ"
        .cmdDel.Top = 180
        .cmdDel.Left = 430
        .cmdDel.Width = 120
        .cmdDel.Height = 30
        .cmdDel.Visible = .T.
        .cmdDel.WriteMethod("Click", ;
            [IF MESSAGEBOX("Видалити поточний запис?", 4+32) = 6] + CHR(13) + ;
            [   SELECT Stations] + CHR(13) + ;
            [   DELETE] + CHR(13) + ;
            [   SKIP] + CHR(13) + ;
            [   IF EOF()] + CHR(13) + ;
            [      SKIP -1] + CHR(13) + ;
            [   ENDIF] + CHR(13) + ;
            [   THISFORM.Refresh()] + CHR(13) + ;
            [ENDIF])

        .AddObject("cmdRefresh", "CommandButton")
        .cmdRefresh.Caption = "ОНОВИТИ"
        .cmdRefresh.Top = 220
        .cmdRefresh.Left = 430
        .cmdRefresh.Width = 120
        .cmdRefresh.Height = 30
        .cmdRefresh.Visible = .T.
        .cmdRefresh.WriteMethod("Click", ;
            [SELECT Stations] + CHR(13) + ;
            [GO TOP] + CHR(13) + ;
            [THISFORM.Refresh()])
    ENDWITH

    * --- Сторінка 2: Пасажири ---
    WITH .pgfData.Page2
        .Caption = "Пасажири"

        .AddObject("grdData", "Grid")
        .grdData.RecordSourceType = 1
        .grdData.RecordSource = "Passengers"
        .grdData.Width = 450
        .grdData.Height = 380
        .grdData.Top = 10
        .grdData.Left = 10
        .grdData.Visible = .T.

        * Поля для редагування
        .AddObject("lblLName", "Label")
        .lblLName.Caption = "Прізвище:"
        .lblLName.Top = 20
        .lblLName.Left = 480
        .lblLName.Visible = .T.

        .AddObject("txtLName", "TextBox")
        .txtLName.ControlSource = "Passengers.lname"
        .txtLName.Top = 40
        .txtLName.Left = 480
        .txtLName.Width = 200
        .txtLName.Visible = .T.

        .AddObject("lblFName", "Label")
        .lblFName.Caption = "Ім'я:"
        .lblFName.Top = 70
        .lblFName.Left = 480
        .lblFName.Visible = .T.

        .AddObject("txtFName", "TextBox")
        .txtFName.ControlSource = "Passengers.fname"
        .txtFName.Top = 90
        .txtFName.Left = 480
        .txtFName.Width = 200
        .txtFName.Visible = .T.

        .AddObject("lblPName", "Label")
        .lblPName.Caption = "По батькові:"
        .lblPName.Top = 120
        .lblPName.Left = 480
        .lblPName.Visible = .T.

        .AddObject("txtPName", "TextBox")
        .txtPName.ControlSource = "Passengers.pname"
        .txtPName.Top = 140
        .txtPName.Left = 480
        .txtPName.Width = 200
        .txtPName.Visible = .T.

        * Кнопки
        .AddObject("cmdAdd", "CommandButton")
        .cmdAdd.Caption = "ДОДАТИ"
        .cmdAdd.Top = 200
        .cmdAdd.Left = 480
        .cmdAdd.Width = 120
        .cmdAdd.Height = 30
        .cmdAdd.Visible = .T.
        .cmdAdd.WriteMethod("Click", ;
            [SELECT Passengers] + CHR(13) + ;
            [APPEND BLANK] + CHR(13) + ;
            [THISFORM.Refresh()])

        .AddObject("cmdDel", "CommandButton")
        .cmdDel.Caption = "ВИДАЛИТИ"
        .cmdDel.Top = 240
        .cmdDel.Left = 480
        .cmdDel.Width = 120
        .cmdDel.Height = 30
        .cmdDel.Visible = .T.
        .cmdDel.WriteMethod("Click", ;
            [IF MESSAGEBOX("Видалити поточний запис?", 4+32) = 6] + CHR(13) + ;
            [   SELECT Passengers] + CHR(13) + ;
            [   DELETE] + CHR(13) + ;
            [   SKIP] + CHR(13) + ;
            [   IF EOF()] + CHR(13) + ;
            [      SKIP -1] + CHR(13) + ;
            [   ENDIF] + CHR(13) + ;
            [   THISFORM.Refresh()] + CHR(13) + ;
            [ENDIF])
    ENDWITH

    * --- Сторінка 3: Типи вагонів ---
    WITH .pgfData.Page3
        .Caption = "Типи вагонів"

        .AddObject("grdData", "Grid")
        .grdData.RecordSourceType = 1
        .grdData.RecordSource = "CarTypes"
        .grdData.Width = 400
        .grdData.Height = 380
        .grdData.Top = 10
        .grdData.Left = 10
        .grdData.Visible = .T.

        * Поля
        .AddObject("lblType", "Label")
        .lblType.Caption = "Назва типу:"
        .lblType.Top = 20
        .lblType.Left = 430
        .lblType.Visible = .T.

        .AddObject("txtType", "TextBox")
        .txtType.ControlSource = "CarTypes.type_name"
        .txtType.Top = 40
        .txtType.Left = 430
        .txtType.Width = 200
        .txtType.Visible = .T.

        .AddObject("lblCost", "Label")
        .lblCost.Caption = "Базова вартість:"
        .lblCost.Top = 70
        .lblCost.Left = 430
        .lblCost.Visible = .T.

        .AddObject("txtCost", "TextBox")
        .txtCost.ControlSource = "CarTypes.base_cost"
        .txtCost.Top = 90
        .txtCost.Left = 430
        .txtCost.Width = 150
        .txtCost.Visible = .T.

        * Кнопки
        .AddObject("cmdAdd", "CommandButton")
        .cmdAdd.Caption = "ДОДАТИ"
        .cmdAdd.Top = 140
        .cmdAdd.Left = 430
        .cmdAdd.Width = 120
        .cmdAdd.Height = 30
        .cmdAdd.Visible = .T.
        .cmdAdd.WriteMethod("Click", ;
            [SELECT CarTypes] + CHR(13) + ;
            [APPEND BLANK] + CHR(13) + ;
            [THISFORM.Refresh()])

        .AddObject("cmdDel", "CommandButton")
        .cmdDel.Caption = "ВИДАЛИТИ"
        .cmdDel.Top = 180
        .cmdDel.Left = 430
        .cmdDel.Width = 120
        .cmdDel.Height = 30
        .cmdDel.Visible = .T.
        .cmdDel.WriteMethod("Click", ;
            [IF MESSAGEBOX("Видалити поточний запис?", 4+32) = 6] + CHR(13) + ;
            [   SELECT CarTypes] + CHR(13) + ;
            [   DELETE] + CHR(13) + ;
            [   SKIP] + CHR(13) + ;
            [   IF EOF()] + CHR(13) + ;
            [      SKIP -1] + CHR(13) + ;
            [   ENDIF] + CHR(13) + ;
            [   THISFORM.Refresh()] + CHR(13) + ;
            [ENDIF])
    ENDWITH

    * Кнопка закриття форми
    .AddObject("cmdClose", "CommandButton")
    .cmdClose.Caption = "Закрити"
    .cmdClose.Top = 500
    .cmdClose.Left = 325
    .cmdClose.Width = 100
    .cmdClose.Visible = .T.
    .cmdClose.WriteMethod("Click", "THISFORM.Release()")
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

MESSAGEBOX("Частина 1 завершена. Створено форми:" + CHR(13) + ;
           "- frm_main.scx (головна з меню)" + CHR(13) + ;
           "- frm_database.scx (ведення даних)", 64, "Прогрес")

*==========================================================
* Продовження у наступній частині...
*==========================================================
