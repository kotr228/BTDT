#pragma once

#using <System.dll>

using namespace System;
using namespace System::Text;
using namespace System::Collections::Generic;

namespace PlayfairCipherLib {

    public ref class PlayfairCipher
    {
    private:
        // Матриця для українського алфавіту 4x8 (32 букви)
        array<array<wchar_t>^>^ matrix;
        int rows;
        int cols;
        String^ keyword;

        // Український алфавіт (32 букви)
        String^ ukrainianAlphabet;

        // Допоміжні методи
        String^ RemoveDuplicates(String^ input);
        void BuildMatrix(String^ key);
        void FindPosition(wchar_t ch, int% row, int% col);
        String^ PrepareText(String^ text);
        String^ FormatOutput(String^ text);

    public:
        PlayfairCipher();
        PlayfairCipher(String^ key);

        // Основні методи
        void SetKeyword(String^ key);
        String^ GetKeyword();
        String^ GetMatrixAsString();

        String^ Encrypt(String^ plaintext);
        String^ Decrypt(String^ ciphertext);
    };

} // namespace PlayfairCipherLib
