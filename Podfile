# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'

workspace 'Jay.xcworkspace'

target 'Jay' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Jay
  pod 'SteviaLayout', '~>4.4.0'
  pod 'ActionKit', '~> 2.4.0'
  pod 'KeychainSwift', '~> 13.0'
  pod 'RealmSwift'

  target 'JayTests' do
    pod 'Quick'
    pod 'Nimble'
  end

  target 'JayUITests' do
    pod 'Quick'
    pod 'Nimble'
  end

  target 'Jay.Domain' do
    project 'Jay.Domain/Jay.Domain.xcodeproj'
    inherit! :search_paths
  end
end

