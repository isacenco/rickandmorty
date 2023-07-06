//
//  DetailDataView.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 5/7/23.
//

import SwiftUI

struct DetailDataView: View {
    
    let title: String?
    let description: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title ?? "-").foregroundColor(Color(hex: Colors.silverChaliceHex))
            Spacer().frame(maxHeight: 5)
            Text(description ?? "text_unknown")
        }.padding(.horizontal).padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DetailDataView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDataView(title: "Title", description: "Description")
    }
}
