#
# Be sure to run `pod lib lint PalmPayPayment.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PalmPayPayment'
  s.version          = '1.0.0.2311301'
  s.summary          = 'A short description of PalmPayPayment.'
  s.homepage         = 'https://github.com/orgs/PalmPayGroup/repositories/payment-demo-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'palmpay' => 'opensdk-ios@palmpay-inc.com' }
  s.source           = { :http => 'https://static.chuanyinet.com/files/felpkjkr4m3p7vne/palmpay_payment.1.0.0.2311301.zip' }

  s.ios.deployment_target = '11.0'
  s.static_framework = true
  s.vendored_frameworks = 'PalmPayPaymentSDK.framework'
  s.resources = "PalmPayPaymentSDK.framework/PalmPayPaymentSDK.bundle"
end
