//
//  ScrumDetailView.swift
//  Scrumdinger
//
//  Created by Prasun Bhattacharyya on 17/09/22.
//

import SwiftUI

struct ScrumDetailView: View {
    @Binding var scrum: DailyScrum
    @State private var isPresentingEditView = false
    @State private var data = DailyScrum.Data()
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(Int(scrum.lengthInMinutes)) minutes")
                }.accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) {attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
        }
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                scrum.update(from: data)
                            }
                        }
                    }
            }
        }
        .toolbar {
            Button(action: {
                isPresentingEditView = true
                data = scrum.data
            }) {
                Text("Edit")
            }
        }
    }
}

struct ScrumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumDetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
