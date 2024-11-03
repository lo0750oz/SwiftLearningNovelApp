//
//  UserRegisterView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/21.
//

import SwiftUI

struct UserRegisterView: View {
    @EnvironmentObject var appState: AppState
    @State var inputId = ""
    @State var inputPasswd = ""
    @State var mailAdresss = ""
    var body: some View {
        ZStack{
            Color(red:251/255,green:250/255,blue:218/255).ignoresSafeArea()
            VStack(spacing: 25){
                TextField("ユーザーID", text: $inputId)
                    .padding()
                    .frame(width: 220, height: 50)
                    .foregroundColor(Color(red:18/255,green:55/255,blue:42/255))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red:18/255,green:55/255,blue:42/255), lineWidth: 1)
                    )
                TextField("パスワード", text: $inputPasswd)
                    .padding()
                    .frame(width: 220, height: 50)
                    .foregroundColor(Color(red:18/255,green:55/255,blue:42/255))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red:18/255,green:55/255,blue:42/255), lineWidth: 1)
                    )
                TextField("メールアドレス", text: $mailAdresss)
                    .padding()
                    .frame(width: 220, height: 50)
                    .foregroundColor(Color(red:18/255,green:55/255,blue:42/255))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red:18/255,green:55/255,blue:42/255), lineWidth: 1)
                    )
                Button(action: {
                    print("新規登録タップされたよ")
//                    presenter.didTapLoginButton()
                }){
                    Text("新規登録")
                        .padding()
                        .frame(width: 120, height: 50)
                        .background(Color(red:18/255,green:55/255,blue:42/255))
                        .foregroundColor(Color(red:251/255,green:250/255,blue:218/255))
                        .cornerRadius(.infinity)
                }
            }
        }
    }
}

struct UserRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        return UserRegisterView()
            .environmentObject(appState)
    }
}
