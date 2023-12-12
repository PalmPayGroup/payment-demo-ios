//
//  OrderModel.swift
//  PaymentSDKDemo
//
//  Created by Leo on 2023/12/12.
//

import Foundation

struct ResponsePrototype: Codable {
    var respMsg: String?
    var respCode: String?
    var data: OrderModel?
}

struct OrderModel: Codable {
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
