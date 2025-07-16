//
//  WeightChartView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 12.06.2025.
//

import SwiftUI
import Charts

struct WeightChartView: View {
    let weightHistory: [WeightEntry]

    var body: some View {
        Chart {
            ForEach(weightHistory) { entry in
                LineMark(
                    x: .value("Tarih", entry.date),
                    y: .value("Kilo", entry.weight)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(Color.green)
                .symbol(Circle())
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.day().month())
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .frame(height: 220)
        .padding()
    }
}

