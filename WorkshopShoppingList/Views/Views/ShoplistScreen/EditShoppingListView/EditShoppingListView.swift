//
//  EditShoppingListView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 07.12.2024.
//
import SwiftUI
import Combine

struct EditShoppinglistView: View {
    @ObservedObject var viewModel: ShoplistsScreenViewModel
    @FocusState private var isTextFieldFocused: Bool
    @Binding var currentListName: String?
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
                    Text(AppConstants.Texts.editListNameLabelText)
                        .padding(.top, 24)
                        .padding(.leading, 32)
                    
                    Spacer()
                }
                HStack{
                    TextField("", text: $listNewName)
                        .modifier(TextFieldPlaceHolderTextModifier(placeholder: listNewName ?? AppConstants.Texts.newListSheetPlaceholderText,
                                                                   text: $listNewName,
                                                                   placeholderTextColor: .textSecondary, horizontalPadding: 16)
                        )
                        .keyboardType(.default)
                        .focused($isTextFieldFocused)
                        .padding(.vertical, 11)
                        .autocorrectionDisabled(true)
                        .tint(.textSecondary)
                        .onChange(of: listNewName){
                            if listNewName.count > 70 {
                                       listNewName = String(listNewName.prefix(70))
                                   }
                            if listNewName != currentListName{
                                isListNameValid = !viewModel.shoppinglistAlreadyExists(listNewName)
                            }
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
        .onAppear{
            listNewName = currentListName ?? AppConstants.Texts.unamedText
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
            Text(AppConstants.Texts.editListNameSheetText)
                .font(AppConstants.Fonts.largeTextLarge17)
            Spacer()
            Button(action: {
                viewModel.renameList(currentName: currentListName ?? AppConstants.Texts.unamedText, newName: listNewName)
                isViewPresented.toggle()
            }) {
                Text(AppConstants.Texts.readyButtonText)
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
