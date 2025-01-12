//
//  UserRegisterView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/21.
//

import SwiftUI

struct UserRegisterView: View {
    @EnvironmentObject var appState: AppState
    var presenter: UserRegisterPresenterProtocol
    @State var inputPasswd = ""
    @State var inputMail = ""
    //    @State private var user: UserData? = nil
    private let userDefaultsManager = UserDefaultsManager()
    
    @AppStorage("storedUser")private var storedUserData: String = ""
    @AppStorage("login")private var isLogin: Bool = false
    
    var body: some View {
        ZStack{
            Color(.main).ignoresSafeArea()
            VStack(spacing: 25){
                if isLogin {
                    Text("新規登録が完了しました")
                    if let user = decodeUserData(from: storedUserData) {
                        Text("ユーザーID: \(user.id)")
                    }
                    Button(action: {
                        print("マイページへ遷移")
                        presenter.didTaptoUserPageButton()
                    }){
                        Text("マイページへ")
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(Color.deeepGreen)
                            .foregroundColor(Color.mainCream)
                            .cornerRadius(.infinity)
                    }
                    
                } else {
                    SecureField("パスワード", text: $inputPasswd)
                        .padding()
                        .frame(width: 220, height: 50)
                        .foregroundColor(Color.mainGreen)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.mainGreen, lineWidth: 1)
                        )
                    TextField("メールアドレス", text: $inputMail)
                        .padding()
                        .frame(width: 220, height: 50)
                        .foregroundColor(Color.mainGreen)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.mainGreen, lineWidth: 1)
                        )
                    Button(action: {
                        print("新規登録タップされたよ")
                        presenter.didTapRegisterButton(password: inputPasswd, mail: inputMail)
                    }){
                        Text("新規登録")
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(Color.mainGreen)
                            .foregroundColor(Color.mainCream)
                            .cornerRadius(.infinity)
                    }
                }
            }
            
            // ヘッダー部分を overlay で配置
            VStack{
                HStack {
                    Button(action: {
                        print("戻るボタンが押されました")
                        presenter.didTapPageBackButton()
                    }){
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Home")
                        }
                        .foregroundColor(.black)
                    }
                    .frame(width: 100) // 左側の固定幅を設定
                    
                    Spacer()
                    
                    VStack{
                        Text("新規ユーザー登録")
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
    private func decodeUserData(from storedUserData: String) -> UserData? {
        print("ユーザーデフォルト確認：\(storedUserData)")
        guard let data = storedUserData.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(UserData.self, from: data)
    }
}

struct UserRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        let router = UserRegisterRouter()
        let apiClient = APIClient()
        let interactor = UserRegisterInteractor(apiClient: apiClient, appState: appState)
        let presenter = UserRegisterPresenter(router: router, appState: appState, interactor: interactor)
        UserRegisterView(presenter: presenter).environmentObject(appState)
    }
}
