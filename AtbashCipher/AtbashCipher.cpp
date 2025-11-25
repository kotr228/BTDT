#include "AtbashCipher.h"

using namespace System;
using namespace System::Text;
using namespace AtbashCipherLib;

// Конструктор за замовчуванням
AtbashCipher::AtbashCipher()
{
    keyword = "";
    substitutionAlphabet = "";
}

// Конструктор з ключовим словом
AtbashCipher::AtbashCipher(String^ key)
{
    SetKeyword(key);
}

// Видаляє дублікати літер з рядка
String^ AtbashCipher::RemoveDuplicates(String^ input)
{
    if (String::IsNullOrEmpty(input))
        return "";

    StringBuilder^ result = gcnew StringBuilder();
    List<wchar_t>^ seen = gcnew List<wchar_t>();

    for (int i = 0; i < input->Length; i++)
    {
        wchar_t ch = Char::ToUpper(input[i]);
        if (!seen->Contains(ch))
        {
            seen->Add(ch);
            result->Append(ch);
        }
    }
    return result->ToString();
}

// Встановлює ключове слово та створює алфавіт заміни
void AtbashCipher::SetKeyword(String^ key)
{
    keyword = RemoveDuplicates(key);

    // Створюємо алфавіт заміни
    StringBuilder^ alphabet = gcnew StringBuilder();
    alphabet->Append(keyword);

    // Додаємо решту літер англійського алфавіту
    for (wchar_t ch = L'A'; ch <= L'Z'; ch++)
    {
        if (keyword->IndexOf(ch) == -1)
        {
            alphabet->Append(ch);
        }
    }

    // Додаємо кириличні літери (українські)
    // А-Я (1040-1071 у Unicode)
    for (wchar_t ch = L'\u0410'; ch <= L'\u042F'; ch++)
    {
        if (keyword->IndexOf(ch) == -1)
        {
            alphabet->Append(ch);
        }
    }

    // Додаємо українські літери: Є, І, Ї, Ґ
    array<wchar_t>^ ukrainianChars = { L'\u0404', L'\u0406', L'\u0407', L'\u0490' };
    for (int i = 0; i < ukrainianChars->Length; i++)
    {
        if (keyword->IndexOf(ukrainianChars[i]) == -1)
        {
            alphabet->Append(ukrainianChars[i]);
        }
    }

    substitutionAlphabet = alphabet->ToString();
}

String^ AtbashCipher::GetKeyword()
{
    return keyword;
}

String^ AtbashCipher::GetSubstitutionAlphabet()
{
    return substitutionAlphabet;
}

// Шифрування одного символу простим Атбашем
wchar_t AtbashCipher::EncryptChar(wchar_t ch)
{
    // Англійські великі літери (A-Z)
    if (ch >= L'A' && ch <= L'Z')
    {
        return L'Z' - (ch - L'A');
    }
    // Англійські малі літери (a-z)
    else if (ch >= L'a' && ch <= L'z')
    {
        return L'z' - (ch - L'a');
    }
    // Кириличні великі літери (А-Я)
    else if (ch >= L'\u0410' && ch <= L'\u042F')
    {
        return (wchar_t)(L'\u042F' - (ch - L'\u0410'));
    }
    // Кириличні малі літери (а-я)
    else if (ch >= L'\u0430' && ch <= L'\u044F')
    {
        return (wchar_t)(L'\u044F' - (ch - L'\u0430'));
    }
    // Українські літери (великі)
    else if (ch == L'\u0404') return L'\u0490'; // Є -> Ґ
    else if (ch == L'\u0406') return L'\u0407'; // І -> Ї
    else if (ch == L'\u0407') return L'\u0406'; // Ї -> І
    else if (ch == L'\u0490') return L'\u0404'; // Ґ -> Є
    // Українські літери (малі)
    else if (ch == L'\u0454') return L'\u0491'; // є -> ґ
    else if (ch == L'\u0456') return L'\u0457'; // і -> ї
    else if (ch == L'\u0457') return L'\u0456'; // ї -> і
    else if (ch == L'\u0491') return L'\u0454'; // ґ -> є

    return ch; // Повертаємо символ без змін, якщо це не літера
}

// Дешифрування одного символу простим Атбашем (симетричний алгоритм)
wchar_t AtbashCipher::DecryptChar(wchar_t ch)
{
    return EncryptChar(ch);
}

