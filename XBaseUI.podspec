#
# Be sure to run `pod lib lint BaseUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XBaseUI'
  s.version          = '1.0.2'
  s.summary          = 'A short description of BaseUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Ge3kX/XBaseUI.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ge3kX' => 'ge3kxm@gmail.com' }
  s.source           = { :git => 'https://github.com/Ge3kX/XBaseUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.1'
  
  s.source_files = 'XBaseUI/Classes/**/*'
  
  s.resource_bundles = {
     'XBaseUI' => ['XBaseUI/Assets/*.xcassets',
                    'XBaseUI/Assets/*.png',
                    'XBaseUI/Assets/*.bundle']
  }
  
  # s.public_header_files = 'XBaseUI/Classes/**/*.h'
  s.frameworks = 'UIKit'
  
  s.dependency 'MJRefresh'
  s.dependency 'XBaseUtils'
  s.dependency 'XResourceTool'
  s.dependency 'SnapKit'
  s.dependency 'WebViewJavascriptBridge'
  s.dependency 'PKHUD' , '~> 5.1.0'
  s.dependency 'Toast-Swift' , '~> 3.0.1'
  
end
