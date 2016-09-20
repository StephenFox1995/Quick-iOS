source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

target 'QuickAppTests' do
  pod 'SwiftyJSON', :git => 'https://github.com/IBM-Swift/SwiftyJSON' # Swift 3: True
  pod 'Quick' # Swift 3: False
  pod 'Nimble', '~> 5.0.0' # Swift 3: True
end

target 'QuickApp' do
    pod 'Alamofire', '~> 4.0' # Swift 3: True
    pod 'SwiftyJSON', :git => 'https://github.com/IBM-Swift/SwiftyJSON' # Swift 3: ?
    pod 'JWTDecode', '~> 2.0' # Swift 3: True
    pod 'Cartography', :git => 'https://github.com/robb/Cartography', :branch => 'orta-swift3'
    pod 'Locksmith' # Swift 3: True
    pod 'FontAwesome.swift', :git => 'https://github.com/thii/FontAwesome.swift' # Swift 3: True
end

