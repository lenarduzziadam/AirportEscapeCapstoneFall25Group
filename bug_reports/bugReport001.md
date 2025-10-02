**Emulated:** Yes

**Device:** Macbook air 2024 (16 gb ram, m4 chip, 512 gb)
**Operarting System:** Mac OS Squoioa 15.6.1

**Emulator(/s):** iphone 16 pro/iphone 16e
**Emulator OS:** IOS 18.6

**Tester:** Adam Lenarduzzi

**Expected Behavior:** Plan layover screen should either display a default state (such as placeholder text (ex. "Make a selection"), or a default airport) or pre populate with a sensible default value when screen intially loads. 

**Actual Behvarior:** Airport information area displays as blank/empty until a selection is made with dropdown menu. 

**Testing Method:** Manual testing

**Reproduction of Bug:** 1. Open App
                        2. click "My layover" button
                        3. As soon as you load in notice how the location/location is not showing up until after an option is selected.
                        

__Enviorment:__

    **Flutter version:** 3.35.2
    **Dart version:** 3.9.0
    **Sprint:** Sprint 3
    **Commit:** 5df6536364b2ee2cebfa78d9b2d34bcd2ccd502f