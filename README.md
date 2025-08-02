# Fundraising Portal - Flutter App

A simple Flutter application that simulates a fundraising intern portal with dummy data. This app provides a complete UI experience for interns to track their fundraising progress, view leaderboards, and stay updated with announcements.

## Features

### 🔐 Authentication
- **Login/Sign-Up Screen**: Clean UI with form validation (no actual authentication)
- **Responsive Design**: Works on mobile, web, and desktop platforms

### 📊 Dashboard
- **Intern Profile**: Displays intern name and welcome message
- **Fundraising Stats**: Shows total donations raised and referral count
- **Referral Code**: Personal referral code with copy-to-clipboard functionality
- **Rewards System**: Achievement cards showing unlocked and locked rewards
- **Progress Tracking**: Visual indicators for fundraising milestones

### 🏆 Leaderboard
- **Top Performers**: Ranked list of top 5 fundraisers
- **Current User Highlighting**: Special styling for the logged-in user
- **Detailed Stats**: Shows donation amounts and referral counts
- **Rank Badges**: Special icons and colors for top 3 positions

### 📢 Announcements
- **Latest Updates**: Company-wide announcements and news
- **Categorized Content**: Different types of announcements (celebrations, challenges, updates, etc.)
- **Priority System**: Important announcements are highlighted
- **Interactive Features**: View details and share functionality

## Mock Data

The app uses realistic dummy data including:
- **Intern Name**: Alex Johnson
- **Referral Code**: alex2025
- **Total Donations**: ₹15,750
- **Referrals Count**: 23
- **Leaderboard**: 5 mock users with varying performance metrics
- **Announcements**: 6 different types of company updates

## Technical Details

### Architecture
- **State Management**: Built-in Flutter StatefulWidget
- **Navigation**: Bottom navigation bar with 3 main screens
- **UI Framework**: Material Design 3 with custom theming
- **Responsive Design**: Adapts to different screen sizes

### Screens Structure
```
lib/
├── main.dart                 # App entry point
└── screens/
    ├── login_screen.dart     # Authentication UI
    ├── main_navigation.dart  # Bottom navigation controller
    ├── dashboard_screen.dart # Main dashboard with stats
    ├── leaderboard_screen.dart # Rankings and competition
    └── announcements_screen.dart # News and updates
```

## Getting Started

### Prerequisites
- Flutter SDK (3.29.2 or later)
- Dart SDK (3.7.2 or later)
- Chrome browser (for web testing)

### Installation

1. **Clone or download the project**
   ```bash
   cd fundraising_portal
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web (recommended)
   flutter run -d chrome
   
   # For mobile (if emulator is available)
   flutter run
   
   # For Windows (if Visual Studio is set up)
   flutter run -d windows
   ```

### Testing

Run the included tests:
```bash
flutter test
```

Run code analysis:
```bash
flutter analyze
```

## Usage

1. **Login**: Enter any email and password (6+ characters) to access the app
2. **Dashboard**: View your fundraising stats and copy your referral code
3. **Leaderboard**: See how you rank against other interns
4. **Announcements**: Stay updated with the latest company news

## Customization

### Changing Mock Data
- Edit the static data in each screen file to customize:
  - User information in `dashboard_screen.dart`
  - Leaderboard entries in `leaderboard_screen.dart`
  - Announcements in `announcements_screen.dart`

### Theming
- Modify the theme in `main.dart` to change colors and styling
- Current theme uses Material Design 3 with blue primary colors

### Adding Features
- The app is structured to easily add new screens via the bottom navigation
- Each screen is self-contained and can be extended independently

## Screenshots

The app includes:
- Modern login interface with form validation
- Comprehensive dashboard with stats and rewards
- Interactive leaderboard with user highlighting
- Rich announcements feed with categorization

## Future Enhancements

This UI-only version can be extended with:
- Real authentication system
- Backend API integration
- Push notifications for announcements
- Real-time leaderboard updates
- Advanced analytics and reporting
- Social sharing features

## License

This project is created for demonstration purposes and uses Flutter's standard license.
