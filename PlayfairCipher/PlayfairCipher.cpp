#include "PlayfairCipher.h"

using namespace System;
using namespace System::Text;
using namespace PlayfairCipherLib;

// Конструктор за замовчуванням
PlayfairCipher::PlayfairCipher()
{
    rows = 4;
    cols = 8;
    matrix = gcnew array<array<wchar_t>^>(rows);
    for (int i = 0; i < rows; i++)
    {
        matrix[i] = gcnew array<wchar_t>(cols);
    }

    // Український алфавіт (32 букви, без ь, ъ, и)
    // АБВГДЕЄЖЗІЙКЛМНОПРСТУФХЦЧШЩЮЯҐЇІ
    ukrainianAlphabet = L"АБВГДЕЄЖЗІЙКЛМНОПРСТУФХЦЧШЩЮЯҐЇ";

    keyword = "";
}

// Конструктор з ключем
PlayfairCipher::PlayfairCipher(String^ key)
{
    rows = 4;
    cols = 8;
    matrix = gcnew array<array<wchar_t>^>(rows);
    for (int i = 0; i < rows; i++)
    {
        matrix[i] = gcnew array<wchar_t>(cols);
    }

    ukrainianAlphabet = L"АБВГДЕЄЖЗІЙКЛМНОПРСТУФХЦЧШЩЮЯҐЇ";

    SetKeyword(key);
}

// Видалення дублікатів з рядка
String^ PlayfairCipher::RemoveDuplicates(String^ input)
{
    if (String::IsNullOrEmpty(input))
        return "";

    StringBuilder^ result = gcnew StringBuilder();
    List<wchar_t>^ seen = gcnew List<wchar_t>();

    for (int i = 0; i < input->Length; i++)
    {
        wchar_t ch = Char::ToUpper(input[i]);

        // Перевіряємо, чи це буква українського алфавіту
        if (ukrainianAlphabet->IndexOf(ch) != -1)
        {
            if (!seen->Contains(ch))
            {
                seen->Add(ch);
                result->Append(ch);
            }
        }
    }

    return result->ToString();
}

// Встановлення ключового слова
void PlayfairCipher::SetKeyword(String^ key)
{
    if (String::IsNullOrEmpty(key))
    {
        keyword = "";
        return;
    }

    keyword = RemoveDuplicates(key);
    BuildMatrix(keyword);
}

String^ PlayfairCipher::GetKeyword()
{
    return keyword;
}

// Побудова матриці шифру
void PlayfairCipher::BuildMatrix(String^ key)
{
    StringBuilder^ matrixString = gcnew StringBuilder();

    // Додаємо ключ
    matrixString->Append(key);

    // Додаємо решту алфавіту
    for (int i = 0; i < ukrainianAlphabet->Length; i++)
    {
        wchar_t ch = ukrainianAlphabet[i];
        if (key->IndexOf(ch) == -1)
        {
            matrixString->Append(ch);
        }
    }

    // Заповнюємо матрицю
    int index = 0;
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            if (index < matrixString->Length)
            {
                matrix[i][j] = matrixString[index];
                index++;
            }
            else
            {
                matrix[i][j] = L' ';
            }
        }
    }
}

// Отримання матриці як рядка
String^ PlayfairCipher::GetMatrixAsString()
{
    StringBuilder^ result = gcnew StringBuilder();

    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            result->Append(matrix[i][j]);
            result->Append(" ");
        }
        result->Append("\r\n");
    }

    return result->ToString();
}

// Пошук позиції символу в матриці
void PlayfairCipher::FindPosition(wchar_t ch, int% row, int% col)
{
    ch = Char::ToUpper(ch);

    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            if (matrix[i][j] == ch)
            {
                row = i;
                col = j;
                return;
            }
        }
    }

    // Якщо не знайдено, повертаємо 0,0
    row = 0;
    col = 0;
}

