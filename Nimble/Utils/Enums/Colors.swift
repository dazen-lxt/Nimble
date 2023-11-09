//
//  Colors.swift
//  RickMortyUIKit
//
//  Created by Carlos Mario Muñoz on 18/10/23.
//

import UIKit

enum Colors {
    static let defaultTextColor: UIColor = UIColor.dynamicColor(
        light: UIColor.color(hexInt: 0x333333),
        dark: UIColor.color(hexInt: 0xCCCCCC)
    )
    static let defaultBackground: UIColor = UIColor.dynamicColor(
        light: UIColor.color(hexInt: 0xFFFFFF),
        dark: UIColor.color(hexInt: 0x000000)
    )
    static let itemBackground: UIColor = UIColor.dynamicColor(
        light: UIColor.color(hexInt: 0x99AAAA),
        dark: UIColor.color(hexInt: 0x775555)
    )
}
