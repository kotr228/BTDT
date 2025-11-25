* =========================================
* Форма послідовного пошуку - searchform.prg
* Програмне створення форми з Grid, Label, TextBox, CheckBox
* =========================================

PUBLIC oSearchForm
oSearchForm = CREATEOBJECT("frmSearch")
oSearchForm.Show()

RETURN

* =========================================
* Визначення класу форми пошуку
* =========================================

DEFINE CLASS frmSearch AS Form
    Height = 600
    Width = 900
    ShowWindow = 1  && In Screen
    AutoCenter = .T.
    Caption = "Послідовний пошук записів"
    Name = "frmSearch"
    WindowType = 0

    * Властивості для зберігання стану пошуку
    cSearchString = ""
    cSearchField = "lastname"
    lCaseSensitive = .F.
    nCurrentRecord = 0

    * =========================================
    * КОМПОНЕНТИ ФОРМИ
    * =========================================

    * Заголовок
    ADD OBJECT lblTitle AS Label WITH ;
        Caption = "Форма послідовного пошуку", ;
        FontSize = 12, ;
        FontBold = .T., ;
        Top = 10, ;
        Left = 20, ;
        Width = 300, ;
        Height = 25, ;
        AutoSize = .T.

    * Поле для введення пошукового запиту
    ADD OBJECT lblSearch AS Label WITH ;
        Caption = "Пошуковий запит:", ;
        Top = 50, ;
        Left = 20, ;
        Width = 120, ;
        Height = 20, ;
        AutoSize = .T.

    ADD OBJECT txtSearch AS TextBox WITH ;
        Top = 48, ;
        Left = 140, ;
        Width = 300, ;
        Height = 24, ;
        Name = "txtSearch"

    * Вибір поля для пошуку
    ADD OBJECT lblField AS Label WITH ;
        Caption = "Шукати в полі:", ;
        Top = 85, ;
        Left = 20, ;
        Width = 120, ;
        Height = 20, ;
        AutoSize = .T.

    ADD OBJECT cboField AS ComboBox WITH ;
        Top = 83, ;
        Left = 140, ;
        Width = 200, ;
        Height = 24, ;
        Style = 2, ;
        Name = "cboField"

    * Чекбокс для регістрозалежного пошуку
    ADD OBJECT chkCaseSensitive AS CheckBox WITH ;
        Caption = "Враховувати регістр", ;
        Top = 120, ;
        Left = 20, ;
        Width = 200, ;
        Height = 20, ;
        Value = 0, ;
        Name = "chkCaseSensitive"

    * Чекбокс для пошуку з початку
    ADD OBJECT chkSearchFromStart AS CheckBox WITH ;
        Caption = "Шукати з початку", ;
        Top = 120, ;
        Left = 230, ;
        Width = 200, ;
        Height = 20, ;
        Value = 1, ;
        Name = "chkSearchFromStart"

    * Кнопки пошуку
    ADD OBJECT btnSearch AS CommandButton WITH ;
        Caption = "Знайти", ;
        Top = 48, ;
        Left = 450, ;
        Width = 100, ;
        Height = 30, ;
        Name = "btnSearch"

    ADD OBJECT btnSearchNext AS CommandButton WITH ;
        Caption = "Знайти далі", ;
        Top = 48, ;
        Left = 560, ;
        Width = 100, ;
        Height = 30, ;
        Enabled = .F., ;
        Name = "btnSearchNext"

    ADD OBJECT btnClearSearch AS CommandButton WITH ;
        Caption = "Очистити", ;
        Top = 48, ;
        Left = 670, ;
        Width = 100, ;
        Height = 30, ;
        Name = "btnClearSearch"

    ADD OBJECT btnShowAll AS CommandButton WITH ;
        Caption = "Показати всі", ;
        Top = 83, ;
        Left = 450, ;
        Width = 100, ;
        Height = 30, ;
        Name = "btnShowAll"

    * Інформаційна панель
    ADD OBJECT lblInfo AS Label WITH ;
        Caption = "Введіть текст для пошуку та натисніть 'Знайти'", ;
        Top = 160, ;
        Left = 20, ;
        Width = 600, ;
        Height = 20, ;
        ForeColor = RGB(0,0,128), ;
        AutoSize = .T.

    * Grid для відображення результатів
    ADD OBJECT grdCustomer AS Grid WITH ;
        Top = 190, ;
        Left = 20, ;
        Width = 860, ;
        Height = 350, ;
        ReadOnly = .T., ;
        RecordSource = "customer", ;
        RecordSourceType = 1, ;
        DeleteMark = .F., ;
        Name = "grdCustomer"

    * Кнопка закриття
    ADD OBJECT btnClose AS CommandButton WITH ;
        Caption = "Закрити", ;
        Top = 550, ;
        Left = 780, ;
        Width = 100, ;
        Height = 30, ;
        Cancel = .T., ;
        Name = "btnClose"

    * =========================================
    * МЕТОДИ ФОРМИ
    * =========================================

    PROCEDURE Init
        * Відкриваємо таблицю
        IF !USED("customer")
            IF FILE("data\customer.dbf")
                USE data\customer IN 0 SHARED
            ELSE
                USE customer IN 0 SHARED
            ENDIF
        ENDIF

        SELECT customer

        * Заповнюємо ComboBox полями таблиці
        THISFORM.cboField.AddItem("lastname - Прізвище")
        THISFORM.cboField.AddItem("firstname - Ім'я")
        THISFORM.cboField.AddItem("middlename - По батькові")
        THISFORM.cboField.AddItem("address - Адреса")
        THISFORM.cboField.AddItem("phone - Телефон")
        THISFORM.cboField.AddItem("email - Email")
        THISFORM.cboField.ListIndex = 1

        * Налаштовуємо Grid
        THISFORM.ConfigureGrid()

        * Переміщуємося на перший запис
        GO TOP

        RETURN .T.
    ENDPROC

    PROCEDURE ConfigureGrid
        * Налаштування стовпців Grid
        WITH THISFORM.grdCustomer
            .ColumnCount = 7
            .RecordSource = "customer"

            * ID
            .Column1.Header1.Caption = "ID"
            .Column1.Width = 50
            .Column1.ControlSource = "customer.id"

            * Прізвище
            .Column2.Header1.Caption = "Прізвище"
            .Column2.Width = 120
            .Column2.ControlSource = "customer.lastname"

            * Ім'я
            .Column3.Header1.Caption = "Ім'я"
            .Column3.Width = 120
            .Column3.ControlSource = "customer.firstname"

            * По батькові
            .Column4.Header1.Caption = "По батькові"
            .Column4.Width = 120
            .Column4.ControlSource = "customer.middlename"

            * Адреса
            .Column5.Header1.Caption = "Адреса"
            .Column5.Width = 200
            .Column5.ControlSource = "customer.address"

            * Телефон
            .Column6.Header1.Caption = "Телефон"
            .Column6.Width = 120
            .Column6.ControlSource = "customer.phone"

            * Email
            .Column7.Header1.Caption = "Email"
            .Column7.Width = 150
            .Column7.ControlSource = "customer.email"

            .Refresh()
        ENDWITH
    ENDPROC

    * Метод пошуку
    PROCEDURE btnSearch.Click
        LOCAL lcSearchValue, lcFieldName, llCaseSensitive, llFound
        LOCAL lnStartRec

        * Отримуємо значення для пошуку
        lcSearchValue = ALLTRIM(THISFORM.txtSearch.Value)

        IF EMPTY(lcSearchValue)
            MESSAGEBOX("Введіть текст для пошуку!", 48, "Увага")
            THISFORM.txtSearch.SetFocus()
            RETURN
        ENDIF

        * Визначаємо поле для пошуку
        lcFieldName = LEFT(THISFORM.cboField.Value, AT("-", THISFORM.cboField.Value) - 1)
        lcFieldName = ALLTRIM(lcFieldName)

        * Враховувати регістр?
        llCaseSensitive = THISFORM.chkCaseSensitive.Value = 1

        * Зберігаємо параметри пошуку
        THISFORM.cSearchString = lcSearchValue
        THISFORM.cSearchField = lcFieldName

        SELECT customer

        * Визначаємо початкову позицію
        IF THISFORM.chkSearchFromStart.Value = 1
            GO TOP
        ENDIF

        lnStartRec = RECNO()

        * Виконуємо пошук
        llFound = THISFORM.DoSearch(lcSearchValue, lcFieldName, llCaseSensitive)

        IF llFound
            THISFORM.btnSearchNext.Enabled = .T.
            THISFORM.lblInfo.Caption = "Знайдено запис №" + TRANSFORM(RECNO()) + " з " + TRANSFORM(RECCOUNT())
            THISFORM.lblInfo.ForeColor = RGB(0,128,0)
            THISFORM.grdCustomer.SetFocus()
        ELSE
            MESSAGEBOX("Запис не знайдено!", 48, "Результат пошуку")
            THISFORM.lblInfo.Caption = "Запис не знайдено"
            THISFORM.lblInfo.ForeColor = RGB(255,0,0)
            GO lnStartRec
        ENDIF

        THISFORM.grdCustomer.Refresh()
    ENDPROC

    * Метод пошуку наступного запису
    PROCEDURE btnSearchNext.Click
        LOCAL llFound

        SELECT customer

        * Переходимо до наступного запису
        SKIP 1

        IF EOF()
            MESSAGEBOX("Досягнуто кінця таблиці. Більше збігів немає.", 48, "Інформація")
            GO BOTTOM
            THISFORM.lblInfo.Caption = "Більше збігів не знайдено"
            THISFORM.lblInfo.ForeColor = RGB(255,128,0)
            RETURN
        ENDIF

        * Продовжуємо пошук
        llFound = THISFORM.DoSearch(THISFORM.cSearchString, THISFORM.cSearchField, THISFORM.chkCaseSensitive.Value = 1)

        IF llFound
            THISFORM.lblInfo.Caption = "Знайдено запис №" + TRANSFORM(RECNO()) + " з " + TRANSFORM(RECCOUNT())
            THISFORM.lblInfo.ForeColor = RGB(0,128,0)
        ELSE
            MESSAGEBOX("Більше збігів не знайдено!", 48, "Результат пошуку")
            THISFORM.lblInfo.Caption = "Більше збігів не знайдено"
            THISFORM.lblInfo.ForeColor = RGB(255,128,0)
        ENDIF

        THISFORM.grdCustomer.Refresh()
    ENDPROC

    * Функція пошуку
    FUNCTION DoSearch(tcSearchValue, tcFieldName, tlCaseSensitive)
        LOCAL lcFieldValue, lcSearchValue, llFound

        llFound = .F.

        * Послідовний пошук
        SCAN
            * Отримуємо значення поля
            lcFieldValue = EVALUATE("customer." + tcFieldName)

            * Перетворюємо в рядок, якщо потрібно
            IF VARTYPE(lcFieldValue) != "C"
                lcFieldValue = TRANSFORM(lcFieldValue)
            ENDIF

            * Порівнюємо з урахуванням регістру або без
            IF tlCaseSensitive
                lcSearchValue = tcSearchValue
            ELSE
                lcFieldValue = UPPER(ALLTRIM(lcFieldValue))
                lcSearchValue = UPPER(ALLTRIM(tcSearchValue))
            ENDIF

            * Перевіряємо, чи містить поле шуканий текст
            IF lcSearchValue $ lcFieldValue
                llFound = .T.
                EXIT
            ENDIF
        ENDSCAN

        RETURN llFound
    ENDFUNC

    * Очистити пошук
    PROCEDURE btnClearSearch.Click
        THISFORM.txtSearch.Value = ""
        THISFORM.cSearchString = ""
        THISFORM.btnSearchNext.Enabled = .F.
        THISFORM.lblInfo.Caption = "Введіть текст для пошуку та натисніть 'Знайти'"
        THISFORM.lblInfo.ForeColor = RGB(0,0,128)
        SELECT customer
        GO TOP
        THISFORM.grdCustomer.Refresh()
        THISFORM.txtSearch.SetFocus()
    ENDPROC

    * Показати всі записи
    PROCEDURE btnShowAll.Click
        SELECT customer
        GO TOP
        THISFORM.txtSearch.Value = ""
        THISFORM.cSearchString = ""
        THISFORM.btnSearchNext.Enabled = .F.
        THISFORM.lblInfo.Caption = "Показано всі записи (" + TRANSFORM(RECCOUNT()) + " шт.)"
        THISFORM.lblInfo.ForeColor = RGB(0,0,128)
        THISFORM.grdCustomer.Refresh()
    ENDPROC

    * Закрити форму
    PROCEDURE btnClose.Click
        THISFORM.Release()
    ENDPROC

    PROCEDURE Destroy
        * Очищення ресурсів
        IF USED("customer")
            * Не закриваємо таблицю, бо вона може використовуватися в головній формі
        ENDIF
    ENDPROC

ENDDEFINE
