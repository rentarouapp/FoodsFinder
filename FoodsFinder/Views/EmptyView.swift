//
//  EmptyView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/23.
//

import SwiftUI

enum EmptyViewType {
    case initial
    case noResult
    case noFavorite
}

struct BookSearchEmptyView: View {
    
    @Binding var type: EmptyViewType
    @Binding var searchText: String
    var isFavorite: Bool
    @State var emptyText: String = "わわわ"
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(spacing: 6) {
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Image("star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200, alignment: .center)
                    Text(isFavorite ? "お気に入りなし" : "検索結果なし")
                        .font(Font.system(size: 20))
                        .bold()
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: geometry.size.width)
                .frame(minHeight: geometry.size.height)
            }
            .onChange(of: type, perform: { newValue in
                self.updateText(type: type)
            })
        }
    }
    
    func updateText(type: EmptyViewType) {
        if type == .initial {
            self.emptyText = "店を探す"
        } else if type == .noResult {
            let noResultMessage: String = String(format: "ああ", self.searchText)
            self.emptyText = noResultMessage
        } else if type == .noFavorite {
            self.emptyText = "お気に入りなし"
        }
    }
}

struct BookSearchEmptyView_Previews: PreviewProvider {
    @State static var type: EmptyViewType = .initial
    @State static var searchText: String = ""
    @State static var isFavorite: Bool = false
    static var previews: some View {
        BookSearchEmptyView(type: $type, searchText: $searchText, isFavorite: false)
            .previewLayout(.sizeThatFits)
    }
}

