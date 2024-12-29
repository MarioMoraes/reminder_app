//
//  SplashViewFlowDelegate.swift
//  Reminder
//
//  Created by Mario Moraes on 23/12/24.
//

import Foundation

public protocol SplashFlowDelegate: AnyObject {
    func openLoginBottomSheet()
    func navigateToHome()
}
