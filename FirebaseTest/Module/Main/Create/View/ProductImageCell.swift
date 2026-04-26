//
//  ProductImageCell.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 26/04/26.
//

import SwiftUI
import UIKit

struct ProductImageCell: View {
    let image: UIImage
    var closeBtnPressed:(()->(Void))?
    var body: some View {
        ZStack(alignment:.topTrailing){
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100,height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
            Button {
                closeBtnPressed?()
            } label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 20,height: 20)
                    .tint(.green)
                    .padding()
                
            }

        }
    }
}

#Preview {
    ProductImageCell(image: UIImage(systemName: "camera")!)
}
