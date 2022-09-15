//
//  TossViewCell.swift
//  DrawLots
//
//  Created by Сергей  Бей on 02.06.2022.
//

import UIKit

private extension Appearance {
#warning("add all items appearance")
}

final class TossViewCell: UICollectionViewCell {
    
    private let appearance = Appearance()
    
    private var feedbackGenerator = Vibration()
    
    private var model: TossCellModel?
    
    private var isNotAnimated = true
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        label.font = label.font.withSize(50)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    
    func configureWith(item: TossCellModel) {
        model = item
        titleLabel.isHidden = item.isHidden
        titleLabel.text = item.participant.isLoser ? "☹️" : "🙂"
    }
    
    private func setupUI() {
        addSubviews()
        makeConstraints()
        configure()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configure() {
        addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(showWinOrLoss))
        )
        layer.cornerRadius = appearance.baseCornerRadius
        layer.masksToBounds = true
        setShadow()
    }
    
    @objc private func showWinOrLoss() {
        titleLabel.isHidden = false
        model?.isHidden = false
        tapAnimation()
        guard self.isNotAnimated else { return }
        self.isNotAnimated.toggle()
        titleLabel.alpha = 0
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromTop, animations: {
            self.titleLabel.alpha = 1
        }, completion: { _ in
            self.layer.borderWidth = 2
            if self.model?.participant.isLoser == true {
                self.titleLabel.animationShake()
                self.layer.borderColor = UIColor.red.cgColor
            } else {
                self.titleLabel.animationShake(byAxis: .y)
                self.layer.borderColor = UIColor.yellow.cgColor
            }
        })
        guard self.model?.participant.isLoser == true else {
            self.feedbackGenerator.setVibration(behavior: OneVibration())
            self.feedbackGenerator.vibrate()
            return
        }
        self.feedbackGenerator.setVibration(behavior: DoubleVibration())
        self.feedbackGenerator.vibrate()
    }
}
