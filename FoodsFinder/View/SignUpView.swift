//
//  SignUpView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/12.
//

import SwiftUI

struct SignUpView: View {
    
    @State var email:String = ""
    @State var password:String = ""
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 18) {
                    Text("無料なので、会員登録しましょう")
                        .frame(height: 100)
                        .font(.system(size: 22)).bold()
                    
                    TextField("email", text: $email)
                        .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                        .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .focused($focusedField, equals: .mail)
                    
                    TextField("password", text: $password)
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
                        //dismiss()
                    }, label: {
                        Text("これで登録する")
                            .fontWeight(.semibold)
                            .frame(width: uiWidth(width: UIScreen.main.bounds.width), height: 50)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(8)
                    })
                }
            }
        }
    }
    
    private func uiWidth(width: CGFloat) -> CGFloat {
        let sideInset: CGFloat = 24
        return abs(width - sideInset*2)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
