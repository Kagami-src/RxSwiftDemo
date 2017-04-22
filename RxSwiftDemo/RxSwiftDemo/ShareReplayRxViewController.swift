//
//  ShareReplayRxViewController.swift
//  RxSwiftDemo
//
//  Created by kagami on 22/4/17.
//  Copyright © 2017年 kagami. All rights reserved.
//

import UIKit
import RxSwift
class ShareReplayRxViewController: UIViewController {

    var counter:Observable<Int>!
    var subscription1:Disposable?,subscription2:Disposable?
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = myInterval(0.5).shareReplay(5)
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func myInterval(_ interval: TimeInterval) -> Observable<Int> {
        return Observable.create { observer in
            print("Subscribed")
            let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer.scheduleRepeating(deadline: DispatchTime.now() + interval, interval: interval)
            
            let cancel = Disposables.create {
                print("Disposed")
                timer.cancel()
            }
            
            var next = 0
            timer.setEventHandler {
                if cancel.isDisposed {
                    return
                }
                observer.on(.next(next))
                next += 1
            }
            timer.resume()
            
            return cancel
        }
    }
    @IBAction func onSubscribe1(_ sender: Any) {
        if subscription1 != nil {return}
        subscription1=counter.subscribe(onNext: { (n) in
            print("subscription1:\(n)")
        })
    }
    @IBAction func onSubscribe2(_ sender: Any) {
        if subscription2 != nil {return}
        subscription2=counter.subscribe(onNext: { (n) in
            print("subscription2:\(n)")
        })
    }
    @IBAction func onDispose1(_ sender: Any) {
        subscription1?.dispose()
        subscription1=nil
    }
    @IBAction func onDispose2(_ sender: Any) {
        subscription2?.dispose()
        subscription2=nil
    }
}
