*----------------------------------------------------------
* Лабораторна робота №10 - Частина 2
* Створення форм пошуку та запитів
*----------------------------------------------------------
CLOSE DATABASES ALL
CLEAR ALL
SET SAFETY OFF
SET TALK OFF

SET DEFAULT TO "C:\VFP_Lab10"

MESSAGEBOX("Створюємо форми пошуку та запитів...", 48, "Lab 10 - Частина 2")

*==========================================================
* 3. ФОРМА ПОСЛІДОВНОГО ПОШУКУ (frm_search_seq.scx)
*==========================================================
DELETE FILE frm_search_seq.scx
DELETE FILE frm_search_seq.sct

CREATE FORM frm_search_seq NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Послідовний пошук (LOCATE)"
    .Width = 650
    .Height = 500
    .AutoCenter = .T.
    .DataSession = 2

    * Відкриваємо БД
    LOCAL lcLoad
    lcLoad = [SET EXCLUSIVE OFF] + CHR(13) + ;
             [SET DEFAULT TO "C:\VFP_Lab9"] + CHR(13) + ;
             [OPEN DATABASE "TktDB_Norm" SHARED] + CHR(13) + ;
             [USE Passengers IN 0 SHARED] + CHR(13) + ;
             [SELECT Passengers]
    .WriteMethod("Load", lcLoad)

    * Заголовок
    .AddObject("lblTitle", "Label")
    .lblTitle.Caption = "Послідовний пошук пасажирів"
    .lblTitle.FontBold = .T.
    .lblTitle.FontSize = 11
    .lblTitle.Top = 10
    .lblTitle.Left = 20
    .lblTitle.Width = 300
    .lblTitle.Visible = .T.

    * Пошук за прізвищем
    .AddObject("lblLName", "Label")
    .lblLName.Caption = "Прізвище:"
    .lblLName.Top = 50
    .lblLName.Left = 20
    .lblLName.Width = 80
    .lblLName.Visible = .T.

    .AddObject("txtLName", "TextBox")
    .txtLName.Top = 48
    .txtLName.Left = 110
    .txtLName.Width = 200
    .txtLName.Visible = .T.

    .AddObject("cmdSearchLName", "CommandButton")
    .cmdSearchLName.Caption = "Шукати"
    .cmdSearchLName.Top = 46
    .cmdSearchLName.Left = 320
    .cmdSearchLName.Width = 100
    .cmdSearchLName.Visible = .T.
    .cmdSearchLName.WriteMethod("Click", ;
        [SELECT Passengers] + CHR(13) + ;
        [GO TOP] + CHR(13) + ;
        [LOCATE FOR UPPER(ALLTRIM(lname)) = UPPER(ALLTRIM(THISFORM.txtLName.Value))] + CHR(13) + ;
        [IF FOUND()] + CHR(13) + ;
        [   THISFORM.grdResult.Refresh()] + CHR(13) + ;
        [   MESSAGEBOX("Знайдено: " + ALLTRIM(fname) + " " + ALLTRIM(lname), 64, "Успіх")] + CHR(13) + ;
        [ELSE] + CHR(13) + ;
        [   MESSAGEBOX("Пасажира з таким прізвищем не знайдено", 48, "Не знайдено")] + CHR(13) + ;
        [ENDIF])

    * Пошук за ім'ям
    .AddObject("lblFName", "Label")
    .lblFName.Caption = "Ім'я:"
    .lblFName.Top = 90
    .lblFName.Left = 20
    .lblFName.Width = 80
    .lblFName.Visible = .T.

    .AddObject("txtFName", "TextBox")
    .txtFName.Top = 88
    .txtFName.Left = 110
    .txtFName.Width = 200
    .txtFName.Visible = .T.

    .AddObject("cmdSearchFName", "CommandButton")
    .cmdSearchFName.Caption = "Шукати"
    .cmdSearchFName.Top = 86
    .cmdSearchFName.Left = 320
    .cmdSearchFName.Width = 100
    .cmdSearchFName.Visible = .T.
    .cmdSearchFName.WriteMethod("Click", ;
        [SELECT Passengers] + CHR(13) + ;
        [GO TOP] + CHR(13) + ;
        [LOCATE FOR UPPER(ALLTRIM(fname)) = UPPER(ALLTRIM(THISFORM.txtFName.Value))] + CHR(13) + ;
        [IF FOUND()] + CHR(13) + ;
        [   THISFORM.grdResult.Refresh()] + CHR(13) + ;
        [   MESSAGEBOX("Знайдено: " + ALLTRIM(fname) + " " + ALLTRIM(lname), 64, "Успіх")] + CHR(13) + ;
        [ELSE] + CHR(13) + ;
        [   MESSAGEBOX("Пасажира з таким ім'ям не знайдено", 48, "Не знайдено")] + CHR(13) + ;
        [ENDIF])

    * Продовжити пошук
    .AddObject("cmdContinue", "CommandButton")
    .cmdContinue.Caption = "Продовжити пошук (CONTINUE)"
    .cmdContinue.Top = 130
    .cmdContinue.Left = 20
    .cmdContinue.Width = 200
    .cmdContinue.Visible = .T.
    .cmdContinue.WriteMethod("Click", ;
        [CONTINUE] + CHR(13) + ;
        [IF FOUND()] + CHR(13) + ;
        [   THISFORM.grdResult.Refresh()] + CHR(13) + ;
        [   MESSAGEBOX("Знайдено наступний запис", 64)] + CHR(13) + ;
        [ELSE] + CHR(13) + ;
        [   MESSAGEBOX("Більше записів не знайдено", 48)] + CHR(13) + ;
        [ENDIF])

    * Показати всі
    .AddObject("cmdShowAll", "CommandButton")
    .cmdShowAll.Caption = "Показати всі"
    .cmdShowAll.Top = 130
    .cmdShowAll.Left = 230
    .cmdShowAll.Width = 120
    .cmdShowAll.Visible = .T.
    .cmdShowAll.WriteMethod("Click", ;
        [SELECT Passengers] + CHR(13) + ;
        [GO TOP] + CHR(13) + ;
        [THISFORM.grdResult.Refresh()])

    * Grid для результатів
    .AddObject("grdResult", "Grid")
    .grdResult.RecordSourceType = 1
    .grdResult.RecordSource = "Passengers"
    .grdResult.Top = 180
    .grdResult.Left = 20
    .grdResult.Width = 610
    .grdResult.Height = 260
    .grdResult.ReadOnly = .T.
    .grdResult.Visible = .T.

    * Закрити
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
* 4. ФОРМА ІНДЕКСНОГО ПОШУКУ (frm_search_idx.scx)
*==========================================================
DELETE FILE frm_search_idx.scx
DELETE FILE frm_search_idx.sct

