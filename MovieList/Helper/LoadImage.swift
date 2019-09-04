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
      guard let url = URL(string: urlString) else {
        return
      }
        af_setImage(withURL: url)
    }
}
