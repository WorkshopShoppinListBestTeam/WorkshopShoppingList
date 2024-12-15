//
//  NewShoppinglistView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import SwiftUI
import Combine

struct NewShoppinglistView: View {
    @ObservedObject var viewModel: ShoplistsScreenViewModel
    @FocusState private var isTextFieldFocused: Bool
    @State private var listNewName: String = ""
    @Binding var isViewPresented: Bool
    @State private var isListNameValid: Bool = true
    
    var body: some View {
        ZStack{
            Color(.backgroundPrimary)
                .ignoresSafeArea()
            VStack{
                topBar
               
                HStack{
                    TextField("", text: $listNewName)
                        .modifier(TextFieldPlaceHolderTextModifier(placeholder: AppConstants.Texts.nameLabelText,
                            text: $listNewName,
                            placeholderTextColor: .textSecondary,
                            horizontalPadding: 16)
                        )
                        .keyboardType(.default) 
                        .focused($isTextFieldFocused)
                        .padding(.vertical, 8)
                        .autocorrectionDisabled(true)
                        .onChange(of: listNewName){
                            if listNewName.count > 70 {
                                listNewName = String(listNewName.prefix(70))
                                   }
                            isListNameValid = !viewModel.shoppinglistAlreadyExists(listNewName)
                        }
                    if !listNewName.isEmpty {
                        Button(action: {
                            listNewName = ""
                        }) {
                            Image(systemName: AppConstants.SymbolsName.xmarkCircleFill)
                                .foregroundColor(.extraTintSecondary)
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .background(.backgroundSecondary)
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
                Spacer()
                
            }
            .ignoresSafeArea(.keyboard)
            .onAppear(){
                isTextFieldFocused = true
            }
            .animatedOnAppear()
        }
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
            Text(AppConstants.Texts.newListSheetTitleText)
                .font(AppConstants.Fonts.largeTextLarge17)
            Spacer()
            Button(action: {
                viewModel.addList(name: listNewName)
                isViewPresented.toggle()
            }) {
                Text(AppConstants.Texts.addButtonText)
                    .padding(.vertical,12)
                    .padding(.horizontal,16)
            }
            .disabled(!isListNameValid || listNewName.isEmpty)
            .foregroundColor( !isListNameValid || listNewName.isEmpty ? .extraTintTetriary : .textSecondary)
        }
    }
}

#Preview {
    @Previewable @State var isViewPresented = true

    NewShoppinglistView(viewModel: ShoplistsScreenViewModel(), isViewPresented: $isViewPresented)
}
