source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'RandomAnimals' do
  pod 'Alamofire', '4.8'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      if target.name == 'Movs'
          target.build_configurations.each do |config|
              if config.name == 'Debug'
                  config.build_settings['OTHER_SWIFT_FLAGS'] = '-DDEBUG'
                  else
                  config.build_settings['OTHER_SWIFT_FLAGS'] = ''
              end
          end
      end
  end
end
