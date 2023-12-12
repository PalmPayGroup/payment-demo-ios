//
//  ViewController.swift
//  PaymentSDKDemo
//
//  Created by Leo on 2023/12/11.
//

import UIKit
import SwiftyRSA
import CryptoKit
import Alamofire
import ProgressHUD
import IQKeyboardManager
import PalmPayPaymentSDK

let prodPrivateKey = "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCMbt+9oZIUomuyUaHWv2la+rbodo5lDj8Q29KjhPCbvfolReX/9adFnYNWoIiVPu5PZYxGpF/OhP2uZPmoGMcrOh7yCVh8pRzq7s1EyQauhLe4qIj/+flp/w4uMZusdTHhsciKrx10dTQ5antwTWYskcTg00kvGBPPaeGS1Jg/3P8vHdHU43RXbZ1d0BaHNmPseWezkq6Z72gceDyfzMcjkkEmkh2s24Rt52pjiPBdT4gmc3cEiMoNZXDdMXZBqjPN00XJMVFowzmeIcdaMcaAxZEi3UQxw1o5/RQ6oL8M9NGyZ+RNMwKDcBfB1P2Pkf+aJPLYNYL0s0NyB0xv6TYDAgMBAAECggEAJipfzjah78+wezbqR+WfaWVn3keSLW6wvxEu7tfLWFhKKmUTu/t0KVxEfH+GfyEqPRO5Ct3TV9oW45V3sDKDtoDGNjtJ/B4XfNXHnaEQms9g6uOK0B6MpTz3CqDa0QTMuKzLdr1ewO61ccE5qOywDv7SxdNGOXFOuPjqoC/87KXo8VUx2H6Bjru2XS0BhCY1m2QE2wO1aiJnTKDiJLbFumoWYwjSgOla0Lg1kR9njtVlETsZQVemSogDZFcW9S1JGEt02G0tbgFC9NF81diW4X677NyUsg6nqvG5vbKyxaPvzEahsy7Ec+eMCIzUNt2wkXoF6vHkKNNpPZJD3xXpEQKBgQDCKpu9Q4Fh92+gj/+W8NMSZ4kmLsTj/NtxTKlaCFXNH2bsdgnFRp71kCC7J1PXJ2mGZU5UrPzSt021RDXkvdpr3iu6S8/mVmdB3xNAgdmC1xSVOLwjahAHY2+92q7IAbH9iCczIKZykbBqVB1+F5KquP8EGEmMyGN14K36sj1xmwKBgQC5J6mwrdY8GMT0GG85s/jJyPx/kS93FEM+2XbaWOZRqTf7ZuGyBQwjji1kDxN/qKst0/FXOpJlbpSFgaI/23SfZUMPbClDs3jjF0l9hskVQDKyEjkjNt8mt+N3PXUrsBxcJXImgS+PFi9FewrsSsuU/uRe/XEG0j3Oj0z3ZpKnuQKBgQC3KbiWttqTjvZHke969R037GGNmmrz4zEjVT0giGJgSPIvuD4JUlBbuCWYR0Yo3a4HMQPOjw1EvdRZXco1SP+F6CR57lBlqjZoBkbEAHoumjR5e/bGtaP/REdB4swkMq00TL8l1PQPee3gsA7ORvB9ilxPAZZIbzScG2Ij7wZVZwKBgQCDxpHD2AUYYnySSW2nwMn5Ox1R4U/JzVcKvRUU056gUfIw8AkDfQolqAPwKbaz7aRfCm/CqEIXBLuZxShnkFYRN62hpVY9A9eusB0yxKIKiNVL3SJjSKNLWCcA73Gb9UxJ3LDAbMMfcCeWqLqeb6Ey2rJIVNKDi1BH2b9qeMs5qQKBgQCfMzLGkkQFVCEtgkj9n631pOqxn//T4HNvBAnVx2EqSZe2Nh3IuCWPkBDkMQ7oCkWaj8bgYNroVdASQGlBYR1TaZ9/4VmaZpFQANWwZuG0Hdwk3Efx7qlBv8x4oYHLpEvhyiVEdJxgEtBbFf6ZwriefZTM81nDBqdYL+JJh6zdYQ=="

