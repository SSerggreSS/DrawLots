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
    
    private let tossModel: TossModel
    
    init(tossModel: TossModel) {
        self.tossModel = tossModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        title = Strings.Toss.tossTapLot
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customView.setGradientBackground(for: .orange)
        super.viewWillAppear(animated)
    }
    
    private func configureDataSource() {
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCustomData>(
          configureCell: { _, collectionView, indexPath, item in
              let cell: TossViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TossViewCell.name, for: indexPath) as! TossViewCell
              cell.backgroundColor = .green
              cell.configureWith(item: item)
              return cell
        })
        
        var participants = Array<Participant>(
            repeating: Participant(isLoser: false),
            count: tossModel.numberParticipants
        )
    
        self.rx.startActivityIndicator(self)
        
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 0..<self.tossModel.numberLosers {
                participants[i].isLoser = true
            }
            participants.shuffle()
            
            DispatchQueue.main.async {
                let items = participants.map { TossCellModel(participant: $0) }
                
                let sections = [
                    SectionOfCustomData(header: "", items: items)
                ]
                
                Observable.just(sections)
                    .bind(to: self.customView.tossCollectionView.rx.items(dataSource: dataSource))
                    .disposed(by: self.disposeBag)
                self.rx.stopActivityIndicator(self)
            }
        }
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
