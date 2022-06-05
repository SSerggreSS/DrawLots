//
//  TossView.swift
//  DrawLots
//
//  Created by Сергей  Бей on 02.06.2022.
//

import RxSwift
import RxDataSources
import UIKit

final class TossView: BaseView {
    
    private let disposeBag = DisposeBag()
    
    let tossCollectionView: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(TossViewCell.self, forCellWithReuseIdentifier: TossViewCell.name)
        return collectionView
    }()
    
    override func addSubviews() {
        super.addSubviews()
        addSubview(tossCollectionView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        tossCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        configureDataSource()
    }
    
    private func configureDataSource() {
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCustomData>(
          configureCell: { dataSource, collectionView, indexPath, item in
              let cell: TossViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TossViewCell.name, for: indexPath) as! TossViewCell
              cell.backgroundColor = .green
              cell.titleLabel.text = "Item \(item.anInt): \(item.aString) - \(item.aCGPoint.x):\(item.aCGPoint.y)"
            return cell
        })
        
        let sections = [
          SectionOfCustomData(header: "First section", items: [CustomData(anInt: 0, aString: "zero", aCGPoint: CGPoint.zero), CustomData(anInt: 1, aString: "one", aCGPoint: CGPoint(x: 1, y: 1)) ]),
          SectionOfCustomData(header: "Second section", items: [CustomData(anInt: 2, aString: "two", aCGPoint: CGPoint(x: 2, y: 2)), CustomData(anInt: 3, aString: "three", aCGPoint: CGPoint(x: 3, y: 3)) ])
        ]
        
        Observable.just(sections)
            .bind(to: tossCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
}
