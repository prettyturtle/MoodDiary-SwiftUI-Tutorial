//
//  SwiftUI_Tutorial1App.swift
//  SwiftUI_Tutorial1
//
//  Created by yc on 2023/04/25.
//

import SwiftUI

@main
struct SwiftUI_Tutorial1App: App {
    var body: some Scene {
        WindowGroup {
            DiaryListView(vm: DiaryListViewModel(storage: MoodDiaryStorage()))
        }
    }
}
