#
# Be sure to run `pod lib lint MKCustomUIModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKCustomUIModule'
  s.version          = '1.0.14'
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
  
  s.resource_bundles = {
    'MKCustomUIModule' => ['MKCustomUIModule/Assets/*.png']
  }
  
  s.subspec 'Cell' do |ss|
    
    ss.subspec 'NormalCell' do |sss|
      sss.subspec 'MKNormalTextCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/NormalCell/MKNormalTextCell/**'
      end
      sss.subspec 'MKTextButtonCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/NormalCell/MKTextButtonCell/**'
        ssss.dependency 'MKCustomUIModule/View/MKPickerView'
      end
      sss.subspec 'MKTextFieldCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/NormalCell/MKTextFieldCell/**'
        ssss.dependency 'MKCustomUIModule/View/MKTextField'
      end
      sss.subspec 'MKTextSwitchCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/NormalCell/MKTextSwitchCell/**'
      end
      sss.subspec 'MKNormalSliderCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/NormalCell/MKNormalSliderCell/**'
        ssss.dependency 'MKCustomUIModule/View/MKSlider'
        ssss.dependency 'MKCustomUIModule/UIAdopter'
      end
    end
    
    ss.subspec 'LoRaCell' do |sss|
      sss.subspec 'MKLoraDeviceTypeCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/LoRaCell/MKLoraDeviceTypeCell/**'
      end
      
      sss.subspec 'MKMeasureTxPowerCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/LoRaCell/MKMeasureTxPowerCell/**'
        ssss.dependency 'MKCustomUIModule/View/MKSlider'
        ssss.dependency 'MKCustomUIModule/UIAdopter'
      end
      
      sss.subspec 'MKFilterDataCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/LoRaCell/MKFilterDataCell/**'
        ssss.dependency 'MKCustomUIModule/View/MKTextField'
      end
      
      sss.subspec 'MKAdvancedSettingCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/LoRaCell/MKAdvancedSettingCell/**'
      end
      
      sss.subspec 'MKMixedChoiceCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/LoRaCell/MKMixedChoiceCell/**'
      end
      
      sss.subspec 'MKLoRaSettingCHCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/LoRaCell/MKLoRaSettingCHCell/**'
        ssss.dependency 'MKCustomUIModule/View/MKPickerView'
      end
      
      sss.subspec 'MKFilterRawAdvDataCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/LoRaCell/MKFilterRawAdvDataCell/**'
        ssss.dependency 'MKCustomUIModule/View/MKTextField'
      end
      
      sss.subspec 'MKRawAdvDataOperationCell' do |ssss|
        ssss.source_files = 'MKCustomUIModule/Classes/Cell/LoRaCell/MKRawAdvDataOperationCell/**'
      end
      
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
      sss.dependency 'MKCustomUIModule/UIAdopter'
    end
    ss.subspec 'MKSlider' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKSlider/**'
    end
    ss.subspec 'MKSearchConditionsView' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKSearchConditionsView/**'
      sss.dependency 'MKCustomUIModule/UIAdopter'
      sss.dependency 'MKCustomUIModule/View/MKSlider'
    end
    ss.subspec 'MKSearchButton' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKSearchButton/**'
    end
    ss.subspec 'MKTextField' do |sss|
      sss.source_files = 'MKCustomUIModule/Classes/View/MKTextField/**'
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
