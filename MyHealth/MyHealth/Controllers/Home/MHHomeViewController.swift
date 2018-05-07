//
//  MHHomeViewController.swift
//  MyHealth
//
//  Created by Mai Hoang Anh on 5/3/18.
//  Copyright © 2018 Mai Hoang Anh. All rights reserved.
//

import UIKit

class MHHomeViewController: UITableViewController {
    
    // Outlet
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var sexLabel: UILabel!
    @IBOutlet private weak var bloodTypeLabel: UILabel!
    @IBOutlet private weak var bloodPressLabel: UILabel!
    @IBOutlet private weak var stepCountLabel: UILabel!
    @IBOutlet private weak var distanceWalikingLabel: UILabel!
    @IBOutlet private weak var energyBunred: UILabel!
    
    private let userHealthProfile = MHUserHealthProfile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .fetchData, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    @objc func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.fetchData()
        }
    }
    
    func fetchData() {
        getAgeSexAndBloodType()
        getStepCount()
        getDistance()
        getEnergyBurned()
        getBloodPressure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getAgeSexAndBloodType() {
        do {
            let userAgeSexAndBloodType = try MHHealthKitManager.sharedInstance.getAgeSexAndBloodType()
            userHealthProfile.age = userAgeSexAndBloodType.age
            userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
            userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
            updateUI()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func getStepCount() {
        MHHealthKitManager.sharedInstance.getTodaySteps { [weak self] (stepCount, error) in
            if let weakSelf = self, error == nil {
                weakSelf.stepCountLabel.text = "\(Int(stepCount))"
            }
        }
    }
    
    private func getDistance() {
        MHHealthKitManager.sharedInstance.getTodayDistanceWalking { [weak self] (distance, error) in
            if let weakSelf = self, error == nil {
                weakSelf.distanceWalikingLabel.text = "\(Int(distance)) m"
            }
        }
    }
    
    private func getEnergyBurned() {
        MHHealthKitManager.sharedInstance.getTodayEnergyBurned { [weak self] (energy, error) in
            if let weakSelf = self, error == nil {
                weakSelf.energyBunred.text = "\(Int(energy)) kCal"
            }
        }
    }
    
    private func getBloodPressure() {
        MHHealthKitManager.sharedInstance.getTodayBloodPressure { [weak self] (bloodPressure, error) in
            if let weakSelf = self, error == nil {
                weakSelf.bloodPressLabel.text = "\(Int(bloodPressure)) mmHg"
            }
        }
    }
    
    private func updateUI() {
        if let age = userHealthProfile.age {
            ageLabel.text = "\(age)"
        }
        if let sex = userHealthProfile.biologicalSex {
            sexLabel.text = sex.stringRepresentation
        }
        if let bloodType = userHealthProfile.bloodType {
            bloodTypeLabel.text = bloodType.stringRepresentation
        }
    }

    // MARK: - Action
    
    @IBAction private func openHealthAppButtonAction(_ sender: Any) {
        openHealthApp()
    }
    
    // MARK: - Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
