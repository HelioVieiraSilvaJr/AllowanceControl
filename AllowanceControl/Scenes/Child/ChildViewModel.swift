//
//  ChildViewModel.swift
//  AllowanceControl
//
//  Created by Helio Junior on 22/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

final class ChildViewModel {
    
    var database = ChildDatabase()
    var child: Child?
    var methodOperation: Method!
    var colorSelected: ColorPicker?
    enum Method {
        case add
        case update
    }
    let colorsData: [ColorPicker] = [
        ColorPicker(name: "padrão", colorHex: "F2F2F7"),
        ColorPicker(name: "azul", colorHex: "85E3FF"),
        ColorPicker(name: "azul pastel", colorHex: "ACE7FF"),
        ColorPicker(name: "verde", colorHex: "BFFCC6"),
        ColorPicker(name: "verde pastel", colorHex: "DBFFD6"),
        ColorPicker(name: "vermelho", colorHex: "FFABAB"),
        ColorPicker(name: "vermelho pastel", colorHex: "FFCBC1"),
        ColorPicker(name: "rosa", colorHex: "F6A6FF"),
        ColorPicker(name: "rosa pastel", colorHex: "FCC2FF"),
        ColorPicker(name: "amarelo", colorHex: "FFF5BA"),
        ColorPicker(name: "amarelo pastel", colorHex: "FFFFD1")
    ]
    
    init(methodOperation: Method, child: Child?) {
        self.child = child
        self.methodOperation = methodOperation
        
        if methodOperation == .add {
            colorSelected = colorsData.randomElement()
        }
        else {
            if self.child == nil {
                fatalError()
            }
            colorSelected = colorsData.filter({ $0.colorHex == child?.colorHex }).first
        }
    }
    
    func validateChild(name: String?, nickname: String?) -> Child? {
        guard let name = name, !name.isEmpty else { return nil }
        guard let nickname = nickname, !nickname.isEmpty else { return nil }
        guard let color = colorSelected else { return nil }
        
        if methodOperation == .update {
            child?.name = name
            child?.nickname = nickname
            child?.colorHex = color.colorHex
            return child!
        }
        return Child(name: name, nickname: nickname, colorHex: color.colorHex)
    }
    
    func save(child: Child, completion: @escaping(Bool) -> ()) {
        if methodOperation == .add {
            database.addDatabase(child: child, completion: completion)
        }
        else {
            database.updateDatabase(child: child, completion: completion)
        }
    }
}
