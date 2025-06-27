Pod::Spec.new do |s|
  s.name             = 'SkyWay'
  s.version          = '5.0.0'
  s.summary          = 'SkyWay simplifies peer-to-peer data, video, and audio calls using WebRTC.'
  s.description      = <<-DESC
  "SkyWay" is a framework that enables using SkyWay in iOS apps.
SkyWay simplifies peer-to-peer data, video, and audio calls using WebRTC.
                       DESC
  s.homepage         = 'https://webrtc.ecl.ntt.com'
  s.license          = { :type => 'Apache License', :file => 'LICENSE.txt' }
  s.author           = { 'NTT DOCOMO BUSINESS, Inc.' => 'skyway@ntt.com' }
  s.source           = { :http => 'https://github.com/skyway/skyway-ios-sdk/releases/download/v5.0.0/SkyWay_iOS_5.0.0.zip', :flatten => true }
  s.ios.deployment_target = '11.0'
  s.vendored_frameworks = 'SkyWay.framework'
  s.source_files  = 'SkyWay.framework/Headers/*.h'
  s.preserve_paths  = 'SkyWay.framework'
end
