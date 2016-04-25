Pod::Spec.new do |s|
   s.name = 'JSQSystemSoundPlayer'
   s.version = '4.4.0'
   s.license = 'MIT'

   s.summary = 'A fancy Obj-C wrapper for Cocoa System Sound Services'
   s.homepage = 'https://github.com/jessesquires/JSQSystemSoundPlayer'
   s.documentation_url = 'http://jessesquires.com/JSQSystemSoundPlayer'

   s.social_media_url = 'https://twitter.com/jesse_squires'
   s.author = 'Jesse Squires'

   s.source = { :git => 'https://github.com/jessesquires/JSQSystemSoundPlayer.git', :tag => s.version }
   s.source_files = 'Source/*.{h,m}'

   s.ios.deployment_target = '6.0'
   s.osx.deployment_target = '10.7'
   s.tvos.deployment_target = '9.0'

   s.frameworks = 'AudioToolbox'

   s.requires_arc = true
end
