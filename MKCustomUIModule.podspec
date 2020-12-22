#
# Be sure to run `pod lib lint MKCustomUIModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKCustomUIModule'
  s.version          = '1.0.0'
  s.summary          = '通用UI组件库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MOKO-iOS-Base-Library/MKCustomUIModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/MOKO-iOS-Base-Library/MKCustomUIModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'MKCustomUIModule/Classes/**/*'
  
  s.resource_bundles = {
    'MKCustomUIModule' => ['MKCustomUIModule/Assets/*.png']
  }
  
  s.subspec 'Cell' do |ss|
    ss.subspec 'MKLoraDeviceTypeCell' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/Cell/MKLoraDeviceTypeCell/**'
    end
    ss.subspec 'MKNormalTextCell' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/Cell/MKNormalTextCell/**'
    end
    ss.subspec 'MKTextButtonCell' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/Cell/MKTextButtonCell/**'
    end
    ss.subspec 'MKTextFieldCell' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/Cell/MKTextFieldCell/**'
    end
    ss.subspec 'MKMeasureTxPowerCell' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/Cell/MKMeasureTxPowerCell/**'
    end
    ss.subspec 'MKTextSwitchCell' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/Cell/MKTextSwitchCell/**'
    end
  end
  
  s.subspec 'View' do |ss|
    ss.subspec 'HaveRefreshView' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/HaveRefreshView/**'
    end
    ss.subspec 'MKHexKeyBoard' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKHexKeyBoard/**'
    end
    ss.subspec 'MKHudManager' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKHudManager/**'
    end
    ss.subspec 'MKPageControl' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKPageControl/**'
    end
    ss.subspec 'MKProgressView' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKProgressView/**'
    end
    ss.subspec 'MKPickerView' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKPickerView/**'
    end
    ss.subspec 'MKSlider' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKSlider/**'
    end
  end
  
  s.subspec 'Controller' do |ss|
    ss.subspec 'MKTrackerAboutPage' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKCustomUIModule/Classes/Controller/MKTrackerAboutPage/Controller/**'
        end
    end
    ss.subspec 'MKTrackerLogPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Controller/MKTrackerLogPage/Controller/**'
      end
    end
  end
  
  s.subspec 'UIAdopter' do |ss|
    ss.source_files = 'MKCustomUIModule/Classes/UIAdopter/**'
  end
  
  s.dependency 'MJRefresh'
  s.dependency 'MBProgressHUD'
  s.dependency 'CircleProgressBar'
  s.dependency 'Masonry'
  
  s.dependency 'MKBaseModuleLibrary'
  
end