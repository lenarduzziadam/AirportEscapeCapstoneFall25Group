**Bug Report #002**

**Emulated:** Yes

**Device:** Macbook air 2024 (16 gb ram, m4 chip, 512 gb)
**Operating System:** Mac OS Sequoia 15.6.1

**Emulator(/s):** iPhone 16 pro/iPhone 16e
**Emulator OS:** iOS 18.6

**Tester:** Adam Lenarduzzi

**Expected Behavior:** Application should compile and build successfully, allowing the app to launch on the iOS simulator without compilation errors.

**Actual Behavior:** Application fails to build with Swift compiler errors related to missing Google Maps modules. Build process terminates with "Could not build the application for the simulator" error message.

**Testing Method:** Manual testing

__Reproduction of Bug:__
    **Reproduction rate:** 10 out of 10 attempts (bug always produces itself - critical build failure)
    
    **Steps of reproduction:**
        1. Open terminal and navigate to project directory
        2. Run `flutter clean` followed by `flutter pub get`
        3. Execute `flutter run` command
        4. Observe build failure during iOS compilation phase
        5. Note specific Swift compiler errors about GoogleMaps module not found
                        

__Environment:__
    **Flutter version:** 3.35.2
    **Dart version:** 3.9.0
    **Sprint:** Sprint 3
    **Commit Range:** 1ba14f64a62c5b6cf7b9aa141797a79efdb74681 to 3c41298b28dac4c7602478e26e3e42e6727a5728

__Error Details:__
    **Primary Error:** Swift Compiler Error (Xcode): Module 'GoogleMaps' not found
    **Secondary Error:** Could not build Objective-C module 'GoogleMapsUtils'
    **Build Status:** Complete build failure - application cannot launch
    **Affected Files:** 
        - ios/Pods/Google-Maps-iOS-Utils/Sources/GoogleMapsUtilsObjC/include/GMSMarker+GMUClusteritem.h
        - CocoaPods dependency resolution
    
__Severity:__ Critical - Application cannot run or be tested
__Priority:__ High - Blocks all development and testing activities