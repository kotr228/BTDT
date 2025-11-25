* =========================================
* CREATE_MAINFORM.PRG
* Програмне створення головної форми
* =========================================

LOCAL oForm

* Видаляємо стару форму якщо існує
IF FILE("mainform.scx")
    DELETE FILE mainform.scx
    DELETE FILE mainform.sct
ENDIF

* Створюємо нову форму
CREATE FORM mainform NOWAIT

* Отримуємо посилання на форму
oForm = _SCREEN.ActiveForm

IF TYPE("oForm") = "O"
    WITH oForm
        * Властивості форми
        .Name = "frmMain"
        .Caption = "Лабораторна робота №7 - Послідовний пошук"
        .Height = 400
        .Width = 600
        .AutoCenter = .T.
        .ShowWindow = 2  && As Top-Level Form
        .WindowType = 0  && Modeless

        * Додаємо Label - заголовок
        .AddObject("lblTitle", "Label")
        .lblTitle.Caption = "Головне меню програми"
        .lblTitle.FontSize = 14
        .lblTitle.FontBold = .T.
        .lblTitle.AutoSize = .T.
        .lblTitle.Top = 20
        .lblTitle.Left = 150
        .lblTitle.Visible = .T.

        * Додаємо Label - інструкція
        .AddObject("lblInfo", "Label")
        .lblInfo.Caption = "Використовуйте меню для навігації:"
        .lblInfo.AutoSize = .T.
        .lblInfo.Top = 70
        .lblInfo.Left = 20
        .lblInfo.Visible = .T.

        * Додаємо Label - пункт FILE
        .AddObject("lblFile", "Label")
        .lblFile.Caption = "FILE -> Exit - Вихід з програми"
        .lblFile.AutoSize = .T.
        .lblFile.Top = 100
        .lblFile.Left = 40
        .lblFile.Visible = .T.

        * Додаємо Label - пункт SEARCH
        .AddObject("lblSearch", "Label")
        .lblSearch.Caption = "SEARCH -> Послідовний пошук - Відкрити форму пошуку"
        .lblSearch.AutoSize = .T.
        .lblSearch.Top = 130
        .lblSearch.Left = 40
        .lblSearch.Visible = .T.

        * Додаємо Label - інфо про БД
        .AddObject("lblDB", "Label")
        .lblDB.Caption = "База даних: lab_7_db"
        .lblDB.FontItalic = .T.
        .lblDB.AutoSize = .T.
        .lblDB.Top = 180
        .lblDB.Left = 20
        .lblDB.Visible = .T.

        * Додаємо Label - інфо про таблицю
        .AddObject("lblTable", "Label")
        .lblTable.Caption = "Таблиця: customer (клієнти)"
        .lblTable.FontItalic = .T.
        .lblTable.AutoSize = .T.
        .lblTable.Top = 210
        .lblTable.Left = 20
        .lblTable.Visible = .T.

        * Додаємо кнопку для відкриття форми пошуку
        .AddObject("cmdSearch", "CommandButton")
        .cmdSearch.Caption = "Відкрити форму пошуку"
        .cmdSearch.Width = 180
        .cmdSearch.Height = 35
        .cmdSearch.Top = 270
        .cmdSearch.Left = 210
        .cmdSearch.Visible = .T.

        * Додаємо кнопку виходу
        .AddObject("cmdExit", "CommandButton")
        .cmdExit.Caption = "Вихід"
        .cmdExit.Width = 100
        .cmdExit.Height = 35
        .cmdExit.Top = 320
        .cmdExit.Left = 250
        .cmdExit.Cancel = .T.
        .cmdExit.Visible = .T.

        * Додаємо код до методів

        * Init
        TEXT TO .Init NOSHOW TEXTMERGE
            LOCAL lcPath
            lcPath = JUSTPATH(SYS(16))
            IF !EMPTY(lcPath)
                SET DEFAULT TO (lcPath)
            ENDIF

            CLOSE DATABASES ALL

            IF FILE("data\lab_7_db.dbc")
                OPEN DATABASE data\lab_7_db SHARED
                USE customer IN 0
            ELSE
                LOCAL lnResult
                lnResult = MESSAGEBOX("База даних не знайдена. Створити?", 4+32, "Створення БД")
                IF lnResult = 6
                    DO data\create_database.prg
                    OPEN DATABASE data\lab_7_db SHARED
                    USE customer IN 0
                ENDIF
            ENDIF

            DO mainmenu.mpr WITH THISFORM, .T.
        ENDTEXT

        * Destroy
        TEXT TO .Destroy NOSHOW
            CLOSE DATABASES ALL
            SET SYSMENU TO DEFAULT
            RELEASE MENUS mainmenu EXTENDED
        ENDTEXT

        * cmdSearch.Click
        TEXT TO .cmdSearch.Click NOSHOW
            DO FORM searchform
        ENDTEXT

        * cmdExit.Click
        TEXT TO .cmdExit.Click NOSHOW
            THISFORM.Release()
        ENDTEXT

    ENDWITH

    * Зберігаємо форму
    KEYBOARD "{CTRL+W}"  && Ctrl+W для збереження

ENDIF

RETURN
