//
//  StatView.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI

struct StatView: View {
    let titleValue: String
    let subtitleValue: String
    var body: some View {
        HStack{
            VStack(alignment:.leading,spacing:12){
                Text(titleValue)
                    .bold()
                Text(subtitleValue)
            }
            Spacer()
        }.frame(maxWidth: .infinity).padding().background(.white).clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

#Preview {
    StatView(titleValue: "Items Sold", subtitleValue: "100000")
}
