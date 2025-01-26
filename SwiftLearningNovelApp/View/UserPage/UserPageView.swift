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
    let makeNewNovelPresenter: MakeNewNovelPresenterProtocol
    let AddNewNovelTextPresenter: AddNewNovelTextPresenterProtocol
    @State private var user: UserData? = nil
    private let userDefaultsManager = UserDefaultsManager()
    
    var body: some View {
        NavigationStack(path: $appState.navigationPath) {
            ZStack(alignment: .bottomTrailing) {
                Color(red:251/255,green:250/255,blue:218/255).ignoresSafeArea()
                
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
                    .background(Color.middeleGreen)
                    .frame(height: 40) // ヘッダーの高さを調整
                    
                    ScrollView {
                        VStack{
                            VStack {
                                // novelData の数だけ NovelSpaceButtonView を表示
                                ForEach(appState.novelData) { novel in
                                    NovelSpaceButtonView(novelData: novel, presenter: presenter )
                                }
                            }
                        }
                    }
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                // サイドメニュー
                SideMenuView(isOpen: $isOpenSideMenu)
                    .environmentObject(appState)
                    .zIndex(1) // サイドメニューを前面に表示
                
                ZStack{
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
                    .zIndex(2)
                }
                .navigationDestination(for: String.self) { destination in
                    if destination == "MakeNewNovelView" {
                        MakeNewNovelView(presenter: makeNewNovelPresenter)
                    } else if destination == "NovelPageView" {
                        NovelPageView()
                    } else if destination == "AddNewNovelTextView" {
                        AddNewNovelTextView(presenter: AddNewNovelTextPresenter)
                    }
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
        let apiClient = APIClient()
        let router = UserPageRouter()
        let interactor = UserPageInteractor(appState: appState, apiClient: apiClient)
        let presenter = UserPagePresenter(router: router, appState: appState, interactor: interactor)
        let makeNewNovelrouter = MakeNewNovelRouter()
        let loginInteractor = LoginInteractor(apiClient: apiClient, appState: appState)
        let makeNewNovelInteractor = MakeNewNovelInteractor(apiClient: apiClient, appState: appState, loginInteractor: loginInteractor)
        let makeNewNovelPresenter = MakeNewNovelPresenter(interactor: makeNewNovelInteractor, loginInteractor: loginInteractor, router: makeNewNovelrouter, appState: appState)
        let AddNewNovelTextInteractor = AddNewNovelTextInteractor(apiClient: apiClient, appState: appState)
        let AddNewNovelTextRouter = AddNewNovelTextRouter()
        let AddNewNovelTextPresenter = AddNewNovelTextPresenter(interactor: AddNewNovelTextInteractor, router: AddNewNovelTextRouter, appState: appState)
        UserPageView(presenter: presenter, makeNewNovelPresenter: makeNewNovelPresenter, AddNewNovelTextPresenter: AddNewNovelTextPresenter).environmentObject(appState)
    }
}
