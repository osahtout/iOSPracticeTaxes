//
//  ContentView.swift
//  tax and salary budgeting
//
//  Created by Sahtout, Omar on 2022-03-13.
//

import SwiftUI
import CoreData

struct ContentView: View
{
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    enum TabItem {
        case taxCalc, budgeting
    }
    
    @State var selectedItem = TabItem.taxCalc
    @State var income: String = ""
    @State var totalTax: String = ""
    @State var federalTaxPayed: String = ""
    @State var provincialTaxPayed: String = ""
    @State var netIncome: String = ""
    @State var taxPerPay: String = ""
    @State var netMonthlyIncome: String = ""
    @State var netPaycheck: String  = ""
    @State var isIncomeTaxCalc: Bool = true
    
    @State var paycheck = ""
    @State var monthlyBills = ""
    @State var companyInvestment = ""
    @State var mortgage = ""
    @State var investment = ""
    @State var selfSpending = ""
    
    @State var dict: [String : String] = [:]
    

    
    var body: some View
    {
        // MARK: tax calc
        TabView(selection: $selectedItem)
        {
       
            VStack()
            {
                Text("Quebec Tax Calculator")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)

                HStack()
                {
                    Spacer()
                    TextField("total income in $", text: $income)
                        .keyboardType(.numberPad)

                }



                Button("submit")
                {
                    populateEverything()
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                List
                {

                    HStack()
                    {
                        Text("Net Income")
                            .fontWeight(.bold)
//                        Spacer()
                        TextField("0$", text: $netIncome)
                            .multilineTextAlignment(.trailing)

                    }
//                    .padding(10.0)



                    HStack()
                    {
                        Text("Federal Tax")
                            .fontWeight(.bold)
                        TextField("0$", text: $federalTaxPayed)
                            .multilineTextAlignment(.trailing)
                    }
//                    .padding(10.0)

                    HStack()
                    {
                        Text("Provincial Tax")
                            .fontWeight(.bold)
                        TextField("0$", text: $provincialTaxPayed)
                            .multilineTextAlignment(.trailing)
                    }
//                    .padding(10.0)

                    HStack()
                    {
                        Text("Total Tax")
                            .fontWeight(.bold)
                        TextField("0$", text: $totalTax)
                            .multilineTextAlignment(.trailing)
                    }
//                    .padding(10.0)

                    HStack()
                    {
                        Text("Tax Per Pay")
                            .fontWeight(.bold)
                        TextField("0$", text: $taxPerPay)
                            .multilineTextAlignment(.trailing)
                    }
//                    .padding(10.0)


                    HStack()
                    {
                        Text("Net Monthly income")
                            .fontWeight(.bold)
                        TextField("0$", text: $netMonthlyIncome)
                            .multilineTextAlignment(.trailing)
                    }
//                    .padding(10.0)

                    HStack()
                    {
                        Text("Net paycheck")
                            .fontWeight(.bold)
                        TextField("0$", text: $netPaycheck)
                            .multilineTextAlignment(.trailing)
                    }
//                    .padding(10.0)

                }
                
            }
            .padding(.leading)
            .tabItem {
                 Image(systemName: "1.circle.fill")
                 Text("Income tax")
             }
            

            // MARK: budgting
            VStack(alignment: .center)
            {
                Text("Budgeting paychecks")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                
                    HStack()
                    {
                        Spacer()
                        TextField("Paycheck $", text: $paycheck)
                            .keyboardType(.numberPad)
    
                    }
                    HStack()
                    {
                        Spacer()
                        TextField("Bills $", text: $monthlyBills)
                            .keyboardType(.numberPad)
                    }
    
                    HStack()
                    {
                        Spacer()
                        TextField("company stocks $", text: $companyInvestment)
                            .keyboardType(.numberPad)
                    }

    
                    Button("calculate")
                    {
                        populateBudgeting()
                    }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                    Group
                    {
                        HStack()
                        {
                            Text("Bills")
                                .fontWeight(.bold)
                            Spacer()
                            TextField("0$", text: $monthlyBills)
                                .multilineTextAlignment(.trailing)
    
                        }
                        .padding(10.0)
                        
                        HStack()
                        {
                            Text("Mortage Saving Amount")
                                .fontWeight(.bold)
                            Spacer()
                            TextField("0$", text: $mortgage)
                                .multilineTextAlignment(.trailing)
    
                        }
                        .padding(10.0)
                        
                        HStack()
                        {
                            Text("company investment")
                                .fontWeight(.bold)
                            Spacer()
                            TextField("0$", text: $companyInvestment)
                                .multilineTextAlignment(.trailing)
    
                        }  .padding(10.0)
                        
                        HStack()
                        {
                            Text("Investment")
                                .fontWeight(.bold)
                            Spacer()
                            TextField("0$", text: $investment)
                                .multilineTextAlignment(.trailing)
    
                        }
                        .padding(10.0)
                        
                        HStack()
                        {
                            Text("Self Spending")
                                .fontWeight(.bold)
                            Spacer()
                            TextField("0$", text: $selfSpending)
                                .multilineTextAlignment(.trailing)
    
                        }
                        .padding(10.0)
                        
                        Spacer()
                    }
                
                Spacer()
                
            }
            .tabItem {
                 Image(systemName: "2.circle.fill")
                 Text("Budgeting")
             }
            
            VStack(alignment: .center)
            {
                ContentView_Second()
            }.tabItem {
                Image(systemName: "3.circle.fill")
                Text("second content view")
            }
            
        }
        .padding(.trailing)
    }
    
    private func addToDict(key: String, value: String)
    {
        dict[key] = value
    }
    
//    private func displayDict()
//    {
//        for (key, value) in dict
//        {
//
//        }
//    }
    