let devPrivateKey = "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCHfLk7+vVlX97A84W7dqDCH/6V9jEmkETjFmCnAlzu2tYoNxQwPZp/p0R01yDCbkPyWjIKMd4N60RMGMmAUrDMf55ym2dntMlXvrcA8vVxMlYp1YasIi6Uh7Zj9xc7HhYY9uvzX6XTlWtD9LxAGf4V3tmE8kpiGtdidlbrAyNAjJuHo3kuSp5SY6TVNg30xBao2zUi+KaSsP9HViO9GLEOgH+MbGvSqnmG2Pa/iAn5eJ2LmeenHhfHMiVBnLh39lrt6X80k/82pnF/Md/DajFrn8q235kClKsHNBc3QdD4FMMDSjRzqD+OhchWu2jijsUwjAp8hg6fnW1GhvhTf1UdAgMBAAECggEATDuuUgRrzSV7RaAAEDG4VGICMki68RLd39R4f6ABwFebhjcvgdE3vDnWd9OP2DaIvrVnUHsskTJeVF7iCfT9C6OG+L9eGGkNnPRvLfaGibGj75f4VaRKB0KxKmAeTyInltZgfqjDumBpYWwz+/FkGNQyGe7mUXr+06T4VPWIAUoAWfHiPFgvFToy7pJcGmW4RT5onS7hKmnq2R8RaEuJKrjHVeZRnzQqqpRCKQ3kL10v8OcFKAs9CNDnAHwD7B5qbpY0T2/AKi0OgcMo5PeXRVixl6cnVrVv5Ba6i5c2knHlpM/c8B7Tyz6kGtO7/jKpjlY+IpABrpymr9qMhY67gQKBgQD+hC80BYus9F46Ln2FUuF38UA7EswF/rJCZxq4HEGTI6Honvp49f5FTCqT8aFl8bpE9W99d6GWaVpp/LbIvkyOzIO6ucyyx8Xm5ux4TED5bbd2A2w14KYkA1l8bvdh0KicK303/3tED9P0NzKvscnuCA8PKJR202e7SuldJnTdPQKBgQCIRuldq80TFWGTVAVxjr8QPv9tTzUoMgC+CPauKVWuGElwcPT2Jii+gJIR3/i5VamChluw+736crgG51JjKX7gNTFYqsOGUbJgdnpbJFI9UvHl2009LC/rnsocsVrWgCLDZwZ6SNC2QEzuw8chMA5liEfMxhGDJZOcDivE+2+VYQKBgEmABtmxGEsULvoCXwFXlAE9TF1C6mR4zyXZ/J9amZ1SVvmEn7S65XlBq7IZv5BfJHmxn0bOe32iYxfkgSyruBQs/4W3DmQ6yO4LlhKPgtwFUUvlZSSSAai4xujmas52oZqn/HtlbkWThJQsNJkEcNoqvZ6VC3rdRkGSOp5J8snJAoGAai6Wdp3+U/g85wZ4l1qaFJaBfzJQQNl1KpzhWCJs2BGkZzAcLg7dgFG9fp/8tKvCQClgGC6OgC4SpY5n60vRx/CqWmPzpRzS18Z437sVOSL/yBFvxVJApF49LM4j8S415/rGWVGTDe5cA04YQgunrATbrPpHeuA0e0uvXvRqpQECgYBnWwNznWQHLTIHGZRpgUbB8ScuAC1U2hSO8k14gWfE1IpIxL7yAKoKAEWmQOFVoCsGrH73xhNj2ZXKIBt7BiB6XcQzZt5nsdwLzZt3jJKA8Npmcwu/ZbWTrIga24a+fbv6T68COoKAdJ0TV8RpNOFe/GeqgaWX671Ta7z3pNU6xw=="

enum Environment {
    case prod
    case dev
    
