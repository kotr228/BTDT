*----------------------------------------------------------
* Лабораторна робота №8 - Створення простих форм
* Форми для перегляду даних з БД (Lab7)
*----------------------------------------------------------
CLOSE DATABASES ALL
CLEAR ALL
SET SAFETY OFF
SET TALK OFF

LOCAL lcPath
lcPath = "C:\VFP_Lab8"

IF !DIRECTORY(lcPath)
    MD (lcPath)
ENDIF
SET DEFAULT TO (lcPath)

* Копіювання БД з Lab7 (якщо потрібно)
* Примітка: У реальному сценарії можна просто відкривати БД з Lab7

MESSAGEBOX("Створюємо прості форми для перегляду даних." + CHR(13) + ;
           "Будь ласка, не закривайте програму!", 48, "Lab 8")

*==========================================================
* 1. ГОЛОВНЕ МЕНЮ (frm_main_menu.scx)
*==========================================================
DELETE FILE frm_main_menu.scx
DELETE FILE frm_main_menu.sct

CREATE FORM frm_main_menu NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Головне Меню (Lab 8)"
    .AutoCenter = .T.
    .Width = 350
    .Height = 300
    .BackColor = RGB(240, 240, 255)

    * Заголовок
    .AddObject("lblTitle", "Label")
    .lblTitle.Caption = "Система перегляду залізничних квитків"
    .lblTitle.FontBold = .T.
    .lblTitle.FontSize = 11
    .lblTitle.Top = 20
    .lblTitle.Left = 30
    .lblTitle.Width = 290
    .lblTitle.Height = 40
    .lblTitle.Alignment = 2
    .lblTitle.Visible = .T.

    * Кнопка "Станції"
    .AddObject("cmdStations", "CommandButton")
    .cmdStations.Caption = "Перегляд станцій"
    .cmdStations.Top = 80
    .cmdStations.Left = 75
    .cmdStations.Width = 200
    .cmdStations.Height = 35
    .cmdStations.Visible = .T.
    .cmdStations.WriteMethod("Click", "DO FORM frm_stations")

    * Кнопка "Пасажири"
    .AddObject("cmdPassengers", "CommandButton")
    .cmdPassengers.Caption = "Перегляд пасажирів"
    .cmdPassengers.Top = 130
    .cmdPassengers.Left = 75
    .cmdPassengers.Width = 200
    .cmdPassengers.Height = 35
    .cmdPassengers.Visible = .T.
    .cmdPassengers.WriteMethod("Click", "DO FORM frm_passengers")

    * Кнопка "Маршрути"
    .AddObject("cmdRoutes", "CommandButton")
    .cmdRoutes.Caption = "Перегляд маршрутів"
    .cmdRoutes.Top = 180
    .cmdRoutes.Left = 75
    .cmdRoutes.Width = 200
    .cmdRoutes.Height = 35
    .cmdRoutes.Visible = .T.
    .cmdRoutes.WriteMethod("Click", "DO FORM frm_routes")

    * Кнопка "Вихід"
    .AddObject("cmdExit", "CommandButton")
    .cmdExit.Caption = "Вихід"
    .cmdExit.Top = 230
    .cmdExit.Left = 125
    .cmdExit.Width = 100
    .cmdExit.Height = 30
    .cmdExit.Visible = .T.
    .cmdExit.WriteMethod("Click", "THISFORM.Release()")
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

*==========================================================
* 2. ФОРМА ПЕРЕГЛЯДУ СТАНЦІЙ (frm_stations.scx)
*==========================================================
DELETE FILE frm_stations.scx
DELETE FILE frm_stations.sct

