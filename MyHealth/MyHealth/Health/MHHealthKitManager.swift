//
//  MHHealthKitManager.swift
//  MyHealth
//
//  Created by Mai Hoang Anh on 5/4/18.
//  Copyright © 2018 Mai Hoang Anh. All rights reserved.
//

import UIKit
import HealthKit

class MHHealthKitManager {
    static let sharedInstance = MHHealthKitManager()
    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        // Check available device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        // Get data
        guard
            let dateOfBirth = HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth),
            let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
            let bloodPressureDiastolic = HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic),
            let bloodPressureSystolic = HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic),
            let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount),
            let distanceWalkingRunning = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
            let distanceCycling = HKObjectType.quantityType(forIdentifier: .distanceCycling),
            let activeEnergyBurned = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
                completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
        }
        
        // Process data to data list
        let healthKitTypesToWrite: Set<HKSampleType> = []
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth, biologicalSex, bloodType, bloodPressureDiastolic, bloodPressureSystolic, stepCount, distanceWalkingRunning, distanceCycling, activeEnergyBurned, HKObjectType.workoutType()]
        
        // Request authorization
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func getAgeSexAndBloodType() throws -> (age: Int, biologicalSex: HKBiologicalSex, bloodType: HKBloodType) {
        let healthKitStore = HKHealthStore()
        do {
            let birthdayComponents = try healthKitStore.dateOfBirthComponents()
            let biologicalSex = try healthKitStore.biologicalSex()
            let bloodType = try healthKitStore.bloodType()
            
            let today = Date()
            let calendar = Calendar.current
            var age = 0
            if let birthday = birthdayComponents.date {
                let ageComponents = calendar.dateComponents([.year], from: birthday, to: today)
                age = ageComponents.year!
            }
            
            let unwrapBiologicalSex = biologicalSex.biologicalSex
            let unwrapBloodType = bloodType.bloodType
            return (age, unwrapBiologicalSex, unwrapBloodType)
        }
    }
    
    func getTodaySteps(completion: @escaping (Double, Error?) -> Void) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = calendar.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])
        if let sampleType = type {
            let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
                DispatchQueue.main.async {
                    var steps: Double = 0
                    if let results = results, results.count > 0 {
                        for result in results as! [HKQuantitySample] {
                            Log.log(with: "Steps \(result.quantity.doubleValue(for: HKUnit.count()))")
                            if result.metadata != nil {
                                
                            } else{
                                steps += result.quantity.doubleValue(for: HKUnit.count())
                            }
                        }
                    }
                    completion(steps, error)
                }
            }
            HKHealthStore().execute(query)
        }
    }
    
    func getTodayDistanceWalking(completion: @escaping (Double, Error?) -> Void) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = calendar.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])
        if let sampleType = type {
            let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
                DispatchQueue.main.async {
                    var distance: Double = 0
                    if let results = results, results.count > 0 {
                        for result in results as! [HKQuantitySample] {
                            Log.log(with: "Distancce \(result.quantity.doubleValue(for: HKUnit.meter()))")
                            if result.metadata != nil {
                                
                            } else {
                                distance += result.quantity.doubleValue(for: HKUnit.meter())
                            }
                        }
                    }
                    completion(distance, error)
                }
            }
            HKHealthStore().execute(query)
        }
    }
    
    func getTodayBloodPressure(completion: @escaping (Double, Error?) -> Void) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = calendar.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])
        if let sampleType = type {
            let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
                DispatchQueue.main.async {
                    var bloodPressure: Double = 0
                    if let results = results, results.count > 0 {
                        for result in results as! [HKQuantitySample] {
                            Log.log(with: "Blood pressure \(result.quantity.doubleValue(for: HKUnit.millimeterOfMercury()))")
                            bloodPressure += result.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                        }
                    }
                    completion(bloodPressure, error)
                }
            }
            HKHealthStore().execute(query)
        }
    }
    
    func getTodayEnergyBurned(completion: @escaping (Double, Error?) -> Void) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let startDate = calendar.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])
        if let sampleType = type {
            let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
                DispatchQueue.main.async {
                    var energy: Double = 0
                    if let results = results, results.count > 0 {
                        for result in results as! [HKQuantitySample] {
                            Log.log(with: "Energy \(result.quantity.doubleValue(for: HKUnit.kilocalorie()))")
                            energy += result.quantity.doubleValue(for: HKUnit.kilocalorie())
                        }
                    }
                    completion(energy, error)
                }
            }
            HKHealthStore().execute(query)
        }
    }
    
}
