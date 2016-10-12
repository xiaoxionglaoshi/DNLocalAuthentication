//
//  ViewController.swift
//  DNLocalAuthentication
//
//  Created by mainone on 16/10/12.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import LocalAuthentication


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func LocalAuthenticationLogin() {
        // 本地认证上下文联系对象
        let context = LAContext()
        var error: NSError?
        
        // 判断设备是否具备指纹认证功能
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            print("可以指纹识别了")
            context .evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "验证指纹以确认您的身份", reply: { (success, error) in
                if success {
                    print("指纹验证成功")
                    DispatchQueue.main.async {
                        //更新UI 必须在主线程中更新,否则天知道要到猴年马月能执行
                    }
                } else {
                    print("指纹验证失败 错误原因:\(error)")
                    let errorMessage = self.errorMessageForError(aerror: error)
                    print(errorMessage)
                }
            })
        } else {
            let errorMessage = self.errorMessageForError(aerror: error)
            print(errorMessage)
        }
    }
    
    
    func errorMessageForError(aerror: Error?) -> String {
        var errorMessage = ""
        if let error = aerror as? NSError {
            switch error.code {
            case LAError.authenticationFailed.rawValue:
                errorMessage = "身份验证不成功"
            case LAError.userCancel.rawValue:
                errorMessage = "手动取消验证"
            case LAError.userFallback.rawValue:
                errorMessage = "使用密码登录"
            case LAError.systemCancel.rawValue:
                errorMessage = "身份验证被系统取消"
            case LAError.passcodeNotSet.rawValue:
                errorMessage = "没有设置密码"
            case LAError.touchIDNotAvailable.rawValue:
                errorMessage = "设备不支持指纹"
            case LAError.touchIDNotEnrolled.rawValue:
                errorMessage = "没有登记的手指触摸ID"
            default:
                errorMessage = ""
            }
            if #available(iOS 9.0, *){
                if error.code == LAError.touchIDLockout.rawValue {
                    errorMessage = "TouchID被锁"
                } else if error.code == LAError.appCancel.rawValue {
                    errorMessage = "认证被取消应用程序"
                } else if error.code == LAError.invalidContext.rawValue {
                    errorMessage = "调用之前已经失效"
                }
            }

        }
        return errorMessage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

