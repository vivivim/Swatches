//
//  AuthView.swift
//  Swatches
//
//  Created by Admin on 8/28/25.
//

import SwiftUI
import SwiftData

struct AuthView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @Binding var currentUserID: UUID?
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isLogin: Bool = false
    @State var isPasswordSecured: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("이메일", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none) // 자동 대문자 방지 iOS 14 이하
                        .textInputAutocapitalization(.never) // iOS 15 이상
                        .disableAutocorrection(true) // 자동 수정 방지
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.bottom, 8)
                    ZStack {
                        if isPasswordSecured {
                            SecureField("비밀번호", text: $password)
                                .autocapitalization(.none) // 자동 대문자 방지 iOS 14 이하
                                .textInputAutocapitalization(.never) // iOS 15 이상
                                .disableAutocorrection(true) // 자동 수정 방지
                                .padding()
                                .padding(.trailing, 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        } else {
                            TextField("비밀번호", text: $password)
                                .autocapitalization(.none) // 자동 대문자 방지 iOS 14 이하
                                .textInputAutocapitalization(.never) // iOS 15 이상
                                .disableAutocorrection(true) // 자동 수정 방지
                                .padding()
                                .padding(.trailing, 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                isPasswordSecured.toggle()
                            }) {
                                Image(systemName: isPasswordSecured ? "eye.slash" : "eye")
                                    .padding(.trailing)
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
                .formStyle(.columns)
                .padding(.bottom)
                Button(action: {
                    if isLogin {
                        if let currentUser = users.first(where: { $0.email == email && $0.password == password }) {
                            currentUserID = currentUser.id
                            UserDefaults.standard.set(currentUser.id.uuidString, forKey: "currentUserID")
                            print("로그인 성공")
                        } else {
                            print("로그인 실패")
                        }
                    } else {
                        let newUser = User(email: email, password: password)
                        modelContext.insert(newUser)
                        do {
                            try modelContext.save()
                            currentUserID = newUser.id
                            UserDefaults.standard.set(newUser.id.uuidString, forKey: "currentUserID")
                            print("회원 가입 성공")
                        } catch {
                            print("회원 가입 실패: \(error)")
                        }
                    }
                }) {
                    Text(isLogin ? "로그인" : "회원가입")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .font(.title2)
                        .cornerRadius(8)
                }
                Button(action: {
                    isLogin.toggle()
                }) {
                    Text(isLogin ? "회원 가입하기" : "로그인하기")
                        .padding()
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .navigationTitle(Text(isLogin ? "로그인" : "회원가입"))
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    struct Wrapper: View {
        @State var currentUserID: UUID? = nil
        var body: some View {
            AuthView(currentUserID: $currentUserID)
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}

//#Preview {
//    AuthView()
//}
