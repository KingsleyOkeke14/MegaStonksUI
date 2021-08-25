//
//  ProfileImageOption.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-23.
//

import Foundation


struct ProfileImageOptions{
    var options : [ProfileImageOption] = [ProfileImageOption("🤩", true), ProfileImageOption("👌", false), ProfileImageOption("💂", false), ProfileImageOption("👱‍♀️", false), ProfileImageOption("👨‍🦰", false), ProfileImageOption("😍", false), ProfileImageOption("👮‍♀️", false), ProfileImageOption("🧕", false), ProfileImageOption("🤬", false), ProfileImageOption("🤰", false), ProfileImageOption("🤡", false), ProfileImageOption("💀", false), ProfileImageOption("😤", false), ProfileImageOption("🤖", false), ProfileImageOption("👩‍⚕️", false)]
}

struct ProfileImageOption {
     var image: String
     var isSelected: Bool
    
    init(_ image: String, _ isSelected: Bool) {
        self.image = image
        self.isSelected = isSelected
    }
}
