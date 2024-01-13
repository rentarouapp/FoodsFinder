//
//  SignUpView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/12.
//

import SwiftUI

struct SignUpView: View {
    
    // ViewModel
    @StateObject private var loginViewModel = LoginViewModel.shared
    
    @State var name: String = ""
    @State var email:String = ""
    @State var password:String = ""
    @State var confirmPassword: String = ""
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            VStack(spacing: 18) {
                Text("無料なので、会員登録しましょう")
                    .frame(height: 100)
                    .font(.system(size: 22)).bold()
                
                TextField("ユーザ名（任意）", text: $name)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .focused($focusedField, equals: .mail)
                
                TextField("メールアドレス", text: $email)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .focused($focusedField, equals: .mail)
                
                TextField("パスワード", text: $password)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .focused($focusedField, equals: .password)
                
                TextField("パスワード（確認用）", text: $confirmPassword)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .focused($focusedField, equals: .password)
                
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
    }
    
    private func uiWidth(width: CGFloat) -> CGFloat {
        let sideInset: CGFloat = 24
        return abs(width - sideInset*2)
    }
    
    private func createUser() {
        
        
        loginViewModel.createUser(email: email, password: password, name: name)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
