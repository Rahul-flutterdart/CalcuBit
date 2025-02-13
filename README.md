📊 CalcuBit - Personal Accounting Assistant
A feature-rich personal expense tracker built with Flutter, designed to help users manage and analyze their expenses efficiently.
🚀 Features
✅ Add, Edit, & Delete Expenses - Users can input, modify, and remove expenses with ease.
✅ Expense Summary & Analytics - View categorized expense summaries with charts.
✅ Local Notifications - Get reminders to log daily expenses.
✅ SQLite Database - Securely stores expenses locally.
✅ Multi-language Support - English & Hindi.
✅ State Management with GetX - Efficient app state handling.
🛠 Tech Stack & Libraries
Feature	Library Used
UI Components	Flutter, Google Fonts, GetX
State Management	GetX
Local Database	SQLite (sqflite package)
Notifications	flutter_local_notifications
Charts & Graphs	fl_chart (for visual expense analytics)
Date & Time Picker	intl, TimeOfDay widget
Shared Preferences	shared_preferences (for auth storage)
📂 Project Structure
bash
Copy
Edit
CalcuBit/
│── lib/
│   ├── core/               # Constants, Themes, Utils
│   ├── data/               # Database, Models, Repository
│   ├── presentation/       # UI Views, Controllers, ViewModels
│   ├── services/           # Notification, Localization, Authentication
│   ├── main.dart           # Entry Point
│── assets/                 # Fonts, Images, Icons
│── pubspec.yaml            # Dependencies & Packages
│── README.md               # Documentation
