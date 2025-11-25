* =========================================
* Головна форма програми - mainform.prg
* Програмне створення форми
* =========================================

PUBLIC oMainForm
oMainForm = CREATEOBJECT("frmMain")
oMainForm.Show()

RETURN

* =========================================
* Визначення класу головної форми
* =========================================

DEFINE CLASS frmMain AS Form
    Height = 400
    Width = 600
    ShowWindow = 2  && As Top-Level Form
    AutoCenter = .T.
    Caption = "Лабораторна робота №7 - Послідовний пошук"
    Name = "frmMain"
    WindowType = 0

    * Властивості для зберігання об'єктів
    ADD OBJECT lblTitle AS Label WITH ;
        Caption = "Головне меню програми", ;
        FontSize = 14, ;
        FontBold = .T., ;
        Top = 20, ;
        Left = 150, ;
        Width = 300, ;
        Height = 30, ;
        AutoSize = .T.

    ADD OBJECT lblInfo AS Label WITH ;
        Caption = "Використовуйте меню для навігації:", ;
        Top = 70, ;
        Left = 20, ;
        Width = 300, ;
        Height = 20, ;
        AutoSize = .T.

    ADD OBJECT lblFile AS Label WITH ;
        Caption = "FILE -> Exit - Вихід з програми", ;
        Top = 100, ;
        Left = 40, ;
        Width = 400, ;
        Height = 20, ;
        AutoSize = .T.

    ADD OBJECT lblSearch AS Label WITH ;
        Caption = "SEARCH -> Послідовний пошук - Відкрити форму пошуку", ;
        Top = 130, ;
        Left = 40, ;
        Width = 500, ;
        Height = 20, ;
        AutoSize = .T.

    ADD OBJECT lblInfo2 AS Label WITH ;
        Caption = "База даних: lab_7_db", ;
        Top = 180, ;
        Left = 20, ;
        Width = 300, ;
        Height = 20, ;
        FontItalic = .T., ;
        AutoSize = .T.

    ADD OBJECT lblInfo3 AS Label WITH ;
        Caption = "Таблиця: customer (клієнти)", ;
        Top = 210, ;
        Left = 20, ;
        Width = 300, ;
        Height = 20, ;
        FontItalic = .T., ;
        AutoSize = .T.

    * Метод ініціалізації
    PROCEDURE Init
        * Встановлюємо шлях до проекту
        LOCAL lcProjectPath
        lcProjectPath = JUSTPATH(SYS(16))
        IF !EMPTY(lcProjectPath)
            SET DEFAULT TO (lcProjectPath)
        ENDIF

        * Закриваємо всі відкриті бази даних
        CLOSE DATABASES ALL

        * Відкриваємо базу даних
        IF FILE("data\lab_7_db.dbc")
            OPEN DATABASE data\lab_7_db SHARED
            USE customer IN 0
        ELSE
            * Якщо база не існує, пропонуємо створити
            LOCAL lnResult
            lnResult = MESSAGEBOX("База даних не знайдена. Створити нову базу даних?", 4+32, "Створення бази даних")
            IF lnResult = 6  && Yes
                DO data\create_database.prg
                OPEN DATABASE data\lab_7_db SHARED
                USE customer IN 0
            ELSE
                MESSAGEBOX("Програма не може працювати без бази даних!", 16, "Помилка")
                RETURN .F.
            ENDIF
        ENDIF

        * Завантажуємо меню
        DO menus\mainmenu.mpr WITH THISFORM, .T.

        RETURN .T.
    ENDPROC

    * Метод закриття форми
    PROCEDURE Destroy
        * Закриваємо всі таблиці
        CLOSE DATABASES ALL

        * Видаляємо меню
        SET SYSMENU TO DEFAULT
        RELEASE MENUS mainmenu EXTENDED
    ENDPROC

    * Метод для відкриття форми пошуку
    PROCEDURE OpenSearchForm
        DO FORM forms\searchform.scx
    ENDPROC

ENDDEFINE
