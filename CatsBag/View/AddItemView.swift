//
//  AddItemView.swift
//  CatsBag
//
//  Created by Artem Vinogradov on 30.12.2022.
//

import SwiftUI

struct AddItemView: View {
    @EnvironmentObject var vm: ViewModel
    // Access to .presentationMode for closing modal View
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var folder: FolderEntity
    
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            
            VStack(spacing: 30) {
                // MARK: - Close button section
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(Color("accent"))
                    }
                    Spacer()
                } .padding(.top, 15)
                // MARK: - Add item section
                HStack {
                    TextField(LocalizedStringKey("New product name"), text: $vm.itemName)
                        .padding()
                        .foregroundColor(.black.opacity(0.6))
                        .background(Color("folderColor"))
                        .cornerRadius(20)
                    
                    TextField(LocalizedStringKey("Number"), text: $vm.itemNumber)
                        .padding()
                        .frame(width: 100)
                        .foregroundColor(.black.opacity(0.6))
                        .background(Color("folderColor"))
                        .cornerRadius(20)
                        .keyboardType(.decimalPad)
                }
                
                HStack {
                    Picker("Measurement", selection: $vm.itemMeasurement) {
                        Text(LocalizedStringKey("Ounce")).tag(("oz"))
                        Text(LocalizedStringKey("Pound")).tag("lb")
                        Text(LocalizedStringKey("Gram")).tag("g")
                        Text(LocalizedStringKey("Pint")).tag("pt")
                        Text(LocalizedStringKey("Item")).tag("it")
                        Text(LocalizedStringKey("Litre")).tag("l")
                        Text(LocalizedStringKey("Gallon")).tag("gal")
                        Text(LocalizedStringKey("Millilitre")).tag("ml")
                        Text(LocalizedStringKey("Kilogram")).tag("kg")
                    } .pickerStyle(.wheel)
                        .frame(minWidth: 0)
                        .clipped()
                    
                    Divider().frame(height: 180)
                    
                    Picker("Categories", selection: $vm.itemCategory) {
                        Group {
                            Text(LocalizedStringKey("Sweets & Candy")).tag("Sweets & Candy")
                            Text(LocalizedStringKey("Fish & Seafood")).tag("Fish & Seafood")
                            Text(LocalizedStringKey("Bread & Flour")).tag("Bread & Flour")
                            Text(LocalizedStringKey("Vagetables")).tag("Vagetables")
                        }
                        Group {
                            Text(LocalizedStringKey("Fat & Oil")).tag("Fat & Oil")
                            Text(LocalizedStringKey("Drinks")).tag("Drinks")
                            
                            Text(LocalizedStringKey("Uncategorized")).tag("Uncategorized")
                            Text(LocalizedStringKey("Fruit")).tag("Fruit")
                        }
                        Group {
                            Text(LocalizedStringKey("Milk & Egg")).tag("Milk & Egg")
                            Text(LocalizedStringKey("Meat & Soy")).tag("Meat & Soy")
                            Text(LocalizedStringKey("Mushrooms")).tag("Mushrooms")
                            Text(LocalizedStringKey("Nuts & Seeds")).tag("Nuts & Seeds")
                        }
                    } .pickerStyle(.wheel)
                        .frame(minWidth: 0)
                        .clipped()
                }
                // MARK: - New item button
                if !vm.itemName.isEmpty {
                    Button {
                        if !vm.itemName.isEmpty {
                            withAnimation {
                                vm.addItem(folder: folder)
                                presentationMode.wrappedValue.dismiss()
                            }
                            vm.itemName = ""
                            vm.itemNumber = ""
                            vm.itemMeasurement = "it"
                            vm.itemCategory = "Uncategorized"
                        }
                    } label: {
                        Text(LocalizedStringKey("SAVE"))
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 150)
                            .background(Color("accent"))
                            .cornerRadius(20)
                    }
                }
                Spacer()
            } .padding(.horizontal)
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    static let entity = FolderEntity(context: context)
    
    static var previews: some View {
        AddItemView(folder: entity)
            .environmentObject(ViewModel())
    }
}
