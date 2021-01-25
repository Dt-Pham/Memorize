//
//  EmojiMemoryThemeChooser.swift
//  Memorize
//
//  Created by Duong Pham on 1/24/21.
//

import SwiftUI

struct EmojiMemoryThemeChooser: View {
    var body: some View {
        var themes = [Theme]()
        themes.append(.flags)
        themes.append(.faces)
        themes.append(.places)
        themes.append(.weather)
        return NavigationView {
            List {
                ForEach(themes) { theme in
                    ThemePreview(theme: theme)
                }
            }
            .navigationTitle("Memorize")
            .navigationBarItems(
                leading: Button(action: {
                    print("Add new theme")
                }, label: {
                    Image(systemName: "plus")
                }),
                trailing: EditButton()
            )
        }
    }
}

struct ThemePreview: View {
    var theme: Theme
    var body: some View {
        NavigationLink(destination: EmojiMemoryGameView(emojiGame: EmojiMemoryGame(theme: theme))) {
            VStack {
                Text(theme.name).font(Font.system(size: 30))
                Text(theme.emojis).lineLimit(1)
            }
        }
        .foregroundColor(Color(theme.color))
    }
}

struct ThemeEditor: View {
    var body: some View {
        EmptyView()
    }
}
