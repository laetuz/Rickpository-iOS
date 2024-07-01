//
//  CharacterRow.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation

import SwiftUI
import CachedAsyncImage

struct CharacterRow: View {

    var category: CharacterModel
    var body: some View {
        VStack {
            imageCategory
            content
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 250)
        .background(Color.random.opacity(0.3))
        .cornerRadius(30)
    }
}

extension CharacterRow {

    var imageCategory: some View {
        CachedAsyncImage(url: URL(string: category.image)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.cornerRadius(30).scaledToFit().frame(width: 200).padding(.top)
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(category.name)
                    .font(.title)
                    .bold()
                    .lineLimit(1)
                Spacer()
            }
            
            
            Text("\(category.species), \(category.status)")
                .font(.system(size: 14))
                .lineLimit(2)
        }
        .padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
    }
}
