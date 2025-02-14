💰 CalcuBit App – Clean Architecture with MVVM & Domain-Driven Design
📌 Overview
This project is an Expense Manager App built using Clean Architecture, following the MVVM (Model-View-ViewModel) pattern and Domain-Driven Design (DDD). The app allows users to efficiently track and manage their expenses while ensuring scalability, maintainability, and testability.

The architecture consists of three main layers:

Presentation Layer: Handles UI and state management using GetX controllers.
Domain Layer: Contains business logic, ensuring separation from UI and data handling.
Data Layer: Manages database interactions, models, and repositories for structured data management.
Additionally, the app includes services for notifications and authentication, along with utility functions for date handling, storage, and formatting.

🏗 Project Structure
The project is designed to maintain modularity and separation of concerns:

Core Layer: Manages global utilities such as themes, localization, and routing to ensure app-wide consistency.
Data Layer: Handles data persistence using SQFlite, defines models for expenses, and abstracts data sources through repositories.
Domain Layer: Contains business logic and use cases, making the app flexible and easy to test.
Presentation Layer: Houses UI components, screens, and state management using GetX controllers.
Services Layer: Manages background services such as notifications and authentication.
Utilities: Provides helper functions for common tasks such as date formatting and local storage.
🔄 Flow of Data
The app follows a structured data flow:

The user interacts with the UI (e.g., adding an expense).
The ViewModel (controller) processes the request and calls the Use Case.
The Use Case communicates with the Repository to handle data transactions.
The Repository interacts with the Database (SQFlite) for data storage and retrieval.
The updated data is returned to the UI, ensuring real-time updates.
For example, when adding a new expense:

The user enters details and clicks "Save" in the UI.
The ExpenseController triggers the AddExpenseUseCase.
The use case delegates the request to the ExpenseRepository.
The repository saves the expense in SQFlite and updates the UI dynamically.
🚀 Key Features & Benefits
Scalability: The modular structure allows easy addition of new features.
Separation of Concerns: UI, business logic, and data handling remain independent.
Testability: Business logic (use cases) can be unit tested separately.
Maintainability: Code changes are isolated, making bug fixes and updates straightforward.
Reusability: Common UI components (buttons, inputs) can be used across multiple screens.
✅ Technologies Used
Architecture: Clean Architecture + MVVM + Domain-Driven Design
State Management: GetX
Database: SQFlite for persistent local storage
Notifications: Flutter Local Notifications
Authentication: SharedPreferences for local storage


🎯 What Can Users Do?
🚀 Track & Manage Expenses
Users can add, edit, and delete expenses effortlessly. Each expense entry includes details like category, amount, date, and description. The app ensures a user-friendly way to categorize expenses, making financial management simple and effective.

📊 Visual Expense Insights (Pie Chart)
Understanding spending habits is made easier with a pie chart representation of expenses. Users can quickly identify which categories (e.g., food, travel, shopping, bills) are consuming the most money, allowing for better budgeting and financial control.

🔍 View Transaction History
A detailed list of past expenses is available, helping users review and track their spending patterns over time.

🔔 Stay Notified
The app provides reminders and notifications, ensuring users never forget important financial transactions or upcoming expenses.

🔒 Secure & Private
All data is securely stored using SQFlite for local storage, ensuring privacy and offline access.

🏗 How Does the App Work?
1️⃣ Adding an Expense

Users enter details such as amount, category, and date.
The data is stored locally using SQFlite.
The UI updates instantly to reflect the new expense.
2️⃣ Viewing Expense Breakdown (Pie Chart)

The app automatically categorizes expenses and generates a pie chart.
Users get a clear visual breakdown of where their money is going.
Each slice represents a category, making it easier to analyze spending habits.
3️⃣ Editing & Deleting Expenses

Users can modify an existing expense if needed.
Unnecessary transactions can be deleted effortlessly.
The pie chart updates dynamically based on changes.
✅ Why Use This App?
📊 Visual Insights: Easily understand spending patterns via the pie chart.
💡 Smart Expense Management: Keep track of where every penny goes.
📅 Organized History: Review past transactions with ease.
🔔 Helpful Reminders: Stay on top of your expenses with notifications.
⚡ Fast & Offline: Works seamlessly without an internet connection.
🔧 Technologies Used
State Management: GetX
Database: SQFlite (Local Storage)
UI & Visualization: Flutter Charts for Pie Chart Representation
Notifications: Flutter Local Notifications
