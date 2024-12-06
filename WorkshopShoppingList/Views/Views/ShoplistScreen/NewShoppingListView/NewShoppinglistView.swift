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
                
                TextField("", text: $listNewName)
                    .modifier(TextFieldPlaceHolderTextModifier(placeholder: AppConstants.Texts.nameListLabelText,
                                                               text: $listNewName,
                                                               placeholderTextColor: .textSecondary, horizontalPadding: 16)
                    )
                    .focused($isTextFieldFocused)
                    .padding(.vertical, 8)
                    .background(.backgroundSecondary)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .onChange(of: listNewName){
                        isListNameValid = !viewModel.shoppinglistAlreadyExists(listNewName)
                    }
                
                Text(AppConstants.Texts.newListSheetDuplicatedNameAlertMessage)
                    .font(AppConstants.Fonts.footnote)
                    .foregroundColor(.atentionPrimary)
                    .opacity(isListNameValid ? 0 : 1)
                    .animation(.easeInOut, value: isListNameValid)
                
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
            .tint(.textSecondary)
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
            .tint(.textSecondary)
        }
    
    }
    
}

#Preview {
    @Previewable @State var isViewPresented = true

    NewShoppinglistView(viewModel: ShoplistsScreenViewModel(), isViewPresented: $isViewPresented)
}