CREATE FORM frm_stations NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Перегляд станцій"
    .Width = 600
    .Height = 450
    .AutoCenter = .T.
    .DataSession = 2

    * Відкриваємо БД в Load
    LOCAL lcLoad
    lcLoad = [SET EXCLUSIVE OFF] + CHR(13) + ;
             [SET DEFAULT TO "C:\VFP_Lab7"] + CHR(13) + ;
             [OPEN DATABASE "TktDB_Simple" SHARED] + CHR(13) + ;
             [USE Stations IN 0 SHARED]
    .WriteMethod("Load", lcLoad)

    * Заголовок
    .AddObject("lblTitle", "Label")
    .lblTitle.Caption = "Список залізничних станцій"
    .lblTitle.FontBold = .T.
    .lblTitle.FontSize = 10
    .lblTitle.Top = 10
    .lblTitle.Left = 20
    .lblTitle.Width = 300
    .lblTitle.Visible = .T.

    * Grid для відображення даних
    .AddObject("grdStations", "Grid")
    .grdStations.RecordSourceType = 1
    .grdStations.RecordSource = "Stations"
    .grdStations.Top = 40
    .grdStations.Left = 20
    .grdStations.Width = 560
    .grdStations.Height = 350
    .grdStations.ReadOnly = .T.
    .grdStations.Visible = .T.

    * Кнопка "Закрити"
    .AddObject("cmdClose", "CommandButton")
    .cmdClose.Caption = "Закрити"
    .cmdClose.Top = 400
    .cmdClose.Left = 250
    .cmdClose.Width = 100
    .cmdClose.Visible = .T.
    .cmdClose.WriteMethod("Click", "THISFORM.Release()")
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

*==========================================================
* 3. ФОРМА ПЕРЕГЛЯДУ ПАСАЖИРІВ (frm_passengers.scx)
*==========================================================
DELETE FILE frm_passengers.scx
DELETE FILE frm_passengers.sct

CREATE FORM frm_passengers NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Перегляд пасажирів"
    .Width = 650
    .Height = 500
    .AutoCenter = .T.
    .DataSession = 2

    * Відкриваємо БД в Load
    LOCAL lcLoad
    lcLoad = [SET EXCLUSIVE OFF] + CHR(13) + ;
             [SET DEFAULT TO "C:\VFP_Lab7"] + CHR(13) + ;
             [OPEN DATABASE "TktDB_Simple" SHARED] + CHR(13) + ;
             [USE Passengers IN 0 SHARED]
    .WriteMethod("Load", lcLoad)

    * Заголовок
    .AddObject("lblTitle", "Label")
    .lblTitle.Caption = "Список пасажирів"
    .lblTitle.FontBold = .T.
    .lblTitle.FontSize = 10
    .lblTitle.Top = 10
    .lblTitle.Left = 20
    .lblTitle.Width = 300
    .lblTitle.Visible = .T.

    * Пошук
    .AddObject("lblSearch", "Label")
    .lblSearch.Caption = "Пошук за прізвищем:"
    .lblSearch.Top = 45
    .lblSearch.Left = 20
    .lblSearch.Width = 150
    .lblSearch.Visible = .T.

    .AddObject("txtSearch", "TextBox")
    .txtSearch.Top = 42
    .txtSearch.Left = 180
    .txtSearch.Width = 150
    .txtSearch.Visible = .T.

    .AddObject("cmdSearch", "CommandButton")
    .cmdSearch.Caption = "Знайти"
    .cmdSearch.Top = 40
    .cmdSearch.Left = 340
    .cmdSearch.Width = 80
    .cmdSearch.Visible = .T.
    .cmdSearch.WriteMethod("Click", ;
        [SELECT Passengers] + CHR(13) + ;
        [LOCATE FOR UPPER(ALLTRIM(lname)) = UPPER(ALLTRIM(THISFORM.txtSearch.Value))] + CHR(13) + ;
        [IF FOUND()] + CHR(13) + ;
        [   THISFORM.grdPassengers.Refresh()] + CHR(13) + ;
        [   MESSAGEBOX("Пасажира знайдено!", 64)] + CHR(13) + ;
        [ELSE] + CHR(13) + ;
        [   MESSAGEBOX("Пасажира не знайдено", 48)] + CHR(13) + ;
        [ENDIF])

    * Grid для відображення даних
    .AddObject("grdPassengers", "Grid")
    .grdPassengers.RecordSourceType = 1
    .grdPassengers.RecordSource = "Passengers"
    .grdPassengers.Top = 80
    .grdPassengers.Left = 20
    .grdPassengers.Width = 610
    .grdPassengers.Height = 360
    .grdPassengers.ReadOnly = .T.
    .grdPassengers.Visible = .T.

    * Кнопка "Закрити"
    .AddObject("cmdClose", "CommandButton")
    .cmdClose.Caption = "Закрити"
    .cmdClose.Top = 450
    .cmdClose.Left = 275
    .cmdClose.Width = 100
    .cmdClose.Visible = .T.
    .cmdClose.WriteMethod("Click", "THISFORM.Release()")
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

