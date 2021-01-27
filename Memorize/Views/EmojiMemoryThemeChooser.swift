//
//  EmojiMemoryThemeChooser.swift
//  Memorize
//
//  Created by Duong Pham on 1/24/21.
//

import SwiftUI

struct EmojiMemoryThemeChooser: View {
    @EnvironmentObject var store: EmojiMemoryGameStore
    @State private var editMode: EditMode = .inactive
    @State private var showAddThemePopup = false
        
    var body: some View {
        return NavigationView {
            List {
                ForEach(store.themes) { theme in
                    ThemePreview(theme: theme, isEditing: editMode.isEditing)
                }
                .onDelete { indexSet in
                    indexSet.map { store.themes[$0] }.forEach { theme in
                        store.removeTheme(theme)
                    }
                }
            }
            .animation(.none)
            .navigationTitle("Memorize")
            .navigationBarItems(
                leading: addThemeButton,
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
    
    var addThemeButton: some View {
        Button(action: {
            print("Add new theme")
            showAddThemePopup = true
        }, label: {
            Image(systemName: "plus")
        })
          
        
    }
}

struct ThemePreview: View {
    var theme: Theme
    @State var isEditing: Bool
    @State var showThemeEditor = false
    
    var body: some View {
        Group {
            if isEditing {
                VStack {
                    Text(theme.name).font(Font.system(size: 30))
                    Text(theme.emojis).lineLimit(1)
                }
                .onTapGesture {
                    showThemeEditor = true
                }
                .sheet(isPresented: $showThemeEditor, content: {
                    ThemeEditor()
                })
                .foregroundColor(Color(theme.color))
            }
            else {
                NavigationLink(destination: EmojiMemoryGameView(emojiGame: EmojiMemoryGame(theme: theme))) {
                    VStack {
                        Text(theme.name).font(Font.system(size: 30))
                        Text(theme.emojis).lineLimit(1)
                    }
                }
                .foregroundColor(Color(theme.color))
            }
        }
    }
}

struct ThemeEditor: View {
    var body: some View {
        Text("Theme Editor").font(.headline).padding()
        Form {
            EditableText("Theme Name", isEditing: true, onChanged: {name in })
        }
    }
}
