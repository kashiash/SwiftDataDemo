//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Jacek Kosinski U on 13/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \TodoModel.createDate, order: .forward, animation: .smooth) var todoList: [TodoModel]
    @Query var tags: [Tag]
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:20) {
                    ForEach(todoList){ todo in
                        NavigationLink {
                            todo.icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                            Text(todo.title)
                            Text(todo.content)
                        } label: {
                            VStack{
                                HStack{
                                    todo.icon
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)

                                    Text(todo.title)
                                }
                                Text(todo.content)
                                    .font(.caption2)
                            }
                        }

                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .padding(.vertical, 50)
            .padding(.trailing, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.2))
            .onChange(of: todoList) {
                print("todo list changed")
            }
            .toolbar {
                Button("Add Task") {
                    addTodo()
                }
            }
        }
    }


    private func addTodo() {
        let date = Date()
        let newTodo = TodoModel(title: "\(date)", content: "Todo Created on \(Date())", iconData: UIImage(systemName: "car.front.waves.left.and.right.and.up.fill")!,  tags: tags)
        modelContext.insert(newTodo)
    }
}

#Preview {

    let container = try! ModelContainer(for: TodoModel.self,
                                        configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let date = Date()
    let newTodo = TodoModel(title: "\(date)", content: "Todo Created on \(Date())", iconData: UIImage(systemName: "car.front.waves.left.and.right.and.up.fill")!,  tags: [])
    container.mainContext.insert(newTodo)
    return ContentView()
        .modelContainer(container)
}
