//
//  AddNewNovelTextView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/25.
//

import SwiftUI

struct AddNewNovelTextView: View {
    @EnvironmentObject var appState: AppState
    var presenter: AddNewNovelTextPresenterProtocol
    @State var newText = ""
    
    var body: some View {
        ZStack {
            Color.mainCream.ignoresSafeArea()
            
            // ヘッダー部分を overlay で配置
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        print("閉じるボタンが押されました")
                        appState.navigationPath.removeLast()
                    }){
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                            Text("閉じる")
                        }
                        .foregroundColor(.black)
                    }
                    .frame(width: 100) // 左側の固定幅を設定
                    
                    Spacer()
                    
                    VStack{
                        Text("テキスト作成")
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
            
            VStack(spacing: 25){
                TextEditor(text: $newText)
                    .padding()
                    .multilineTextAlignment(.leading)
                    .frame(width: 380, height: 600)
                    .scrollContentBackground(Visibility.hidden)
                    .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.mainCream) // 背景色を指定
                        )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.deeepGreen, lineWidth: 1)
                    )
                Button(action: {
                    print("追加タップされたよ")
                    presenter.didTapAddButton(text: newText)
                }){
                    Text("追加")
                        .padding()
                        .frame(width: 120, height: 50)
                        .background(Color.deeepGreen)
                        .foregroundColor(Color.mainCream)
                        .cornerRadius(.infinity)
                }
            }
            .padding(.top, 80) // ヘッダーとのスペースを調整
            .padding(.horizontal, 16)
            
            Spacer() // 画面の余白を調整
        }
        .navigationBarHidden(true)
    }
}


struct AddNewNovelTextView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        let apiClient = APIClient()
        let interactor = AddNewNovelTextInteractor(apiClient: apiClient, appState: appState)
        let router = AddNewNovelTextRouter()
        let presenter = AddNewNovelTextPresenter(interactor: interactor, router: router, appState: appState)
        AddNewNovelTextView(presenter: presenter).environmentObject(appState)
    }
}
