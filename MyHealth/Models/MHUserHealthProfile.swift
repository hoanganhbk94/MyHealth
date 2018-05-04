//
//  MHUserHealthProfile.swift
//  MyHealth
//
//  Created by Mai Hoang Anh on 5/4/18.
//  Copyright © 2018 Mai Hoang Anh. All rights reserved.
//

import HealthKit

class MHUserHealthProfile {
    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?
    var bloodPress: Double?
    
    var stepCount: Int?
    var distanceWalking: Double?
    var distanceCycling: Double?
    var energyBurned: Double?
}
