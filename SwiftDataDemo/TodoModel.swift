//
//  TodoModel.swift
//  SwiftDataDemo
//
//  Created by Jacek Kosinski U on 13/09/2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class TodoModel {
    @Attribute(.unique)
    var id: UUID = UUID()
    var title: String = ""
    var content : String = ""
    var iconData: Data

    var icon: Image {
        if let uiImage = UIImage(data: iconData) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "questionmark.diamond.fill")
        }
    }

    var createDate: Date
    var isDone: Bool

    var tags: [Tag]

    init(title: String, content: String, iconData: UIImage,   tags: [Tag]) {
      //  self.id = id
        self.title = title
        self.content = content
        self.iconData = iconData.pngData() ?? Data()
        self.createDate = .now
     self.isDone = true
        self.tags = tags
    }
}


