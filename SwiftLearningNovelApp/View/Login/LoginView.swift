//
//  LoginView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/04.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State var inputId = ""
    @State var inputPasswd = ""
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
                Button(action: {
                    print("ログインタップされたよ")
                    //                    presenter.didTapLoginButton()
                }){
                    Text("ログイン")
                        .padding()
                        .frame(width: 120, height: 50)
                        .background(Color(red:18/255,green:55/255,blue:42/255))
                        .foregroundColor(Color(red:251/255,green:250/255,blue:218/255))
                        .cornerRadius(.infinity)
                }
            }
            // ヘッダー部分を overlay で配置
            VStack{
                    HStack {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Home")
                        }
                        .frame(width: 100) // 左側の固定幅を設定
                        
                        Spacer()
                        
                        VStack{
                            Text("ログイン")
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        Spacer()
                        
                        // 右側の空きスペース（将来ボタン等を追加する想定で配置）
                        HStack {}.frame(width: 100) // 右側も左と同じ幅を確保
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 67/255, green: 104/255, blue: 80/255).opacity(0.7))
                    .frame(height: 40) // ヘッダーの高さを調整
                    Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        return LoginView()
            .environmentObject(appState)
    }
}
