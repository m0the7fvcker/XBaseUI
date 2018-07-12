#
# Be sure to run `pod lib lint BaseUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XBaseUI'
  s.version          = '1.0.0'
  s.summary          = 'A short description of BaseUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Ge3kXm/XBaseUI.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Poly.ma' => 'ge3kxm@gmail.com' }
  s.source           = { :git => 'https://github.com/Ge3kXm/XBaseUI.git.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.1'
  
  s.source_files = 'XBaseUI/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XBaseUI' => ['XBaseUI/Assets/*.png']
  # }

  # s.public_header_files = 'XBaseUI/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'MJRefresh'
  s.dependency 'XBaseUtils' , '~> 1.0.3'
end
