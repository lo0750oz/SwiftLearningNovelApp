//
//  HomeView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/01.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        VStack{
            Text("小説リレー")
            ZStack{
                if appState.isLogin {
                    UserPageView()
                }else{
                Text("ログイン").onTapGesture {
                    print("タップされたよ");
                }
               }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppState())
    }
}

#Preview {
    HomeView()
}
