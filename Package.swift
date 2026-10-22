// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "MKCustomUIModule",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "MKCustomUIModule",
            targets: ["MKCustomUIModule"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/MOKO-iOS-Base-Library/MKBaseModuleLibrary.git", from: "2.2.14"),
    ],
    targets: [
        .target(
            name: "MKCustomUIModule",
            dependencies: ["MKBaseModuleLibrary"],
            path: "MKCustomUIModule",
            sources: ["Classes"],
            resources: [.process("Assets")],
            publicHeadersPath: "Classes/PublicHeaders",
            cSettings: [
                .headerSearchPath("Classes"),
                .headerSearchPath("Classes/Cell"),
                .headerSearchPath("Classes/Cell/FilterCell"),
                .headerSearchPath("Classes/Cell/FilterCell/FilterBeaconCell"),
                .headerSearchPath("Classes/Cell/FilterCell/FilterByRawDataCell"),
                .headerSearchPath("Classes/Cell/FilterCell/FilterEditSectionHeaderView"),
                .headerSearchPath("Classes/Cell/FilterCell/FilterNormalTextFieldCell"),
                .headerSearchPath("Classes/Cell/LoRaCell"),
                .headerSearchPath("Classes/Cell/LoRaCell/MKAdvancedSettingCell"),
                .headerSearchPath("Classes/Cell/LoRaCell/MKFilterConditionCell"),
                .headerSearchPath("Classes/Cell/LoRaCell/MKFilterDataCell"),
                .headerSearchPath("Classes/Cell/LoRaCell/MKFilterRawAdvDataCell"),
                .headerSearchPath("Classes/Cell/LoRaCell/MKLoRaSettingCHCell"),
                .headerSearchPath("Classes/Cell/LoRaCell/MKMeasureTxPowerCell"),
                .headerSearchPath("Classes/Cell/LoRaCell/MKMixedChoiceCell"),
                .headerSearchPath("Classes/Cell/LoRaCell/MKRawAdvDataOperationCell"),
                .headerSearchPath("Classes/Cell/NormalCell"),
                .headerSearchPath("Classes/Cell/NormalCell/MKButtonMsgCell"),
                .headerSearchPath("Classes/Cell/NormalCell/MKDeviceInfoCell"),
                .headerSearchPath("Classes/Cell/NormalCell/MKDeviceInfoDfuCell"),
                .headerSearchPath("Classes/Cell/NormalCell/MKNormalSliderCell"),
                .headerSearchPath("Classes/Cell/NormalCell/MKNormalTextCell"),
                .headerSearchPath("Classes/Cell/NormalCell/MKSettingTextCell"),
                .headerSearchPath("Classes/Cell/NormalCell/MKTextButtonCell"),
                .headerSearchPath("Classes/Cell/NormalCell/MKTextFieldCell"),
                .headerSearchPath("Classes/Cell/NormalCell/MKTextSwitchCell"),
                .headerSearchPath("Classes/Controller"),
                .headerSearchPath("Classes/Controller/CASelectPage"),
                .headerSearchPath("Classes/Controller/CASelectPage/Controller"),
                .headerSearchPath("Classes/Controller/MKAboutPage"),
                .headerSearchPath("Classes/Controller/MKAboutPage/Controller"),
                .headerSearchPath("Classes/Controller/MKAboutPage/Model"),
                .headerSearchPath("Classes/Controller/MKAboutPage/View"),
                .headerSearchPath("Classes/Controller/MKTrackerAboutPage"),
                .headerSearchPath("Classes/Controller/MKTrackerAboutPage/Controller"),
                .headerSearchPath("Classes/MQTTServerView"),
                .headerSearchPath("Classes/MQTTServerView/GeneralParams"),
                .headerSearchPath("Classes/MQTTServerView/SSL"),
                .headerSearchPath("Classes/MQTTServerView/UserCredentials"),
                .headerSearchPath("Classes/UIAdopter"),
                .headerSearchPath("Classes/Vendor/MJRefresh/include"),
                .headerSearchPath("Classes/Vendor/MJRefresh"),
                .headerSearchPath("Classes/Vendor/MJRefresh/Base"),
                .headerSearchPath("Classes/Vendor/MJRefresh/Custom"),
                .headerSearchPath("Classes/Vendor/MJRefresh/Custom/Footer"),
                .headerSearchPath("Classes/Vendor/MJRefresh/Custom/Footer/Auto"),
                .headerSearchPath("Classes/Vendor/MJRefresh/Custom/Footer/Back"),
                .headerSearchPath("Classes/Vendor/MJRefresh/Custom/Header"),
                .headerSearchPath("Classes/Vendor/MJRefresh/Custom/Trailer"),
                .headerSearchPath("Classes/Vendor/CircleProgressBar"),
                .headerSearchPath("Classes/View"),
                .headerSearchPath("Classes/View/HaveRefreshView"),
                .headerSearchPath("Classes/View/MKAlertView"),
                .headerSearchPath("Classes/View/MKHexKeyBoard"),
                .headerSearchPath("Classes/View/MKHudManager"),
                .headerSearchPath("Classes/View/MKPageControl"),
                .headerSearchPath("Classes/View/MKPickerView"),
                .headerSearchPath("Classes/View/MKProgressView"),
                .headerSearchPath("Classes/View/MKSearchButton"),
                .headerSearchPath("Classes/View/MKSearchConditionsView"),
                .headerSearchPath("Classes/View/MKSlider"),
                .headerSearchPath("Classes/View/MKTableSectionHeader"),
                .headerSearchPath("Classes/View/MKTextField"),
                .headerSearchPath("Classes/View/MKTimePicker"),
                .headerSearchPath("Classes/View/NirKxMenu"),
                .headerSearchPath("Classes/View/WifiAlertView"),
            ],
            linkerSettings: [
                .linkedFramework("UIKit"),
                .linkedFramework("QuartzCore")
            ]
        )
    ]
)
