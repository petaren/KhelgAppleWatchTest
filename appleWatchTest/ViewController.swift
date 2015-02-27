//
//  ViewController.swift
//  appleWatchTest
//
//  Created by Petar Mataic on 24/02/15.
//  Copyright (c) 2015 Petar Mataic. All rights reserved.
//

import UIKit
import CountController

class ViewController: UIViewController, CountControllerDelegate {

    @IBOutlet weak var countLabel: UILabel!
    var countController: CountController!
    let userDefaults = NSUserDefaults(suiteName: "group.petarsApp")!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let count = self.userDefaults.integerForKey("count")
        self.countController = CountController(delegate: self, count: count)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("countChanged"), name: NSUserDefaultsDidChangeNotification, object: nil)

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.updateLabelWithCount(self.countController.count)
    }

    @IBAction func increase(sender: UIButton) {
        self.countController.increase()
    }

    @IBAction func decrease(sender: UIButton) {
        self.countController.decrease()
    }

    @IBAction func startTimer(sender: UIButton) {
        self.countController.timerOn = true
    }

    @IBAction func stopTimer(sender: AnyObject) {
        self.countController.timerOn = false
    }

    @IBAction func refreshCount(sender: UIButton) {
        self.countController.count = NSUserDefaults(suiteName: "group.petarsApp")!.integerForKey("count")
    }

    func updateLabelWithCount(count: Int) {
        self.countLabel.text = "\(count)"
    }

    // MARK: CountControllerDelegate

    func countController(countController: CountController, didUpdateCountTo count: Int) {
        self.updateLabelWithCount(count)
        self.userDefaults.setInteger(count, forKey: "count")
        self.userDefaults.synchronize()
    }

    @objc func countChanged() {
        self.updateLabelWithCount(self.countController.count)
    }
}

