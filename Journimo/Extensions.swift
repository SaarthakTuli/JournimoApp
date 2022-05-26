//
//  Extensions.swift
//  Journimo
//
//  Created by Saarthak Tuli on 23/05/22.
//

import SwiftUI
import Foundation


extension Double {
    func removeZerosFromEnd() -> String {
            let formatter = NumberFormatter()
            let number = NSNumber(value: self)
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}



extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    // Retrieving RootView Controller
    func getRootViewController()-> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else {return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else { return .init() }
        
        return root
        
    }
    
}
