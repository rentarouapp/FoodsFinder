//
//  LoginView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/29.
//

import SwiftUI

struct LoginView: View {
    
    @State var email:String = ""
    @State var password:String = ""
    @FocusState private var focusedField: Field?
    
    @Environment(\.dismiss) private var dismiss
    
    @State var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack(spacing: 18) {
                    Text("🍺ログインしてね🍣")
                        .frame(height: 100)
                        .font(.system(size: 30)).bold()
                    
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
                    
                    Spacer()
                        .frame(height: 100)
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
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        //dismiss()
                    }, label: {
                        Text("ログイン")
                            .fontWeight(.semibold)
                            .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(8)
                    })
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("新規会員登録")
                            .fontWeight(.semibold)
                            .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                            .foregroundColor(.blue)
                            .background(Color(.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("ログインせずに使う")
                            .fontWeight(.semibold)
                            .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                            .foregroundColor(.black)
                            .background(Color(.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.black, lineWidth: 1)
                            )
                    })
                    Spacer()
                        .frame(height: 20)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
    }
    
    private func uiWidth(width: CGFloat) -> CGFloat {
        let sideInset: CGFloat = 24
        return abs(width - sideInset*2)
    }
}

enum Field: Hashable {
    case name
    case mail
    case password
    case confirmPassword
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
