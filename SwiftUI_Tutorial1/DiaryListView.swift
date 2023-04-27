//
//  DiaryListView.swift
//  SwiftUI_Tutorial1
//
//  Created by yc on 2023/04/25.
//

import SwiftUI

struct DiaryListView: View {
    
    @StateObject var vm: DiaryListViewModel
    
    @State var isPresenting: Bool = false
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: layout) {
                        ForEach(vm.keys, id: \.self) { key in
                            Section {
                                let items = vm.dic[key] ?? []
                                
                                let orderedItems = items.sorted { $0.date < $1.date }
                                
                                ForEach(orderedItems) { item in
                                    NavigationLink {
                                        DiaryDetailView(vm: DiaryDetailViewModel(diaries: $vm.list, diary: item))
                                    } label: {
                                        MoodDiaryCell(diary: item)
                                            .frame(height: 50.0)
                                    }
                                }
                            } header: {
                                Text(formattedSectionTitle(key))
                                    .font(.system(size: 30.0, weight: .black))
                            }
                            .frame(height: 60.0)
                            .padding()
                        }
                    }
                }
                
                HStack {
                    Button {
                        print("New Button Tapped")
                        isPresenting = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30.0)
                    }
                    .frame(width: 80.0, height: 80.0)
                    .foregroundColor(.white)
                    .background(Color.pink)
                    .cornerRadius(40.0)
                }
            }
            
            
            .navigationTitle("Emotion Diary")
        }
        .sheet(isPresented: $isPresenting) {
            DiaryDateInputView(vm: DiaryViewModel(isPresented: $isPresenting, diaries: $vm.list))
        }
        .onAppear {
            vm.fetch()
        }
    }
}

extension DiaryListView {
    private func formattedSectionTitle(_ id: String) -> String {
        let dateComponents = id
            .components(separatedBy: "-")
            .compactMap{ Int($0) }
        
        guard let year = dateComponents.first, let month = dateComponents.last else {
            return id
        }
        
        let calendar = Calendar(identifier: .gregorian)
        let dateComponent = DateComponents(calendar: calendar, year: year, month: month)
        let date = dateComponent.date!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

struct DiaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView(vm: DiaryListViewModel(storage: MoodDiaryStorage()))
    }
}
