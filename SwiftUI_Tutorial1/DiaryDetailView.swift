//
//  DiaryDetailView.swift
//  SwiftUI_Tutorial1
//
//  Created by yc on 2023/04/25.
//

import SwiftUI

struct DiaryDetailView: View {
    
    @StateObject var vm: DiaryDetailViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack(spacing: 50.0) {
                    Text(formattedDate(dateString: vm.diary.date))
                        .font(.system(size: 30.0, weight: .bold))
                    
                    Image(systemName: vm.diary.mood.imageName)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .black.opacity(0.2), radius: 10.0)
                        .frame(height: 80.0)
                    
                    Text(vm.diary.text)
                        .font(.system(size: 20.0, weight: .medium))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
            
            HStack {
                Button {
                    print("Delete Button Tapped")
                    vm.delete()
                } label: {
                    Image(systemName: "trash")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20.0)
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.leading, 32.0)
                
                Spacer()
            }
        }
        
    }
}

extension DiaryDetailView {
    private func formattedDate(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let date = formatter.date(from: dateString)
        
        formatter.dateFormat = "EEE, MMM d, yyyy"
        return formatter.string(from: date!)
    }
}

struct DiaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryDetailView(vm: DiaryDetailViewModel(diaries: .constant(MoodDiary.list), diary: MoodDiary.list.first!))
    }
}
