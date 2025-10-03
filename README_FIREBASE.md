🚀 Airport Escape – Quick Start (VS Code)
This guide shows how to open the project, install dependencies, and run it in VS Code.
No extra Firebase setup is required — the configuration files are already included in the repository.

## 1️⃣ Open the Project in VS Code

- Open VS Code.
- Go to **File → Open Folder…**  
- Select: `AirportEscapeCapstoneFall25Group/airport_escape`

*(Optional)* If you have the `code` command installed, you can run:

cd AirportEscapeCapstoneFall25Group/airport_escape
code .

2️⃣ Make Sure Flutter Is Installed
Run this to verify your Flutter + Dart setup:

bash
Copy code
flutter doctor
If any components are missing, follow the instructions Flutter gives you to install them.

Make sure Chrome is installed if you plan to run the app on the web.

3️⃣ Install Project Dependencies
Inside the project folder, run:

bash
Copy code
flutter pub get
This downloads all packages (including Firebase).
If you are running on iOS or macOS, also run cd ios && pod install && cd .. (or cd macos && pod install && cd ..) after flutter pub get.

4️⃣ Choose a Device to Run On
Web: Use Chrome

Mobile: Use Android Emulator or iOS Simulator

Physical Device: Plug it in and enable developer mode

Check available devices with:

bash
Copy code
flutter devices

5️⃣ Run the App
Once dependencies are installed and a device is selected, run:

bash
Copy code
flutter run
VS Code will launch the app on the selected device or browser.

✅ Firebase Notes
The Firebase configuration files (google-services.json, GoogleService-Info.plist, firebase.json, and firebase_options.dart) are already included in the repo.

You do NOT need to run flutterfire configure or add any extra Firebase keys.

When the app runs, it will automatically initialize Firebase and connect to the provided Realtime Database.

📝 Troubleshooting
If VS Code doesn’t recognize Flutter commands, install the Flutter extension from the Extensions Marketplace.

If you change any dependencies, re-run:

bash
Copy code
flutter pub get
If you’re on macOS and see build errors, run:

bash
Copy code
flutter clean
flutter pub get
and then try flutter run again.
