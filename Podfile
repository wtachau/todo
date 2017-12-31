# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Originate/CocoaPods.git'

def shared_pods
    pod 'Mantle', '~> 2.0.6'
    pod 'AFNetworking', '~> 3.0'
    pod 'PKFunctional', :git => 'https://github.com/wtachau/PKFunctional.git'
end

target 'ToDo' do
    platform :ios, '11.0'
    pod 'OriginateAutoLayout'
    pod 'PaperTrailLumberjack', :git => 'https://github.com/greenbits/papertrail-lumberjack-ios.git'
    pod 'SVProgressHUD'
    shared_pods
end

target 'ToDoMac' do
    platform :osx, '10.13'
    shared_pods
end
