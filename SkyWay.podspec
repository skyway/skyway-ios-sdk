Pod::Spec.new do |s|
  s.name             = 'SkyWay'
  s.version          = '1.0.3'
  s.summary          = 'SkyWay simplifies peer-to-peer data, video, and audio calls using WebRTC.'
  s.description      = <<-DESC
  "SkyWay" is a framework that enables using SkyWay in iOS apps.
SkyWay simplifies peer-to-peer data, video, and audio calls using WebRTC.
                       DESC
  s.homepage         = 'https://webrtc.ecl.ntt.com'
  s.license          = { :type => 'Apache License', :file => 'LICENSE.txt' }
  s.author           = { 'NTT Communications' => 'skyway@ntt.com' }
  s.source           = { :http => 'https://github.com/skyway/skyway-ios-sdk/releases/download/v1.0.3/SkyWay_iOS_1.0.3.zip', :flatten => true }
  s.ios.deployment_target = '8.0'
  s.vendored_frameworks = 'SkyWay.framework'
  s.source_files  = 'SkyWay.framework/Headers/*.h'
  s.preserve_paths  = 'SkyWay.framework'
  s.xcconfig  = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/SkyWay.framework/**"' }
end
