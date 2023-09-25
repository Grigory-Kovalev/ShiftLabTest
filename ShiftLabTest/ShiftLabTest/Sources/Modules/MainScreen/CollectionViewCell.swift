//
//  CollectionViewCell.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 25.09.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    //MARK: - Metrics
    enum Metrics {
        static let titleLabelTop: CGFloat = 10.0
        static let titleLabelLeading: CGFloat = 10.0
        static let titleLabelTrailing: CGFloat = -10.0

        static let dateRangeLabelBottom: CGFloat = -10.0
        static let dateRangeLabelLeading: CGFloat = 10.0
        static let dateRangeLabelTrailing: CGFloat = -10.0

        static let borderWidth: CGFloat = 3.0
        static let cornerRadius: CGFloat = 10.0
    }

    
    // MARK: - Subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Resource.MainScreen.Fonts.titleLabelCell
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateRangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Resource.MainScreen.Fonts.dateRangeLabelCell
        label.textColor = Resource.MainScreen.Colors.dateRangeLabelTextCell
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupUI() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.titleLabelTop),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.titleLabelLeading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metrics.titleLabelTrailing),
        ])
        
        addSubview(dateRangeLabel)
        NSLayoutConstraint.activate([
            dateRangeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Metrics.dateRangeLabelBottom),
            dateRangeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.dateRangeLabelLeading),
            dateRangeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metrics.dateRangeLabelTrailing),
        ])
    }

    // MARK: - ConfigureUI
    private func configureUI() {
        layer.borderWidth = Metrics.borderWidth
        layer.cornerRadius = Metrics.cornerRadius
        layer.borderColor = Resource.MainScreen.Colors.cellBorderColorCell.cgColor
    }

    
    //MARK: - SetData
    func configure(with event: MainScreenModel) {
        titleLabel.text = event.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        let startDateString = dateFormatter.string(from: event.startTime)
        let endDateString = dateFormatter.string(from: event.endTime)
        
        dateRangeLabel.text = "\(startDateString) - \(endDateString)"
    }
}
