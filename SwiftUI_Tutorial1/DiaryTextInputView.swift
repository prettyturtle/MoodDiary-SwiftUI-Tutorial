//
//  DiaryTextInputView.swift
//  SwiftUI_Tutorial1
//
//  Created by yc on 2023/04/26.
//

import SwiftUI

struct DiaryTextInputView: View {
    
    @StateObject var vm: DiaryViewModel
    @FocusState var focused: Bool
    
    var body: some View {
        VStack {
            TextEditor(text: $vm.text)
                .focused($focused)
                .border(.gray.opacity(0.2), width: 2.0)
                .onAppear {
                    focused = true
                }
            
            Button {
                vm.completed()
            } label: {
                Text("Done")
                    .frame(width: 200.0, height: 80.0)
                    .foregroundColor(.white)
                    .background(Color.pink)
                    .cornerRadius(40.0)
            }
        }
        .padding()
    }
}

struct DiaryTextInputView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryTextInputView(vm: DiaryViewModel(isPresented: .constant(false), diaries: .constant(MoodDiary.list)))
    }
}
