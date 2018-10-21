//
//  StartUpController.swift
//  Weather
//
//  Created by Fatih Şen on 19.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class StartUpController: UIViewController {
  
  @IBOutlet weak var viewImageBackground: UIImageView!
	
	private let disposeBag = DisposeBag()
	
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewImageBackground.image = UIImage(named: "berlin")
		if let cityRepository = container?.resolve(CityRepository.self) {
			disposeBag += cityRepository.loadCities()
				.subscribeOn(MainScheduler.asyncInstance)
				.observeOn(MainScheduler.instance)
				.subscribe(onNext: { data in
					print(data)
					}, onError: { error in
						print(error.localizedDescription)
					})
		}
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    super.viewDidDisappear(animated)
  }
}
