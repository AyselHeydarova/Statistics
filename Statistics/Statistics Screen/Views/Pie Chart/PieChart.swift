//
//  PieChart.swift
//  Statistics
//
//  Created by Aysel Heydarova on 10.02.23.
//

import UIKit

class PieChart: UIView {

    private let π: CGFloat = CGFloat(Double.pi)
    /// width of the each item
    private var item: PieChartItem = PieChartItem(
        ratio: 0,
        color: .black,
        arcwidth: 0,
        centerImage: UIImage(systemName: "plus")
    )

    private var circleLayer: CAShapeLayer?
    private var shapeLayer: CAShapeLayer?
    private var centerImageView: UIView?

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCircle()
    }

    public func setItem(item: PieChartItem) {
        self.item = item
        drawCircle()
    }

    private func drawCircle(){
        calculateAngles()
        let center = calculateCenter()
        let radius: CGFloat = calculateRadius()
        let arcWidth: CGFloat = item.arcwidth
        
        guard let startAngle = item.startAngle,
              let endAngle = item.endAngle else {
            return
        }

        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius/2 - arcWidth/2,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        circlePath.lineCapStyle = .round

        let fullPath = UIBezierPath(arcCenter: center,
                                    radius: radius/2 - arcWidth/2,
                                    startAngle: startAngle,
                                    endAngle: startAngle - 0.001,
                                    clockwise: true)

        circleLayer?.removeFromSuperlayer()
        shapeLayer?.removeFromSuperlayer()

        let circleLayer = CAShapeLayer()
        circleLayer.path = fullPath.cgPath
        circleLayer.strokeColor = item.ratio == 100 ?  item.color.cgColor :  item.color.cgColor.copy(alpha: 0.15)
        circleLayer.lineWidth = arcWidth
        circleLayer.fillColor = UIColor.clear.cgColor

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = item.color.cgColor
        shapeLayer.lineWidth = arcWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")

        self.circleLayer = circleLayer
        self.shapeLayer = shapeLayer

        guard let circle = self.circleLayer, let shape = self.shapeLayer else { return }

        layer.addSublayer(circle)
        layer.addSublayer(shape)

        if let image = item.centerImage {

            centerImageView?.removeFromSuperview()

            let imageView = UIImageView(frame: .zero)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = image
                .withTintColor(item.color)

            self.addSubview(imageView)
            self.centerImageView = imageView

            imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: radius/2 - arcWidth/2).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: radius/2 - arcWidth/2).isActive = true
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
    }

    /// calculate each item's angle to present pie chart
    private func calculateAngles() {
        let totalRatio: CGFloat = 100
        item.startAngle =  3 * π / 2
        
        guard let startAngle = item.startAngle else { return }
        
        item.endAngle = startAngle + (360 * item.ratio / totalRatio).degreesToRadians
        if let endAngle = item.endAngle, endAngle > 2 * π {
            item.endAngle = endAngle - 2 * π
        }
    }

    /// calculate center of the graph
    ///
    /// - Returns: point of the center
    private func calculateCenter() -> CGPoint {
        return CGPoint(x:bounds.width/2, y: bounds.height/2)
    }

    /// calculate radius of the graph
    ///
    /// - Returns: value of the radius
    private func calculateRadius() -> CGFloat {
        return min(bounds.width, bounds.height)
    }
}

private extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}

private extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}


