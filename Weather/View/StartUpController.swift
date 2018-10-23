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
  
  @IBOutlet private var viewImageBackground: UIImageView!
  @IBOutlet private var viewButtonSelectedCity: UIButton!
  @IBOutlet private var viewButtonContinue: UIButton!
  @IBOutlet private var viewCityPicker: UIPickerView!
	
	private let disposeBag = DisposeBag()
	
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
      viewButtonContinue.isEnabled = userDefaultsRepository.selectedCityId != 0
    }
    
		if let cityRepository = container?.resolve(CityRepository.self) {
      
      let dataSource = cityRepository.loadCities()
        .async()
    
      disposeBag += dataSource
        .bind(to: viewCityPicker.rx.itemTitles) { _, city -> String in
          return "\(city.name)"
        }
      
      disposeBag += dataSource
        .delay(0.5, scheduler: MainScheduler.instance)
        .subscribe(onNext: selectDefault(_ :))
      
      disposeBag += viewCityPicker.rx.modelSelected(City.self)
        .subscribe(onNext: selectionChanged(_ :))
		}
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    super.viewDidDisappear(animated)
  }
  
  private func selectDefault(_ cities: [City]) {
    if let city = cities.first {
      selectionChanged([city])
    }
  }
  
  private func selectionChanged(_ cities: [City]) {
    if var userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
      if let city = cities.first {
        viewButtonContinue.isEnabled = city.id != 0
        // will bind image on change
        viewImageBackground.image = UIImage(named: city.name.lowercased())
        // will bind text on change
        viewButtonSelectedCity.setTitle(city.name, for: .normal)
        // will store id on change
        userDefaultsRepository.selectedCityId = Int(city.id)
      }
    }
  }
}
