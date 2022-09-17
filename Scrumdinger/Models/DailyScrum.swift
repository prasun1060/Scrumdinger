//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Prasun Bhattacharyya on 17/09/22.
//

import Foundation

struct DailyScrum: Identifiable {
    var id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Double
    var theme: Theme
    
    init(id: UUID=UUID(), title: String, attendees: [String], lengthInMinutes: Double, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map{Attendee(name: $0)}
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable {
        var id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct Data {
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(title: title, attendees: attendees, lengthInMinutes: lengthInMinutes, theme: theme)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        attendees = data.attendees
        lengthInMinutes = data.lengthInMinutes
        theme = data.theme
    }
}

extension DailyScrum {
    static let sampleData: [DailyScrum] = [
        DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, theme: .yellow),
        DailyScrum(title: "App Dev", attendees: ["Cathy", "Daisy", "Grey", "Eden", "Prasun"], lengthInMinutes: 5, theme: .orange),
        DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Grey", "Eden", "Prasun", "Souvik", "Shaunak"], lengthInMinutes: 5, theme: .poppy)
    ]
}
