//
//  MMHealthKitDef.swift
//  MyHealth
//
//  Created by Mai Hoang Anh on 5/4/18.
//  Copyright © 2018 Mai Hoang Anh. All rights reserved.
//

import HealthKit

extension HKBiologicalSex {
    var stringRepresentation: String {
        switch self {
        case .notSet:
            return "Unknown"
        case .female:
            return "Female"
        case .male:
            return "Male"
        case .other:
            return "Other"
        }
    }
}

extension HKBloodType {
    var stringRepresentation: String {
        switch self {
        case .notSet:
            return "Unknown"
        case .aPositive:
            return "A+"
        case .aNegative:
            return "A-"
        case .bPositive:
            return "B+"
        case .bNegative:
            return "B-"
        case .abPositive:
            return "AB+"
        case .abNegative:
            return "AB-"
        case .oPositive:
            return "O+"
        case .oNegative:
            return "O-"
        }
    }
}
