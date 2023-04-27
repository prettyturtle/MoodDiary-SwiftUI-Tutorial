//
//  DiaryDetailViewModel.swift
//  SwiftUI_Tutorial1
//
//  Created by yc on 2023/04/27.
//

import Foundation
import SwiftUI

final class DiaryDetailViewModel: ObservableObject {
    
    @Published var diaries: Binding<[MoodDiary]>
    @Published var diary: MoodDiary
    
    init(diaries: Binding<[MoodDiary]>, diary: MoodDiary) {
        self.diaries = diaries
        self.diary = diary
    }
    
    func delete() {
        diaries.wrappedValue = diaries.wrappedValue.filter { $0.id != diary.id }
    }
}
