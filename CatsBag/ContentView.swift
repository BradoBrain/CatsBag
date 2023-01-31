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
            if #available(iOS 16.0, *) {
                ZStack(alignment: .top) {
                    VStack {
                        TopBarView()
                        
                        FolderView()
                    }
                } .toolbar(.hidden)
            } else {
                ZStack(alignment: .top) {
                    VStack {
                        TopBarView()
                        
                        FolderView()
                    }
                } .navigationBarHidden(true)
            }
        } .accentColor(Color("accent"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
