//
//  BottomSheetViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    let bottomSheetView = UIView()
    let dimmedViewButton = UIButton()
    private let subView: UIView
    
    var defaultHeight: CGFloat = 136 + safeAreaHeight
    var bottomSheetViewTopConstraint: CGFloat = 0
    
    init(subView: UIView) {
        self.subView = subView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheetView()
    }
    
    @objc func selectDimmedViewButton() {
        hideBottomSheetView()
    }
    
    func showBottomSheetView() {
        let safeAreaHeight: CGFloat = self.view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = self.view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint = (safeAreaHeight + bottomPadding) - defaultHeight
        bottomSheetView.snp.updateConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(bottomSheetViewTopConstraint)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.dimmedViewButton.alpha = 1.0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func hideBottomSheetView() {
        let safeAreaHeight: CGFloat = self.view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = self.view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint = safeAreaHeight + bottomPadding
        bottomSheetView.snp.updateConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(bottomSheetViewTopConstraint)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.dimmedViewButton.alpha = 0.0
            self.view.layoutIfNeeded()
        } completion: { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    func setUpView() {
        dimmedViewButton.alpha = 0.0
        dimmedViewButton.backgroundColor = .black.withAlphaComponent(0.4)
        self.view.addSubview(dimmedViewButton)
        dimmedViewButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dimmedViewButton.addTarget(self, action: #selector(selectDimmedViewButton), for: .touchUpInside)
        
        bottomSheetView.backgroundColor = .white
        bottomSheetView.clipsToBounds = true
        bottomSheetView.layer.cornerRadius = 12
        self.view.addSubview(bottomSheetView)
        
        let topConstant = self.view.safeAreaLayoutGuide.layoutFrame.height + self.view.safeAreaInsets.bottom
        bottomSheetView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(topConstant)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        let indicatorView = UIView()
        indicatorView.backgroundColor = .nanuriGray8
        indicatorView.frame = CGRect(x: 0, y: 0, width: 37, height: 5)
        indicatorView.layer.cornerRadius = 2.5
        bottomSheetView.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(37)
            make.height.equalTo(5)
        }
        
        bottomSheetView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.equalTo(indicatorView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
