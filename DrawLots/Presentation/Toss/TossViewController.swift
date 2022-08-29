//
//  TossViewController.swift
//  DrawLots
//
//  Created by Сергей  Бей on 02.06.2022.
//

import RxDataSources
import RxSwift
import UIKit

final class TossViewController: BaseViewController, UIScrollViewDelegate {
    
    var disposeBag = DisposeBag()
    
    private let customView = TossView()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }
    
    private let tossModel: TossModel
    
    init(tossModel: TossModel) {
        self.tossModel = tossModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDataSource() {
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCustomData>(
          configureCell: { _, collectionView, indexPath, item in
              let cell: TossViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TossViewCell.name, for: indexPath) as! TossViewCell
              cell.backgroundColor = .green
              cell.configureWith(item: item)
              return cell
        })
        
        let items = tossModel.participants.map { TossCellModel(participant: $0) }
        
        let sections = [
            SectionOfCustomData(header: "", items: items)
        ]
        
        Observable.just(sections)
            .bind(to: customView.tossCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

class TossCellModel {
    init(participant: Participant) {
        self.participant = participant
    }
    let participant: Participant
    var isHidden = true
}

struct SectionOfCustomData: SectionModelType {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData {
    typealias Item = TossCellModel
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
