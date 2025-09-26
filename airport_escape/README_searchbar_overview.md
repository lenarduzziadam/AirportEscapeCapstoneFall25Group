# Search Bar Feature Overview

This document explains the logic and structure of the search bar implemented in the `landing_page.dart` file of the Airport Escape Flutter app.

## Purpose
The search bar allows users to type and search for locations or keywords (e.g., restaurant, entertainment, relax, massage, food, etc.). Results are filtered and displayed in real time as the user types.

## How It Works

**TextEditingController**: Manages the input from the search bar.
**Sample Data List**: Contains example locations and keywords to search from.
**Filtered Results List**: Stores the items that match the current search query.
**Filtering Logic**: Every time the user types in the search bar, the app filters the sample data to show only items that contain the search text (case-insensitive).
**UI Structure**:
  - The search bar is placed at the top of the page using a `TextField`.
  - Filtered results are shown in a scrollable list (`ListView`).
  - The welcome message is displayed below the search results or when no search is active.

## Extending the Feature
- You can replace the sample data with real location and keyword data from a database or API.
- Add navigation or actions to each search result (e.g., tap to view details).
- Support advanced search features like category filters or suggestions.

