//
//  VariablesRxViewController.swift
//  RxSwiftDemo
//
//  Created by kagami on 22/4/17.
//  Copyright © 2017年 kagami. All rights reserved.
//

import UIKit
import RxSwift
class VariablesRxViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onVariables1(_ sender: Any) {
        let variable = Variable(0)

        print("Before first subscription ---")

        _ = variable.asObservable()
                .subscribe(onNext: { n in
                    print("First \(n)")
                }, onCompleted: {
                    print("Completed 1")
                })

        print("Before send 1")

        variable.value = 1

        print("Before second subscription ---")

        _ = variable.asObservable()
                .subscribe(onNext: { n in
                    print("Second \(n)")
                }, onCompleted: {
                    print("Completed 2")
                })

        variable.value = 2

        print("End ---")
        print("will be complete")
    }

    let variable = Variable(0)
    var subscriptionCount=0
    @IBAction func onVariables2(_ sender: Any) {
        print("Before subscription ---")
        let currCount=subscriptionCount
        _ = variable.asObservable()
                .subscribe(onNext: { n in
                    print("\(currCount)onNext: \(n)")
                }, onCompleted: {
                    print("Completed 1")
                })
        print("End ---")
        subscriptionCount += 1
    }

    var sendCount=1
    @IBAction func onSend(_ sender: Any) {
        sendCount += 1
        variable.value=sendCount
    }

}
