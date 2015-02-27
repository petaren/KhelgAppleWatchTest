//
//  InterfaceController.swift
//  appleWatchTest WatchKit Extension
//
//  Created by Petar Mataic on 24/02/15.
//  Copyright (c) 2015 Petar Mataic. All rights reserved.
//

import WatchKit
import Foundation
import CountController

class InterfaceController: WKInterfaceController, CountControllerDelegate {

    @IBOutlet weak var countLabel: WKInterfaceLabel!
    var counter: CountController?

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        let count = NSUserDefaults(suiteName: "group.petarsApp")!.integerForKey("count")
        self.counter = CountController(delegate: self, count: count)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        self.countLabel.setText("\(self.counter?.count ?? 0)")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func increase() {
        self.counter?.increase()
    }

    @IBAction func decrease() {
        self.counter?.decrease()
    }

    @IBAction func startTimer() {
        self.counter?.timerOn = true
    }

    @IBAction func stopTimer() {
        self.counter?.timerOn = false
    }
    
    @IBAction func refresh() {
        self.counter?.count = NSUserDefaults(suiteName: "group.petarsApp")!.integerForKey("count")
    }

    func countController(countController: CountController, didUpdateCountTo count: Int) {
        self.countLabel.setText("\(count)")
        NSUserDefaults(suiteName: "group.petarsApp")!.setInteger(count, forKey: "count")
        NSUserDefaults(suiteName: "group.petarsApp")!.synchronize()
    }
}
