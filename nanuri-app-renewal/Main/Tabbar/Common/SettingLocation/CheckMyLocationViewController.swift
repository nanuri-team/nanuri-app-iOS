//
//  CheckMyLocationViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/13.
//

import UIKit
import CoreLocation

class CheckMyLocationViewController: UIViewController {
    
    var locationManager: CLLocationManager = CLLocationManager()
    let myLocationLabel = UILabel()
    
    var edgeHeight = 34
    var userLongitude: CGFloat = 0.0
    var userLatitude: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "내 위치 설정"
        self.view.backgroundColor = .white
        locationManager.delegate = self
        //위치업데이트
        locationManager.startUpdatingLocation()
        extendedLayoutIncludesOpaqueBars = true

        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        setUpView()
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectOkButton() {
        patchUserLocationInfo(longitude: userLongitude, latitude: userLatitude)
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func getCurrentAddress(location: CLLocation) {
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
            if error != nil {
                print("\(error)")
                return
            }
            
            guard let placemark = placemarks?.first,
                  let administrativeArea = placemark.administrativeArea,
                  let subLocality = placemark.subLocality
           else { return }
           
            self.myLocationLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 24, text: "\"\(administrativeArea) \(subLocality)\"", lineHeight: 27.24)
            
            // 위도, 경도 가져오기
            guard let location = placemark.location else { return }
            self.userLongitude = location.coordinate.longitude
            self.userLatitude = location.coordinate.latitude
        }
    }
    
    private func patchUserLocationInfo(longitude: CGFloat, latitude: CGFloat) {
        let locationString = "POINT (\(latitude) \(longitude))"
        print(locationString)
        let params: [String: String] = ["location": locationString]
        NetworkService.shared.patchUserIsActiveRequest(parameters: params)
    }

    func setUpView() {
        let locationTitleLabel = UILabel()
        locationTitleLabel.attributedText = .attributeFont(font: .PRegular, size: 16, text: "여기가 현재\n회원님의 위치가 맞나요?", lineHeight: 24)
        locationTitleLabel.numberOfLines = 2
        locationTitleLabel.textAlignment = .center
        locationTitleLabel.textColor = .nanuriGray5
        self.view.addSubview(locationTitleLabel)
        locationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            make.left.right.equalToSuperview()
        }
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "location_image")
        self.view.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(locationTitleLabel.snp.bottom).inset(-40)
            make.centerX.equalToSuperview()
        }
        
        myLocationLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 24, text: "\"\"", lineHeight: 27.24)
        myLocationLabel.textColor = .nanuriGreen
        self.view.addSubview(myLocationLabel)
        myLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.bottom).inset(-32)
            make.centerX.equalToSuperview()
        }
        
        let buttonView = UIView()
        self.view.addSubview(buttonView)
        
        let cancelButton = MainButton(style: .disable)
        cancelButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "아니오, 다릅니다", lineHeight: 18), for: .normal)
        buttonView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.45)
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        cancelButton.addTarget(self, action: #selector(selectCancelButton), for: .touchUpInside)
        
        let okButton = MainButton(style: .main)
        okButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "네, 맞습니다", lineHeight: 18), for: .normal)
        buttonView.addSubview(okButton)
        okButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.45)
            make.top.bottom.equalToSuperview()
            make.left.equalTo(cancelButton.snp.right).inset(-7)
            make.right.equalToSuperview().inset(16)
        }
        okButton.addTarget(self, action: #selector(selectOkButton), for: .touchUpInside)
        
        buttonView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(14)
            make.height.equalTo(48)
            make.left.right.equalToSuperview()
        }
    }

}

extension CheckMyLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location)
            getCurrentAddress(location: location)
        }
    }
}