    func endpoint() -> String {
        switch self {
        case .prod:
            return "https://open-gw-prod.palmpay-inc.com"
        case .dev:
            return "https://open-gw-dev.palmpay-inc.com"
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var goodsNameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var privateKeyTextField: UITextField!
    @IBOutlet weak var appIdTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        goodsNameTextField.placeholder = "Test Goods Name"
        amountTextField.placeholder = "100"
        privateKeyTextField.placeholder = defaultPrivateKey
        appIdTextField.placeholder = defaultAppId
    }
    
    @IBAction func makePayment(_ sender: Any) {
        let params = getParams()
        let signString = getSignature(with: params, privateKey: defaultPrivateKey)
        let appId = params["appid"] as? String ?? ""
        let headers = [
            "Content-Type": "application/json;charset=UTF-8",
            "CountryCode": "NG",
            "App_id": appId,
            "Authorization": "Bearer \(appId)",
            "Signature": signString
        ]
        
        let urlString = environment.endpoint() + "/api/v2/payment/merchant/createorder"
        
        ProgressHUD.show()
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: HTTPHeaders(headers)).responseDecodable(of: ResponsePrototype.self) { response in
            guard let response = response.value else {
                ProgressHUD.dismiss()
                return
            }
            if response.respCode == "00000000" {
                ProgressHUD.dismiss()
                if let order = response.data {
                    self.invokePaymentSDK(with: order)
                }
            } else if let errorMsg = response.respMsg {
                ProgressHUD.showError(errorMsg, interaction: true)
            }
        }
    }
    
    // pass order info to sdk, invoke sdk to pay
    func invokePaymentSDK(with order: OrderModel) {
        let orderAmount = order.orderAmount
        let payToken = order.payToken
        let sdkSessionID = order.sdkSessionId
        let sdkSignKey = order.sdkSignKey
        let goodsName = order.goodsName
        let appId = order.appId

        PalmPayPaymentCaller.makePayment(appID: appId,
                                         goodsName: goodsName,
                                         orderNo: sdkSessionID,
                                         orderAmount: NSNumber(value: orderAmount),
                                         payToken: payToken,
                                         sdkSessionID: sdkSessionID,
                                         sdkSignKey: sdkSignKey) { status, errorMessage in
        }
    }
    
    let environment = Environment.prod
    
    var defaultPrivateKey: String {
        if environment == .prod {
            return prodPrivateKey
        }
        return prodPrivateKey
    }
    
    var defaultAppId: String {
        if environment == .prod {
            return "L231207064662739637031"
        }
        return "L231127054769719185611"
    }
    
    func getParams() -> [String: Any] {
        
        var params: [String: Any] = [
            "country": "NG",
            "currency": "NGN",
            "productType": "pay_wallet"
        ]
        
        // amount
        var amountString = amountTextField.text ?? ""
        if amountString.isEmpty {
            amountString = "100"
        }
        let amount = NSDecimalNumber(string: amountString)
        let amountToPercents = amount.multiplying(by: NSDecimalNumber(string: "100")).stringValue
        params["amount"] = amountToPercents
        
        // order id
        let uuid = UUID().uuidString
        params["orderId"] = uuid
        
        // timestamp
        let timestamp = Int(Date().timeIntervalSince1970 * 1000)
        params["requestTime"] = timestamp
        
        // appid
        params["appid"] = defaultAppId
        if let inputAppId = appIdTextField.text, !inputAppId.isEmpty {
            params["appid"] = inputAppId
        }
        
        // goodsName
        var goodsName = goodsNameTextField.text ?? ""
        if goodsName.isEmpty {
            goodsName = "Test Goods Name"
        }
        params["goodsName"] = goodsName
        
        // private key
        params["privateKey"] = defaultPrivateKey
        if let key = privateKeyTextField.text, !key.isEmpty {
            params["privateKey"] = key
        }
        
        let version = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String
        params["version"] = version
        
        let nonceStr = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        params["nonceStr"] = nonceStr
        
        return params
    }
    
    // sign parameters to get signature, set signature to request header
    func getSignature(with params: [String: Any], privateKey: String) -> String {
        var querys: [String] = [String]()
        for key in params.keys.sorted() {
            querys.append("\(key)=\(params[key]!)")
        }
        let queryString = querys.joined(separator: "&")
        let md5 = Insecure.MD5.hash(data: Data(queryString.utf8)).map {
            String(format: "%02hhx", $0)
        }.joined()
        
        if let privateKey = try? PrivateKey(base64Encoded: privateKey), let clear = try? ClearMessage(string: md5.uppercased(), using: .utf8) {
            return (try? clear.signed(with: privateKey, digestType: .sha1).base64String) ?? ""
        }
        
        return ""
    }
    
}

