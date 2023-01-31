//
//  UpdateItemView.swift
//  CatsBag
//
//  Created by Artem Vinogradov on 30.12.2022.
//

import SwiftUI

struct UpdateItemView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var item: ItemEntity
    
    @State var updateName = ""
    @State var updateNumber = ""
    @State var updateMeasurement = "it"
    @State var updateCategory = "Uncategorized"
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            
            VStack(spacing: 30) {
                // MARK: - Add item section
                HStack {
                    TextField(item.name ?? "", text: $updateName)
                        .padding()
                        .foregroundColor(.black.opacity(0.6))
                        .background(Color("folderColor"))
                        .cornerRadius(20)
                    
                    TextField(item.number ?? "", text: $updateNumber)
                        .padding()
                        .frame(width: 100)
                        .foregroundColor(.black.opacity(0.6))
                        .background(Color("folderColor"))
                        .cornerRadius(20)
                        .keyboardType(.decimalPad)
                }
                
                HStack {
                    Picker("Measurement", selection: $updateMeasurement) {
                        Text(LocalizedStringKey("Ounce")).tag("oz")
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
                    
                    Picker("Categories", selection: $updateCategory) {
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
                
                if !updateName.isEmpty {
                    Button {
                        if !updateName.isEmpty {
                            withAnimation {
                                vm.updateItem(item: item, name: updateName, number: updateNumber, measurement: updateMeasurement, category: updateCategory)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    } label: {
                        Text("UPDATE")
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

struct UpdateItemView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    static let entity = ItemEntity(context: context)
    
    static var previews: some View {
        UpdateItemView(item: entity)
            .environmentObject(ViewModel())
    }
}
