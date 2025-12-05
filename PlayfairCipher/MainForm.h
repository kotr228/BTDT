#pragma once

#using <System.dll>
#using <System.Windows.Forms.dll>
#using <System.Drawing.dll>
#using <System.Data.dll>

#include "PlayfairCipher.h"

namespace PlayfairCipherLib {

    using namespace System;
    using namespace System::ComponentModel;
    using namespace System::Collections;
    using namespace System::Windows::Forms;
    using namespace System::Data;
    using namespace System::Drawing;
    using namespace System::IO;

    /// <summary>
    /// MainForm - головна форма для роботи з шифром Плейфера
    /// </summary>
    public ref class MainForm : public System::Windows::Forms::Form
    {
    public:
        MainForm(void)
        {
            InitializeComponent();
            cipher = gcnew PlayfairCipher();
        }

    protected:
        /// <summary>
        /// Очищення ресурсів
        /// </summary>
        ~MainForm()
        {
            if (components)
            {
                delete components;
            }
        }

    private:
        PlayfairCipher^ cipher;
        System::ComponentModel::Container^ components;

        // Компоненти форми
        System::Windows::Forms::Label^ lblTitle;
        System::Windows::Forms::Label^ lblKeyword;
        System::Windows::Forms::TextBox^ txtKeyword;
        System::Windows::Forms::Button^ btnSetKeyword;
        System::Windows::Forms::Label^ lblMatrix;
        System::Windows::Forms::TextBox^ txtMatrix;
        System::Windows::Forms::Label^ lblInput;
        System::Windows::Forms::TextBox^ txtInput;
        System::Windows::Forms::Label^ lblOutput;
        System::Windows::Forms::TextBox^ txtOutput;
        System::Windows::Forms::Button^ btnEncrypt;
        System::Windows::Forms::Button^ btnDecrypt;
        System::Windows::Forms::Button^ btnClear;
        System::Windows::Forms::Button^ btnLoadFile;
        System::Windows::Forms::Button^ btnSaveFile;
        System::Windows::Forms::Label^ lblInfo;
        System::Windows::Forms::GroupBox^ grpKeyword;
        System::Windows::Forms::GroupBox^ grpText;

#pragma region Windows Form Designer generated code
        /// <summary>
        /// Ініціалізація компонентів форми
        /// </summary>
        void InitializeComponent(void)
        {
            this->lblTitle = (gcnew System::Windows::Forms::Label());
            this->grpKeyword = (gcnew System::Windows::Forms::GroupBox());
            this->lblKeyword = (gcnew System::Windows::Forms::Label());
            this->txtKeyword = (gcnew System::Windows::Forms::TextBox());
            this->btnSetKeyword = (gcnew System::Windows::Forms::Button());
            this->lblMatrix = (gcnew System::Windows::Forms::Label());
            this->txtMatrix = (gcnew System::Windows::Forms::TextBox());
            this->grpText = (gcnew System::Windows::Forms::GroupBox());
            this->lblInput = (gcnew System::Windows::Forms::Label());
            this->txtInput = (gcnew System::Windows::Forms::TextBox());
            this->lblOutput = (gcnew System::Windows::Forms::Label());
            this->txtOutput = (gcnew System::Windows::Forms::TextBox());
            this->btnEncrypt = (gcnew System::Windows::Forms::Button());
            this->btnDecrypt = (gcnew System::Windows::Forms::Button());
            this->btnClear = (gcnew System::Windows::Forms::Button());
            this->btnLoadFile = (gcnew System::Windows::Forms::Button());
            this->btnSaveFile = (gcnew System::Windows::Forms::Button());
            this->lblInfo = (gcnew System::Windows::Forms::Label());
            this->grpKeyword->SuspendLayout();
            this->grpText->SuspendLayout();
            this->SuspendLayout();

            //
            // lblTitle
            //
            this->lblTitle->AutoSize = true;
            this->lblTitle->Font = (gcnew System::Drawing::Font(L"Segoe UI", 16, System::Drawing::FontStyle::Bold));
            this->lblTitle->Location = System::Drawing::Point(250, 15);
            this->lblTitle->Name = L"lblTitle";
            this->lblTitle->Size = System::Drawing::Size(350, 30);
            this->lblTitle->TabIndex = 0;
            this->lblTitle->Text = L"Шифр Плейфера (Playfair Cipher)";

            //
            // grpKeyword
            //
            this->grpKeyword->Controls->Add(this->lblKeyword);
            this->grpKeyword->Controls->Add(this->txtKeyword);
            this->grpKeyword->Controls->Add(this->btnSetKeyword);
            this->grpKeyword->Controls->Add(this->lblMatrix);
            this->grpKeyword->Controls->Add(this->txtMatrix);
            this->grpKeyword->Font = (gcnew System::Drawing::Font(L"Segoe UI", 9));
            this->grpKeyword->Location = System::Drawing::Point(20, 60);
            this->grpKeyword->Name = L"grpKeyword";
            this->grpKeyword->Size = System::Drawing::Size(820, 250);
            this->grpKeyword->TabIndex = 1;
            this->grpKeyword->TabStop = false;
            this->grpKeyword->Text = L"Налаштування ключа";

            //
            // lblKeyword
            //
            this->lblKeyword->AutoSize = true;
            this->lblKeyword->Location = System::Drawing::Point(15, 30);
            this->lblKeyword->Name = L"lblKeyword";
            this->lblKeyword->Size = System::Drawing::Size(100, 15);
            this->lblKeyword->TabIndex = 0;
            this->lblKeyword->Text = L"Ключове слово:";

            //
            // txtKeyword
            //
            this->txtKeyword->Font = (gcnew System::Drawing::Font(L"Segoe UI", 10));
            this->txtKeyword->Location = System::Drawing::Point(120, 25);
            this->txtKeyword->Name = L"txtKeyword";
            this->txtKeyword->Size = System::Drawing::Size(500, 25);
            this->txtKeyword->TabIndex = 1;

            //
            // btnSetKeyword
            //
            this->btnSetKeyword->Font = (gcnew System::Drawing::Font(L"Segoe UI", 9));
            this->btnSetKeyword->Location = System::Drawing::Point(630, 23);
            this->btnSetKeyword->Name = L"btnSetKeyword";
            this->btnSetKeyword->Size = System::Drawing::Size(170, 30);
            this->btnSetKeyword->TabIndex = 2;
            this->btnSetKeyword->Text = L"Встановити ключ";
            this->btnSetKeyword->UseVisualStyleBackColor = true;
            this->btnSetKeyword->Click += gcnew System::EventHandler(this, &MainForm::btnSetKeyword_Click);

            //
            // lblMatrix
            //
            this->lblMatrix->AutoSize = true;
            this->lblMatrix->Location = System::Drawing::Point(15, 65);
            this->lblMatrix->Name = L"lblMatrix";
            this->lblMatrix->Size = System::Drawing::Size(190, 15);
            this->lblMatrix->TabIndex = 3;
            this->lblMatrix->Text = L"Матриця шифру (4x8 для української):";

            //
            // txtMatrix
            //
            this->txtMatrix->BackColor = System::Drawing::SystemColors::Window;
            this->txtMatrix->Font = (gcnew System::Drawing::Font(L"Courier New", 12, System::Drawing::FontStyle::Bold));
            this->txtMatrix->Location = System::Drawing::Point(15, 85);
            this->txtMatrix->Multiline = true;
            this->txtMatrix->Name = L"txtMatrix";
            this->txtMatrix->ReadOnly = true;
            this->txtMatrix->Size = System::Drawing::Size(790, 150);
            this->txtMatrix->TabIndex = 4;

            //
            // grpText
            //
            this->grpText->Controls->Add(this->lblInput);
            this->grpText->Controls->Add(this->txtInput);
            this->grpText->Controls->Add(this->lblOutput);
            this->grpText->Controls->Add(this->txtOutput);
            this->grpText->Controls->Add(this->btnEncrypt);
            this->grpText->Controls->Add(this->btnDecrypt);
            this->grpText->Controls->Add(this->btnClear);
            this->grpText->Font = (gcnew System::Drawing::Font(L"Segoe UI", 9));
            this->grpText->Location = System::Drawing::Point(20, 320);
            this->grpText->Name = L"grpText";
            this->grpText->Size = System::Drawing::Size(820, 280);
            this->grpText->TabIndex = 2;
            this->grpText->TabStop = false;
            this->grpText->Text = L"Шифрування / Дешифрування";

            //
            // lblInput
            //
            this->lblInput->AutoSize = true;
            this->lblInput->Location = System::Drawing::Point(15, 25);
            this->lblInput->Name = L"lblInput";
            this->lblInput->Size = System::Drawing::Size(80, 15);
            this->lblInput->TabIndex = 0;
            this->lblInput->Text = L"Вхідний текст:";

            //
            // txtInput
            //
            this->txtInput->Font = (gcnew System::Drawing::Font(L"Segoe UI", 10));
            this->txtInput->Location = System::Drawing::Point(15, 45);
            this->txtInput->Multiline = true;
            this->txtInput->Name = L"txtInput";
            this->txtInput->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;
            this->txtInput->Size = System::Drawing::Size(790, 80);
            this->txtInput->TabIndex = 1;

            //
            // lblOutput
            //
            this->lblOutput->AutoSize = true;
            this->lblOutput->Location = System::Drawing::Point(15, 140);
            this->lblOutput->Name = L"lblOutput";
            this->lblOutput->Size = System::Drawing::Size(85, 15);
            this->lblOutput->TabIndex = 2;
            this->lblOutput->Text = L"Вихідний текст:";

            //
            // txtOutput
            //
            this->txtOutput->Font = (gcnew System::Drawing::Font(L"Segoe UI", 10));
            this->txtOutput->Location = System::Drawing::Point(15, 160);
            this->txtOutput->Multiline = true;
            this->txtOutput->Name = L"txtOutput";
            this->txtOutput->ReadOnly = true;
            this->txtOutput->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;
            this->txtOutput->Size = System::Drawing::Size(790, 80);
            this->txtOutput->TabIndex = 3;

            //
            // btnEncrypt
            //
            this->btnEncrypt->Font = (gcnew System::Drawing::Font(L"Segoe UI", 9, System::Drawing::FontStyle::Bold));
            this->btnEncrypt->Location = System::Drawing::Point(180, 245);
            this->btnEncrypt->Name = L"btnEncrypt";
            this->btnEncrypt->Size = System::Drawing::Size(150, 30);
            this->btnEncrypt->TabIndex = 4;
            this->btnEncrypt->Text = L"Зашифрувати";
            this->btnEncrypt->UseVisualStyleBackColor = true;
            this->btnEncrypt->Click += gcnew System::EventHandler(this, &MainForm::btnEncrypt_Click);

            //
            // btnDecrypt
            //
            this->btnDecrypt->Font = (gcnew System::Drawing::Font(L"Segoe UI", 9, System::Drawing::FontStyle::Bold));
            this->btnDecrypt->Location = System::Drawing::Point(340, 245);
            this->btnDecrypt->Name = L"btnDecrypt";
            this->btnDecrypt->Size = System::Drawing::Size(150, 30);
            this->btnDecrypt->TabIndex = 5;
            this->btnDecrypt->Text = L"Дешифрувати";
            this->btnDecrypt->UseVisualStyleBackColor = true;
            this->btnDecrypt->Click += gcnew System::EventHandler(this, &MainForm::btnDecrypt_Click);

            //
            // btnClear
            //
            this->btnClear->Location = System::Drawing::Point(500, 245);
            this->btnClear->Name = L"btnClear";
            this->btnClear->Size = System::Drawing::Size(150, 30);
            this->btnClear->TabIndex = 6;
            this->btnClear->Text = L"Очистити";
            this->btnClear->UseVisualStyleBackColor = true;
            this->btnClear->Click += gcnew System::EventHandler(this, &MainForm::btnClear_Click);

            //
            // btnLoadFile
            //
            this->btnLoadFile->Font = (gcnew System::Drawing::Font(L"Segoe UI", 9));
            this->btnLoadFile->Location = System::Drawing::Point(250, 610);
            this->btnLoadFile->Name = L"btnLoadFile";
            this->btnLoadFile->Size = System::Drawing::Size(150, 35);
            this->btnLoadFile->TabIndex = 3;
            this->btnLoadFile->Text = L"Завантажити файл";
            this->btnLoadFile->UseVisualStyleBackColor = true;
            this->btnLoadFile->Click += gcnew System::EventHandler(this, &MainForm::btnLoadFile_Click);

            //
            // btnSaveFile
            //
            this->btnSaveFile->Font = (gcnew System::Drawing::Font(L"Segoe UI", 9));
            this->btnSaveFile->Location = System::Drawing::Point(460, 610);
            this->btnSaveFile->Name = L"btnSaveFile";
            this->btnSaveFile->Size = System::Drawing::Size(150, 35);
            this->btnSaveFile->TabIndex = 4;
            this->btnSaveFile->Text = L"Зберегти результат";
            this->btnSaveFile->UseVisualStyleBackColor = true;
            this->btnSaveFile->Click += gcnew System::EventHandler(this, &MainForm::btnSaveFile_Click);

            //
            // lblInfo
            //
            this->lblInfo->Font = (gcnew System::Drawing::Font(L"Segoe UI", 8, System::Drawing::FontStyle::Italic));
            this->lblInfo->ForeColor = System::Drawing::Color::Gray;
            this->lblInfo->Location = System::Drawing::Point(20, 655);
            this->lblInfo->Name = L"lblInfo";
            this->lblInfo->Size = System::Drawing::Size(820, 40);
            this->lblInfo->TabIndex = 5;
            this->lblInfo->Text = L"Шифр Плейфера використовує матрицю 4x8 для українського алфавіту.\r\nДля шифрування введіть ключове слово та натисніть 'Встановити ключ'.";
            this->lblInfo->TextAlign = System::Drawing::ContentAlignment::TopCenter;

            //
            // MainForm
            //
            this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
            this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
            this->ClientSize = System::Drawing::Size(860, 710);
            this->Controls->Add(this->lblInfo);
            this->Controls->Add(this->btnSaveFile);
            this->Controls->Add(this->btnLoadFile);
            this->Controls->Add(this->grpText);
            this->Controls->Add(this->grpKeyword);
            this->Controls->Add(this->lblTitle);
            this->FormBorderStyle = System::Windows::Forms::FormBorderStyle::FixedSingle;
            this->MaximizeBox = false;
            this->Name = L"MainForm";
            this->StartPosition = System::Windows::Forms::FormStartPosition::CenterScreen;
            this->Text = L"Шифр Плейфера - Лабораторна робота №6";
            this->grpKeyword->ResumeLayout(false);
            this->grpKeyword->PerformLayout();
            this->grpText->ResumeLayout(false);
            this->grpText->PerformLayout();
            this->ResumeLayout(false);
            this->PerformLayout();
        }
#pragma endregion

        // Обробники подій

        /// <summary>
        /// Встановлення ключового слова та побудова матриці
        /// </summary>
        System::Void btnSetKeyword_Click(System::Object^ sender, System::EventArgs^ e)
        {
            try
            {
                String^ keyword = txtKeyword->Text->Trim();

                if (String::IsNullOrEmpty(keyword))
                {
                    MessageBox::Show("Введіть ключове слово!", "Помилка",
                        MessageBoxButtons::OK, MessageBoxIcon::Warning);
                    return;
                }

                cipher = gcnew PlayfairCipher(keyword);
                txtMatrix->Text = cipher->GetMatrixAsString();

                lblInfo->Text = "Ключ встановлено: " + cipher->GetKeyword() + "\r\nМатриця готова до шифрування.";
                lblInfo->ForeColor = System::Drawing::Color::Green;

                MessageBox::Show("Ключове слово встановлено!\nМатриця побудована успішно.", "Успіх",
                    MessageBoxButtons::OK, MessageBoxIcon::Information);
            }
            catch (Exception^ ex)
            {
                MessageBox::Show("Помилка встановлення ключа:\n" + ex->Message, "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Error);
            }
        }

        /// <summary>
        /// Шифрування тексту
        /// </summary>
        System::Void btnEncrypt_Click(System::Object^ sender, System::EventArgs^ e)
        {
            try
            {
                if (String::IsNullOrEmpty(cipher->GetKeyword()))
                {
                    MessageBox::Show("Спочатку встановіть ключове слово!", "Помилка",
                        MessageBoxButtons::OK, MessageBoxIcon::Warning);
                    return;
                }

                String^ plaintext = txtInput->Text;
                if (String::IsNullOrEmpty(plaintext))
                {
                    MessageBox::Show("Введіть текст для шифрування!", "Помилка",
                        MessageBoxButtons::OK, MessageBoxIcon::Warning);
                    return;
                }

                String^ ciphertext = cipher->Encrypt(plaintext);
                txtOutput->Text = ciphertext;

                lblInfo->Text = "Текст зашифровано успішно!";
                lblInfo->ForeColor = System::Drawing::Color::Green;
            }
            catch (Exception^ ex)
            {
                MessageBox::Show("Помилка шифрування:\n" + ex->Message, "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Error);
            }
        }

        /// <summary>
        /// Дешифрування тексту
        /// </summary>
        System::Void btnDecrypt_Click(System::Object^ sender, System::EventArgs^ e)
        {
            try
            {
                if (String::IsNullOrEmpty(cipher->GetKeyword()))
                {
                    MessageBox::Show("Спочатку встановіть ключове слово!", "Помилка",
                        MessageBoxButtons::OK, MessageBoxIcon::Warning);
                    return;
                }

                String^ ciphertext = txtInput->Text;
                if (String::IsNullOrEmpty(ciphertext))
                {
                    MessageBox::Show("Введіть текст для дешифрування!", "Помилка",
                        MessageBoxButtons::OK, MessageBoxIcon::Warning);
                    return;
                }

                String^ plaintext = cipher->Decrypt(ciphertext);
                txtOutput->Text = plaintext;

                lblInfo->Text = "Текст дешифровано успішно!";
                lblInfo->ForeColor = System::Drawing::Color::Green;
            }
            catch (Exception^ ex)
            {
                MessageBox::Show("Помилка дешифрування:\n" + ex->Message, "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Error);
            }
        }

        /// <summary>
        /// Очищення полів
        /// </summary>
        System::Void btnClear_Click(System::Object^ sender, System::EventArgs^ e)
        {
            txtInput->Clear();
            txtOutput->Clear();
            lblInfo->Text = "Поля очищено.";
            lblInfo->ForeColor = System::Drawing::Color::Gray;
        }

        /// <summary>
        /// Завантаження тексту з файлу
        /// </summary>
        System::Void btnLoadFile_Click(System::Object^ sender, System::EventArgs^ e)
        {
            OpenFileDialog^ openDialog = gcnew OpenFileDialog();
            openDialog->Filter = "Текстові файли (*.txt)|*.txt|Всі файли (*.*)|*.*";
            openDialog->Title = "Виберіть файл для завантаження";

            if (openDialog->ShowDialog() == System::Windows::Forms::DialogResult::OK)
            {
                try
                {
                    String^ content = File::ReadAllText(openDialog->FileName, System::Text::Encoding::UTF8);
                    txtInput->Text = content;
                    lblInfo->Text = "Файл завантажено: " + Path::GetFileName(openDialog->FileName);
                    lblInfo->ForeColor = System::Drawing::Color::Blue;
                }
                catch (Exception^ ex)
                {
                    MessageBox::Show("Помилка завантаження файлу:\n" + ex->Message, "Помилка",
                        MessageBoxButtons::OK, MessageBoxIcon::Error);
                }
            }
        }

        /// <summary>
        /// Збереження результату у файл
        /// </summary>
        System::Void btnSaveFile_Click(System::Object^ sender, System::EventArgs^ e)
        {
            if (String::IsNullOrEmpty(txtOutput->Text))
            {
                MessageBox::Show("Немає тексту для збереження!", "Помилка",
                    MessageBoxButtons::OK, MessageBoxIcon::Warning);
                return;
            }

            SaveFileDialog^ saveDialog = gcnew SaveFileDialog();
            saveDialog->Filter = "Текстові файли (*.txt)|*.txt|Всі файли (*.*)|*.*";
            saveDialog->Title = "Збереження результату";
            saveDialog->FileName = "encrypted_text.txt";

            if (saveDialog->ShowDialog() == System::Windows::Forms::DialogResult::OK)
            {
                try
                {
                    File::WriteAllText(saveDialog->FileName, txtOutput->Text, System::Text::Encoding::UTF8);
                    lblInfo->Text = "Файл збережено: " + Path::GetFileName(saveDialog->FileName);
                    lblInfo->ForeColor = System::Drawing::Color::Blue;
                    MessageBox::Show("Результат успішно збережено!", "Успіх",
                        MessageBoxButtons::OK, MessageBoxIcon::Information);
                }
                catch (Exception^ ex)
                {
                    MessageBox::Show("Помилка збереження файлу:\n" + ex->Message, "Помилка",
                        MessageBoxButtons::OK, MessageBoxIcon::Error);
                }
            }
        }
    };
}
