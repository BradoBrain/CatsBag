//
//  ContentView.swift
//  CatsBag
//
//  Created by Artem Vinogradov on 30.12.2022.
//

import SwiftUI


/// ContentView is main View. Root of navigation stack.
struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    TopBarView()
                    
                    FolderView()
                }
            } .toolbar(.hidden)
        } .accentColor(Color("accent"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
