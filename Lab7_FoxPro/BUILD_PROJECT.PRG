* =========================================
* BUILD_PROJECT.PRG
* Скрипт для створення всього проекту
* Лабораторна робота №7
* =========================================

SET TALK OFF
SET SAFETY OFF
SET DELETED ON

CLEAR

? "=============================================="
? "  Створення проекту Visual FoxPro"
? "  Лабораторна робота №7"
? "=============================================="
?

* Крок 1: Створення бази даних
? "Крок 1: Створення бази даних..."
IF FILE("data\lab_7_db.dbc")
    ? "  База даних вже існує"
ELSE
    DO data\create_database.prg
    ? "  База даних створена"
ENDIF
?

* Крок 2: Створення проекту
? "Крок 2: Створення файлу проекту..."
IF FILE("Lab7.pjx")
    DELETE FILE Lab7.pjx
    DELETE FILE Lab7.pjt
ENDIF

CREATE PROJECT Lab7.pjx NOWAIT NOSHOW
? "  Проект Lab7.pjx створено"

* Додаємо файли до проекту
_VFP.ActiveProject.Files.Add("data\lab_7_db.dbc")
_VFP.ActiveProject.Files.Add("data\create_database.prg")
? "  Додано базу даних до проекту"
?

* Крок 3: Створення форм програмно
? "Крок 3: Створення форм..."

* Головна форма
? "  Створення mainform.scx..."
DO create_mainform.prg
_VFP.ActiveProject.Files.Add("mainform.scx")

* Форма пошуку
? "  Створення searchform.scx..."
DO create_searchform.prg
_VFP.ActiveProject.Files.Add("searchform.scx")
?

* Крок 4: Створення меню
? "Крок 4: Створення меню..."
DO create_menu.prg
_VFP.ActiveProject.Files.Add("mainmenu.mnx")
? "  Меню створено"
?

* Крок 5: Збереження проекту
? "Крок 5: Збереження проекту..."
_VFP.ActiveProject.Build("Lab7.app", 3, .F., .F., .F.)
_VFP.ActiveProject.Close

? "  Проект збережено"
?

? "=============================================="
? "  ПРОЕКТ УСПІШНО СТВОРЕНО!"
? "=============================================="
?
? "Для запуску:"
? "  1. Відкрийте Lab7.pjx у Visual FoxPro"
? "  2. Або запустіть: DO FORM mainform"
?
? "=============================================="

SET SAFETY ON
SET TALK ON

RETURN
