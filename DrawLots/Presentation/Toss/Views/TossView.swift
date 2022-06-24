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
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
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
    
}
