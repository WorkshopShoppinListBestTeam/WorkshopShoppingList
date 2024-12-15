//
//  NewItemtView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 08.12.2024.
//

import SwiftUI

struct NewItemtView: View {
    @ObservedObject var viewModel: ItemsScreenViewModel
    @Binding var isViewPresented: Bool
    @State private var isListNameValid: Bool = true
    @State private var itemNewName: String = ""
    @State private var itemNewQuantity: Int = 0
    @State private var itemMeasurementUnit: MeasurementUnit = .pieces
    @State private var hasChangedMeasurementUnit: Bool = false
    
    private var itemNewQuantityString: Binding<String> {
        Binding(
            get: { String(itemNewQuantity) },
            set: { itemNewQuantity = Int($0) ?? 0 }
        )
    }
    
    
    var body: some View {
        ZStack{
            Color(.backgroundTetriary)
                .ignoresSafeArea()
            VStack{
                topBar
                VStack{
                    HStack{
                        Text(AppConstants.Texts.nameLabelText)
                            .font(AppConstants.Fonts.largeTextLarge17)
                            .padding(.top, 40)
                            .padding(.leading, 32)
                        
                        Spacer()
                    }
                    HStack{
                        TextField("", text: $itemNewName)
                            .modifier(TextFieldPlaceHolderTextModifier(placeholder: AppConstants.Texts.newItemSheetPlaceholderNameText,
                                                                       text: $itemNewName,
                                                                       placeholderTextColor: .textSecondary,
                                                                       horizontalPadding: 16)
                            )
                            .keyboardType(.default)
                            .padding(.vertical, 11)
                            .autocorrectionDisabled(true)
                            .onChange(of: itemNewName){
                                if itemNewName.count > 70 {
                                           itemNewName = String(itemNewName.prefix(70))
                                       }
                                
                                isListNameValid = !viewModel.itemAlreadyExists(itemNewName)
                            }
                        
                        if !itemNewName.isEmpty {
                            Button(action: {
                                itemNewName = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.extraTintSecondary)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .background(isListNameValid ? .backgroundSecondary : .atentionSecondary)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                    
                    HStack{
                        Text(AppConstants.Texts.newListSheetDuplicatedNameAlertMessage)
                            .padding(.leading,32)
                            .font(AppConstants.Fonts.footnote)
                            .foregroundColor(.atentionPrimary)
                            .opacity(isListNameValid ? 0 : 1)
                            .animation(.easeInOut, value: isListNameValid)
                        Spacer()
                    }
                }
                
                
                
                //Group with quantity and measurement
                HStack(alignment: .top, spacing: 16){
                    //Quantity
                    VStack{
                        //Label
                        HStack{
                            Text(AppConstants.Texts.amountListLabelText)
                                .font(AppConstants.Fonts.largeTextLarge17)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                        //Group with textField and buttons
                        HStack{
                            HStack{
                                TextField("", text: itemNewQuantityString)
                                    .modifier(TextFieldPlaceHolderTextModifier(placeholder: AppConstants.Texts.newItemSheetPlaceholderNameText,
                                        text: itemNewQuantityString,
                                        placeholderTextColor: .textSecondary,
                                        horizontalPadding: 16)
                                    )
                                    .frame(alignment: .center)
                                    .keyboardType(.numberPad)
                                    .padding(.vertical, 12)
                                    .padding(.leading, 16)
                                    .autocorrectionDisabled(true)
                            }
                            HStack{
                                Button{
                                    itemNewQuantity = max(itemNewQuantity - 1, 0)
                                } label: {
                                    Image(systemName: AppConstants.SymbolsName.minusSymbol)
                                        .font(AppConstants.Fonts.largeTextBody17)
                                        .foregroundColor(.textTetriary)
                                        .padding(.horizontal, 14)
                                    
                                }
                                Rectangle().frame(width: 1, height: 18)
                                    .foregroundColor(.backgroundSecondary)
                                Button{
                                    itemNewQuantity += 1
                                }label: {
                                    Image(systemName: AppConstants.SymbolsName.plusSymbol)
                                        .font(AppConstants.Fonts.largeTextBody17)
                                        .foregroundColor(.textTetriary)
                                        .padding(.horizontal, 14)
                                }
                            }
                            .padding(.vertical, 6)
                            .background(.accentTetriary)
                            .cornerRadius(8)
                            .padding(.trailing, 16)
                        }
                        .frame(width: 200)
                        .background(.backgroundSecondary)
                        .cornerRadius(10)
                    }
                    //Measurement
                    VStack{
                        HStack{
                            Text(AppConstants.Texts.measurementListLabelText)
                                .font(AppConstants.Fonts.largeTextLarge17)
                                .padding(.leading, 16)
                            Spacer()
                        }
                        HStack(spacing: 8){
                            Spacer()
                            Text(itemMeasurementUnit.rawValue)
                                .font(AppConstants.Fonts.largeTextBody17)
                                .foregroundColor(hasChangedMeasurementUnit ? .textPrimary : .extraTintTetriary)
                            
                            Menu {
                                ForEach(MeasurementUnit.allCases, id: \.rawValue) { unit in
                                    Button(action: {
                                        itemMeasurementUnit = unit
                                    }) {
                                        ZStack{
                                            Color(.extraTintQuinary)
                                        }
                                        HStack {
                                            Text(unit.rawValue)
                                                .font(AppConstants.Fonts.largeTextBody17)
                                                .foregroundColor(.textPrimary)
                                            Spacer()
                                            if unit == itemMeasurementUnit {
                                                Image(systemName: AppConstants.SymbolsName.checkmark)
                                                    .foregroundColor(.textPrimary)
                                            }
                                        }
                                        
                                       
                                    }
                                }
                            } label: {
                                Image(systemName: AppConstants.SymbolsName.chevronUpChevronDown)
                                    .font(AppConstants.Fonts.largeTextBody17)
                                    .foregroundColor(hasChangedMeasurementUnit ? .textPrimary : .extraTintTetriary )
                            }
                            Spacer()
                        }
                        .padding(.vertical, 12)
                        .background(.backgroundSecondary)
                        .cornerRadius(10)
                    }
                    .onChange(of: itemMeasurementUnit){
                        hasChangedMeasurementUnit = true
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 32)
                .cornerRadius(10)
                
                Spacer()
                
                
            }
            .ignoresSafeArea(.keyboard)
            .animatedOnAppear()
        }
        .presentationDetents([.fraction(0.5)])  //Размер на половин экрана
        .presentationDragIndicator(.hidden)
    }
    
    
    
    private var topBar : some View{
        HStack{
            Button(action: {
                isViewPresented.toggle()
            }) {
                Text(AppConstants.Texts.cancelButtonText)
                    .padding(.vertical,12)
                    .padding(.horizontal,16)
            }
            .foregroundColor(.textSecondary)
            Spacer()
            Text(AppConstants.Texts.newItemSheetTitleText)
                .font(AppConstants.Fonts.largeTextLarge17)
            Spacer()
            Button(action: {
                viewModel.addItem(name: itemNewName, quantity: Double(itemNewQuantity), unit: itemMeasurementUnit)
                isViewPresented.toggle()
            }) {
                Text(AppConstants.Texts.addButtonText)
                    .padding(.vertical,12)
                    .padding(.horizontal,16)
            }
            .disabled(!isListNameValid || itemNewName.isEmpty)
            .foregroundColor( !isListNameValid || itemNewName.isEmpty ? .extraTintTetriary : .textSecondary)
        }
        
    }
}

#Preview {
    @Previewable @State var isViewPresented = true
    
    NewItemtView(viewModel: ItemsScreenViewModel(shoppingList: ShoppingList()), isViewPresented: $isViewPresented)
}
