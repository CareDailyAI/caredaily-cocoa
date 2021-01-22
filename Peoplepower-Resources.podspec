Pod::Spec.new do |s|

  s.name         = "Peoplepower-Resources"
  s.summary      = "People Power Resources."
  s.description  = "Utility for retrieving Peoplepower Resources."
  s.homepage     = "http://www.peoplepowerco.com"
  
  s.license      = "Copyright © 2020 People Power Company. All rights reserved."
  
  s.author             = { "Destry Teeter" => "destry.teeter@gmail.com" }
  s.social_media_url   = "http://twitter.com/DestryTeeter"
  
  s.version      = "0.1.6"
  
  s.ios.deployment_target = "11.0"
  s.watchos.deployment_target = "6.0"
#  s.osx.deployment_target = "10.9"
#  s.tvos.deployment_target = "9.0"
  
  s.source       = { :git => "https://github.com/destryteeter/Peoplepower.git", :tag => "#{s.version}" }
  
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
end
