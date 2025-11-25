* =========================================
* CREATE_SEARCHFORM.PRG
* Програмне створення форми пошуку
* =========================================

* Видаляємо стару форму
IF FILE("searchform.scx")
    DELETE FILE searchform.scx
    DELETE FILE searchform.sct
ENDIF

* Використовуємо клас з forms\searchform.prg
* Створюємо екземпляр форми та зберігаємо як SCX

LOCAL oForm
oForm = CREATEOBJECT("frmSearch")

* Зберігаємо форму як SCX
IF TYPE("oForm") = "O"
    oForm.SaveAsClass("searchform.vcx", "frmSearch")
    * Альтернативно створюємо через Save As
    * oForm.Show()
    * KEYBOARD "{CTRL+W}"
ENDIF

RETURN

* =========================================
* Визначення класу форми пошуку
* (Копія з forms\searchform.prg)
* =========================================

DEFINE CLASS frmSearch AS Form
    Height = 600
    Width = 900
    ShowWindow = 1
    AutoCenter = .T.
    Caption = "Послідовний пошук записів"
    Name = "frmSearch"
    WindowType = 0

    cSearchString = ""
    cSearchField = "lastname"
    lCaseSensitive = .F.

    ADD OBJECT lblTitle AS Label WITH ;
        Caption = "Форма послідовного пошуку", ;
        FontSize = 12, ;
        FontBold = .T., ;
        Top = 10, ;
        Left = 20, ;
        AutoSize = .T.

    ADD OBJECT lblSearch AS Label WITH ;
        Caption = "Пошуковий запит:", ;
        Top = 50, ;
        Left = 20, ;
        AutoSize = .T.

    ADD OBJECT txtSearch AS TextBox WITH ;
        Top = 48, ;
        Left = 140, ;
        Width = 300, ;
        Height = 24

    ADD OBJECT lblField AS Label WITH ;
        Caption = "Шукати в полі:", ;
        Top = 85, ;
        Left = 20, ;
        AutoSize = .T.

    ADD OBJECT cboField AS ComboBox WITH ;
        Top = 83, ;
        Left = 140, ;
        Width = 200, ;
        Height = 24, ;
        Style = 2

    ADD OBJECT chkCaseSensitive AS CheckBox WITH ;
        Caption = "Враховувати регістр", ;
        Top = 120, ;
        Left = 20, ;
        Value = 0

    ADD OBJECT btnSearch AS CommandButton WITH ;
        Caption = "Знайти", ;
        Top = 48, ;
        Left = 450, ;
        Width = 100, ;
        Height = 30

    ADD OBJECT btnSearchNext AS CommandButton WITH ;
        Caption = "Знайти далі", ;
        Top = 48, ;
        Left = 560, ;
        Width = 100, ;
        Height = 30, ;
        Enabled = .F.

    ADD OBJECT btnClearSearch AS CommandButton WITH ;
        Caption = "Очистити", ;
        Top = 48, ;
        Left = 670, ;
        Width = 100, ;
        Height = 30

    ADD OBJECT lblInfo AS Label WITH ;
        Caption = "Введіть текст для пошуку", ;
        Top = 160, ;
        Left = 20, ;
        AutoSize = .T., ;
        ForeColor = RGB(0,0,128)

    ADD OBJECT grdCustomer AS Grid WITH ;
        Top = 190, ;
        Left = 20, ;
        Width = 860, ;
        Height = 350, ;
        ReadOnly = .T., ;
        RecordSource = "customer", ;
        RecordSourceType = 1, ;
        DeleteMark = .F.

    ADD OBJECT btnClose AS CommandButton WITH ;
        Caption = "Закрити", ;
        Top = 550, ;
        Left = 780, ;
        Width = 100, ;
        Height = 30, ;
        Cancel = .T.

    PROCEDURE Init
        IF !USED("customer")
            IF FILE("data\customer.dbf")
                USE data\customer IN 0 SHARED
            ELSE
                USE customer IN 0 SHARED
            ENDIF
        ENDIF

        SELECT customer

        THISFORM.cboField.AddItem("lastname - Прізвище")
        THISFORM.cboField.AddItem("firstname - Ім'я")
        THISFORM.cboField.AddItem("phone - Телефон")
        THISFORM.cboField.ListIndex = 1

        THISFORM.ConfigureGrid()
        GO TOP
    ENDPROC

    PROCEDURE ConfigureGrid
        WITH THISFORM.grdCustomer
            .ColumnCount = 7
            .RecordSource = "customer"
            .Column1.Header1.Caption = "ID"
            .Column1.Width = 50
            .Column1.ControlSource = "customer.id"
            .Column2.Header1.Caption = "Прізвище"
            .Column2.Width = 120
            .Column2.ControlSource = "customer.lastname"
            .Column3.Header1.Caption = "Ім'я"
            .Column3.Width = 120
            .Column3.ControlSource = "customer.firstname"
            .Column4.Header1.Caption = "Телефон"
            .Column4.Width = 120
            .Column4.ControlSource = "customer.phone"
            .Column5.Header1.Caption = "Email"
            .Column5.Width = 150
            .Column5.ControlSource = "customer.email"
            .Column6.Header1.Caption = "Адреса"
            .Column6.Width = 200
            .Column6.ControlSource = "customer.address"
            .Column7.Header1.Caption = "Примітки"
            .Column7.Width = 100
            .Column7.ControlSource = "customer.notes"
            .Refresh()
        ENDWITH
    ENDPROC

    PROCEDURE btnSearch.Click
        LOCAL lcSearchValue, lcFieldName, llFound

        lcSearchValue = ALLTRIM(THISFORM.txtSearch.Value)

        IF EMPTY(lcSearchValue)
            MESSAGEBOX("Введіть текст для пошуку!", 48, "Увага")
            RETURN
        ENDIF

        lcFieldName = LEFT(THISFORM.cboField.Value, AT("-", THISFORM.cboField.Value) - 1)
        lcFieldName = ALLTRIM(lcFieldName)

        THISFORM.cSearchString = lcSearchValue
        THISFORM.cSearchField = lcFieldName

        SELECT customer
        GO TOP

        llFound = THISFORM.DoSearch(lcSearchValue, lcFieldName)

        IF llFound
            THISFORM.btnSearchNext.Enabled = .T.
            THISFORM.lblInfo.Caption = "Знайдено запис №" + TRANSFORM(RECNO())
            THISFORM.lblInfo.ForeColor = RGB(0,128,0)
        ELSE
            MESSAGEBOX("Запис не знайдено!", 48, "Результат")
            THISFORM.lblInfo.Caption = "Запис не знайдено"
            THISFORM.lblInfo.ForeColor = RGB(255,0,0)
        ENDIF

        THISFORM.grdCustomer.Refresh()
    ENDPROC

    PROCEDURE btnSearchNext.Click
        LOCAL llFound
        SELECT customer
        SKIP 1

        IF EOF()
            MESSAGEBOX("Кінець таблиці", 48, "Інформація")
            GO BOTTOM
            RETURN
        ENDIF

        llFound = THISFORM.DoSearch(THISFORM.cSearchString, THISFORM.cSearchField)

        IF llFound
            THISFORM.lblInfo.Caption = "Знайдено запис №" + TRANSFORM(RECNO())
        ELSE
            MESSAGEBOX("Більше збігів немає!", 48, "Результат")
        ENDIF

        THISFORM.grdCustomer.Refresh()
    ENDPROC

    FUNCTION DoSearch(tcSearchValue, tcFieldName)
        LOCAL lcFieldValue, llFound
        llFound = .F.

        SCAN
            lcFieldValue = EVALUATE("customer." + tcFieldName)

            IF VARTYPE(lcFieldValue) != "C"
                lcFieldValue = TRANSFORM(lcFieldValue)
            ENDIF

            lcFieldValue = UPPER(ALLTRIM(lcFieldValue))
            tcSearchValue = UPPER(ALLTRIM(tcSearchValue))

            IF tcSearchValue $ lcFieldValue
                llFound = .T.
                EXIT
            ENDIF
        ENDSCAN

        RETURN llFound
    ENDFUNC

    PROCEDURE btnClearSearch.Click
        THISFORM.txtSearch.Value = ""
        THISFORM.btnSearchNext.Enabled = .F.
        THISFORM.lblInfo.Caption = "Введіть текст для пошуку"
        SELECT customer
        GO TOP
        THISFORM.grdCustomer.Refresh()
    ENDPROC

    PROCEDURE btnClose.Click
        THISFORM.Release()
    ENDPROC

ENDDEFINE
