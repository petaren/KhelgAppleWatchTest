//
//  CountController.swift
//  appleWatchTest
//
//  Created by Petar Mataic on 24/02/15.
//  Copyright (c) 2015 Petar Mataic. All rights reserved.
//

import Foundation

public protocol CountControllerDelegate: class {
    func countController(countController: CountController, didUpdateCountTo count: Int)
}

public class CountController {
    private var timer: NSTimer?

    public weak var delegate: CountControllerDelegate?

    public var count: Int = 0 {
        didSet {
            self.delegate?.countController(self, didUpdateCountTo: self.count)
        }
    }

    public var timerOn: Bool = false {
        didSet {
            if timerOn == true {
                self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("timerFire"), userInfo: nil, repeats: true)
            } else {
                self.timer?.invalidate()
            }
        }
    }

    public init(delegate: CountControllerDelegate, count: Int) {
        self.delegate = delegate
        self.count = count
    }


    public func increase() {
        self.count++
    }

    public func decrease() {
        self.count--
    }

    @objc private func timerFire() {
        self.decrease()
        if self.count == 0 {
            self.timer?.invalidate()
        }
    }
}
