//
//  PhotoListCell.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/26.
//

import Foundation
import UIKit

import Kingfisher

final class PhotoListCell: UITableViewCell {
  
  // MARK: - Data Store
  
  var viewModel: PhotoViewModel?
  
  // MARK: - UI Components
  
  private let photoImageView = UIImageView()
  private let authorNameLabel = UILabel()
  
  // MARK: - Initialization & Deinitialization
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Inheritance
  
  override func prepareForReuse() {
    super.prepareForReuse()
    resetUI()
  }
  
  // MARK: - Configure
  
  func configure(by viewModel: PhotoViewModel) {
    self.viewModel = viewModel
    authorNameLabel.text = viewModel.author
    photoImageView.kf.setImage(with: URL(string: viewModel.imageURL))
    setupUI()
  }
}

extension PhotoListCell {
  private func setupUI() {
    guard let viewModel = viewModel else { return }
    photoImageView.do {
      $0.add(to: contentView)
      $0.snp.makeConstraints { (make) in
        make.edges.equalToSuperview()
        make.width.equalTo(viewModel.width).priority(.high)
        make.height.equalTo(viewModel.height).priority(.high)
      }
      $0.contentMode = .scaleAspectFill
    }
  }
  
  private func resetUI() {
    
  }
}
