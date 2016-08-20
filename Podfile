source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'QuickAppTests' do
  testing_pods
end

target 'QuickApp' do
    pod 'Alamofire', '~> 3.4'
    pod 'SwiftyJSON'
    pod "JWTDecode", '~> 1.0'
    pod 'Locksmith'
end
