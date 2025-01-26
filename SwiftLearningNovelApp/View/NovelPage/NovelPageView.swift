//
//  NovelPageView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/13.
//

import SwiftUI

struct NovelPageView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.mainCream.ignoresSafeArea()
            
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
                        Text(appState.viewNovelData?.title ?? "デフォルトタイトル")
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
            .zIndex(3)
            
            ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(appState.noveltexts, id: \.self) {
                            text in
                            Text(text)
                                .padding([.leading, .trailing], 30)
                            Divider()
                        }
                        Spacer()
                    }
                    .padding(.top, 50)
                }
                .padding(.top, 10)
            }
            
            ZStack{
                // 円形ボタン
                Button(action: {
                    print("円形ボタンが押されました")
                    appState.navigationPath.append("AddNewNovelTextView")
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
            .navigationBarHidden(true)
        }
        
    }
}

#Preview {
    NovelPageView()
}
