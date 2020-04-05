//
//  HomeButton.swift
//  RandomAnimals
//
//  Created by Hugo on 02/01/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import UIKit

class HomeButton: UIView {
    
    @IBOutlet weak var homeButtton: UIButton!
    var contentView:UIView?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: HomeTestsConstant.homeButton, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
