
Pod::Spec.new do |s|

  s.name         = "MapxusVisualSDK"
  s.version      = "3.11.1"
  s.summary      = "Indoor visual map sdk"
  s.description  = <<-DESC
                   Provide indoor visualization services.
                   DESC
  s.homepage     = "http://www.mapxus.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Mapxus" => "developer@maphive.io" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://github.com/MapxusSample/mapxus-visual-sdk-ios.git', :tag => "#{s.version}" }
  s.requires_arc = true
  s.module_name  = "MapxusVisualSDK"
  s.vendored_frameworks = "MapxusVisualSDK/MapxusVisualSDK.framework"
  s.dependency "MapxusBaseSDK", "3.11.1"

end