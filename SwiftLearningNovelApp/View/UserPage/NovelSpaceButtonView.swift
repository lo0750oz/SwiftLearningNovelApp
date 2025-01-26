//
//  NovelSpaceButtonView.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/13.
//

import SwiftUI

struct NovelSpaceButtonView: View {
    var novelData: NovelData
    var presenter: UserPagePresenterProtocol
    
    var body: some View {
        Button(action: {
            // ボタンがタップされたときのアクションをここに追加
            print("Button tapped")
            presenter.didTapToNovelPageButton(novelData: novelData)
        }) {
            HStack{
                Spacer()
                Text("title:")
                Text("\(novelData.title)")
                    .bold()
                Spacer()
                VStack{
                    Text("\(novelData.memberOne)")
                    Text("\(novelData.memberTwo)")
                }
            }
            .frame(width: 350)
            .padding()
            .background(Color.mainCream)
            .foregroundColor(Color.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.middeleGreen, lineWidth: 2)
            )
        }
    }
}

struct NovelSpaceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        // titleSampleの代わりに文字列を直接渡す
        let appState = AppState()
        let router = UserPageRouter()
        let apiClient = APIClient()
        let interactor = UserPageInteractor(appState: appState, apiClient: apiClient)
        let presenter = UserPagePresenter(router: router, appState: appState, interactor: interactor)
        let novelData = NovelData(id: "XXXX", title: "Sample", memberOne: "member1", memberTwo: "member2")
        NovelSpaceButtonView(novelData: novelData, presenter: presenter)
    }
}