*==========================================================
* 4. ФОРМА ПЕРЕГЛЯДУ МАРШРУТІВ (frm_routes.scx)
*==========================================================
DELETE FILE frm_routes.scx
DELETE FILE frm_routes.sct

CREATE FORM frm_routes NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Перегляд маршрутів"
    .Width = 600
    .Height = 450
    .AutoCenter = .T.
    .DataSession = 2

    * Відкриваємо БД в Load
    LOCAL lcLoad
    lcLoad = [SET EXCLUSIVE OFF] + CHR(13) + ;
             [SET DEFAULT TO "C:\VFP_Lab7"] + CHR(13) + ;
             [OPEN DATABASE "TktDB_Simple" SHARED] + CHR(13) + ;
             [USE Routes IN 0 SHARED]
    .WriteMethod("Load", lcLoad)

    * Заголовок
    .AddObject("lblTitle", "Label")
    .lblTitle.Caption = "Список маршрутів"
    .lblTitle.FontBold = .T.
    .lblTitle.FontSize = 10
    .lblTitle.Top = 10
    .lblTitle.Left = 20
    .lblTitle.Width = 300
    .lblTitle.Visible = .T.

    * Фільтр за відстанню
    .AddObject("lblFilter", "Label")
    .lblFilter.Caption = "Відстань більше:"
    .lblFilter.Top = 45
    .lblFilter.Left = 20
    .lblFilter.Width = 120
    .lblFilter.Visible = .T.

    .AddObject("txtDistance", "TextBox")
    .txtDistance.Top = 42
    .txtDistance.Left = 150
    .txtDistance.Width = 80
    .txtDistance.Value = "0"
    .txtDistance.Visible = .T.

    .AddObject("cmdFilter", "CommandButton")
    .cmdFilter.Caption = "Застосувати"
    .cmdFilter.Top = 40
    .cmdFilter.Left = 240
    .cmdFilter.Width = 100
    .cmdFilter.Visible = .T.
    .cmdFilter.WriteMethod("Click", ;
        [SELECT Routes] + CHR(13) + ;
        [SET FILTER TO distance > VAL(THISFORM.txtDistance.Value)] + CHR(13) + ;
        [GO TOP] + CHR(13) + ;
        [THISFORM.grdRoutes.Refresh()] + CHR(13) + ;
        [MESSAGEBOX("Фільтр застосовано", 64)])

    .AddObject("cmdClearFilter", "CommandButton")
    .cmdClearFilter.Caption = "Скасувати"
    .cmdClearFilter.Top = 40
    .cmdClearFilter.Left = 350
    .cmdClearFilter.Width = 100
    .cmdClearFilter.Visible = .T.
    .cmdClearFilter.WriteMethod("Click", ;
        [SELECT Routes] + CHR(13) + ;
        [SET FILTER TO] + CHR(13) + ;
        [GO TOP] + CHR(13) + ;
        [THISFORM.grdRoutes.Refresh()] + CHR(13) + ;
        [MESSAGEBOX("Фільтр скасовано", 64)])

    * Grid для відображення даних
    .AddObject("grdRoutes", "Grid")
    .grdRoutes.RecordSourceType = 1
    .grdRoutes.RecordSource = "Routes"
    .grdRoutes.Top = 80
    .grdRoutes.Left = 20
    .grdRoutes.Width = 560
    .grdRoutes.Height = 320
    .grdRoutes.ReadOnly = .T.
    .grdRoutes.Visible = .T.

    * Кнопка "Закрити"
    .AddObject("cmdClose", "CommandButton")
    .cmdClose.Caption = "Закрити"
    .cmdClose.Top = 410
    .cmdClose.Left = 250
    .cmdClose.Width = 100
    .cmdClose.Visible = .T.
    .cmdClose.WriteMethod("Click", "THISFORM.Release()")
ENDWITH

KEYBOARD '{CTRL+W}' PLAIN
DOEVENTS
=INKEY(1)

MESSAGEBOX("ГОТОВО! Форми створено." + CHR(13) + ;
           "Створено 4 форми:" + CHR(13) + ;
           "- frm_main_menu.scx (головне меню)" + CHR(13) + ;
           "- frm_stations.scx (станції)" + CHR(13) + ;
           "- frm_passengers.scx (пасажири + пошук)" + CHR(13) + ;
           "- frm_routes.scx (маршрути + фільтр)" + CHR(13) + CHR(13) + ;
           "Запустіть: DO FORM frm_main_menu", 64, "Lab 8 - Успіх")
