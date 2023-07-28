//
//  SearchResultView.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct SearchResultView: View {
    
    @StateObject private var network = RequestAPIYouTubeBigBox.shared
    @State var isShowDetailBoxView = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(network.YouTubeBigBoxList, id: \.self) { model in
                YouTubeBigBoxView(model: model)
                    .onTapGesture {
                        isShowDetailBoxView = true
                    }
            }
        }
        .fullScreenCover(isPresented: $isShowDetailBoxView) {
            YouTubeDetailBoxView()
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView()
    }
}
