//
//  SchedulerRxViewController.swift
//  RxSwiftDemo
//
//  Created by kagami on 22/4/17.
//  Copyright © 2017年 kagami. All rights reserved.
//

import UIKit
import RxSwift
class SchedulerRxViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    let computeScheduler = SerialDispatchQueueScheduler(qos: .default)
    let IOScheduler = SerialDispatchQueueScheduler(qos: .default)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var count=0;
    @IBAction func onStartClicked(_ sender: Any) {
        count += 1
        _=Observable<Int>.just(count)
        .observeOn(IOScheduler)
        .map { (input) -> String in
            //do IO
            print("IO:\(input)")
            Thread.sleep(forTimeInterval: 1.5)

            return "IO complete:\(input)"
        }.observeOn(computeScheduler)
        .map { (input) -> String in
            //do compute
            print("compute:\(input)")
            Thread.sleep(forTimeInterval: 1)
            return "\(input)...."
        }.observeOn(MainScheduler.instance)
        .subscribe(onNext: { (input) in
            self.label.text=input
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
