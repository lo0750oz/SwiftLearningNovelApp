//
//  HomeView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/01.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    var presenter: HomePresenterProtocol
    var body: some View {
        ZStack{
            Color(red:251/255,green:250/255,blue:218/255).ignoresSafeArea()
            VStack(spacing: 0){
                Text("小説リレー")
                    .font(.system(size: 65, weight: .semibold, design: .default ))
                    .padding(.bottom, 50)
                    .foregroundColor(Color(red:18/255,green:55/255,blue:42/255))
                ZStack{
                    if appState.isLogin {
                        HStack{
                            Button(action: {
                                print("マイページへタップされたよ")
                                presenter.didTapUserPageViewButton()
                            }){
                                Text("マイページへ")
                                    .padding()
                                    .frame(width: 150, height: 50)
                                    .foregroundColor(Color(red:18/255,green:55/255,blue:42/255))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color(red:18/255,green:55/255,blue:42/255), lineWidth: 1)
                                    )
                            }
                        }
                    }else{
                        HStack{
                            Button(action: {
                                print("ログインタップされたよ")
                                presenter.didTapLoginButton()
                            }){
                                Text("ログイン")
                                    .padding()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50)
                                    .foregroundColor(Color(red:18/255,green:55/255,blue:42/255))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color(red:18/255,green:55/255,blue:42/255), lineWidth: 1)
                                    )
                            }
                            Button(action: {
                                print("新規登録タップされたよ")
                                presenter.didTapUserRegisterButton()
                            }){
                                Text("新規登録")
                                    .padding()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50)
                                    .foregroundColor(Color(red:18/255,green:55/255,blue:42/255))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color(red:18/255,green:55/255,blue:42/255), lineWidth: 1)
                                    )
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        let router = HomeRouter()
        let presenter = HomePresenter(router: router, appState: appState)
        HomeView(presenter: presenter).environmentObject(appState)
    }
}
