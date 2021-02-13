//
//  DetailCell.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

protocol DetailCellDelegate: class {
  func didSelectScrollView(in cell: UICollectionViewCell, _ scrollView: UIScrollView)
}

class DetailCell: UICollectionViewCell {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var photoView: UIImageView!
  
  weak var delegate: DetailCellDelegate?
  
  lazy var zoomTapRecognizer: UITapGestureRecognizer = {
    let r = UITapGestureRecognizer()
    r.addTarget(self, action: #selector(doubleTappedScrollView))
    r.numberOfTapsRequired = 2
    return r
  }()
  
  lazy var hideTapRecognizer: UITapGestureRecognizer = {
    let r = UITapGestureRecognizer()
    r.addTarget(self, action: #selector(tappedScrollView))
    r.require(toFail: zoomTapRecognizer)
    return r
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    scrollView.frame = contentView.bounds
    scrollView.contentSize = contentView.frame.size
    photoView.frame = scrollView.bounds
    scrollView.addGestureRecognizer(zoomTapRecognizer)
    scrollView.addGestureRecognizer(hideTapRecognizer)
  }
  
  func configure(_ photo: Photo) {
    photoView.loadImageUsingCache(
      with: photo.urls.regular,
      placeHolder: nil
    )
  }
  
  @objc func doubleTappedScrollView() {
    
  }
  
  @objc func tappedScrollView() {
    delegate?.didSelectScrollView(in: self, scrollView)
  }
}

extension DetailCell: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return photoView
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    guard scrollView.zoomScale > 1 else {
      scrollView.contentInset = .zero
      return
    }
    
    guard let image = photoView.image else { return }
    
    let ratioWidth = photoView.frame.width / image.size.width
    let ratioHeight = photoView.frame.height / image.size.height
    
    let ratio = ratioWidth < ratioHeight ? ratioWidth : ratioHeight
    
    let newWidth = image.size.width * ratio
    let newHeight = image.size.height * ratio
    
    let left = newWidth * scrollView.zoomScale > photoView.frame.width
      ? (newWidth - photoView.frame.width)
      : (scrollView.frame.width - scrollView.contentSize.width)
    let top = newHeight * scrollView.zoomScale > photoView.frame.height
      ? (newHeight - photoView.frame.height)
      : (scrollView.frame.height - scrollView.contentSize.height)
    
    scrollView.contentInset = .init(
      top: top * 0.5,
      left: left * 0.5,
      bottom: top * 0.5,
      right: left * 0.5
    )
  }
}
