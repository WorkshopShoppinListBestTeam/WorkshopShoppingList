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
        static let appearanceUserDefaultsKey = "appearance"
        static let userOrderingUserDefaultsKey = "userOrdering"
        static let splashScreenMainMessage = "Добро пожаловать!"
        static let splashScreenSubMessage = "Создавайте списки, добавляйте товары, отмечайте, что уже куплено"
        static let shopListScreenEmptyListMainMessage = "У вас пока нет списков"
        static let shopListScreenEmptyListSubMessage = "Нажмите на кнопку, чтобы создать свой первый список"
        static let shpoListScreenTitle = "Мои списки"
        static let addListButtonText = "Добавить список"
        static let searchTextPlaceholder = "Поиск"
        static let cancelText = "Отмена"
        static let cancelButtonText = "Отменить"
        static let addButtonText = "Добавить"
        static let readyButtonText = "Готово"
        static let newListSheetTitleText = "Новый список"
        static let newListSheetPlaceholderText = "Название"
        static let editListNameSheetText = "Редактирование"
        static let editListNameLabelText = "Название списка"
        static let newListSheetDuplicatedNameAlertMessage = "Список с таким названием уже существует"
        static let noResultFoundMainText = "Мы не смогли найти то, что вы искали"
        static let noResultFoundSubText = "Попробуйте изменить запрос или проверить написание"
        static let iconsSheetTitle = "Иконка"
        static let backNavigationButtonText = "Списки"
        static let nameLabelText = "Название"
        static let amountListLabelText = "Количество"
        static let measurementListLabelText = "Измерение"
        static let alertTitleText = "Удалить список"
        static let alertConfimationText: (String) -> String = { listName in
            return "Удалить список «\(listName)» ? Все данные в списке будут потеряны."
        }
        
        static let deleteButtonText = "Удалить"
        static let renameButtonText = "Переименовать"
        static let editButtonText = "Редактировать"
        static let duplicateButtonText = "Дублировать"
        static let itemScreenEmptyListMainMessage = "В списке покупок пока пусто"
        static let itemScreenEmptyListSubMessage = "Нажмите на +, чтобы добавить товары"
        
        static let newItemSheetPlaceholderNameText = "Товар"
        static let newItemSheetPlaceholderQuantityText = "0"
        static let newItemSheetPlaceholderMeasurmentUnitText = "шт"
        static let newItemSheetTitleText = "Новый товар"
        
        static let lightThemeLabeltext = "Светлая тема"
        static let darkThemeLabeltext = "Тёмная тема"
        static let themeLabelText = "Оформление"
        static let deleteAll = "Удалить все списки"
        static let deletePurchased = "Очистить купленные"
        static let deleteAllItems = "Удалить все товары"
        
        static let orderMenuText = "Сортировка"
        static let orderByAlphabet = "По алфавиту"
        static let orderByUser = "Пользовательская"
        
        
        static let alertDeletingPurchasedTitle = "Очистить купленные"
        static let alertDeletingPurchasedMessage = "Товары, отмеченные как купленные, будут удалены."
        
        static let alertDeletingAllItemsTitle = "Удалить все товары"
        static let alertDeletingAllItemsMessage = "Все товары в данном списке покупок будут удалены."
        
        static let alertDeletingAllListsTitle = "Удалить все списки"
        static let alertDeletingAllListsMessage = "Все данные в списках будут потеряны."
        
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
    
    struct SymbolsName {
        static let magnifyingGlassSymbol = "magnifyingglass"
        static let plusSymbol = "plus"
        static let settingsSymbol = "ellipsis.circle"
        static let chevronRigth = "chevron.right"
        static let xmarkCircleFill = "xmark.circle.fill"
        static let sunMax = "sun.max"
        static let moon = "moon"
        static let paintPalette = "paintpalette"
        static let trash = "trash"
        static let checkmark = "checkmark"
        static let chevronUpChevronDown = "chevron.up.chevron.down"
        static let checkmarkCircleFill = "checkmark.circle.fill"
        static let circle = "circle"
        static let pencil = "pencil"
        static let broom = "broom"
        static let orderingByButton = "arrow.up.arrow.down"
        static let orderingByUser = "text.justify"
        static let orderingByAlphabet = "character"
    }
    
    
    struct ImageNames{
        static var logoImageName = "Logo"
        static var NoResultsFound : String { themedImageName(light: "NoResultsFoundScreenLight", dark: "NoResultsFoundScreenDark")
        }
        static var ProductListScreen : String { themedImageName(light: "ProductListScreenLight", dark: "ProductListScreenDark")
        }
        static var ShoppingListScreen : String { themedImageName(light: "ShoppingListScreenLight", dark: "ShoppingListScreenDark")
        }
        static var StartScreen : String { themedImageName(light: "StartScreenLight", dark: "StartScreenDark")
        }
        
        static var Grabber : String {themedImageName(light: "GrabberLight", dark: "GrabberDark")
        }
      
        static var Clean : String {themedImageName(light: "CleanLight", dark: "CleanDark")
        }
        
        private static func themedImageName(light: String, dark: String) -> String {
            let isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
            return isDarkMode ? dark : light
        }
    }
    
    
}
