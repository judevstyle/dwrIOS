# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'EwsAppiOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for EwsAppiOS

pod 'MaterialComponents/ActionSheet'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'Google-Maps-iOS-Utils', '~> 3.2.1'
  pod 'Moya'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya/RxSwift'
  pod 'Toast-Swift', '~> 5.0.1'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'Bolts'
pod 'SideMenu', '~> 6.0'
pod 'IQKeyboardManagerSwift'
pod 'TOCropViewController', '~> 2.6.1'

end
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
               end
          end
   end
end


