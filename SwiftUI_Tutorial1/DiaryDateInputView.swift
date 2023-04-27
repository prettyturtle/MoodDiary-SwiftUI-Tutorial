//
//  DiaryDateInputView.swift
//  SwiftUI_Tutorial1
//
//  Created by yc on 2023/04/25.
//

import SwiftUI

struct DiaryDateInputView: View {
    
    @StateObject var vm: DiaryViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Start Date",
                    selection: $vm.date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding(SwiftUI.EdgeInsets(top: 32.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
                
                Spacer()
                
                NavigationLink {
                    DiaryModeInputView(vm: vm)
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
}

struct DiaryDateInputView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryDateInputView(vm: DiaryViewModel(isPresented: .constant(false), diaries: .constant(MoodDiary.list)))
    }
}
