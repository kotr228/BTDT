#using <System.dll>
#using <System.Windows.Forms.dll>
#using <System.Drawing.dll>

#include "MainForm.h"

using namespace System;
using namespace System::Windows::Forms;
using namespace PlayfairCipherLib;

[STAThreadAttribute]
int main(array<System::String^>^ args)
{
    // Увімкнення візуальних стилів
    Application::EnableVisualStyles();
    Application::SetCompatibleTextRenderingDefault(false);

    // Створення та запуск головної форми
    Application::Run(gcnew MainForm());

    return 0;
}
