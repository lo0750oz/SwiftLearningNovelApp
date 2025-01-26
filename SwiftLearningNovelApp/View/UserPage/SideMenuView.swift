//
//  SideMenuView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/12/08.
//

import Foundation
import SwiftUI

struct SideMenuView: View {
    @Binding var isOpen: Bool
    @EnvironmentObject var appState: AppState
    private let userDefaultsManager = UserDefaultsManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 背景の半透明なオーバーレイ
                if isOpen {
                    Color.black.opacity(isOpen ? 0.3 : 0)
                        .ignoresSafeArea()
                        .animation(.easeInOut(duration: 0.3), value: isOpen)
                        .onTapGesture {
                            // 背景タップでサイドメニューを閉じる
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.isOpen = false
                            }
                        }
                }
                
                // サイドメニュー本体
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Button(action: {
                            appState.isLogin = false
                            userDefaultsManager.removeUser()
                            appState.removeNovelData()
                            print("ログアウト")
                        }) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("ログアウト")
                            }
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                        }
                        
                        Divider()
                        
                        Button(action: {
                            print("設定")
                        }) {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                Text("設定")
                            }
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                        }
                    }
                    .padding()
                    .frame(width: 250)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .background(Color.mainCream)
                    .offset(x: isOpen ? 0 : -250) // 閉じたときは画面外
                    .animation(.easeInOut(duration: 0.3), value: isOpen) // 開閉アニメーション
                    
                    Spacer()
                }
            }
        }
    }
}