    private func populateBudgeting()
    {
        let paycheckFloat = Float(paycheck) ?? 0.0
        let billsFloat = (Float(monthlyBills) ?? 0.0) / 2
        let stockOptions = Float(companyInvestment) ?? 0.0
        
        let totalPay = (paycheckFloat + stockOptions)
        
        mortgage = String(format: "%.2f" ,totalPay * 0.5 - billsFloat)
        investment = String(format: "%.2f", totalPay * 0.3 - stockOptions)
        selfSpending = String(format: "%.2f", totalPay * 0.2)
        
    }
    
    private func populateEverything()
    {
        totalTax = getTotalTax()
        federalTaxPayed = getFederalTax()
        provincialTaxPayed = getProvincialTax()
        netIncome = getNetIncome()
        netMonthlyIncome = getMonthlyIncome()
        netPaycheck = getpaycheck()
        taxPerPay = getTaxPerPay()
        
    }
    
    private func getTaxPerPay() -> String
    {
        let payBeforeTax = (Float(income) ?? 0.0) / 24
        let pay: Float = Float(getpaycheck()) ?? 0.0
        
        return String(format: "%.2f", payBeforeTax - pay);
    }
    
    private func getpaycheck() -> String
    {
        let netFullIncome = Float(getNetIncome()) ?? 0.0
        return String(format: "%.2f", netFullIncome / 24)
    }
    
    private func getMonthlyIncome() -> String
    {
        let netIncomeFull = Float(getNetIncome()) ?? 0.0
        return String(format: "%.2f", (netIncomeFull / 12) )
    }
    
    
    private func getNetIncome() -> String
    {
        let totaltax = Float(getTotalTax()) ?? 0.0
        let inc = Float(income) ?? 0.0
        return String(format: "%.2f", (inc - totaltax))
    }
    
    
    private func getTotalTax() -> String
    {
        let fedTax = Float(getFederalTax()) ?? 0.0
        let provTax = Float(getProvincialTax()) ?? 0.0
        return String(format: "%.2f", (fedTax + provTax))
    }
    
    private let firstFedTaxBracket: Float = 0.15
    private let secondFedTaxBracket: Float  = 0.205
    private let thirdFedTaxBracket: Float  = 0.26
    private let fourthFedTaxBracket: Float  = 0.29
    private let lastFedTaxBracket: Float  = 0.33
    
    private let firstFedIncomeBracket: Float = 50197
    private let secondFedIncomeBracket: Float  = 100392
    private let thirdFedTIncomeBracket: Float  = 155625
    private let fourthFedIncomeBracket: Float  = 221708
    
    
    private func getFederalTax() -> String
    {
        let totalIncome = Float(income) ?? 0.0
        var totalFederalTax: Float = 0
        var incomeLeftToTax: Float = totalIncome
        
        if(totalIncome > 0.0)
        {
            if(incomeLeftToTax > fourthFedIncomeBracket)
            {
                incomeLeftToTax = incomeLeftToTax - fourthFedIncomeBracket
                totalFederalTax += incomeLeftToTax * lastFedTaxBracket
                incomeLeftToTax = fourthFedIncomeBracket
            }
            
            if(incomeLeftToTax > thirdFedTIncomeBracket)
            {
                let difference = incomeLeftToTax - thirdFedTIncomeBracket
                totalFederalTax = difference * fourthFedTaxBracket
                incomeLeftToTax = thirdFedTIncomeBracket
            }
            
            if(incomeLeftToTax > secondFedIncomeBracket)
            {
                let difference = incomeLeftToTax - secondFedIncomeBracket
                totalFederalTax = difference * thirdFedTaxBracket
                incomeLeftToTax = secondFedIncomeBracket
            }
            
            if(incomeLeftToTax > firstFedIncomeBracket)
            {
                let difference = incomeLeftToTax - firstFedIncomeBracket
                totalFederalTax = difference * secondFedTaxBracket
                incomeLeftToTax = firstFedIncomeBracket
                
            }
            
            totalFederalTax += incomeLeftToTax * firstFedTaxBracket
            
        }
        
        
        return String(format: "%.2f", totalFederalTax)
    }
    
    
    private let taxBracketQuebec1: Float = 0.15
    private let taxBracketQuebec2: Float  = 0.20
    private let taxBracketQuebec3: Float  = 0.24
    private let taxBracketQuebec4: Float  = 0.2575

    private let incomeQuebecBracket1: Float = 46295
    private let incomeQuebecBracket2: Float  = 92580
    private let incomeQuebecBracket3: Float  = 112655
    
    
    
    private func getProvincialTax() -> String
    {
        let totalIncome = Float(income) ?? 0.0
        var totalProvincialTax: Float = 0
        var incomeLeftToTax: Float = totalIncome
        
        if(totalIncome > 0.0)
        {
            if(incomeLeftToTax > incomeQuebecBracket3)
            {
                incomeLeftToTax = incomeLeftToTax - incomeQuebecBracket3
                totalProvincialTax += incomeLeftToTax * taxBracketQuebec4
                incomeLeftToTax = incomeQuebecBracket3
            }
            
            if(incomeLeftToTax > incomeQuebecBracket2)
            {
                let difference = incomeLeftToTax - incomeQuebecBracket2
                totalProvincialTax = difference * taxBracketQuebec3
                incomeLeftToTax = incomeQuebecBracket2
            }

            if(incomeLeftToTax > incomeQuebecBracket1)
            {
                let difference = incomeLeftToTax - incomeQuebecBracket1
                totalProvincialTax = difference * taxBracketQuebec2
                incomeLeftToTax = incomeQuebecBracket1
            }
            
            totalProvincialTax += incomeLeftToTax * taxBracketQuebec1
        }
        
        
        return String(format: "%.2f", totalProvincialTax)
        
    }
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
