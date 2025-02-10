//
//  SignUpView.swift
//  BattingRecordStorageApp
//
//  Created by Kiriu Tomoki on 2025/01/27.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var signUpError = ""
    @State private var isSignUpSuccessful = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            TextField("メールアドレス", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            SecureField("パスワード（6文字以上）", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                hideKeyboard() // 🔹 キーボードを閉じる
                signUp()
            }) {
                Text("新規登録")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .disabled(email.isEmpty || password.count < 6) // 🔹 無効な入力のときボタンを無効化

            if !signUpError.isEmpty {
                Text(signUpError)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("新規登録")
        .alert("登録成功", isPresented: $isSignUpSuccessful) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("新規登録が完了しました！")
        }
    }

    // 🔹 新規登録処理
    func signUp() {
        guard isValidEmail(email) else {
            signUpError = "有効なメールアドレスを入力してください。"
            return
        }
        guard password.count >= 6 else {
            signUpError = "パスワードは6文字以上必要です。"
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                signUpError = "新規登録に失敗しました: \(error.localizedDescription)"
            } else {
                signUpError = ""
                isSignUpSuccessful = true // 成功フラグを立てる
                print("✅ 新規登録成功: \(authResult?.user.email ?? "")")
            }
        }
    }

    // 🔹 メールアドレスのバリデーション関数
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
}

// 🔹 キーボードを閉じるメソッド（ボタン押下時）
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SignUpView()
}
