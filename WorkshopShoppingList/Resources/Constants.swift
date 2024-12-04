//
//  Constants.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 04.12.2024.
//


import Foundation
import SwiftUI

struct AppConstants {
    static var shared = AppConstants()
    private init(){}
    
    struct General {
        static let appName = "WorkshopShoppingList"
        static let logoMainMessage = "Добро пожаловать в Список покупок"
        static let logoSubMessage = "Создавайте списки, добавляйте товары, отмечайте, что уже куплено"
        static let splashDuration: TimeInterval = 0.2
    }
    
    struct Fonts{
         static let semiboldTextFontName = "SFProDisplay-Semibold"
         static let regularTextFontName = "SFProDisplay-Regular"
         static let boldTextFontName = "SFProDisplay-Bold"
        
        static let header1 = Font.custom(boldTextFontName, size: 34)
        static let header2 = Font.custom(semiboldTextFontName, size: 20)
        static let largeTextLarge17 = Font.custom(semiboldTextFontName, size: 17)
        static let largeTextBody17 = Font.custom(regularTextFontName, size: 17)
        static let smallTextBody15 = Font.custom(semiboldTextFontName, size: 15)
        static let footnote = Font.custom(regularTextFontName, size: 13)
        static let caption = Font.custom(regularTextFontName, size: 12)
    }
}
