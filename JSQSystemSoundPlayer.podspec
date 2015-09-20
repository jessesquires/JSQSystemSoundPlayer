Pod::Spec.new do |s|
   s.name = 'JSQSystemSoundPlayer'
   s.version = '4.2.0'
   s.license = 'MIT'

   s.summary = 'A fancy Obj-C wrapper for Cocoa System Sound Services'
   s.homepage = 'https://github.com/jessesquires/JSQSystemSoundPlayer'
   s.documentation_url = 'http://jessesquires.com/JSQSystemSoundPlayer'

   s.social_media_url = 'https://twitter.com/jesse_squires'
   s.author = { 'Jesse Squires' => 'jesse.squires.developer@gmail.com' }

   s.source = { :git => 'https://github.com/jessesquires/JSQSystemSoundPlayer.git', :tag => s.version }
   s.source_files = 'JSQSystemSoundPlayer/JSQSystemSoundPlayer/*.{h,m}'

   s.ios.deployment_target = '6.0'
   s.ios.frameworks = 'AudioToolbox', 'Foundation', 'UIKit'

   s.osx.deployment_target = '10.7'
   s.osx.frameworks = 'AudioToolbox', 'Foundation'

   s.requires_arc = true
end
