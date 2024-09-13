//
//  Tag.swift
//  SwiftDataDemo
//
//  Created by Jacek Kosinski U on 13/09/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Tag {
    var name: String
    var color: TagColor
    @Relationship(inverse: \TodoModel.tags) var todos: [TodoModel]

    init(name: String, color: TagColor, todos: [TodoModel]) {
        self.name = name
        self.color = color
        self.todos = todos
    }
}

enum TagColor: Codable, CaseIterable {
    case red
    case blue
    case mint
    case orange

    var color: Color {
        switch self {
        case .red:
            return .red
        case .blue:
            return .blue
        case .mint:
            return .mint
        case .orange:
            return .orange
        }
    }
}
