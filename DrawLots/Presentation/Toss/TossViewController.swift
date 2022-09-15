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
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionOfCustomData>(
          configureCell: { _, collectionView, indexPath, item in
              let cell: TossViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TossViewCell.name, for: indexPath) as! TossViewCell
              cell.backgroundColor = .green
              cell.configureWith(item: item)
              cell.alpha = 0
              UIView.animate(withDuration: 1, animations: {
                  cell.alpha = 1
              })
              return cell
        })
        
        var participants = [Participant]()
    
        self.rx.startActivityIndicator(self)
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            for i in 0..<self.tossModel.numberParticipants {
                let participant = Participant(id: i)
                participants.append(participant)
            }
            
            for i in 0..<self.tossModel.numberLosers {
                participants[i].isLoser = true
            }
            
            participants.shuffle()
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

class TossCellModel: IdentifiableType, Equatable {
    typealias Identity = Int
    
    let participant: Participant
    var isHidden = true
    var identity: Int {
        return participant.id
    }
    init(participant: Participant) {
        self.participant = participant
    }
    static func == (lhs: TossCellModel, rhs: TossCellModel) -> Bool {
        lhs.participant.id == rhs.participant.id
    }
}

struct SectionOfCustomData: AnimatableSectionModelType {
    var header: String
    var items: [Item]
    var identity: String {
        return header
    }
}

extension SectionOfCustomData {
    typealias Item = TossCellModel
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
