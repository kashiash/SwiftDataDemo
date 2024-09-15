//
//  TodoCard.swift
//  SwiftDataDemo
//
//  Created by Jacek Kosinski U on 13/09/2024.
//

import SwiftUI
import SwiftData

struct TodoDetail: View {

    @State
    var todo: TodoModel

    var body: some View {
        HStack{
            todo.icon
                .resizable()
                .scaledToFit()
                .frame(width: 50)

Spacer()
            Image(systemName: todo.isDone ? "checkmark.circle" : "questionmark.circle")
                .font(.system(size: 24))
                .foregroundStyle(todo.isDone ? Color.green : Color.red)
        }
        .padding()
            HStack(spacing: 20) {



            VStack(spacing: 10) {
                HStack {
                    ForEach(todo.tags) { tag in
                        Text(tag.name)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(RoundedRectangle(cornerRadius: 4).fill(tag.color.color))

                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack {
                    TextField("Title",text: $todo.title)
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)


                    TextEditor(text: $todo.content)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }


            }




        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.2)).stroke(.black, style: .init(lineWidth: 2.0)))
        .padding(.horizontal, 20)
        .onAppear {
            print(todo.tags)
        }

    }
}

#Preview {
    let container = try! ModelContainer(for: TodoModel.self,
                                        configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let date = Date()
    let newTodo = TodoModel(title: "\(date)", content: "Todo Created on \(Date())", iconData: UIImage(systemName: "car.front.waves.left.and.right.and.up.fill")!,  tags: [])
    container.mainContext.insert(newTodo)
    return TodoDetail(todo: newTodo)
        .modelContainer(container)
}
