
Pod::Spec.new do |s|

  s.name         = "MapxusVisualSDK"
  s.version      = "3.7.0"
  s.summary      = "Indoor visual map sdk"
  s.description  = <<-DESC
                   Provide indoor visualization services.
                   DESC
  s.homepage     = "http://www.mapxus.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Mapxus" => "developer@maphive.io" }
  s.platform     = :ios, "9.0"
  s.source       = { :path => '../mapxus-visual-sdk-ios' }
  s.requires_arc = true
  s.module_name  = "MapxusVisualSDK"
  s.vendored_frameworks = "MapxusVisualSDK/MapxusVisualSDK.framework"
  s.dependency "MapxusBaseSDK", "3.7.0"

end