// Простий Атбаш - шифрування
String^ AtbashCipher::Encrypt(String^ plaintext)
{
    if (String::IsNullOrEmpty(plaintext))
        return "";

    StringBuilder^ result = gcnew StringBuilder();
    for (int i = 0; i < plaintext->Length; i++)
    {
        result->Append(EncryptChar(plaintext[i]));
    }
    return result->ToString();
}

// Простий Атбаш - дешифрування
String^ AtbashCipher::Decrypt(String^ ciphertext)
{
    return Encrypt(ciphertext); // Атбаш є симетричним
}

// Шифрування одного символу з ключем
wchar_t AtbashCipher::EncryptCharWithKey(wchar_t ch)
{
    bool isLower = Char::IsLower(ch);
    wchar_t upperCh = Char::ToUpper(ch);

    // Стандартний англійський алфавіт
    String^ normalAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    // Шукаємо позицію в нормальному алфавіті
    int pos = normalAlphabet->IndexOf(upperCh);

    if (pos != -1 && pos < substitutionAlphabet->Length)
    {
        wchar_t encrypted = substitutionAlphabet[pos];
        return isLower ? Char::ToLower(encrypted) : encrypted;
    }

    // Кириличні літери
    if (upperCh >= L'\u0410' && upperCh <= L'\u042F')
    {
        // Визначаємо позицію в кириличному алфавіті
        String^ cyrillicAlphabet = L"\u0410\u0411\u0412\u0413\u0414\u0415\u0416\u0417\u0418\u0419\u041A\u041B\u041C\u041D\u041E\u041F\u0420\u0421\u0422\u0423\u0424\u0425\u0426\u0427\u0428\u0429\u042C\u042E\u042F\u0404\u0406\u0407\u0490";
        pos = cyrillicAlphabet->IndexOf(upperCh);

        if (pos != -1)
        {
            // Знаходимо відповідну літеру в алфавіті заміни
            int substPos = 26 + pos; // Після англійських літер
            if (substPos < substitutionAlphabet->Length)
            {
                wchar_t encrypted = substitutionAlphabet[substPos];
                return isLower ? Char::ToLower(encrypted) : encrypted;
            }
        }
    }

    return ch; // Якщо не знайдено, повертаємо оригінальний символ
}

// Дешифрування одного символу з ключем
wchar_t AtbashCipher::DecryptCharWithKey(wchar_t ch)
{
    bool isLower = Char::IsLower(ch);
    wchar_t upperCh = Char::ToUpper(ch);

    // Шукаємо позицію в алфавіті заміни
    int pos = substitutionAlphabet->IndexOf(upperCh);

    if (pos == -1)
        return ch;

    String^ normalAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    // Якщо позиція в межах англійського алфавіту
    if (pos < 26 && pos < normalAlphabet->Length)
    {
        wchar_t decrypted = normalAlphabet[pos];
        return isLower ? Char::ToLower(decrypted) : decrypted;
    }

    // Кириличні літери
    if (pos >= 26)
    {
        String^ cyrillicAlphabet = L"\u0410\u0411\u0412\u0413\u0414\u0415\u0416\u0417\u0418\u0419\u041A\u041B\u041C\u041D\u041E\u041F\u0420\u0421\u0422\u0423\u0424\u0425\u0426\u0427\u0428\u0429\u042C\u042E\u042F\u0404\u0406\u0407\u0490";
        int cyrPos = pos - 26;
        if (cyrPos < cyrillicAlphabet->Length)
        {
            wchar_t decrypted = cyrillicAlphabet[cyrPos];
            return isLower ? Char::ToLower(decrypted) : decrypted;
        }
    }

    return ch;
}

// Атбаш з ключем - шифрування
String^ AtbashCipher::EncryptWithKey(String^ plaintext)
{
    if (String::IsNullOrEmpty(plaintext))
        return "";

    if (String::IsNullOrEmpty(substitutionAlphabet))
        return plaintext;

    StringBuilder^ result = gcnew StringBuilder();
    for (int i = 0; i < plaintext->Length; i++)
    {
        result->Append(EncryptCharWithKey(plaintext[i]));
    }
    return result->ToString();
}

// Атбаш з ключем - дешифрування
String^ AtbashCipher::DecryptWithKey(String^ ciphertext)
{
    if (String::IsNullOrEmpty(ciphertext))
        return "";

    if (String::IsNullOrEmpty(substitutionAlphabet))
        return ciphertext;

    StringBuilder^ result = gcnew StringBuilder();
    for (int i = 0; i < ciphertext->Length; i++)
    {
        result->Append(DecryptCharWithKey(ciphertext[i]));
    }
    return result->ToString();
}
