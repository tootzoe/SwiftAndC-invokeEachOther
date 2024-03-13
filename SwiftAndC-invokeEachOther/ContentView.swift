//
//  ContentView.swift
//  SwiftAndC-invokeEachOther
//
//  Created by thor on 13/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//

 
import SwiftUI

struct ContentView: View {
     
    @ObservedObject private var myObj = TOOTTestClz.shared
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Result: \(myObj.myDat.hexDescription)")
            Divider()
            Button("We go"){
                doSumFunc(10)
            }
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
    }
    
    private func doSumFunc(_ x : Int) {
       
        DispatchQueue.global(qos: .default).async {
            print("Start doSumFunc....")
            myAddFunc(Int32(x)) // this func defined in c
        }
        
    }
    
    
}


class TOOTTestClz: ObservableObject {
    static let shared = TOOTTestClz()
    private init() {}
     
    @Published var myDat : Data = Data()
    
    public func addDat(_ newDat : Data) {
        
        DispatchQueue.main.schedule { [weak self] in
            self?.myDat = (newDat)
        }
        
        print("append new dat done....\(myDat.hexDescription)")
    }
     
    
}

extension Data {
    var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}

#Preview {
    ContentView()
}



@_cdecl("callbackInSwift5")
func callbackInSwift5(aa :Int) -> Int {
    let sum = aa + 2
    let d = withUnsafeBytes(of: aa) { Data($0)  }
    TOOTTestClz.shared.addDat(d)
    return sum
}
