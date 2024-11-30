//
//  SplashView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @State private var showMainScreen = false
    @State private var progressValue : TimeInterval = 0.2
    var body: some View {
        Group{
            if !showMainScreen{
                splashContent
            }else{
                ShoplistsScreen()
            }
        }
        .onAppear(){
            startSplash()
        }
    }
    
    private var splashContent: some View {
        ZStack {
            Color(.pink.opacity(0.30)).edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                  
                Spacer()
                
                Text("Добро пожаловать в Список покупок")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black.opacity(0.75))
                    .padding(.horizontal, 16)
                    .frame(alignment: .center)
                
                Text("Создавайте списки, добавляйте товары, отмечайте, что уже куплено")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(.black.opacity(0.50))
                    .padding(.horizontal, 16)
                
                
                Spacer()
            }
        }
    }
    
    func startSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showMainScreen.toggle()
        }
    }
}

#Preview {
    ShoplistsScreen()
}

