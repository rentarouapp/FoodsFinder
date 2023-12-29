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
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    VStack(spacing: 18) {
                        Text("🍺ログイン画面🍣")
                            .frame(height: 100)
                            .font(.system(size: 30)).bold()
                        
                        TextField("email", text: $email)
                            .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                            .frame(width: uiWidth(width: geometry.size.width), height: 56)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.gray, lineWidth: 1)
                            )
                            .focused($focusedField, equals: .mail)
                        
                        TextField("password", text: $password)
                            .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                            .frame(width: uiWidth(width: geometry.size.width), height: 56)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.gray, lineWidth: 1)
                            )
                            .focused($focusedField, equals: .password)
                        Spacer()
                            .frame(height: 100)
                    }
                    
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("ログイン")
                                .fontWeight(.semibold)
                                .frame(width: uiWidth(width: geometry.size.width), height: 56)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(8)
                        })
                        
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("ログインせずに使う")
                                .fontWeight(.semibold)
                                .frame(width: uiWidth(width: geometry.size.width), height: 56)
                                .foregroundColor(.blue)
                                .background(Color(.white))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue, lineWidth: 1)
                                )
                        })
                        
                        Spacer()
                            .frame(height: 20)
                    }
                }
            }
            .interactiveDismissDisabled()
            .onTapGesture {
                focusedField = nil
            }
        }
    }
    
    private func uiWidth(width: CGFloat) -> CGFloat {
        let sideInset: CGFloat = 24
        return width - sideInset*2
    }
}

enum Field: Hashable {
    case mail
    case password
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
