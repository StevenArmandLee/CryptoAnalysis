//
//  SecondViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/5/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit
import Charts

class StatisticalViewController: UIViewController {

    
    @IBOutlet weak var chartView: BarChartView!
    
    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var characterFrequencyLength: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        chartView.noDataText = "There is no data being provided"
        chartView.descriptionText = ""
        chartView.animate(xAxisDuration: 2, yAxisDuration: 2)
        chartView.doubleTapToZoomEnabled = false
        generateChart(Int(characterFrequencyLength.value))
        setCharts(getXAxisLabel(), values: getXAxisData(getXAxisLabel()))
        informationTextView.text = getStaticalInformation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        generateChart(Int(characterFrequencyLength.value))
        setCharts(getXAxisLabel(), values: getXAxisData(getXAxisLabel()))
        informationTextView.text = getStaticalInformation()
    }
    
    @IBAction func characterFrequencyDidChange(sender: UISlider) {
        
        sender.setValue(Float(lround(Double(characterFrequencyLength.value))), animated: true)
        
        if(Int(sender.value) <= trimmedText.characters.count)
        {
            generateChart(Int(characterFrequencyLength.value))
            setCharts(getXAxisLabel(), values: getXAxisData(getXAxisLabel()))
        }
    }
   
    @IBAction func changeSegment(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            chartView.hidden = false
            characterFrequencyLength.hidden = false
            informationTextView.hidden=true
            
        case 1:
            chartView.hidden = true
            characterFrequencyLength.hidden = true
            informationTextView.hidden=false
            informationTextView.text = getStaticalInformation()
        default:
            break;
        }
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

