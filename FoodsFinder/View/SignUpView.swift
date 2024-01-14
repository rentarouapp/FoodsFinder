//
//  SignUpView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/12.
//

import SwiftUI

struct SignUpView: View {
    // Login
    @StateObject private var loginViewModel = LoginViewModel.shared
    // Alert
    @StateObject var alertViewModel = AlertViewModel()
    
    @State var name: String = ""
    @State var email:String = ""
    @State var password:String = ""
    @State var confirmPassword: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if focusedField == nil {
                    Text("無料なので、会員登録しましょう")
                        .frame(height: 100)
                        .font(.system(size: 22).bold())
                }
                Text("※ 任意")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 16))
                    .foregroundColor(.blue)
                TextField("ユーザ名", text: $name)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .focused($focusedField, equals: .name)
                
                Spacer().frame(height: 18)
                
                Text("※ 必須")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 16))
                    .foregroundColor(.red)
                TextField("メールアドレス", text: $email)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .focused($focusedField, equals: .mail)
                Spacer().frame(height: 18)
                
                Text("※ 必須")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 16))
                    .foregroundColor(.red)
                TextField("パスワード", text: $password)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .focused($focusedField, equals: .password)
                Spacer().frame(height: 18)
                
                Text("※ 必須")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 16))
                    .foregroundColor(.red)
                TextField("パスワード（確認用）", text: $confirmPassword)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .focused($focusedField, equals: .confirmPassword)
                
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack{
                        Spacer()
                        Button("Close"){
                            self.focusedField = nil
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            
            VStack {
                Spacer()
                Button(action: {
                    createUser()
                }, label: {
                    Text("この情報で登録する")
                        .fontWeight(.semibold)
                        .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(8)
                })
                Spacer()
                    .frame(height: 20)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .customAlert(for: $alertViewModel.alertEntity)
        .customAlert2(for: $loginViewModel.alertViewModel.alertEntity)
        .PKHUD(isPresented: $loginViewModel.isFetching, HUDContent: .progress)
    }
    
    private func uiWidth(width: CGFloat) -> CGFloat {
        let sideInset: CGFloat = 24
        return abs(width - sideInset*2)
    }
    
    private func createUser() {
        if let alertEntity = ValidationInteractor.singleButtonAlertEntityWithSignUpValidation(
            email: email,
            password: password,
            confirmPassword: confirmPassword
        ) {
            // 入力不備があったらダイアログ表示
            alertViewModel.alertEntity = alertEntity
            alertViewModel.alertEntity.show()
            return
        }
        loginViewModel.alertCompletion = {
            dismiss()
        }
        loginViewModel.createUser(email: email, password: password, name: name)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
