//
//  YearPickerView.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 10.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit


class YearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var years: [Int]!
    
    var year: Int = 0 {
        didSet {
            selectRow(years.index(of: year)!, inComponent: 0, animated: true)
        }
    }
    
    var currentYear: Int {
        return Calendar.current.component(Calendar.Component.year, from: Date())
    }
    
    var onYearSelected: ((_ year: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
        self.yearsSetupDefault()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
        self.yearsSetupDefault()
    }
    
    init(pastYearsStartsFrom startYear: Int) {
        super.init(frame: CGRect.zero)
        self.commonSetup()
        self.yearsSetup(from: startYear)
    }
    
    init(futureYearsTill stopYear: Int) {
        super.init(frame: CGRect.zero)
        self.commonSetup()
        self.yearsSetup(till: stopYear)
    }
    
    
    
    fileprivate func commonSetup() {
        self.delegate = self
        self.dataSource = self
    }
    
    fileprivate func yearsSetupDefault() {
        
        var years: [Int] = []
        for i in 1...15 {
            years.append(currentYear+i)
        }
        self.years = years
        self.selectRow(self.years.count-1, inComponent: 0, animated: true)
    }
    
    fileprivate func yearsSetup(from startYear: Int) {
        
        guard startYear < currentYear else {
            yearsSetupDefault()
            return
        }
        
        var years: [Int] = []
        for i in startYear...currentYear {
            years.append(i)
        }
        self.years = years
        self.selectRow(self.years.count-1, inComponent: 0, animated: true)
    }
    
    fileprivate func yearsSetup(till stopYear: Int) {
        guard stopYear > currentYear else {
            yearsSetupDefault()
            return
        }
        
        var years: [Int] = []
        for i in currentYear...stopYear {
            years.append(i)
        }
        self.years = years
        self.selectRow(self.years.count-1, inComponent: 0, animated: true)
    }

    
    // Mark: UIPicker Delegate / Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(years[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = years[self.selectedRow(inComponent: component)]
        if let block = onYearSelected {
            block(year)
        }
        
        self.year = year
    }
    
}
