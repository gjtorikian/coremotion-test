//
//  ViewController.swift
//  coremotion-test
//
//  Created by Garen Torikian on 1/6/19.
//  Copyright © 2019 Garen Torikian. All rights reserved.
//

import CoreMotion
import UIKit

class ViewController: UIViewController {

    let motionManager = CMMotionManager()

    // create a CMMotionActivityManager instance
    let coreMotionActivityManager = CMMotionActivityManager()

    var timer: Timer!

    let coreMotionErrorMsg = "The activity moniter is not available. It requires at least the M7 motion co-processor. It appears this device does not have the hardware needed."

    @IBOutlet weak var accX: UITextField!
    @IBOutlet weak var accY: UITextField!
    @IBOutlet weak var accZ: UITextField!

    @IBOutlet weak var gravX: UITextField!
    @IBOutlet weak var gravY: UITextField!
    @IBOutlet weak var gravZ: UITextField!

    @IBOutlet weak var rotX: UITextField!
    @IBOutlet weak var rotY: UITextField!
    @IBOutlet weak var rotZ: UITextField!

    @IBOutlet weak var pitchX: UITextField!
    @IBOutlet weak var rollY: UITextField!
    @IBOutlet weak var yawZ: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        startUpdates()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        stopUpdates()
    }

    func doubleToString(val: Double) -> String {
        return String(format:"%.3f", val);
    }

    @objc func startUpdates() {
        if !motionManager.isDeviceMotionAvailable {
            print(coreMotionErrorMsg); return
        }

        motionManager.deviceMotionUpdateInterval = 0.5;
        motionManager.startDeviceMotionUpdates(to: OperationQueue()) { (data, error) in
            let userAcceleration = data?.userAcceleration;
            let gravity = data?.gravity;
            let rotation = data?.rotationRate;
            let attitude  = data?.attitude;

            DispatchQueue.main.async {
                self.accX.text = self.doubleToString(val: userAcceleration!.x);
                self.accY.text = self.doubleToString(val: userAcceleration!.y);
                self.accZ.text = self.doubleToString(val: userAcceleration!.z);

                self.gravX.text = self.doubleToString(val: gravity!.x);
                self.gravY.text = self.doubleToString(val: gravity!.y);
                self.gravZ.text = self.doubleToString(val: gravity!.z);

                self.rotX.text = self.doubleToString(val: rotation!.x);
                self.rotY.text = self.doubleToString(val: rotation!.y);
                self.rotZ.text = self.doubleToString(val: rotation!.z);

                self.pitchX.text = self.doubleToString(val: attitude!.pitch);
                self.rollY.text = self.doubleToString(val: attitude!.roll);
                self.yawZ.text = self.doubleToString(val: attitude!.yaw);
            }
        }
    }

    func stopUpdates() {
        if !motionManager.isDeviceMotionAvailable {
            print(coreMotionErrorMsg); return
        }

        motionManager.stopAccelerometerUpdates()
    }
}

