#pragma once

#include <string>
#include <algorithm>
#include <set>

using namespace System;
using namespace System::Collections::Generic;

namespace AtbashCipherLib {

    public ref class AtbashCipher
    {
    private:
        String^ keyword;
        String^ substitutionAlphabet;

        // Допоміжні методи
        String^ RemoveDuplicates(String^ input);
        wchar_t EncryptChar(wchar_t ch);
        wchar_t DecryptChar(wchar_t ch);
        wchar_t EncryptCharWithKey(wchar_t ch);
        wchar_t DecryptCharWithKey(wchar_t ch);

    public:
        AtbashCipher();
        AtbashCipher(String^ key);

        // Простий Атбаш (без ключа)
        String^ Encrypt(String^ plaintext);
        String^ Decrypt(String^ ciphertext);

        // Атбаш з ключем
        String^ EncryptWithKey(String^ plaintext);
        String^ DecryptWithKey(String^ ciphertext);

        // Геттери/Сеттери
        void SetKeyword(String^ key);
        String^ GetKeyword();
        String^ GetSubstitutionAlphabet();
    };

} // namespace AtbashCipherLib
