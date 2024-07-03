//
//  AboutView.swift
//  Rickpository
//
//  Created by Ryo Martin on 04/07/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Image("martin")
            .resizable()
            .renderingMode(.original)
            .scaledToFit()
            .frame(width: 250)
            .cornerRadius(50)
        mediumTitle("Name").padding([.top])
        Text("Ryo Martin")
        mediumTitle("Location").padding([.top])
        Text("Bandar Lampung, Indonesia")
        mediumTitle("Profession").padding([.top])
        Text("Undergraduate/Android and iOS Developer")
    }
}

extension AboutView {
    func mediumTitle(_ title: String) -> some View {
        Text(title).font(.headline)
    }
}

#Preview {
    AboutView()
}
