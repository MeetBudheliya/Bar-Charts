//
//  ViewController.swift
//  test_charts
//
//  Created by Meet Budheliya on 21/06/22.
//

import UIKit
import SwiftCharts
import Charts

class ViewController: UIViewController {


    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var barChartView2: BarChartView!
    
    override func viewDidLoad() {

        let players = ["“Ozil”", "“Ramsey”", "“Laca”"]
        let goals = [6.5, 1.3, 26]

        customizeChart(dataPoints: players, values: goals.map{ Double($0) }, chart: barChartView)



        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Apr", "May"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 3.0, 12.0]
        let unitsBought = [10.0, 14.0, 60.0, 13.0, 2.0, 3.0, 12.0]

        customizeMultilineChart(months: months, sold: unitsSold, bought: unitsBought, chart: barChartView2)

    }

    func customizeChart(dataPoints: [String], values: [Double], chart:BarChartView) {
        // TO-DO: customize the chart here

        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
        let chartData = BarChartData(dataSet: chartDataSet)
        chart.data = chartData

        chartDataSet.colors = [.red]
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values:dataPoints)
        //Also, you probably we want to add:

        chart.xAxis.granularity = 1

    }


    func customizeMultilineChart(months:[String], sold:[Double], bought:[Double], chart:BarChartView) {
        // TO-DO: customize the chart here

        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []


        for i in 0..<months.count {

            let dataEntry = BarChartDataEntry(x: Double(i) , y: sold[i])
            dataEntries.append(dataEntry)

            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: bought[i])
            dataEntries1.append(dataEntry1)

            //stack barchart
            //let dataEntry = BarChartDataEntry(x: Double(i), yValues:  [self.unitsSold[i],self.unitsBought[i]], label: "groupChart")

        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Unit sold")
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Unit Bought")

        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //chartDataSet.colors = ChartColorTemplates.colorful()
        //let chartData = BarChartData(dataSet: chartDataSet)

        let chartData = BarChartData(dataSets: dataSets)


        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"

        let groupCount = months.count
        let startYear = 0


        chartData.barWidth = barWidth;
        chart.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        chart.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)

        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        chart.notifyDataSetChanged()

        chart.data = chartData

        //chart animation
        chart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)


    }


}

