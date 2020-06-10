Pod::Spec.new do |s|

  s.name         = "Peoplepower-Resources"
  s.summary      = "People Power Resources."
  s.description  = "Utility for retrieving Peoplepower Resources."
  s.homepage     = "http://www.peoplepowerco.com"
  
  s.license      = "Copyright © 2020 People Power Company. All rights reserved."
  
  s.author             = { "Destry Teeter" => "destry.teeter@gmail.com" }
  s.social_media_url   = "http://twitter.com/DestryTeeter"
  
  s.version      = "0.1.1"
  
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/destryteeter/Peoplepower.git", :tag => "#{s.version}" }

  s.resources = "Peoplepower/Resources/*.{plist}"
end
