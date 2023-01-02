//
//  ItemView.swift
//  CatsBag
//
//  Created by Artem Vinogradov on 30.12.2022.
//

import SwiftUI

/**
 ItemView is View to create new items and show list of them.
 
 All items have folderName attribute to filter them by folder.
 
 - NAVIGATION:
    - AddItemView
    - UpdateItemView
 
 */
struct ItemView: View {
    @EnvironmentObject var vm: ViewModel
    // Current folder object to filter item by folderName
    @StateObject var folder: FolderEntity
    // Property wrapper to inject ItemEntity to the View
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ItemEntity.done, ascending: true),
                          NSSortDescriptor(keyPath: \ItemEntity.category, ascending: false)],
        animation: .default) private var items: FetchedResults<ItemEntity>
    // Flags to show Add/UpdateItemView
    @State private var showUpdateView = false
    @State private var showAddView = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("background").ignoresSafeArea()
            
            List {
                ForEach(items, id: \.id) { item in
                    Group {
                        if item.folderName == folder.name {
                            NavigationLink(destination: UpdateItemView(item: item)) {
                                HStack {
                                    Text(item.name ?? "Error: item.name is nil")
                                    Spacer()
                                    Text(item.number ?? "Error: item.number is nil")
                                    Text(item.measurement ?? "Error: item.measurement is nil")
                                }
                            }
                            .bold()
                            .strikethrough(item.done, pattern: .solid, color: .gray)
                            .foregroundColor(item.done ? .gray : .black.opacity(0.5))
                            .font(.title3)
                            .padding()
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color("background"))
                            .ignoresSafeArea(edges: .horizontal)
                            .background(item.done ? Color("boughtItem") : vm.getColor(item: item))
                            .cornerRadius(15)
                            .padding(EdgeInsets(top: 2, leading: 15, bottom: 2, trailing: 15))
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(action: {
                            item.done.toggle()
                        }, label: {
                            Image(systemName: "basket.fill")
                        })
                        .tint(item.done ? Color.gray : Color.green)
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        vm.deleteItems(offsets: indexSet, items: items)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            // MARK: - Button to show AddItemView as modal View
            Button {
                self.showAddView.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 54))
            } .sheet(isPresented: $showAddView) {
                AddItemView(folder: folder)
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    static let folderEntity = FolderEntity(context: context)
    
    static var previews: some View {
        ItemView(folder: folderEntity)
            .environmentObject(ViewModel())
    }
}
