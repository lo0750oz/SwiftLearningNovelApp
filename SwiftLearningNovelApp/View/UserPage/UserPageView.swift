//
//  UserPageView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/04.
//

import SwiftUI

struct UserPageView: View {
    @EnvironmentObject var appState: AppState
    @State var isOpenSideMenu: Bool = false
    var presenter: UserPagePresenterProtocol
    @State private var user: UserData? = nil
    private let userDefaultsManager = UserDefaultsManager()
    
    var body: some View {
        NavigationStack(path: $appState.navigationPath) {
            ZStack(alignment: .bottomTrailing) {
                Color(red:251/255,green:250/255,blue:218/255).ignoresSafeArea()
                
                Text("ユーザー情報: \(user)")
                
                // ヘッダー部分を overlay で配置
                VStack{
                    HStack {
                        Button(action: {
                            // サイドメニューを開く
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isOpenSideMenu.toggle()
                            }
                        }){
                            HStack {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                            }
                            .foregroundColor(.black)
                        }
                        .frame(width: 40) // 左側の固定幅を設定
                        
                        
                        Spacer()
                        
                        VStack{
                            Text("マイページ")
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        Spacer()
                        
                        // 右側の空きスペース（将来ボタン等を追加する想定で配置）
                        HStack {}.frame(width: 40) // 右側も左と同じ幅を確保
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 67/255, green: 104/255, blue: 80/255).opacity(0.7))
                    .frame(height: 40) // ヘッダーの高さを調整
                    Spacer()
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                // サイドメニュー
                SideMenuView(isOpen: $isOpenSideMenu)
                    .environmentObject(appState)
                    .zIndex(1) // サイドメニューを前面に表示
                
                // 円形ボタン
                Button(action: {
                    print("円形ボタンが押されました")
                    presenter.didTapAddNovelButton()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color.mainCream)
                        .frame(width: 70, height: 70)
                        .background(Color.deeepGreen)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "MakeNewNovelView" {
                    MakeNewNovelView()
                }
            }
        }
        .onAppear {
            // ユーザー情報を読み込む
            self.user = userDefaultsManager.getUser()
        }
    }
}

struct UserPageView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        let router = UserPageRouter()
        let presenter = UserPagePresenter(router: router, appState: appState)
        UserPageView(presenter: presenter).environmentObject(appState)
    }
}
