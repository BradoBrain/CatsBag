//
//  CatsBagApp.swift
//  CatsBag
//
//  Created by Artem Vinogradov on 30.12.2022.
//

import SwiftUI

@main
struct CatsBagApp: App {
    // Add environment to manage ScenePhase
    @Environment(\.scenePhase) var scenePhase
    // Add environment to get access to ViewModel from all View. CatsBag is now root view.
    @StateObject var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, vm.context)
                .environmentObject(vm)
        }
        // Managing of ScenePhase
        .onChange(of: scenePhase) { newScene in
            switch newScene {
            case .background:
                print("\(scenePhase)")
                vm.save()
            case .inactive:
                print("\(scenePhase)")
            case .active:
                print("\(scenePhase)")
            @unknown default:
                print("\(scenePhase)")
                vm.save()
            }
        }
    }
}
