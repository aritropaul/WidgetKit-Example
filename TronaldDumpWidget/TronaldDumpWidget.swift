//
//  TronaldDumpWidget.swift
//  TronaldDumpWidget
//
//  Created by Aritro Paul on 27/06/20.
//

import WidgetKit
import SwiftUI

@main
struct QuoteWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "QuoteWidget",
            provider: Provider(),
            placeholder: Text("Cool Stuff by Dolan Trum"),
            content: { entry in
                WidgetEntryView(entry: entry)
            }
        )
        .configurationDisplayName("Quote Widget")
        .description("Shows the dumbest stuff said by Donald Trump")
    }
}

struct WidgetEntryView: View {
    var entry: QuoteEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(entry.quote.value ?? "")
                .italic()
                .font(.caption)
            Text("- Donald Trump")
                .foregroundColor(.secondary)
                .font(.footnote)
        }
        .padding()
    }
}

struct QuoteEntry: TimelineEntry {
    var date: Date
    var quote: Quote
}


struct Provider: TimelineProvider {
    var loader = QuoteController()

    func snapshot(with context: Context,
                  completion: @escaping (QuoteEntry) -> ()) {
        let entry = QuoteEntry(date: Date(), quote: Quote(value: "President of the US of A"))
        completion(entry)
    }

    func timeline(with context: Context,
                  completion: @escaping (Timeline<QuoteEntry>) -> ()) {
        
        let components = DateComponents(minute: 10)
        let futureDate = Calendar.current.date(byAdding: components, to: Date())!
        
        loader.getQuote { (quote) in
            let entry = QuoteEntry(date: Date(), quote: quote)
            let timeline = Timeline(entries: [entry], policy: .after(futureDate))
            completion(timeline)
        }
    }
}
