//
//  SwiftUIView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 07.12.2024.
//

import SwiftUI


struct EmojiGridSheet: View {
    let emojis: [String]
    let onEmojiSelected: (String) -> Void
    let rows = [
        GridItem(.adaptive(minimum: 40))
    ]
    var body: some View {
        VStack {
            HStack{
                Text(AppConstants.Texts.iconsSheetTitle)
                    .font(.headline)
                    .padding()
            }
            ScrollView(.horizontal){
                LazyHGrid(rows: rows, spacing: 12) {
                    ForEach(emojis, id: \.self) { emoji in
                        Button(action: {
                            onEmojiSelected(emoji)
                        }) {
                            Image(systemName: emoji)
                                .frame(width: 44,height: 44)
                                .foregroundColor(.textTetriary)
                                .background(.accentPrimary)
                                .cornerRadius(22)
                        }
                    }
                }
                .padding(.horizontal, 26)
                
                Spacer()
            }
        }
        .presentationDetents([.fraction(0.35)])  
        .presentationDragIndicator(.visible)
    }
    
}
