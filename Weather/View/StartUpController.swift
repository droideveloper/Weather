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
    
    // set up button label scalablity
    viewButtonSelectedCity.titleLabel?.numberOfLines = 0 // will improve those into next level of change in text
    viewButtonSelectedCity.titleLabel?.adjustsFontSizeToFitWidth = true
    
    if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
      viewButtonContinue.isEnabled = userDefaultsRepository.selectedCityId != 0
    }
    
    viewImageBackground.image = UIImage(named: "berlin")
		if let cityRepository = container?.resolve(CityRepository.self) {
      
      disposeBag += cityRepository.loadCities()
        .async()
        .do( onNext: { [weak weakSelf = self] cities in
          weakSelf?.viewCityPicker.selectRow(0, inComponent: 0, animated: true)
          }
        )
        .bind(to: viewCityPicker.rx.itemTitles) { _, city -> String in
          return "\(city.name)"
        }
      
      disposeBag += viewCityPicker.rx.modelSelected(City.self)
        .subscribe(onNext: { [weak weakSelf = self] cities in
          if var userDefaultsRepository = weakSelf?.container?.resolve(UserDefaultsRepository.self) {
            if let city = cities.first {
              weakSelf?.viewButtonContinue.isEnabled = city.id != 0
              // will bind image on change
              weakSelf?.viewImageBackground.image = UIImage(named: city.name.lowercased())
              // will bind text on change
              weakSelf?.viewButtonSelectedCity.titleLabel?.text = city.name
              // will store id on change
              userDefaultsRepository.selectedCityId = Int(city.id)
            }
          }
        })
		}
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    super.viewDidDisappear(animated)
  }
}
