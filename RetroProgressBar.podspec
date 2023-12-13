Pod::Spec.new do |s|
  s.name             = 'RetroProgressBar'
  s.version          = '1.0.0'
  s.summary          = 'A progress bar inspired by old versions of iOS and Mac OS X'
  s.homepage         = 'https://github.com/maxkalik/RetroProgressBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Max Kalik' => 'maxkalik@gmail.com' }
  s.source           = { :git => 'https://github.com/maxkalik/RetroProgressBar.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/RetroProgressBar/**/*'
end
