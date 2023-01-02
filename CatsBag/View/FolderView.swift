//
//  FolderView.swift
//  CatsBag
//
//  Created by Artem Vinogradov on 30.12.2022.
//

import SwiftUI

/**
 FolderView is View to create new folders and show list of them.
 
 On the view are text field to add new folder with name and foreach loop to show all items into a folder.
 */
struct FolderView: View {
    @EnvironmentObject var vm: ViewModel
    // Property wrapper to inject FolderEntity to the View
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \FolderEntity.name, ascending: true)],
                  animation: .default) private var folders: FetchedResults<FolderEntity>
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            
            List {
                // MARK: - TextField to add new folder with name
                Group {
                    TextField("Enter a name for the new folder", text: $vm.folderName)
                        .padding()
                        .font(.title3)
                        .foregroundColor(.black.opacity(0.6))
                        .background(Color("folderColor"))
                        .cornerRadius(15)
                        .onSubmit {
                            if !vm.folderName.isEmpty {
                                withAnimation {
                                    vm.addFolder()
                                }
                                vm.folderName = ""
                            }
                        } .submitLabel(.send)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color("background"))
                .padding(EdgeInsets(top: 20, leading: 15, bottom: 2, trailing: 15))
                // MARK: - List of folders
                ForEach(folders) { folder in
                    NavigationLink(destination: ItemView(folder: folder)) {
                        LabeledContent(folder.name ?? "", value: "\(folder.items?.count ?? 0)")
                            .foregroundColor(.black.opacity(0.6))
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        vm.deleteFolder(offsets: indexSet, folders: folders)
                    }
                }
                .padding()
                .font(.title3)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color("background"))
                .ignoresSafeArea(edges: .horizontal)
                .background(Color("folderColor"))
                .cornerRadius(15)
                .padding(EdgeInsets(top: 2, leading: 15, bottom: 2, trailing: 15))
            } .listStyle(.plain)
        }
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
            .environmentObject(ViewModel())
    }
}
