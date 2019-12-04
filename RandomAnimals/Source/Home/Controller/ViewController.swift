//
//  ViewController.swift
//  RandomAnimals
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
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
    
    private var presenter: HomePresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter.make(viewDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadingvisibility()
        self.presenter.fetchCurrentAnimalby(index: 0)
        self.animalSegmentControl.selectedSegmentIndex = 0
    }
    
    
    @IBAction func shuffle(_ sender: Any) {
        self.loadingvisibility()
        self.presenter.fetchCurrentAnimalby(index: self.animalSegmentControl.selectedSegmentIndex)
    }
}

extension ViewController: HomePresenterOutput {
    func successVisibility(dogImage: UIImage) {
        self.viewError.alpha = 0
        self.viewSuccess.alpha = 1
        self.viewLoading.alpha = 0
        self.dogImage.image = dogImage
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
    }
}
