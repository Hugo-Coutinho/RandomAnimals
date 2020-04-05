//
//  ViewController.swift
//  RandomAnimals
//
//  Created by Hugo on 27/10/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var labelUnavailable: UILabel!
    @IBOutlet weak var viewSuccess: UIView!
    @IBOutlet weak var viewError: UIView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var animalSegmentControl: UISegmentedControl!
    @IBOutlet weak var shuffleAnimalSuccessVisibility: HomeButton!
    @IBOutlet weak var shuffleAnimalFailureVisibility: HomeButton!
    
    private var presenter: HomePresenterInput!
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter.make(viewDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadingvisibility()
        self.presenter.fetchCurrentAnimalby(index: 0)
        self.animalSegmentControl.selectedSegmentIndex = 0
    }
}

extension ViewController: HomePresenterOutput {
    func successVisibility(dogImage: UIImage) {
        self.viewError.alpha = 0
        self.viewSuccess.alpha = 1
        self.viewLoading.alpha = 0
        self.dogImage.image = dogImage
        self.setTapToEachHomeButton(homeButtonByCurrentVisibility: shuffleAnimalSuccessVisibility)
    }
    
    func loadingvisibility() {
        self.loading.startAnimating()
        self.viewError.alpha = 0
        self.viewSuccess.alpha = 0
        self.viewLoading.alpha = 1
    }
    
    func failureVisibility() {
        self.viewError.alpha = 1
        self.viewSuccess.alpha = 0
        self.viewLoading.alpha = 0
        self.setTapToEachHomeButton(homeButtonByCurrentVisibility: shuffleAnimalFailureVisibility)
    }
}

// MARK: - SETUP TAP
extension ViewController {
    private func setTapToEachHomeButton(homeButtonByCurrentVisibility: HomeButton) {
        self.tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.shuffleAnimal))
        homeButtonByCurrentVisibility.addGestureRecognizer(self.tap)
    }
    
    @objc private func shuffleAnimal() {
        self.loadingvisibility()
        self.presenter.fetchCurrentAnimalby(index: self.animalSegmentControl.selectedSegmentIndex)
    }
}
