//
//  DiaryModeInputView.swift
//  SwiftUI_Tutorial1
//
//  Created by yc on 2023/04/25.
//

import SwiftUI

struct DiaryModeInputView: View {
    
    @StateObject var vm: DiaryViewModel
    
    let moods: [Mood] = Mood.allCases
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                ForEach(moods, id: \.self) { mood in
                    Button {
                        print("Mood selected")
                        vm.mood = mood
                    } label: {
                        VStack {
                            Image(systemName: mood.imageName)
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80.0)
                                .shadow(color: .black.opacity(0.2), radius: 10.0)
                                .padding()
                            
                            Text(mood.name)
                                .foregroundColor(.gray)
                        }
                        .frame(height: 180.0)
                        .background(mood == vm.mood ? Color.gray.opacity(0.4) : Color.clear)
                        .cornerRadius(10.0)
                    }
                }
            }
            .padding()
            
            Spacer()
            
            NavigationLink {
                DiaryTextInputView(vm: vm)
            } label: {
                Text("Next")
                    .frame(width: 200.0, height: 80.0)
                    .foregroundColor(.white)
                    .background(Color.pink)
                    .cornerRadius(40.0)
            }
        }
    }
}

struct DiaryModeInputView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryModeInputView(vm: DiaryViewModel(isPresented: .constant(false), diaries: .constant(MoodDiary.list)))
    }
}
