#pragma once

#include "AtbashCipher.h"

namespace AtbashCipherApp {

    using namespace System;
    using namespace System::ComponentModel;
    using namespace System::Collections;
    using namespace System::Windows::Forms;
    using namespace System::Data;
    using namespace System::Drawing;
    using namespace System::IO;
    using namespace AtbashCipherLib;

    public ref class MainForm : public System::Windows::Forms::Form
    {
    public:
        MainForm(void)
        {
            InitializeComponent();
            cipher = gcnew AtbashCipher();
        }

    protected:
        ~MainForm()
        {
            if (components)
            {
                delete components;
            }
        }

    private:
        AtbashCipher^ cipher;
        String^ loadedFilePath;

        // Компоненти інтерфейсу
        System::Windows::Forms::TabControl^ tabControl1;
        System::Windows::Forms::TabPage^ tabPageSimple;
        System::Windows::Forms::TabPage^ tabPageWithKey;
        System::Windows::Forms::TabPage^ tabPageFile;

        // Проста Атбаш
        System::Windows::Forms::TextBox^ txtSimpleInput;
        System::Windows::Forms::TextBox^ txtSimpleOutput;
        System::Windows::Forms::Button^ btnSimpleEncrypt;
        System::Windows::Forms::Button^ btnSimpleDecrypt;
        System::Windows::Forms::Label^ lblSimpleInput;
        System::Windows::Forms::Label^ lblSimpleOutput;

        // Атбаш з ключем
        System::Windows::Forms::TextBox^ txtKeyword;
        System::Windows::Forms::TextBox^ txtKeyInput;
        System::Windows::Forms::TextBox^ txtKeyOutput;
        System::Windows::Forms::Button^ btnSetKey;
        System::Windows::Forms::Button^ btnKeyEncrypt;
        System::Windows::Forms::Button^ btnKeyDecrypt;
        System::Windows::Forms::Label^ lblKeyword;
        System::Windows::Forms::Label^ lblKeyInput;
        System::Windows::Forms::Label^ lblKeyOutput;
        System::Windows::Forms::Label^ lblSubstitutionAlphabet;

        // Робота з файлами
        System::Windows::Forms::TextBox^ txtFileContent;
        System::Windows::Forms::TextBox^ txtFileOutput;
        System::Windows::Forms::TextBox^ txtFileKeyword;
        System::Windows::Forms::Button^ btnLoadFile;
        System::Windows::Forms::Button^ btnFileEncrypt;
        System::Windows::Forms::Button^ btnFileDecrypt;
        System::Windows::Forms::Button^ btnSaveFile;
        System::Windows::Forms::Label^ lblFileContent;
        System::Windows::Forms::Label^ lblFileOutput;
        System::Windows::Forms::Label^ lblFileKeyword;
        System::Windows::Forms::Label^ lblFilePath;

        System::ComponentModel::Container^ components;

        void InitializeComponent(void)
        {
            this->tabControl1 = (gcnew System::Windows::Forms::TabControl());
            this->tabPageSimple = (gcnew System::Windows::Forms::TabPage());
            this->tabPageWithKey = (gcnew System::Windows::Forms::TabPage());
            this->tabPageFile = (gcnew System::Windows::Forms::TabPage());

            //
            // tabControl1
            //
            this->tabControl1->Controls->Add(this->tabPageSimple);
            this->tabControl1->Controls->Add(this->tabPageWithKey);
            this->tabControl1->Controls->Add(this->tabPageFile);
            this->tabControl1->Location = System::Drawing::Point(12, 12);
            this->tabControl1->Name = L"tabControl1";
            this->tabControl1->SelectedIndex = 0;
            this->tabControl1->Size = System::Drawing::Size(760, 537);
            this->tabControl1->TabIndex = 0;

            //
            // MainForm
            //
            this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(784, 561);
            this->Controls->Add(this->tabControl1);
            this->Name = L"MainForm";
            this->Text = L"Шифрування Атбаш - Лабораторна робота №5";
            this->tabControl1->ResumeLayout(false);

            InitializeSimpleTab();
            InitializeKeyTab();
            InitializeFileTab();

            this->ResumeLayout(false);
        }

        void InitializeSimpleTab()
        {
            // Створення елементів для простого Атбаш
            this->lblSimpleInput = (gcnew System::Windows::Forms::Label());
            this->txtSimpleInput = (gcnew System::Windows::Forms::TextBox());
            this->lblSimpleOutput = (gcnew System::Windows::Forms::Label());
            this->txtSimpleOutput = (gcnew System::Windows::Forms::TextBox());
            this->btnSimpleEncrypt = (gcnew System::Windows::Forms::Button());
            this->btnSimpleDecrypt = (gcnew System::Windows::Forms::Button());

            this->tabPageSimple->SuspendLayout();

            // lblSimpleInput
            this->lblSimpleInput->AutoSize = true;
            this->lblSimpleInput->Location = System::Drawing::Point(20, 20);
            this->lblSimpleInput->Name = L"lblSimpleInput";
            this->lblSimpleInput->Size = System::Drawing::Size(100, 13);
            this->lblSimpleInput->Text = L"Вхідний текст:";

            // txtSimpleInput
            this->txtSimpleInput->Location = System::Drawing::Point(20, 40);
            this->txtSimpleInput->Multiline = true;
            this->txtSimpleInput->Name = L"txtSimpleInput";
            this->txtSimpleInput->Size = System::Drawing::Size(700, 100);
            this->txtSimpleInput->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;

            // btnSimpleEncrypt
            this->btnSimpleEncrypt->Location = System::Drawing::Point(20, 150);
            this->btnSimpleEncrypt->Name = L"btnSimpleEncrypt";
            this->btnSimpleEncrypt->Size = System::Drawing::Size(150, 30);
            this->btnSimpleEncrypt->Text = L"Зашифрувати";
            this->btnSimpleEncrypt->Click += gcnew System::EventHandler(this, &MainForm::btnSimpleEncrypt_Click);

            // btnSimpleDecrypt
            this->btnSimpleDecrypt->Location = System::Drawing::Point(180, 150);
            this->btnSimpleDecrypt->Name = L"btnSimpleDecrypt";
            this->btnSimpleDecrypt->Size = System::Drawing::Size(150, 30);
            this->btnSimpleDecrypt->Text = L"Розшифрувати";
            this->btnSimpleDecrypt->Click += gcnew System::EventHandler(this, &MainForm::btnSimpleDecrypt_Click);

            // lblSimpleOutput
            this->lblSimpleOutput->AutoSize = true;
            this->lblSimpleOutput->Location = System::Drawing::Point(20, 200);
            this->lblSimpleOutput->Name = L"lblSimpleOutput";
            this->lblSimpleOutput->Size = System::Drawing::Size(100, 13);
            this->lblSimpleOutput->Text = L"Результат:";

            // txtSimpleOutput
            this->txtSimpleOutput->Location = System::Drawing::Point(20, 220);
            this->txtSimpleOutput->Multiline = true;
            this->txtSimpleOutput->Name = L"txtSimpleOutput";
            this->txtSimpleOutput->ReadOnly = true;
            this->txtSimpleOutput->Size = System::Drawing::Size(700, 100);
            this->txtSimpleOutput->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;

            // tabPageSimple
            this->tabPageSimple->Controls->Add(this->lblSimpleInput);
            this->tabPageSimple->Controls->Add(this->txtSimpleInput);
            this->tabPageSimple->Controls->Add(this->btnSimpleEncrypt);
            this->tabPageSimple->Controls->Add(this->btnSimpleDecrypt);
            this->tabPageSimple->Controls->Add(this->lblSimpleOutput);
            this->tabPageSimple->Controls->Add(this->txtSimpleOutput);
            this->tabPageSimple->Location = System::Drawing::Point(4, 22);
            this->tabPageSimple->Name = L"tabPageSimple";
            this->tabPageSimple->Padding = System::Windows::Forms::Padding(3);
            this->tabPageSimple->Size = System::Drawing::Size(752, 511);
            this->tabPageSimple->TabIndex = 0;
            this->tabPageSimple->Text = L"Простий Атбаш";
            this->tabPageSimple->UseVisualStyleBackColor = true;

            this->tabPageSimple->ResumeLayout(false);
            this->tabPageSimple->PerformLayout();
        }

        void InitializeKeyTab()
        {
            // Створення елементів для Атбаш з ключем
            this->lblKeyword = (gcnew System::Windows::Forms::Label());
            this->txtKeyword = (gcnew System::Windows::Forms::TextBox());
            this->btnSetKey = (gcnew System::Windows::Forms::Button());
            this->lblSubstitutionAlphabet = (gcnew System::Windows::Forms::Label());
            this->lblKeyInput = (gcnew System::Windows::Forms::Label());
            this->txtKeyInput = (gcnew System::Windows::Forms::TextBox());
            this->lblKeyOutput = (gcnew System::Windows::Forms::Label());
            this->txtKeyOutput = (gcnew System::Windows::Forms::TextBox());
            this->btnKeyEncrypt = (gcnew System::Windows::Forms::Button());
            this->btnKeyDecrypt = (gcnew System::Windows::Forms::Button());

            this->tabPageWithKey->SuspendLayout();

            // lblKeyword
            this->lblKeyword->AutoSize = true;
            this->lblKeyword->Location = System::Drawing::Point(20, 20);
            this->lblKeyword->Name = L"lblKeyword";
            this->lblKeyword->Text = L"Ключове слово (прізвище):";

            // txtKeyword
            this->txtKeyword->Location = System::Drawing::Point(200, 17);
            this->txtKeyword->Name = L"txtKeyword";
            this->txtKeyword->Size = System::Drawing::Size(300, 20);

            // btnSetKey
            this->btnSetKey->Location = System::Drawing::Point(510, 15);
            this->btnSetKey->Name = L"btnSetKey";
            this->btnSetKey->Size = System::Drawing::Size(120, 25);
            this->btnSetKey->Text = L"Встановити ключ";
            this->btnSetKey->Click += gcnew System::EventHandler(this, &MainForm::btnSetKey_Click);

            // lblSubstitutionAlphabet
            this->lblSubstitutionAlphabet->AutoSize = true;
            this->lblSubstitutionAlphabet->Location = System::Drawing::Point(20, 50);
            this->lblSubstitutionAlphabet->Name = L"lblSubstitutionAlphabet";
            this->lblSubstitutionAlphabet->Size = System::Drawing::Size(700, 13);
            this->lblSubstitutionAlphabet->Text = L"Алфавіт заміни: ";

            // lblKeyInput
            this->lblKeyInput->AutoSize = true;
            this->lblKeyInput->Location = System::Drawing::Point(20, 80);
            this->lblKeyInput->Name = L"lblKeyInput";
            this->lblKeyInput->Text = L"Вхідний текст:";

            // txtKeyInput
            this->txtKeyInput->Location = System::Drawing::Point(20, 100);
            this->txtKeyInput->Multiline = true;
            this->txtKeyInput->Name = L"txtKeyInput";
            this->txtKeyInput->Size = System::Drawing::Size(700, 100);
            this->txtKeyInput->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;

            // btnKeyEncrypt
            this->btnKeyEncrypt->Location = System::Drawing::Point(20, 210);
            this->btnKeyEncrypt->Name = L"btnKeyEncrypt";
            this->btnKeyEncrypt->Size = System::Drawing::Size(150, 30);
            this->btnKeyEncrypt->Text = L"Зашифрувати";
            this->btnKeyEncrypt->Click += gcnew System::EventHandler(this, &MainForm::btnKeyEncrypt_Click);

            // btnKeyDecrypt
            this->btnKeyDecrypt->Location = System::Drawing::Point(180, 210);
            this->btnKeyDecrypt->Name = L"btnKeyDecrypt";
            this->btnKeyDecrypt->Size = System::Drawing::Size(150, 30);
            this->btnKeyDecrypt->Text = L"Розшифрувати";
            this->btnKeyDecrypt->Click += gcnew System::EventHandler(this, &MainForm::btnKeyDecrypt_Click);

            // lblKeyOutput
            this->lblKeyOutput->AutoSize = true;
            this->lblKeyOutput->Location = System::Drawing::Point(20, 250);
            this->lblKeyOutput->Name = L"lblKeyOutput";
            this->lblKeyOutput->Text = L"Результат:";

            // txtKeyOutput
            this->txtKeyOutput->Location = System::Drawing::Point(20, 270);
            this->txtKeyOutput->Multiline = true;
            this->txtKeyOutput->Name = L"txtKeyOutput";
            this->txtKeyOutput->ReadOnly = true;
            this->txtKeyOutput->Size = System::Drawing::Size(700, 100);
            this->txtKeyOutput->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;

            // tabPageWithKey
            this->tabPageWithKey->Controls->Add(this->lblKeyword);
            this->tabPageWithKey->Controls->Add(this->txtKeyword);
            this->tabPageWithKey->Controls->Add(this->btnSetKey);
            this->tabPageWithKey->Controls->Add(this->lblSubstitutionAlphabet);
            this->tabPageWithKey->Controls->Add(this->lblKeyInput);
            this->tabPageWithKey->Controls->Add(this->txtKeyInput);
            this->tabPageWithKey->Controls->Add(this->btnKeyEncrypt);
            this->tabPageWithKey->Controls->Add(this->btnKeyDecrypt);
            this->tabPageWithKey->Controls->Add(this->lblKeyOutput);
            this->tabPageWithKey->Controls->Add(this->txtKeyOutput);
            this->tabPageWithKey->Location = System::Drawing::Point(4, 22);
            this->tabPageWithKey->Name = L"tabPageWithKey";
            this->tabPageWithKey->Padding = System::Windows::Forms::Padding(3);
            this->tabPageWithKey->Size = System::Drawing::Size(752, 511);
            this->tabPageWithKey->TabIndex = 1;
            this->tabPageWithKey->Text = L"Атбаш з ключем";
            this->tabPageWithKey->UseVisualStyleBackColor = true;

            this->tabPageWithKey->ResumeLayout(false);
            this->tabPageWithKey->PerformLayout();
        }

        void InitializeFileTab()
        {
            // Створення елементів для роботи з файлами
            this->lblFileKeyword = (gcnew System::Windows::Forms::Label());
            this->txtFileKeyword = (gcnew System::Windows::Forms::TextBox());
            this->btnLoadFile = (gcnew System::Windows::Forms::Button());
            this->lblFilePath = (gcnew System::Windows::Forms::Label());
            this->lblFileContent = (gcnew System::Windows::Forms::Label());
            this->txtFileContent = (gcnew System::Windows::Forms::TextBox());
            this->btnFileEncrypt = (gcnew System::Windows::Forms::Button());
            this->btnFileDecrypt = (gcnew System::Windows::Forms::Button());
            this->lblFileOutput = (gcnew System::Windows::Forms::Label());
            this->txtFileOutput = (gcnew System::Windows::Forms::TextBox());
            this->btnSaveFile = (gcnew System::Windows::Forms::Button());

            this->tabPageFile->SuspendLayout();

            // lblFileKeyword
            this->lblFileKeyword->AutoSize = true;
            this->lblFileKeyword->Location = System::Drawing::Point(20, 20);
            this->lblFileKeyword->Name = L"lblFileKeyword";
            this->lblFileKeyword->Text = L"Ключове слово:";

            // txtFileKeyword
            this->txtFileKeyword->Location = System::Drawing::Point(130, 17);
            this->txtFileKeyword->Name = L"txtFileKeyword";
            this->txtFileKeyword->Size = System::Drawing::Size(200, 20);

            // btnLoadFile
            this->btnLoadFile->Location = System::Drawing::Point(20, 50);
            this->btnLoadFile->Name = L"btnLoadFile";
            this->btnLoadFile->Size = System::Drawing::Size(150, 30);
            this->btnLoadFile->Text = L"Завантажити файл";
            this->btnLoadFile->Click += gcnew System::EventHandler(this, &MainForm::btnLoadFile_Click);

            // lblFilePath
            this->lblFilePath->AutoSize = true;
            this->lblFilePath->Location = System::Drawing::Point(180, 58);
            this->lblFilePath->Name = L"lblFilePath";
            this->lblFilePath->Text = L"Файл не завантажено";
            this->lblFilePath->ForeColor = System::Drawing::Color::Gray;

            // lblFileContent
            this->lblFileContent->AutoSize = true;
            this->lblFileContent->Location = System::Drawing::Point(20, 90);
            this->lblFileContent->Name = L"lblFileContent";
            this->lblFileContent->Text = L"Вміст файлу:";

            // txtFileContent
            this->txtFileContent->Location = System::Drawing::Point(20, 110);
            this->txtFileContent->Multiline = true;
            this->txtFileContent->Name = L"txtFileContent";
            this->txtFileContent->ReadOnly = true;
            this->txtFileContent->Size = System::Drawing::Size(700, 100);
            this->txtFileContent->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;

            // btnFileEncrypt
            this->btnFileEncrypt->Location = System::Drawing::Point(20, 220);
            this->btnFileEncrypt->Name = L"btnFileEncrypt";
            this->btnFileEncrypt->Size = System::Drawing::Size(150, 30);
            this->btnFileEncrypt->Text = L"Зашифрувати";
            this->btnFileEncrypt->Click += gcnew System::EventHandler(this, &MainForm::btnFileEncrypt_Click);

            // btnFileDecrypt
            this->btnFileDecrypt->Location = System::Drawing::Point(180, 220);
            this->btnFileDecrypt->Name = L"btnFileDecrypt";
            this->btnFileDecrypt->Size = System::Drawing::Size(150, 30);
            this->btnFileDecrypt->Text = L"Розшифрувати";
            this->btnFileDecrypt->Click += gcnew System::EventHandler(this, &MainForm::btnFileDecrypt_Click);

            // lblFileOutput
            this->lblFileOutput->AutoSize = true;
            this->lblFileOutput->Location = System::Drawing::Point(20, 260);
            this->lblFileOutput->Name = L"lblFileOutput";
            this->lblFileOutput->Text = L"Результат:";

            // txtFileOutput
            this->txtFileOutput->Location = System::Drawing::Point(20, 280);
            this->txtFileOutput->Multiline = true;
            this->txtFileOutput->Name = L"txtFileOutput";
            this->txtFileOutput->ReadOnly = true;
            this->txtFileOutput->Size = System::Drawing::Size(700, 100);
            this->txtFileOutput->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;

            // btnSaveFile
            this->btnSaveFile->Location = System::Drawing::Point(20, 390);
            this->btnSaveFile->Name = L"btnSaveFile";
            this->btnSaveFile->Size = System::Drawing::Size(150, 30);
            this->btnSaveFile->Text = L"Зберегти результат";
            this->btnSaveFile->Click += gcnew System::EventHandler(this, &MainForm::btnSaveFile_Click);

            // tabPageFile
            this->tabPageFile->Controls->Add(this->lblFileKeyword);
            this->tabPageFile->Controls->Add(this->txtFileKeyword);
            this->tabPageFile->Controls->Add(this->btnLoadFile);
            this->tabPageFile->Controls->Add(this->lblFilePath);
            this->tabPageFile->Controls->Add(this->lblFileContent);
            this->tabPageFile->Controls->Add(this->txtFileContent);
            this->tabPageFile->Controls->Add(this->btnFileEncrypt);
            this->tabPageFile->Controls->Add(this->btnFileDecrypt);
            this->tabPageFile->Controls->Add(this->lblFileOutput);
            this->tabPageFile->Controls->Add(this->txtFileOutput);
            this->tabPageFile->Controls->Add(this->btnSaveFile);
            this->tabPageFile->Location = System::Drawing::Point(4, 22);
            this->tabPageFile->Name = L"tabPageFile";
            this->tabPageFile->Size = System::Drawing::Size(752, 511);
            this->tabPageFile->TabIndex = 2;
            this->tabPageFile->Text = L"Робота з файлами";
            this->tabPageFile->UseVisualStyleBackColor = true;

            this->tabPageFile->ResumeLayout(false);
            this->tabPageFile->PerformLayout();
        }

        // Обробники подій
        System::Void btnSimpleEncrypt_Click(System::Object^ sender, System::EventArgs^ e)
        {
            String^ input = txtSimpleInput->Text;
            String^ output = cipher->Encrypt(input);
            txtSimpleOutput->Text = output;
        }

        System::Void btnSimpleDecrypt_Click(System::Object^ sender, System::EventArgs^ e)
        {
            String^ input = txtSimpleInput->Text;
            String^ output = cipher->Decrypt(input);
            txtSimpleOutput->Text = output;
        }

        System::Void btnSetKey_Click(System::Object^ sender, System::EventArgs^ e)
        {
            String^ keyword = txtKeyword->Text;
            if (String::IsNullOrWhiteSpace(keyword))
            {
                MessageBox::Show("Будь ласка, введіть ключове слово!", "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Warning);
                return;
            }
            cipher->SetKeyword(keyword);
            lblSubstitutionAlphabet->Text = "Алфавіт заміни: " + cipher->GetSubstitutionAlphabet();
        }

        System::Void btnKeyEncrypt_Click(System::Object^ sender, System::EventArgs^ e)
        {
            if (String::IsNullOrEmpty(cipher->GetKeyword()))
            {
                MessageBox::Show("Спочатку встановіть ключове слово!", "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Warning);
                return;
            }
            String^ input = txtKeyInput->Text;
            String^ output = cipher->EncryptWithKey(input);
            txtKeyOutput->Text = output;
        }

        System::Void btnKeyDecrypt_Click(System::Object^ sender, System::EventArgs^ e)
        {
            if (String::IsNullOrEmpty(cipher->GetKeyword()))
            {
                MessageBox::Show("Спочатку встановіть ключове слово!", "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Warning);
                return;
            }
            String^ input = txtKeyInput->Text;
            String^ output = cipher->DecryptWithKey(input);
            txtKeyOutput->Text = output;
        }

        System::Void btnLoadFile_Click(System::Object^ sender, System::EventArgs^ e)
        {
            OpenFileDialog^ openFileDialog = gcnew OpenFileDialog();
            openFileDialog->Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*";
            openFileDialog->Title = "Виберіть файл для завантаження";

            if (openFileDialog->ShowDialog() == System::Windows::Forms::DialogResult::OK)
            {
                try
                {
                    loadedFilePath = openFileDialog->FileName;
                    StreamReader^ reader = gcnew StreamReader(loadedFilePath, System::Text::Encoding::UTF8);
                    txtFileContent->Text = reader->ReadToEnd();
                    reader->Close();
                    lblFilePath->Text = "Завантажено: " + Path::GetFileName(loadedFilePath);
                    lblFilePath->ForeColor = System::Drawing::Color::Green;
                }
                catch (Exception^ ex)
                {
                    MessageBox::Show("Помилка завантаження файлу: " + ex->Message, "Помилка",
                        MessageBoxButtons::OK, MessageBoxIcon::Error);
                }
            }
        }

        System::Void btnFileEncrypt_Click(System::Object^ sender, System::EventArgs^ e)
        {
            if (String::IsNullOrWhiteSpace(txtFileContent->Text))
            {
                MessageBox::Show("Спочатку завантажте файл!", "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Warning);
                return;
            }

            String^ keyword = txtFileKeyword->Text;
            if (!String::IsNullOrWhiteSpace(keyword))
            {
                cipher->SetKeyword(keyword);
                txtFileOutput->Text = cipher->EncryptWithKey(txtFileContent->Text);
            }
            else
            {
                txtFileOutput->Text = cipher->Encrypt(txtFileContent->Text);
            }
        }

        System::Void btnFileDecrypt_Click(System::Object^ sender, System::EventArgs^ e)
        {
            if (String::IsNullOrWhiteSpace(txtFileContent->Text))
            {
                MessageBox::Show("Спочатку завантажте файл!", "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Warning);
                return;
            }

            String^ keyword = txtFileKeyword->Text;
            if (!String::IsNullOrWhiteSpace(keyword))
            {
                cipher->SetKeyword(keyword);
                txtFileOutput->Text = cipher->DecryptWithKey(txtFileContent->Text);
            }
            else
            {
                txtFileOutput->Text = cipher->Decrypt(txtFileContent->Text);
            }
        }

        System::Void btnSaveFile_Click(System::Object^ sender, System::EventArgs^ e)
        {
            if (String::IsNullOrWhiteSpace(txtFileOutput->Text))
            {
                MessageBox::Show("Немає даних для збереження!", "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Warning);
                return;
            }

            SaveFileDialog^ saveFileDialog = gcnew SaveFileDialog();
            saveFileDialog->Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*";
            saveFileDialog->Title = "Зберегти результат";

            if (saveFileDialog->ShowDialog() == System::Windows::Forms::DialogResult::OK)
            {
                try
                {
                    StreamWriter^ writer = gcnew StreamWriter(saveFileDialog->FileName, false, System::Text::Encoding::UTF8);
                    writer->Write(txtFileOutput->Text);
                    writer->Close();
                    MessageBox::Show("Файл успішно збережено!", "Успіх",
                        MessageBoxButtons::OK, MessageBoxIcon::Information);
                }
                catch (Exception^ ex)
                {
                    MessageBox::Show("Помилка збереження файлу: " + ex->Message, "Помилка",
                        MessageBoxButtons::OK, MessageBoxIcon::Error);
                }
            }
        }
    };
}
