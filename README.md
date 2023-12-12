# payment-demo-ios

### SDK Integration

1. Add private specs to your Podfile:
   
   ```ruby
   source 'https://github.com/PalmPayGroup/payment-demo-ios.git'
   ```
   
2. Add the pod to your Podfile:

   ```ruby
   pod 'PalmPayPayment'
   ```

3. And then run:

   ```ruby
   pod install
   ```
   
4. Make payment

   ```swift
   // step 1
   // create order(from backend)
   // order type definition
   struct Order: Codable {
      var orderAmount: Int
      var orderNo: String
      var sdkSessionId: String
      var appId: String
      var orderStatus: Int
      var goodsName: String
      var merchantNo: String
      var merchantName: String
      var payToken: String
      var sdkSignKey: String
      var checkoutUrl: String
   }

   // step2
   // get order info from backend, then pass order info to sdk
   // make payment
   func makePayment() {
        guard let order = result else {
            return
        }
        
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
             // status: "000000" for success, other for error
             // errorMessage: cause of failure
        }
    }
   ```
