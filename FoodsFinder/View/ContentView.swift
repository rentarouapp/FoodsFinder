//
//  ContentView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSheet: Bool = true
    
    var body: some View {
        HPView()
            .sheet(isPresented: $showSheet) {
                LoginView()
            }
    }
}

#Preview {
    ContentView()
}
