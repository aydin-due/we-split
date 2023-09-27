//
//  ContentView.swift
//  we-split
//
//  Created by aydin salman on 14/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var check = 0.0
    @State var people = 0
    @State var tip = 20
    @FocusState var isCheckFocused: Bool
    
    let tips = [0, 10, 15, 20, 25]
    
    var splittedTotal: Double {
        let people = Double(people+2)
        let tip = check / 100 * Double(tip)
        let total = tip + check
        return total/people
    }
    
    var body: some View {
        return NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $check, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isCheckFocused)
                    Picker("Number of people", selection: $people) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    
                }
                Section {
                    Picker("Tip percentage", selection: $tip) {
                        ForEach(tips, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                header: {
                    Text("how much tip do you want to leave?")
                }
                Section {
                    Text(splittedTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isCheckFocused = false
                    }
                }
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
