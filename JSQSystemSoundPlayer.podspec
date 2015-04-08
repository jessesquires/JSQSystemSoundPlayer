Pod::Spec.new do |s|
	s.name				= 'JSQSystemSoundPlayer'
	s.version			= '2.0.1'
	s.summary			= 'A fancy Obj-C wrapper for iOS System Sound Services'
	s.homepage			= 'https://github.com/jessesquires/JSQSystemSoundPlayer'
	s.social_media_url	= 'https://twitter.com/jesse_squires'
	s.license			= 'MIT'
	s.author			= { 'Jesse Squires' => 'jesse.squires.developer@gmail.com' }
	s.source			= { :git => 'https://github.com/jessesquires/JSQSystemSoundPlayer.git', :tag => s.version.to_s }
	s.ios.deployment_target = '6.0'
	s.osx.deployment_target = '10.6'
	s.source_files		= 'JSQSystemSoundPlayer/Classes/*'
	s.ios.frameworks	= 'AudioToolbox', 'Foundation', 'UIKit'
	s.osx.frameworks	= 'AudioToolbox', 'Foundation',
	s.requires_arc		= true
end
