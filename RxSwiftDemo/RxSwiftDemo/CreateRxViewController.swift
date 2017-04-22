//
//  CreateRxViewController.swift
//  RxSwiftDemo
//
//  Created by kagami on 22/4/17.
//  Copyright © 2017年 kagami. All rights reserved.
//

import UIKit
import RxSwift
class CreateRxViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onJust(_ sender: Any) {
        _=Observable<String>.just("one")
        .subscribe({ (event) in
            print("subscribe:\(event.element ?? "complete")")
        })
    }
    @IBAction func onFrom(_ sender: Any) {
        _=Observable<String>.from(["one","two","three"])
            .subscribe({ (event) in
                print("subscribe:\(event.element ?? "complete")")
            })
    }
    @IBAction func onCreate(_ sender: Any) {
        let array=["one","two","error","three"]
        _=Observable<String>.create({ (ob) -> Disposable in
            for item in array{
                if item=="error"{
                    ob.onError(MyError.Test(item))
                }else{
                    ob.onNext(item)
                }
            }
            return Disposables.create()
        }).subscribe(onNext: { (el) in
            print("onNext:\(el)")
        }, onError: { (error) in
            print("onError:\(error)")
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
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
enum MyError: Error {
    case Test(String)
}
