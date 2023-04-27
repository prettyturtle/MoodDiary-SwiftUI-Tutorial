//
//  DiaryListViewModel.swift
//  SwiftUI_Tutorial1
//
//  Created by yc on 2023/04/25.
//

import Foundation
import Combine

final class DiaryListViewModel: ObservableObject {
    
    let storage: MoodDiaryStorage
    
    @Published var list: [MoodDiary] = []
    @Published var dic: [String: [MoodDiary]] = [:]
    
    var subscriptions = Set<AnyCancellable>()
    
    init(storage: MoodDiaryStorage) {
        self.storage = storage
        
        bind()
    }
    
    var keys: [String] {
        return dic.keys.sorted { $0 < $1 }
    }
    
    private func bind() {
        $list
            .print("[DiaryListViewModel]")
            .sink { items in
                self.dic = Dictionary(grouping: items, by: { $0.monthlyIdentifier })
                self.persist(items: items)
            }
            .store(in: &subscriptions)
    }
    
    func persist(items: [MoodDiary]) {
        guard !items.isEmpty else {
            return
        }
        
        storage.persist(items)
    }
    
    func fetch() {
        list = storage.fetch()
    }
}
