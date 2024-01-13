//
//  CompleteView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import SwiftUI

struct CompleteView: View {
    var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                Text("テスト")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .frame(height: 50)
                    .foregroundColor(.blue)
                    .background(Color(.clear))
            })
        }
    }
}

struct CompleteView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteView()
    }
}
