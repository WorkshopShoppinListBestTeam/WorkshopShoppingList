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
    struct General{
        static let splashDuration: TimeInterval = 0.2
    }
    struct Texts {
        static let appName = "WorkshopShoppingList"
        
        static let splashScreenMainMessage = "Добро пожаловать!"
        static let splashScreenSubMessage = "Создавайте списки, добавляйте товары, отмечайте, что уже куплено"
        static let shpoListScreenEmptyListMainMessage = "У вас пока нет списков"
        static let shpoListScreenEmptyListSubMessage = "Нажмите на кнопку, чтобы создать свой первый список"
        static let shpoListScreenTitle = "Мои списки"
    }
    
    struct Fonts{
         static let semiboldTextFontName = "SFPro-Semibold"
         static let regularTextFontName = "SFPro-Regular"
         static let boldTextFontName = "SFPro-Bold"
        
        static let header1 = Font.custom(boldTextFontName, size: 34)
        static let header2 = Font.custom(semiboldTextFontName, size: 20)
        static let largeTextLarge17 = Font.custom(semiboldTextFontName, size: 17)
        static let largeTextBody17 = Font.custom(regularTextFontName, size: 17)
        static let smallTextBody15 = Font.custom(semiboldTextFontName, size: 15)
        static let footnote = Font.custom(regularTextFontName, size: 13)
        static let caption = Font.custom(regularTextFontName, size: 12)
    }
}
