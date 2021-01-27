//
//  EmojiMemoryTheme.swift
//  Memorize
//
//  Created by Duong Pham on 1/24/21.
//

import SwiftUI
import Combine

struct Theme: Codable, Hashable, Identifiable {
    var name: String
    var emojis: String
    var color: UIColor.RGB
    let id: UUID
    
    init?(json: Data?) {
        if json != nil, let newTheme = try? JSONDecoder().decode(Theme.self, from: json!) {
            self = newTheme
        }
        else {
            return nil
        }
    }
    
    init(name: String = "Unnamed", emojis: String = "🐤😄🇹🇴", color: Color = .black) {
        self.name = name
        self.emojis = emojis
        self.color = UIColor(color).rgb
        self.id = UUID()
    }
    
    var json: Data? {
        try? JSONEncoder().encode(self)
    }
    
    // MARK: - Predefined themes
    static let weather = Theme(
        name: "Weather",
        emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨🌫",
        color: .blue
    )
    
    static let faces = Theme(
        name: "Faces",
        emojis: "😀😃😄😁😆😅😂🤣☺️😊😇🙂🙃😉😌",
        color: .yellow
    )
    
    static let places = Theme(
        name: "Places",
        emojis: "🗼🗽🗿🏰🏯🏟🎡🎢🎠🏖⛩🛕🕌🕍⛪️🏛💒🏩🏫",
        color: .purple
    )
    
    static let vehicles = Theme(
        name: "Vehicles",
        emojis: "🚂🚈🚃🚑🚒✈️🛸🚀⛴🛵🏍",
        color: .red
    )
    
    static let flags = Theme(
        name: "Flags",
        emojis: "🇿🇼🇿🇲🇾🇪🇪🇭🇼🇫🇻🇳🇻🇪🇻🇦🇻🇺🇺🇿🇺🇾🇺🇸🏴󠁧󠁢󠁷󠁬󠁳󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁥󠁮󠁧󠁿🇬🇧🇺🇦🇺🇬🇻🇮🇳🇴",
        color: .blue
    )
}
