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
                            TodoDetail(todo: todo)
                        } label: {
                            TodoCard(todo: todo)
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
                HStack(spacing: 10) {
                    Button(action: {
                        addTodo()
                    }, label: {
                        Text("Add Todo")
                    })
                    .foregroundStyle(.white)
              //      .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue))

                    Button(action: {
                        addTag()
                    }, label: {
                        Text("Add Tag")
                    })
                    .foregroundStyle(.white)
                //    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue))

                    Button(action: {
                        guard let lastTag = tags.last else {return}
                        deleteTag(lastTag)
                    }, label: {
                        Text("Delete Tag")
                    })
                    .foregroundStyle(.white)
                //    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.red))

                }
                Spacer()
                    .frame(height: 20)
            }
        }
    }

    private func addTag() {
        let color = TagColor.allCases.randomElement() ?? .blue
        let newTag = Tag(name: "Tag \(tags.count + 1)", color: color, todos: [])
        modelContext.insert(newTag)
    }

    private func deleteTag(_ tag: Tag) {
        modelContext.delete(tag)
    }

    private func addTodo() {
        let date = Date()
        let newTodo = TodoModel(title: "\(date)", content: "Todo Created on \(Date())", iconData: UIImage(systemName: "car.front.waves.left.and.right.and.up.fill")!,  tags: tags)
        modelContext.insert(newTodo)
    }
}

#Preview {
    ContentView()
        .modelContainer(TodoModel.preview)
}
