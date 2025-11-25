* =========================================
* CREATE_MENU.PRG
* Програмне створення меню через Menu Designer
* =========================================

* Примітка: Меню в Visual FoxPro зазвичай створюються через
* Menu Designer (графічний інтерфейс).
*
* Для програмного створення можна використовувати команди
* DEFINE PAD, DEFINE POPUP, ON SELECTION

* Видаляємо старе меню
IF FILE("mainmenu.mnx")
    DELETE FILE mainmenu.mnx
    DELETE FILE mainmenu.mnt
ENDIF

* Замість створення MNX файлу, створюємо MPR файл з кодом меню
* MPR файл - це згенерований код меню, який можна запускати напряму

LOCAL lcMenuCode

TEXT TO lcMenuCode NOSHOW TEXTMERGE
* =========================================
* MAINMENU.MPR
* Згенероване меню для Лабораторної роботи №7
* =========================================

LPARAMETERS oFormRef, lTopLevel

IF TYPE("oFormRef") != "O" OR ISNULL(oFormRef)
    lTopLevel = .F.
ENDIF

IF lTopLevel
    SET SYSMENU TO
    SET SYSMENU AUTOMATIC

    DEFINE PAD pad_file OF _MSYSMENU PROMPT "FILE" KEY ALT+F
    DEFINE PAD pad_search OF _MSYSMENU PROMPT "SEARCH" KEY ALT+S

    ON PAD pad_file OF _MSYSMENU ACTIVATE POPUP popup_file
    ON PAD pad_search OF _MSYSMENU ACTIVATE POPUP popup_search

    DEFINE POPUP popup_file MARGIN RELATIVE SHADOW
    DEFINE BAR 1 OF popup_file PROMPT "Exit" KEY CTRL+Q
    ON SELECTION BAR 1 OF popup_file oFormRef.Release()

    DEFINE POPUP popup_search MARGIN RELATIVE SHADOW
    DEFINE BAR 1 OF popup_search PROMPT "Послідовний пошук" KEY CTRL+F
    ON SELECTION BAR 1 OF popup_search DO FORM searchform

ENDIF

RETURN
ENDTEXT

* Зберігаємо як MPR файл
STRTOFILE(lcMenuCode, "mainmenu.mpr")

? "Меню створено: mainmenu.mpr"

RETURN
