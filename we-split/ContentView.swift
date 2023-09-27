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
    @State var tip = 0
    @FocusState var isCheckFocused: Bool
    
    let currency = Locale.current.currency?.identifier ?? "USD"
    
    var total: Double {
        let tip = check / 100 * Double(tip)
        return tip + check
    }
    
    var splittedTotal: Double {
        let people = Double(people+2)
        return total/people
    }
     
    var body: some View {
        return NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $check, format: .currency(code: currency))
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
                        ForEach(0...100, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                header: {
                    Text("how much tip do you want to leave?")
                }
                Section {
                    Text(splittedTotal, format: .currency(code: currency))
                }
                header: {
                    Text("Amount per person")
                }
                Section {
                    Text(total, format: .currency(code: currency))
                        .foregroundColor(tip == 0 ? .red : .black)
                }
                header: {
                    Text("Total amount")
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
