//
//  SegmentedPieChart.swift
//  Statistics
//
//  Created by Aysel Heydarova on 10.02.23.
//

import UIKit

class SegmentedPieChart: UIView {
    
    var dataEntries: [PieChartDataEntry] = [] {
        didSet { setNeedsDisplay() }
    }
    private var selectedEntry: PieChartDataEntry?
    private var outerRadii = [PieChartDataEntry: CGFloat]()
    private var outerPaths = [PieChartDataEntry: UIBezierPath]()
    private var outerRadius: CGFloat {
        return min(bounds.width, bounds.height) / 2 - 10
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        addGestureRecognizer(tapGesture)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: self)

        for entry in dataEntries {
            outerRadii[entry] = outerRadius

            if let outerPath = outerPaths[entry], outerPath.contains(touchPoint) {
                selectedEntry = entry
                outerRadii[selectedEntry!] = outerRadius + 10

                setNeedsDisplay()
            }
        }
    }

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let spaceAngle = CGFloat.pi / 100

        let total = dataEntries.reduce(0) { $0 + $1.value }
        var startAngle = -CGFloat.pi / 2
        var endAngle = startAngle
        let innerRadius: CGFloat = outerRadius - 20
        var outerRadius: CGFloat = self.outerRadius
        var innerCircle: UIBezierPath = UIBezierPath()

        for entry in dataEntries {
            outerRadius = outerRadii[entry, default: outerRadius]
            endAngle = startAngle + 2 * .pi * (entry.value / total) - spaceAngle

            let outerPath = UIBezierPath(
                arcCenter: center,
                radius: outerRadius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )

            outerPath.addLine(to: center)
            outerPath.close()

            startAngle = endAngle + spaceAngle

            outerPaths[entry] = outerPath
            entry.color.setFill()
            outerPath.fill()

            innerCircle = UIBezierPath(
                arcCenter: center,
                radius: innerRadius,
                startAngle: 0,
                endAngle: 2 * .pi,
                clockwise: true
            )
            print("LOG: innerCircle \(innerCircle.bounds)")
            UIColor.systemBackground.setFill()
            innerCircle.fill()
        }

        let circleDiameter: Double = (innerRadius * 2)
        let squareSize = circleDiameter * sqrt(2) / 2

        let infoViewRect = CGRect(
            x: center.x - squareSize / 2,
            y: center.y - squareSize / 2,
            width: squareSize,
            height: squareSize
        )

        let infoView = ChartInfoView(frame: infoViewRect)

        let defaultItem = InfoItem(title: "All expences", amount: total, currency: "AZN/Month", isButtonVisible: false)

        let item = InfoItem(title: selectedEntry?.categoryName ?? "", amount: selectedEntry?.value ?? 0, currency: "AZN/Month", isButtonVisible: true)

        if let previousView = subviews.first(where: { $0 is ChartInfoView }) {
            previousView.removeFromSuperview()
        }

        infoView.configure(with: selectedEntry == nil ? defaultItem : item)
        addSubview(infoView)
    }

    func distance(from point: CGPoint, to center: CGPoint) -> CGFloat {
        let xDist = point.x - center.x
        let yDist = point.y - center.y
        return sqrt(xDist * xDist + yDist * yDist)
    }
}

struct PieChartDataEntry: Hashable {
    var color: UIColor
    var value: CGFloat
    var categoryName: String
}
