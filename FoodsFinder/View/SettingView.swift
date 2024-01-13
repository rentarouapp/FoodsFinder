//
//  SettingView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import SwiftUI

struct SettingView: View {
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        
        VStack {
            Button(action: {
                showSheet = true
            }, label: {
                Text("ログイン")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .frame(height: 50)
                    .foregroundColor(.blue)
                    .background(Color(.clear))
            })
        }
        .sheet(isPresented: $showSheet) {
            LoginView()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
