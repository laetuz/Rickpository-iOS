//
//  CustomView.swift
//  Rickpository
//
//  Created by Ryo Martin on 03/07/24.
//

import SwiftUI

struct CustomIcon: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 28))
                .foregroundColor(.orange)
            
            Text(title)
                .font(.caption)
                .padding(.top, 8)
        }
    }
}
