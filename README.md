# Airport Escape

**For passengers, by passengers** - A Flutter mobile application that helps travelers make the most of their layover time by discovering nearby activities and attractions around airports.

## 🎯 Project Overview

Airport Escape is designed to transform tedious layover waiting into exciting mini-adventures. The app provides personalized recommendations for restaurants, shopping, and entertainment venues near airports based on your layover duration and location.

## ✨ Key Features

### Core Functionality
- **Smart Activity Recommendations**: Discover restaurants, shopping centers, and entertainment venues near your layover airport
- **Duration-Based Suggestions**: Activities are filtered based on your layover time (3 hours = 10km radius, 6+ hours = 20km+ radius)
- **Real-time Distance Calculation**: See exact distances and travel times from the airport
- **Interactive Maps**: Visualize activity locations with integrated Google Maps

### User Experience
- **Multi-language Support**: Available in 11 languages (English, Spanish, French, German, Italian, Arabic, Russian, Korean, Japanese, Chinese, Hindi)
- **Dark/Light Theme**: Adaptive theming with user preference persistence
- **Favorites System**: Save preferred destinations with heart icons for quick access
- **User Accounts**: Login system with personalized saved destinations
- **Brightness Control**: Adjustable screen brightness for various lighting conditions

### Technical Features
- **Offline Capability**: Core features work without constant internet connection
- **Firebase Integration**: Real-time database for user data and preferences
- **Google Places API**: Comprehensive location data and reviews
- **Geolocation Services**: Accurate distance calculations and mapping
- **Settings Persistence**: User preferences saved across app sessions

## 🏗️ Architecture

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase Realtime Database
- **APIs**: Google Places API, Google Maps API
- **State Management**: Provider pattern
- **Localization**: Flutter's built-in i18n with ARB files
- **Storage**: SharedPreferences for local data persistence

## 📱 App Structure

AirportEscapeCapstoneFall25Group/
├── airport_escape/                # Main Flutter application
│   ├── lib/
│   │   ├── main.dart             # 🎯 Primary development file
│   │   ├── landing_page.dart     # Home screen with airport selection
│   │   ├── layover_page.dart     # Main activity browsing interface
│   │   ├── login_page.dart       # User authentication
│   │   ├── user_account.dart     # User profile and saved destinations
│   │   ├── settings_menu.dart    # App configuration and preferences
│   │   ├── l10n/                 # Internationalization files
│   │   ├── settings/             # Theme and locale providers
│   │   └── widgets/              # Reusable UI components
│   └── (swift, firebase, pubspec.yaml, etc...)
├── images/                       # Image assets (relative path: '../images/')
├── videos/                       # Video content (relative path: '../videos/')
├── text_files/                   # Text documentation (relative path: '../text_files/')
└── README.md                     # This file



## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / Xcode for device testing
- Google Cloud Platform account (for Maps/Places APIs)
- Firebase project setup

### Installation

1. **Clone the repository**
   ```
   git clone [repository-url]
   cd airport_escape
   ```
   
2. **Install Dependencies**
   ```
   flutter pub get
   ```

3. **Environment Setup**
- Create a .env in the root of your directory
- Add your google API key
```
GOOGLE_API_KEY=your_api_key_here
```


__Project access and key information:__


For most convenient project access  cd into airport_escape directory
example
```cd airport_escape```

after this step to work on project code utilize the main.dart file in the lib folder this file is how flutter effectively works. 


**Added folders to project purpose and pathing info:**

 
**images**: meant to hold images. *relative path*: '../images/'

**videos**: meant to hold video content. *relative path*: '../videos/'

**text_files**: meant to hold text files.  *relative path*: '../text_files/'

