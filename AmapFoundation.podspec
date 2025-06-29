require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "AmapFoundation"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_version_supported }
  s.source       = { :git => "https://github.com/472647301/react-native-amap-foundation.git", :tag => "#{s.version}" }
  # s.xcconfig     = { "OTHER_LDFLAGS" => "-ObjC" }
  
  s.source_files = "ios/**/*.{h,m,mm,cpp}"
  s.private_header_files = "ios/**/*.h"
  
  s.dependency 'AMap3DMap-NO-IDFA', '10.0.1000' 

 install_modules_dependencies(s)
end
