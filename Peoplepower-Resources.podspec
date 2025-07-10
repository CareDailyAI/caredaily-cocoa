Pod::Spec.new do |s|

  s.name         = "Peoplepower-Resources"
  s.summary      = "Care Daily Resources."
  s.description  = "Utility for retrieving Care Daily Resources."
  s.homepage     = "https://caredaily.ai"
  
  s.license      = "Copyright © 2023 People Power Company. All rights reserved."
  
  s.author             = { "Destry Teeter" => "destry.teeter@gmail.com" }
  s.social_media_url   = "http://twitter.com/DestryTeeter"
  
  s.version      = "1.0.31"
  
  s.ios.deployment_target = "11.0"
  s.watchos.deployment_target = "6.0"
#  s.osx.deployment_target = "10.9"
#  s.tvos.deployment_target = "9.0"
  
  s.source       = { :git => "https://github.com/CareDailyAI/caredaily-cocoa.git", :tag => "#{s.version}" }
  
  s.subspec 'iOS' do |ios|
    ios.resources = "Sources/*.{plist,strings}"
    ios.resource_bundles = {
      'Peoplepower' => ['Sources/**/*.lproj']
    }
  end
  
  s.subspec 'watchOS' do |watchos|
    watchos.resources = "Sources/*.{plist,strings}"
    watchos.resource_bundles = {
      'Peoplepower' => ['Sources/**/*.lproj']
    }
  end
  
  s.subspec 'Tests' do |ios|
    ios.resources = "Tests/Data/*.{json,txt,m4a,jpeg,mp4}"
  end
end
