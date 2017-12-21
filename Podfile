# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Originate/CocoaPods.git'

def import_pods
    pod 'Mantle', '~> 2.0.6'
end

target 'ToDo' do
    platform :ios, '11.0'
    import_pods
    pod 'OriginateAutoLayout'
    pod 'OriginateHTTP'
    pod 'PaperTrailLumberjack', :git => 'https://github.com/greenbits/papertrail-lumberjack-ios.git'
end

target 'ToDoMac' do
    platform :osx, '10.13'
    import_pods
end
