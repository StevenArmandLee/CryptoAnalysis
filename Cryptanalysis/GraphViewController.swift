//
//  GraphViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 13/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation
import Charts

class GraphViewController: UIViewController {
    
    private var stasticalModel: StasticalModel = StasticalModel()
    
    @IBOutlet weak var symbolSwitch: UISwitch!
    @IBOutlet weak var caseSensitiveSwitch: UISwitch!
    @IBOutlet var chartView: BarChartView!
    @IBOutlet var frequencyLengthSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.descriptionText = ""
        chartView.animate(xAxisDuration: 2, yAxisDuration: 2)
        chartView.doubleTapToZoomEnabled = false
        chartView.leftAxis.valueFormatter = NSNumberFormatter()
        chartView.leftAxis.valueFormatter?.minimumFractionDigits = 0
        chartView.rightAxis.valueFormatter = NSNumberFormatter()
        chartView.rightAxis.valueFormatter?.minimumFractionDigits = 0
        
        
        stasticalModel.generateChart(Int(frequencyLengthSlider.value), isCaseSensitive: caseSensitiveSwitch.on, isRemoveSymbol: symbolSwitch.on)
        setCharts(stasticalModel.getXAxisLabel(), values: stasticalModel.getXAxisData(stasticalModel.getXAxisLabel()))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        stasticalModel.generateChart(Int(frequencyLengthSlider.value), isCaseSensitive: caseSensitiveSwitch.on, isRemoveSymbol: symbolSwitch.on)
        setCharts(stasticalModel.getXAxisLabel(), values: stasticalModel.getXAxisData(stasticalModel.getXAxisLabel()))
        
    }
    
    @IBAction func FrequencyLengthDidChange(sender: UISlider) {
        sender.setValue(Float(lround(Double(frequencyLengthSlider.value))), animated: true)
        
        if(Int(sender.value) <= stasticalModel.getTrimmedText().characters.count)
        {
            stasticalModel.generateChart(Int(frequencyLengthSlider.value), isCaseSensitive: caseSensitiveSwitch.on, isRemoveSymbol: symbolSwitch.on)
            setCharts(stasticalModel.getXAxisLabel(), values: stasticalModel.getXAxisData(stasticalModel.getXAxisLabel()))
        }
    }
    
    
    @IBAction func onSwitch(sender: UISwitch) {
        stasticalModel.generateChart(Int(frequencyLengthSlider.value), isCaseSensitive: caseSensitiveSwitch.on, isRemoveSymbol: symbolSwitch.on)
        chartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
        setCharts(stasticalModel.getXAxisLabel(), values: stasticalModel.getXAxisData(stasticalModel.getXAxisLabel()))
    }
    
    func setCharts(xAxisLabels: [String], values: [Double])
    {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<xAxisLabels.count
        {
            dataEntries.append(BarChartDataEntry(value: values[i], xIndex: i))
            
        }
        let charDataSet = BarChartDataSet(yVals: dataEntries, label: "Character Frequency")
        charDataSet.valueFormatter?.minimumFractionDigits = 0
        charDataSet.valueFormatter?.generatesDecimalNumbers=false
        let charData = BarChartData(xVals: xAxisLabels, dataSet: charDataSet)
        chartView.data=charData
    }
    
    
}

