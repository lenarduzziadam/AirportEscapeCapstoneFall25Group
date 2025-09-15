# Airport Escape Flutter App Overview (spring 0 - sprint 1)

This document explains the main structure and features of your Flutter app, focusing on the key components and their roles.

## Project Structure
- **main.dart**: The entry point and theme setup for the app.
- **landing_page.dart**: Contains the main landing page UI, including the app bar and drawer widgets.

## Key Components

### 1. Entry Point
- `main()` function: Starts the app by running `MyApp`.

### 2. MyApp Widget (main.dart)
- Root widget for the app.
- Sets up the overall theme (colors, styles) and specifies the home screen.

### 3. MyHomePage Widget (landing_page.dart)
- Main screen of the app.
- Uses a `Scaffold` to provide the basic layout: AppBar, Drawer, and Body.
- The body displays a styled welcome message in the center.

### 4. SettingsDrawer Widget (landing_page.dart)
- Custom drawer menu for settings.
- Contains options like General and Security, with icons and a header.

### 5. CustomAppBar Widget (landing_page.dart)
- Custom app bar at the top of the screen.
- Includes a settings button (opens the drawer), app title, and an account menu (Profile, Logout).

## How It Works
- The app uses Flutter's widget system to build the UI.
- The theme and colors are set globally for a consistent look.
- Navigation and menus are handled with built-in Flutter widgets (`Drawer`, `AppBar`, `PopupMenuButton`).
- The code is organized for readability and easy future expansion.

---

## Details on Key Functions and Methods

### Settings Button (AppBar Leading)
- The settings icon in the top left is created using `IconButton` inside the AppBar's `leading` property.
- When pressed, it calls `Scaffold.of(context).openDrawer()`, which opens the settings drawer from the left.

### Account Icon and Menu (AppBar Actions)
- The account icon in the top right is implemented with `PopupMenuButton`.
- Tapping the icon shows a dropdown menu with options like Profile and Logout.
- The `onSelected` callback is where you would handle navigation or actions for each menu item.

### Drawer Structure
- The drawer uses a `DrawerHeader` for the title and background color.
- Each option (General, Security) is a `ListTile` with an icon and label, making it easy to add more settings.

### AppBar Title
- The app title is centered and styled bold using the `Text` widget in the AppBar's `title` property.

