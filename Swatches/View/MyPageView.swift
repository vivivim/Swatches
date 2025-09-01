//
//  MyPageView.swift
//  Swatches
//
//  Created by Admin on 8/28/25.
//

import SwiftUI

struct MyPageView: View {
    @Binding var currentUserID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("로그인된 이메일: ")
                Text("\(currentUserID ?? UUID())")
                Button(action: {
                    UserDefaults.standard.removeObject(forKey: "currentUserID")
                    currentUserID = nil
                }) {
                    Text("로그아웃")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .navigationTitle(Text("마이페이지"))
        }
    }
}

#Preview {
    @Previewable @State var currentUserID: UUID? = nil
    MyPageView(currentUserID: $currentUserID)
}
