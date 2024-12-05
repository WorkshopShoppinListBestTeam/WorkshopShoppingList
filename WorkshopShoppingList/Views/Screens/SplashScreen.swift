//
//  SplashView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import Foundation
import SwiftUI
import Combine

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
            Color(.backgroundPrimary).edgesIgnoringSafeArea(.all)
            VStack {
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 18)
                    .padding(.bottom, 44)
                PlaceholderView(imageName: "StartScreenLight", mainMessage: AppConstants.General.logoMainMessage, subMessage: AppConstants.General.logoSubMessage)
            
            }
            }
    }
    
    func startSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            showMainScreen.toggle()
        }
    }
}

#Preview {
    ShoplistsScreen()
}

