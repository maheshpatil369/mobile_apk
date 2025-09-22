pashudhan_ai_frontend/
└── lib/
    ├── main.dart             # App entry point, theme setup, and initial routing
    │
    ├── screens/              # All the main pages/screens of your app
    │   ├── authentication/
    │   │   └── login_page.dart   # The UI for the login screen
    │   ├── home/
    │   │   └── home_page.dart    # The main capture screen
    │   ├── result/
    │   │   └── result_page.dart  # Displays the analysis result (with dummy data)
    │   ├── history/
    │   │   └── history_page.dart # Lists all records (with dummy data)
    │   ├── profile/
    │   │   └── profile_page.dart # User profile and settings (with dummy data)
    │   └── onboarding/
    │       └── help_onboarding_page.dart # The help page with video and tips
    │
    ├── widgets/              # Reusable UI components used across multiple screens
    │   ├── app_bar_custom.dart      # Custom app bar for consistent branding
    │   ├── bottom_nav_bar.dart      # The main navigation bar
    │   ├── record_list_item.dart    # Widget for a single item in the history list
    │   └── stats_card.dart          # Widget to display user statistics on profile
    │
    ├── data/                 # For mock/dummy data while backend is not integrated
    │   ├── mock_animals.dart    # List of dummy animal records for history/results
    │   └── mock_user.dart       # Dummy user profile data
    │
    └── utils/                # General utility functions (e.g., image picking)
        ├── app_colors.dart      # Central place for your color scheme
        ├── app_constants.dart   # Other app-wide constants
        └── image_picker_util.dart # Helper for camera and gallery access (returns file path)