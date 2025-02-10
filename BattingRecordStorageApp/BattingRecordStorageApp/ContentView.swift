//
//  ContentView.swift
//  BattingRecordStorageApp
//
//  Created by Kiriu Tomoki on 2025/01/27.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginError = ""
    @State private var showSignUp = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    Spacer()

                    Image("icon_1")
                        .resizable()
                        .scaledToFit()
                        .padding()

                    Spacer()

                    // キーボードによるレイアウト崩れ防止のため ScrollView を使用
                    ScrollView {
                        VStack(spacing: 16) {
                            TextField("メールアドレス", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)

                            SecureField("パスワード", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            Button(action: {
                                login()
                            }) {
                                Text("ログイン")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }

                            if !loginError.isEmpty {
                                Text(loginError)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                            }

                            NavigationLink(destination: SignUpView()) {
                                Text("新規登録はこちら")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                    }

                    Spacer()
                }
            }
            .navigationTitle("ログイン")
            .onAppear {
                DispatchQueue.main.async {
                    if FirebaseApp.app() != nil {
                        print("✅ Firebase is successfully configured.")
                    } else {
                        print("⚠️ Firebase configuration failed.")
                    }
                }
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                loginError = "ログインに失敗しました: \(error.localizedDescription)"
            } else {
                loginError = ""
                print("ログイン成功: \(authResult?.user.email ?? "")")
            }
        }
    }
}

#Preview {
    ContentView()
}
