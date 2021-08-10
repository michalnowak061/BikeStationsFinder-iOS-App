import UIKit

class TitleLabelCreator: LabelCreator {
  func create() -> UILabel {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = #colorLiteral(red: 0.1866590679, green: 0.1866918504, blue: 0.1866519153, alpha: 1)
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 1
    label.minimumScaleFactor = 0.01
    return label
  }
}