CREATE FORM frm_search_idx NOWAIT
=INKEY(0.5)
ASELOBJ(laForm, 1)
loForm = laForm[1]

WITH loForm
    .Caption = "Індексний пошук (SEEK)"
    .Width = 600
    .Height = 450
    .AutoCenter = .T.
    .DataSession = 2

    * Відкриваємо БД з індексом
    LOCAL lcLoad
    lcLoad = [SET EXCLUSIVE OFF] + CHR(13) + ;
             [SET DEFAULT TO "C:\VFP_Lab9"] + CHR(13) + ;
             [OPEN DATABASE "TktDB_Norm" SHARED] + CHR(13) + ;
             [USE Passengers ORDER pass_id IN 0 SHARED] + CHR(13) + ;
             [SELECT Passengers]
    .WriteMethod("Load", lcLoad)

    * Заголовок
    .AddObject("lblTitle", "Label")
    .lblTitle.Caption = "Індексний пошук за ID пасажира"
    .lblTitle.FontBold = .T.
    .lblTitle.FontSize = 11
    .lblTitle.Top = 10
    .lblTitle.Left = 20
    .lblTitle.Width = 350
    .lblTitle.Visible = .T.

    .AddObject("lblInfo", "Label")
    .lblInfo.Caption = "Пошук використовує індекс для швидкого доступу (SEEK)"
    .lblInfo.Top = 35
    .lblInfo.Left = 20
    .lblInfo.Width = 400
    .lblInfo.Visible = .T.

    * Пошук за ID
    .AddObject("lblID", "Label")
    .lblID.Caption = "ID пасажира:"
    .lblID.Top = 70
    .lblID.Left = 20
    .lblID.Width = 100
    .lblID.Visible = .T.

    .AddObject("txtID", "TextBox")
    .txtID.Top = 68
    .txtID.Left = 130
    .txtID.Width = 150
    .txtID.Value = "1"
    .txtID.Visible = .T.

    .AddObject("cmdSeek", "CommandButton")
    .cmdSeek.Caption = "SEEK (швидкий пошук)"
    .cmdSeek.Top = 66
    .cmdSeek.Left = 290
    .cmdSeek.Width = 180
    .cmdSeek.Visible = .T.
    .cmdSeek.WriteMethod("Click", ;
        [SELECT Passengers] + CHR(13) + ;
        [SEEK VAL(THISFORM.txtID.Value)] + CHR(13) + ;
        [IF FOUND()] + CHR(13) + ;
        [   THISFORM.grdResult.Refresh()] + CHR(13) + ;
        [   LOCAL lcMsg] + CHR(13) + ;
        [   lcMsg = "Знайдено:" + CHR(13) + ;
        [            "ID: " + TRANSFORM(pass_id) + CHR(13) + ;
        [            "ПІБ: " + ALLTRIM(lname) + " " + ALLTRIM(fname) + " " + ALLTRIM(pname)] + CHR(13) + ;
        [   MESSAGEBOX(lcMsg, 64, "Успіх")] + CHR(13) + ;
        [ELSE] + CHR(13) + ;
        [   MESSAGEBOX("Пасажира з ID=" + THISFORM.txtID.Value + " не знайдено", 48, "Не знайдено")] + CHR(13) + ;
        [ENDIF])

    * Інформаційна панель
    .AddObject("lblSeekInfo", "Label")
    .lblSeekInfo.Caption = "SEEK швидше ніж LOCATE, бо використовує індекс"
    .lblSeekInfo.Top = 110
    .lblSeekInfo.Left = 20
    .lblSeekInfo.Width = 400
    .lblSeekInfo.ForeColor = RGB(0, 100, 0)
    .lblSeekInfo.Visible = .T.

    * Grid для результатів
    .AddObject("grdResult", "Grid")
    .grdResult.RecordSourceType = 1
    .grdResult.RecordSource = "Passengers"
    .grdResult.Top = 150
    .grdResult.Left = 20
    .grdResult.Width = 560
    .grdResult.Height = 240
    .grdResult.ReadOnly = .T.
    .grdResult.Visible = .T.

    * Закрити
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

MESSAGEBOX("Частина 2 завершена. Створено форми пошуку:" + CHR(13) + ;
           "- frm_search_seq.scx (послідовний)" + CHR(13) + ;
           "- frm_search_idx.scx (індексний)", 64, "Прогрес")

* Продовження у частині 3...