// Підготовка тексту для шифрування
String^ PlayfairCipher::PrepareText(String^ text)
{
    if (String::IsNullOrEmpty(text))
        return "";

    StringBuilder^ result = gcnew StringBuilder();

    // Видаляємо всі символи крім українських букв
    for (int i = 0; i < text->Length; i++)
    {
        wchar_t ch = Char::ToUpper(text[i]);
        if (ukrainianAlphabet->IndexOf(ch) != -1)
        {
            result->Append(ch);
        }
    }

    // Додаємо 'Г' між однаковими буквами та в кінці якщо непарна довжина
    StringBuilder^ prepared = gcnew StringBuilder();
    int len = result->Length;

    for (int i = 0; i < len; i += 2)
    {
        prepared->Append(result[i]);

        if (i + 1 < len)
        {
            if (result[i] == result[i + 1])
            {
                // Однакові букви - вставляємо 'Г'
                prepared->Append(L'Г');
                i--; // Повертаємося назад, щоб обробити другу букву
            }
            else
            {
                prepared->Append(result[i + 1]);
            }
        }
        else
        {
            // Непарна довжина - додаємо 'Я' в кінець
            prepared->Append(L'Я');
        }
    }

    return prepared->ToString();
}

// Форматування виходу (додавання пробілів між біграмами)
String^ PlayfairCipher::FormatOutput(String^ text)
{
    if (String::IsNullOrEmpty(text))
        return "";

    StringBuilder^ result = gcnew StringBuilder();

    for (int i = 0; i < text->Length; i += 2)
    {
        result->Append(text[i]);
        if (i + 1 < text->Length)
        {
            result->Append(text[i + 1]);
        }
        if (i + 2 < text->Length)
        {
            result->Append(" ");
        }
    }

    return result->ToString();
}

// Шифрування
String^ PlayfairCipher::Encrypt(String^ plaintext)
{
    if (String::IsNullOrEmpty(plaintext))
        return "";

    if (String::IsNullOrEmpty(keyword))
    {
        throw gcnew Exception("Спочатку встановіть ключове слово!");
    }

    String^ prepared = PrepareText(plaintext);
    StringBuilder^ result = gcnew StringBuilder();

    for (int i = 0; i < prepared->Length; i += 2)
    {
        wchar_t ch1 = prepared[i];
        wchar_t ch2 = prepared[i + 1];

        int row1 = 0, col1 = 0, row2 = 0, col2 = 0;
        FindPosition(ch1, row1, col1);
        FindPosition(ch2, row2, col2);

        // Правила шифрування Плейфера
        if (row1 == row2)
        {
            // Обидва символи в одному рядку
            col1 = (col1 + 1) % cols;
            col2 = (col2 + 1) % cols;
        }
        else if (col1 == col2)
        {
            // Обидва символи в одному стовпці
            row1 = (row1 + 1) % rows;
            row2 = (row2 + 1) % rows;
        }
        else
        {
            // Утворюють прямокутник - міняємо стовпці
            int temp = col1;
            col1 = col2;
            col2 = temp;
        }

        result->Append(matrix[row1][col1]);
        result->Append(matrix[row2][col2]);
    }

    return FormatOutput(result->ToString());
}

// Дешифрування
String^ PlayfairCipher::Decrypt(String^ ciphertext)
{
    if (String::IsNullOrEmpty(ciphertext))
        return "";

    if (String::IsNullOrEmpty(keyword))
    {
        throw gcnew Exception("Спочатку встановіть ключове слово!");
    }

    // Видаляємо пробіли
    String^ cleaned = ciphertext->Replace(" ", "");
    cleaned = cleaned->ToUpper();

    StringBuilder^ result = gcnew StringBuilder();

    for (int i = 0; i < cleaned->Length; i += 2)
    {
        if (i + 1 >= cleaned->Length)
            break;

        wchar_t ch1 = cleaned[i];
        wchar_t ch2 = cleaned[i + 1];

        int row1 = 0, col1 = 0, row2 = 0, col2 = 0;
        FindPosition(ch1, row1, col1);
        FindPosition(ch2, row2, col2);

        // Правила дешифрування Плейфера (зворотні)
        if (row1 == row2)
        {
            // Обидва символи в одному рядку
            col1 = (col1 - 1 + cols) % cols;
            col2 = (col2 - 1 + cols) % cols;
        }
        else if (col1 == col2)
        {
            // Обидва символи в одному стовпці
            row1 = (row1 - 1 + rows) % rows;
            row2 = (row2 - 1 + rows) % rows;
        }
        else
        {
            // Утворюють прямокутник - міняємо стовпці
            int temp = col1;
            col1 = col2;
            col2 = temp;
        }

        result->Append(matrix[row1][col1]);
        result->Append(matrix[row2][col2]);
    }

    return FormatOutput(result->ToString());
}
