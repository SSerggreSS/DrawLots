//
//  TossViewController.swift
//  DrawLots
//
//  Created by Сергей  Бей on 02.06.2022.
//

import RxDataSources
import RxSwift
import UIKit

final class TossViewController: BaseViewController {
    
    var disposeBag = DisposeBag()
    
    private let customView = TossView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
    }
}

struct CustomData {
  var anInt: Int
  var aString: String
  var aCGPoint: CGPoint
}

struct SectionOfCustomData: SectionModelType {
  var header: String
  var items: [Item]
}
extension SectionOfCustomData {
  typealias Item = CustomData

   init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}


