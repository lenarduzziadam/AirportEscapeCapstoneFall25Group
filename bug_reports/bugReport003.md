**Bug Report #003**

**Emulated:** Yes

**Device:** Macbook air 2024 (16 gb ram, m4 chip, 512 gb)
**Operating System:** Mac OS Sequoia 15.6.1

**Emulator(/s):** iPhone 16 pro/iPhone 16e, macOS Desktop
**Emulator OS:** iOS 18.6, macOS 15.6.1

**Tester:** Adam Lenarduzzi

**Expected Behavior:** Application should compile and build successfully on both iOS and macOS simulators from the kavindu_alt branch without deployment target compatibility errors.

**Actual Behavior:** Application consistently fails to build with kernel snapshot packaging failure and macOS deployment target incompatibility warnings. Build terminates with "BUILD FAILED" status on both iOS and macOS simulation targets.

**Testing Method:** Manual testing

__Reproduction of Bug:__
    **Reproduction rate:** 10 out of 10 attempts (bug always produces itself - critical build failure)
    
    **Steps of reproduction:**
        1. Switch to kavindu_alt branch: `git checkout kavindu_alt`
        2. Create test branch: `git checkout -b adam_test_kavindu`
        3. Run `flutter clean` followed by `flutter pub get`
        4. Execute `flutter run` command for iOS simulator
        5. Observe build failure with kernel snapshot packaging error
        6. Repeat process targeting macOS simulator
        7. Note identical failure pattern across both platforms
                        

__Environment:__
    **Flutter version:** 3.35.2
    **Dart version:** 3.9.0
    **Sprint:** Sprint 3
    **Branch:** kavindu_alt (tested on adam_test_kavindu)
    **Commit:** kavindu_alt branch specific commit

__Error Details:__
    **Primary Error:** Target kernel_snapshot_program failed: Exception
    **Secondary Error:** Failed to package /Users/adamlenarduzzi/development/serious_projects/AirportEscapeCapstoneFall25Group/airport_escape
    **Tertiary Error:** Command PhaseScriptExecution failed with a nonzero exit code
    **Deployment Warning:** The macOS deployment target 'MACOSX_DEPLOYMENT_TARGET' is set to 10.11, but the range of supported deployment target versions is 10.13 to 15.5.99
    **Build Status:** Complete build failure - application cannot launch on any platform
    **Affected Targets:** 
        - Flutter Assemble (Runner project)
        - geolocator_apple-geolocator_apple_privacy (Pods project)
        - Both iOS and macOS simulation environments
    
__Severity:__ Critical - Branch completely non-functional, blocks all testing
__Priority:__ High - Prevents integration of kavindu_alt branch features

__Additional Notes:__ 
    - Error occurs immediately during build phase before any application code execution
    - Issue appears to be related to deployment target configuration in Pods and build scripts
    - Both iOS and macOS targets affected equally
    - No platform-specific workarounds available