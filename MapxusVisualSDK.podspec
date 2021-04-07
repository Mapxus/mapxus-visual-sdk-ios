
Pod::Spec.new do |s|


  version = '3.21.0'

  s.name         = 'MapxusVisualSDK'
  s.version      = version

  s.summary      = 'Indoor visual map sdk'
  s.description  = 'Provide indoor visualization services.'
  s.homepage     = 'http://www.mapxus.com'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Mapxus' => 'developer@maphive.io' }

  s.platform     = :ios, '9.0'

  s.source       = { :http => "https://ios-sdk.mapxus.com/#{version.to_s}/mapxus-visual-sdk-ios.zip", :flatten => true }

  s.requires_arc = true

  s.module_name  = 'MapxusVisualSDK'
  s.vendored_frameworks = 'dynamic/MapxusVisualSDK.framework'

  s.dependency "MapxusBaseSDK", version


end