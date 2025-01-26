//
//  MakeNewNovelView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/02.
//

import SwiftUI

struct MakeNewNovelView: View {
    @EnvironmentObject var appState: AppState
    var presenter: MakeNewNovelPresenterProtocol
    @State var novelTitle = ""
    @State var memberId = ""
    var body: some View {
        ZStack{
            Color.mainCream.ignoresSafeArea()
            
            VStack(spacing: 25){
                TextField("タイトル", text: $novelTitle)
                    .padding()
                    .frame(width: 220, height: 50)
                    .foregroundColor(Color.deeepGreen)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.deeepGreen, lineWidth: 1)
                    )
                TextField("メンバーID", text: $memberId)
                    .padding()
                    .frame(width: 220, height: 50)
                    .foregroundColor(Color.deeepGreen)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.deeepGreen, lineWidth: 1)
                    )
                Button(action: {
                    print("新規作成タップされたよ")
                    presenter.didTapAddNewNovelButton(title: novelTitle, id: memberId)
                }){
                    Text("新規作成")
                        .padding()
                        .frame(width: 120, height: 50)
                        .background(Color.deeepGreen)
                        .foregroundColor(Color.mainCream)
                        .cornerRadius(.infinity)
                }
            }
            
            // ヘッダー部分を overlay で配置
            VStack{
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
                        Text("小説新規作成")
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Spacer()
                    
                    // 右側の空きスペース（将来ボタン等を追加する想定で配置）
                    HStack {}.frame(width: 100) // 右側も左と同じ幅を確保
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.middeleGreen)
                .frame(height: 40) // ヘッダーの高さを調整
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
    }
}


struct MakeNewNovelView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        let apiClient = APIClient()
        let router = MakeNewNovelRouter()
        let loginInteractor = LoginInteractor(apiClient: apiClient, appState: appState)
        let interactor = MakeNewNovelInteractor(apiClient: apiClient, appState: appState, loginInteractor: loginInteractor)
        let presenter = MakeNewNovelPresenter(interactor: interactor, loginInteractor: loginInteractor, router: router, appState: appState)
        MakeNewNovelView(presenter: presenter).environmentObject(appState)
    }
}
