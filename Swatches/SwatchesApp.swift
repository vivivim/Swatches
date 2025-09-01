//
//  SwatchesApp.swift
//  Swatches
//
//  Created by Admin on 8/27/25.
//

import SwiftUI
import SwiftData

@main
struct SwatchesApp: App {
    // 로그인 상태
//    @State var isLoggedIn: Bool = false
    @State var currentUserID: UUID? = {
        if let idString = UserDefaults.standard.string(forKey: "currentUserID"), let id = UUID(uuidString: idString) {
            return id
        }
        return nil
    }()
    
    // 스위프트 데이터 컨테이너
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Swatch.self,
            User.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Unable to create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            if currentUserID != nil {
                SwatchListView(currentUserID: $currentUserID)
            } else {
                AuthView(currentUserID: $currentUserID)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
