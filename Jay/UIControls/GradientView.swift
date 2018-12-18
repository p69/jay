import UIKit

class GradientView: UIView {
  var colors:[CGColor] = [] {
    didSet {
      gradientLayer.colors = colors
    }
  }

  var start:CGPoint = CGPoint.zero {
    didSet {
      gradientLayer.startPoint = start
    }
  }

  var end:CGPoint = CGPoint(x: 0.0, y: 1.0) {
    didSet {
      gradientLayer.endPoint = end
    }
  }

  var locations: [NSNumber]? = nil {
    didSet {
      gradientLayer.locations = locations
    }
  }


  override class var layerClass: AnyClass { return CAGradientLayer.self }
  var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
}
