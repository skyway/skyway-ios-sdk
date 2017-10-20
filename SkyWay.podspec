Pod::Spec.new do |s|
  s.name             = 'SkyWay'
  s.version          = '1.0.2'
  s.summary          = 'SkyWay simplifies peer-to-peer data, video, and audio calls using WebRTC.'
  s.description      = <<-DESC
  "SkyWay" is a framework that enables using SkyWay in iOS apps.
SkyWay simplifies peer-to-peer data, video, and audio calls using WebRTC.
                       DESC
  s.homepage         = 'https://webrtc.ecl.ntt.com'
  s.license          = { :type => 'Apache License', :file => 'LICENSE.txt' }
  s.author           = { 'NTT Communications' => 'skyway@ntt.com' }
  s.source           = { :git => 'https://github.com/skyway/skyway-ios-sdk.git', :tag => "v1.0.2" }
  s.exclude_files = 'examples'
  s.ios.deployment_target = '8.0'
  s.vendored_frameworks = 'SkyWay.framework'
end
