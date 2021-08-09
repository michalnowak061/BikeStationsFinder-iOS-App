# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'BikeStationsFinder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # ignore all warnings from all pods
  inhibit_all_warnings!

  # Pods for BikeStationsFinder
  pod 'Alamofire', '5.4'
  pod 'SnapKit', '5.0.0'
  pod 'AMDots', '1.0.2'

  pod 'SwiftLint', '0.43.1'
  pod 'Periphery', '2.8.1'

  target 'BikeStationsFinderTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |pi|
   pi.pods_project.targets.each do |t|
       t.build_configurations.each do |bc|
           if bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] == '8.0'
             bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
           end
       end
   end
end