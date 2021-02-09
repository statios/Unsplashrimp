//
//  ExploreViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExploreDisplayLogic: class {

}

final class ExploreViewController: BaseViewController {

  var router: (ExploreRoutingLogic & ExploreDataPassing)?
  var interactor: ExploreBusinessLogic?
  
  @IBOutlet weak var tableView: UITableView!
}

// MARK: - Configure
extension ExploreViewController {
  override func build() {
    let viewController = self
    let interactor = ExploreInteractor()
    let presenter = ExplorePresenter()
    let router = ExploreRouter()
    let worker = ExploreWorker()
    
    interactor.presenter = presenter
    interactor.worker = worker
    presenter.view = viewController
    router.viewController = viewController
    router.dataStore = interactor
    viewController.interactor = interactor
    viewController.router = router
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Unsplashrimp"
    navigationController?.navigationBar.transparentNavigationBar()
    tableView.tableHeaderView = UIView(
      frame: .init(x: 0, y: 0, width: Device.width, height: 44)
    )
  }
}

// MARK: - Display
extension ExploreViewController: ExploreDisplayLogic {

}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return 8
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    let heights: [CGFloat] = [200, 300, 400, 500, 200, 300, 400 ,500 ]
    return heights[indexPath.row]
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PhotoCell",
            for: indexPath
    ) as? PhotoCell else { return PhotoCell() }
    let colors: [UIColor] = [
      .red, .brown, .systemTeal, .systemPink, .red, .brown, .systemTeal, .systemPink
    ]
    cell.backgroundColor = colors[indexPath.row]
    return cell
  }
}

extension ExploreViewController {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
  }
}
