//
//  DiaryViewModel.swift
//  SwiftUI_Tutorial1
//
//  Created by yc on 2023/04/25.
//

import Foundation
import SwiftUI
import Combine

final class DiaryViewModel: ObservableObject {
    
    @Published var diaries: Binding<[MoodDiary]>
    @Published var diary: MoodDiary = MoodDiary(date: "", text: "", mood: .great)
    
    @Published var date: Date = Date()
    @Published var mood: Mood = .great
    @Published var text: String = ""
    @Published var isPresented: Binding<Bool>
    
    var subscriptions = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>, diaries: Binding<[MoodDiary]>) {
        self.isPresented = isPresented
        self.diaries = diaries
        
        $date.sink { date in
            print("---> selected: \(date)")
            
            self.update(date: date)
        }.store(in: &subscriptions)
        
        $mood.sink { mood in
            self.update(mood: mood)
        }.store(in: &subscriptions)
        
        $text.sink { text in
            self.update(text: text)
        }.store(in: &subscriptions)
    }
    
    
    func update(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        diary.date = formatter.string(from: date)
    }
    
    func update(mood: Mood) {
        diary.mood = mood
    }
    
    func update(text: String) {
        diary.text = text
    }
    
    func completed() {
        guard diary.date.isEmpty == false else {
            return
        }
        
        diaries.wrappedValue.append(diary)
        
        isPresented.wrappedValue = false
    }
}
