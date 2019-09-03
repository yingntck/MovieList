//
//  Additional.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 27/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    
    func loadImageUrl(_ urlString:String) {
        af_setImage(withURL: URL(string: urlString)!)
    }
}
