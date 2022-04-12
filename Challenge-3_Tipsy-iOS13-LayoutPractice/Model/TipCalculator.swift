//
//  TipCalculator.swift
//  Challenge-3_Tipsy-iOS13-LayoutPractice
//
//  Created by Андрей Бородкин on 12.04.2022.
//

import Foundation

struct TipCalculator {
    
    var bill: Double = 0
    var tipSelected: Int = 0
    var split: Double = 2
    
    func calculate() -> Double {
        var tip: Double = 0
        
        var tipPercent: Double = 0
        
            switch tipSelected {
            case 0: tipPercent = 0
            case 1: tipPercent = 0.1
            case 2: tipPercent = 0.2
            default: break
        }
        
        tip = bill * tipPercent / split
        let totalBill = bill / split + tip
        
        return totalBill
    }
}
