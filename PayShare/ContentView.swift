//
//  ContentView.swift
//  PayShare
//
//  Created by Alireza Dehghan on 28/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var touchCount = 0
    @State var name = "some Nigga "
    @State private var checkAmount: Double?
    @State private var numberOfPeople = 2
    @State private var tipPercentage = [0, 10, 15, 20]
    @State private var tipGiven = 0
    @FocusState private var isAmountFocused: Bool
    var sharePay: Double{
        return ((checkAmount ?? 0) + ((checkAmount ?? 0) * Double(tipGiven)/100)) / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationView  {
            Form    {
                Section {
                    Picker("How many were you?", selection: $numberOfPeople){
                        ForEach(2..<100 , id: \.self){
                            Text("\($0) people")
                        }
                    }
                    TextField("How much money was paid?", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                }
                Section {
                    Picker("tip picker", selection: $tipGiven){
                        ForEach(tipPercentage, id: \.self){ tip in
                            Text(tip,format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("How much tip was given?")
                }
                Section {
                    Text("Y'all gotta pay \(sharePay , format: .currency(code: Locale.current.currencyCode ?? "USD")) each")
                }
            }
            .navigationTitle("PayShare")
            .toolbar    {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        isAmountFocused = false
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
