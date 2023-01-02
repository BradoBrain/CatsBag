//
//  navBarView.swift
//  CatsBag
//
//  Created by Artem Vinogradov on 02.01.2023.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        ZStack {
            Color("toolBarColor")
            
            Image("toolBarImage")
                .resizable()
                .edgesIgnoringSafeArea(.top)
                .aspectRatio(contentMode: .fill)
                .opacity(0.5)
        } .frame(height: 40)
    }
}

struct navBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
