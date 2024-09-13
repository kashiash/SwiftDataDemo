//
//  TodoMode+Data.swift
//  SwiftDataDemo
//
//  Created by Jacek Kosinski U on 13/09/2024.
//

import Foundation
import SwiftData
import SwiftUI

extension TodoModel {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: TodoModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let date = Date()

        container.mainContext.insert(TodoModel(title: "buy a mouse", content: "Todo Created on \(Date())",
                                               iconData: UIImage(systemName: "magicmouse")!,  tags: []))
        container.mainContext.insert(TodoModel(title: "order keyboard", content: "Todo Created on \(Date())",
                                               iconData: UIImage(systemName: "keyboard")!,  tags: []))
        return container
    }
}
