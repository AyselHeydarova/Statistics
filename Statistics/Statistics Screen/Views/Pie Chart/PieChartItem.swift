//
//  PieChartItem.swift
//  Statistics
//
//  Created by Aysel Heydarova on 10.02.23.
//

import UIKit

class PieChartItem {
    var ratio: CGFloat
    var color: UIColor
    var arcwidth: CGFloat
    var centerImage: UIImage?
    var startAngle: CGFloat?
    var endAngle: CGFloat?
    var ratioText: String {
        return "\(Int(ratio))%"
    }

    init(ratio: CGFloat, color: UIColor, arcwidth: CGFloat, centerImage: UIImage?) {
        self.ratio = ratio
        self.color = color
        self.arcwidth = arcwidth
        self.centerImage = centerImage
    }
}
