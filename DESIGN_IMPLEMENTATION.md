# BudgetU - Complete Design Implementation Guide

## Overview
This document outlines the complete rebuild of the BudgetU app to match the exact UI designs provided. ALL existing screens will be replaced with pixel-perfect implementations.

## Design System

### Colors
- **Dark Green**: #0D1F1A (main app background)
- **Pure Black**: #000000 (login/signup screens)
- **Neon Green**: #00FF85 (primary accent/CTA)
- **Light Gray**: #F5F5F5 (edit profile background)
- **Card Background**: #1A2F2A
- **Text Gray**: #8E8E93

### Typography
- **Font Family**: Inter (Google Fonts)
- **Heading Large**: 32px, Bold
- **Heading Medium**: 24px, Bold
- **Body**: 16px, Regular
- **Small**: 14px, Regular

### Category Colors
- Food: #FF9500 (Orange)
- Transport: #007AFF (Blue)
- Entertainment: #9747FF (Purple)
- Books: #34C759 (Green)
- Shopping: #FF2D55 (Pink)
- Bills: #FFCC00 (Yellow)
- Rent/Housing: #5856D6 (Indigo)

## App Flow (Based on Designs)

### 1. Splash Screen → Onboarding → Auth Flow
```
Splash (3s delay)
  ├─→ [If logged in] → Home
  └─→ [If new] → Onboarding
       ├─→ Sign Up → Budget Personalization (2of4) → Home
       └─→ Log In → Home
```

### 2. Main App Structure
```
Home Screen (Bottom Nav: Home, Insights, Wallet, Profile)
  └─→ FAB (+) → Add Expense Modal
       ├─→ Manual Entry → Add Expense Screen (#5) → Success
       ├─→ Scan Receipt → Camera Screen → Review Scan → Success
       └─→ MoMo Import → Import MoMo Screen (#2) → Review Transaction → Success
```

### 3. Settings Flow (from Profile)
```
Profile Screen
  ├─→ Notifications → Notifications Settings Screen
  ├─→ Privacy & Security → Privacy & Security Screen
  ├─→ Language → Language Selection Screen
  ├─→ Currency → Currency Selection Screen
  ├─→ Export Data → Export Data Screen
  └─→ Edit Profile → Edit Profile Screen (light background!)
```

## Screen-by-Screen Implementation

### Screen 1: Splash Screen ✅
- **Background**: Pure Black (#000000)
- **Logo**: Green rounded square with piggy bank icon
- **Title**: "BudgetU" - 36px Bold
- **Subtitle**: "Student Budgeting Simplified" - 16px Gray
- **Version**: "V1.0.0" at bottom
- **Duration**: 3 seconds, then check login status

### Screen 2: Onboarding Screen
- **Background**: Black/Dark gradient
- **Hero Image**: 3D wallet with coins illustration
- **Badge**: "STUDENT BUDGETING APP" pill
- **Heading**: "Manage Finances &" + "Achieve Your Goals" (green)
- **Body**: Multi-line description
- **Pagination**: Dots (3 screens)
- **CTA**: "Start Budgeting Now →" - Green button
- **Bottom**: "I have an account" - Small gray text

### Screen 3: Signup Screen
- **Background**: Dark Green (#0D1F1A)
- **Logo**: Top left - small icon + "BUDGETU"
- **Back Button**: Top left
- **Heading**: "Create Account" - 32px Bold
- **Subtitle**: "Start tracking your student budget today."
- **Fields**: 
  - Username (person icon)
  - Email (envelope icon)
  - Password (lock icon, show/hide toggle)
  - **Validation**: Red border + error text for invalid fields
  - Checkbox: "I agree to the Terms of Service and Privacy Policy"
- **CTA**: "Create Account →" - Green button (disabled if invalid)
- **Divider**: "OR CONTINUE WITH"
- **Social**: Google + Apple buttons (dark)
- **Bottom**: "Already have an account? Sign in"

### Screen 4: Login Screen  
- **Background**: Pure Black (#000000)
- **Logo**: Top center - icon + "BudgetU"
- **Back Button**: Top left
- **Heading**: "Welcome Back" - 32px Bold White
- **Subtitle**: "Please enter your details to sign in."
- **Fields**:
  - Email or Username
  - Password (show/hide eye icon)
  - "Forgot Password?" - Green link (right aligned)
- **CTA**: "Log In →" - Green button
- **Divider**: "OR CONTINUE WITH"
- **Social**: Google + Apple buttons
- **Bottom**: "Don't have an account? Sign up" (green text)

### Screen 5: Budget Personalization (Setup 2 of 4)
- **Background**: Dark Green
- **Back Button**: Top left
- **Logo**: Top center
- **Progress**: "Setup Progress 2 of 4" + progress bar (50% green)
- **Heading**: "Personalize" + "Your Budget" (green)
- **Subtitle**: "Set limits for your top spending categories..."
- **Monthly Total**: Large card with $1,250.00 + refresh icon
- **Categories**: Vertical list
  - Food & Dining: $400 /mo (checkmark, green border)
  - Rent & Utilities: $650 /mo (edit icon)
  - Transport: $100 /mo (edit icon)
  - Entertainment: $100 /mo (edit icon)
- **Add**: "+ Add Custom Category" (dashed border)
- **Buttons**: "Skip" (left) + "Continue →" (right, green)

### Screen 6: Add Expense Screen (#5 from designs)
- **Background**: Dark Green
- **Close**: X top left
- **Clear**: "Clear" top right (gray)
- **Amount**: Large "$124.50" in neon green + "USD" below
- **Quick Actions**: 2 pills
  - "Scan Receipt" (green icon)
  - "MoMo" (blue icon) "Paste SMS"
- **Category**: Label + horizontal scroll chips
  - Food (selected - green)
  - Transport (dark)
  - Shopping (dark)
  - Edit link (top right)
- **Date**: "Today, Oct 24 →" with calendar icon
- **Note**: "Add a note..." with pencil icon
- **Number Pad**: 0-9 + decimal + backspace (3x4 grid)
- **CTA**: "✓ Add Expense" - Green button at bottom

### Screen 7: Scan Receipt Screen
- **Background**: Camera view (dark overlay)
- **Header**: "Scan Receipt" + "Align receipt within frame"
- **Close**: X top left
- **Flash**: Lightning icon top right
- **Frame**: Green corners showing scan area
- **Status**: "Scanning..." in center
- **Capture**: Large white circle button bottom center
- **Gallery**: Image icon bottom left
- **Manual**: Keyboard icon bottom right
- **Mode Toggle**: "Receipt | Document" bottom (Receipt selected green)

### Screen 8: Review Scan Screen
- **Background**: Dark Green
- **Header**: "Review Scan" + "Discard" (red, top right)
- **Receipt Preview**: Blurred receipt image with zoom icon
- **Info**: "We've extracted these details. Please verify."
- **Amount**: "TOTAL AMOUNT" label + "$42.85" large green
- **Merchant**: Store icon + "Target Market" (editable)
- **Date**: Calendar icon + "Oct 24, 2023 →"
- **Category**: Horizontal pills (Food, Shopping-selected, Transport)
  - "View All" link (top right)
- **Note**: Pencil icon + "Weekly groceries"
- **Actions**:
  - "📷 Retake" (dark button left)
  - "✓ Confirm & Save" (green button right)

### Screen 9: Import MoMo Screen (#2 from designs)
- **Background**: Dark Green
- **Back Button**: Top left
- **Header**: "Import MoMo"
- **Info Card**: Blue info icon
  - "How to import"
  - Instructions text
- **Text Area**: Large input box
  - **Placeholder**: "Example: Payment made for GHS 45.00 to UBER RIDES. Current Balance: GHS 120.00. Reference: 123456..."
  - Gray text
- **Paste Button**: Clipboard icon bottom right of text area
- **CTA**: "✨ Process Message" - Green button
- **Help**: "Transaction details will be automatically extracted from the text."

### Screen 10: Review Transaction Screen
- **Background**: Dark Green
- **Back Button**: Top left
- **Header**: "Review Transaction"
- **Amount Card**: 
  - "PARSED AMOUNT" label
  - "GHS 45.00" (large white)
  - Toggle: "Expense" (green selected) | "Income" (gray)
- **Merchant**: Store icon + "UBER RIDES" (editable)
- **Date/Time**: 2 columns
  - Date: Oct 24, 2023 (calendar icon)
  - Time: 14:30 (clock icon)
- **Category**: Dropdown
  - "Transportation" selected (with icon, checkmark)
- **Reference ID**: Hash icon + "17384920432"
- **CTA**: "✓ Confirm & Save Expense" - Green button
- **Help**: "Verify details before saving. You can edit this later."

### Screen 11: Home Screen (#7 from designs - "Alex" version)
- **Background**: Dark Green
- **Header**:
  - "Welcome back," (gray)
  - "Alex" (large white) [dynamic from user data]
  - Bell icon (top right, green dot notification)
- **Balance Card**:
  - "TOTAL REMAINING" (gray label)
  - "$342.50" (huge green)
  - "📈 Daily Limit: $25.00" (pill)
  - Progress bar
  - "Spent: $657.50" | "Budget: $1,000"
- **Spending Activity**:
  - "Spending Activity" + "This Week"
  - "↓ 12%" (green pill)
  - Line chart (7 days: M T W T F S S)
- **Category Breakdown**:
  - 3 cards horizontal scroll
  - Icon + percentage + label + progress bar
  - Food: 80% (orange)
  - Transport: 45% (blue)
  - Books: 20% (purple)
- **Recent Transactions**:
  - "See all" (green, top right)
  - List items: Icon + Name/Category + Amount
  - Starbucks (Coffee) -$5.50
  - Campus Bookstore (Education) -$45.00
  - Uber (Transport) -$12.00
- **FAB**: Large green + button (centered)
- **Bottom Nav**: Home (active-green) | Insights | Wallet | Profile

### Screen 12: Budget Screen (November Budget)
- **Background**: Dark Green
- **Header**: "November Budget" + Edit icon (top right)
- **Back Button**: Top left
- **Tabs**: "CURRENT MONTH" (active-green) | "NEXT MONTH" (gray)
- **Summary Card**:
  - "Total Monthly Budget" + pie chart icon
  - "$1,200.00" (white)
  - "$340.00" (large green) "AMOUNT REMAINING"
  - Progress bar
  - "📊 Analyze Spending" (white button)
- **Categories Section**:
  - "Categories" + "Manage" (green, top right)
  - List of category cards:
    - Groceries: 66% "On Track" (green) - $200 spent of $300
    - Transport: 90% "Careful" (orange) - $45 of $50
    - Entertainment: 80% "On Track" (green) - $80 of $100
    - Housing: 100% "Paid" (gray) - $550 of $550
  - "+ Add New Category" (dashed border)
- **Bottom Nav**: Home | Budget (active-green) | Track | Profile

### Screen 13: Currency Selection Screen
- **Background**: Dark Green
- **Back Button**: Top left (chevron)
- **Header**: "Currency"
- **Search**: "🔍 Search currency or country..."
- **Section**: "POPULAR CURRENCIES"
- **List**: 
  - USD - United States Dollar (selected - green border + checkmark)
  - EUR - Euro (circle outline)
  - GBP - British Pound
  - CAD - Canadian Dollar
  - JPY - Japanese Yen
  - AUD - Australian Dollar
- **Help**: "Can't find your currency? Show all"
- **CTA**: "Update Currency" - Green button (bottom)

### Screen 14: Language Selection Screen  
- **Background**: Dark Green
- **Back Button**: Top left
- **Header**: "Language"
- **Search**: "🔍 Search languages..."
- **Section**: "SUGGESTED"
- **List**:
  - 🇺🇸 English (US) - "Default" (selected - green)
- **Section**: "ALL LANGUAGES"
- **List**:
  - 🇪🇸 Español - "Spanish"
  - 🇫🇷 Français - "French"
  - 🇩🇪 Deutsch - "German"
  - 🇨🇳 中文 - "Chinese (Simplified)"
  - 🇯🇵 日本語 - "Japanese"
- **Note**: "Changing the language will restart the application to apply the new settings."
- **CTA**: "Update Language" - Green button

### Screen 15: Notifications Settings Screen
- **Background**: Light Gray (#F5F5F5) ← IMPORTANT!
- **Back Button**: Top left
- **Header**: "Notifications" (dark text)
- **Section**: "General"
- **Cards**: White cards with rounded corners
  - Push Notifications (bell icon, blue)
    - "Enable notifications on this device"
    - Toggle ON (green)
  - Email Alerts (envelope icon, blue)
    - "Get summaries sent to your inbox"
    - Toggle OFF
- **Section**: "Budget & Spending"
- **Cards**:
  - Budget Exceeded (wallet icon)
    - "Alert when you hit 100% of a budget"
    - Toggle ON
  - Near Limit Warning
    - "Alert at 80% and 90% usage"
    - Toggle ON
  - Weekly Summary
    - "Weekly report of your spending"
    - Toggle OFF
- **Section**: "App Updates"
- **Cards**:
  - New Features
    - "Tips and new tools available"
    - Toggle OFF
  - Security Alerts (shield icon)
    - "Login attempts and password changes"
    - Toggle ON
- **Bottom Nav**: Home | Insights | Wallet | Profile (active-green)

### Screen 16: Export Data Screen
- **Background**: Dark Green
- **Back Button**: Top left
- **Header**: "Export Data"
- **Heading**: "Export your transaction history"
- **Subtitle**: "Download your financial data for external analysis or record keeping."
- **Select Range**: Label + 4 pills
  - "Current Month" (selected - green)
  - "Last 3 Months"
  - "All Time"
  - "Custom"
- **Select Format**: Label + 2 cards
  - CSV File (selected - green border + radio)
    - Table icon
    - "Best for spreadsheets (Excel, Numbers)"
  - PDF Document (not selected)
    - PDF icon
    - "Best for printing and sharing"
- **Info**: Blue info icon
  - "Your report will include date, merchant, category, and amount for all transactions within the selected range. The file will be saved to your device."
- **CTA**: "Export Data ⬇️" - Green button

### Screen 17: Privacy & Security Screen
- **Background**: Dark Green/Black
- **Back Button**: Top left
- **Header**: "Privacy & Security" (white)
- **Section**: "Login & Security"
- **Cards**: Dark cards
  - Change Password (lock icon, green)
    - "Last updated 3 months ago"
    - Chevron →
  - Biometric Login (fingerprint icon, green)
    - "Use FaceID to log in"
    - Toggle OFF
  - 2-Step Verification (shield-check icon, green)
    - "Extra layer of security"
    - Chevron →
- **Section**: "Privacy Permissions"
- **Cards**:
  - Data Sharing (share icon, green)
    - "Share usage data for analytics"
    - Toggle ON (blue checkmark)
  - App Permissions (person icon, green)
    - "Camera, Location, Contacts"
    - Chevron →
- **Section**: "Device Management"
- **Cards**:
  - Active Sessions (devices icon, green)
    - "iPhone 13 Pro • Austin, TX"
    - Chevron →
- **Delete Account**: Red outlined button
  - "🗑️ Delete Account"
  - Warning: "Deleting your account will permanently remove all your data from BudgetU. This action cannot be undone."

### Screen 18: Edit Profile Screen
- **Background**: Light Gray (#F5F5F5) ← IMPORTANT! White/light background
- **Header**: Dark bar at top
  - "← Edit Profile" (white text on dark)
- **Profile Picture**: Centered
  - Circle with person icon (dark green background)
  - Camera icon (green pill, bottom right)
  - "Change Profile Picture" (gray text)
- **Fields**: White rounded cards
  - Full Name
    - Badge icon + "Alex Johnson"
  - Email Address
    - Envelope icon + "alex.johnson@university.edu"
  - Student ID
    - Graduation cap icon + "STU-2023-8849" (locked icon right)
  - Phone Number
    - Phone icon + "+1 (555) 000-1234"
- **Buttons**:
  - "Save Changes" (green button)
  - "Delete Account" (red outlined button)
- **Bottom Nav**: Home | Insights | Wallet | Profile (active-green)

### Screen 19: Spending Insights Screen
- **Background**: Dark Green
- **Back Button**: Top left
- **Header**: "Spending Insights" + "..." menu (top right)
- **Tabs**: "Weekly" (active-green) | "Monthly" | "Semester"
- **Total Card**:
  - "TOTAL SPENT" + "↓ -12% vs last week" (green pill)
  - "$450.00" (large white)
  - "You are $50 under budget this week." (green text)
- **Spending Trend**:
  - "Daily Activity" + "Details →" (green)
  - Bar chart (M T W T F S S)
  - Friday highlighted with "$112" label
- **Savings Card**:
  - Piggy icon (green)
  - "Savings Opportunity"
  - "You've spent 20% less on coffee this week! Keep it up to save an extra $15 by Sunday."
- **Top Categories**:
  - Donut chart (left)
    - "Top Food" in center
  - List (right):
    - Food: $180
    - Books: $112
    - Transport: $90
    - Others: $68
- **Top Spenders**:
  - "View all" (green, top right)
  - List items with icons:
    - Campus Burger (Yesterday • Food) -$24.50
    - University Bookstore (Tue, Oct 24 • Education) -$85.00
    - Netflix Subscription (Mon, Oct 23 • Entertainment) -$15.99
- **FAB**: Green + button
- **Bottom Nav**: Home | Insights (active-green) | Wallet | Profile

### Screen 20: Profile Screen  
- **Background**: Dark Green
- **Back Button**: Top left
- **Dark Mode**: Moon icon (top right)
- **Profile Card**: Centered
  - Circle avatar (green outline + person icon)
  - "Alex Johnson" (large white)
  - "alex.johnson@university.edu" (gray)
  - "Edit Profile" (green button)
- **Stats**: 3 cards
  - 12 "DAYS ACTIVE"
  - 48 "TRANSACTIONS"
  - $890 "TOTAL SPENT"
- **Section**: "Settings"
- **Cards**: Dark cards with chevrons
  - Notifications (bell icon, green)
    - "Manage your notifications"
  - Privacy & Security (lock icon, green)
    - "Control your data and security"
  - Language (globe icon, green)
    - "English"
  - Currency (dollar icon, green)
    - "USD"
- **Section**: "Data Management"
- **Cards**:
  - Export Data (cloud-down icon, green)
    - "Download your expense data"
  - Backup (cloud-up icon, green)
    - "Backup to cloud storage"
- **Section**: "About"
- **Cards**:
  - About BUDGETU (info icon, green)
    - "Version 1.0.0"
  - Help & Support (question icon, green)
    - "Get help and contact support"
  - Privacy Policy (shield icon, green)
    - "Read our privacy policy"
- **Logout**: Red outlined button
- **Bottom Nav**: Home | Insights | Wallet | Profile (active-green)

### Screen 21: Forgot Password Screen
- **Background**: Dark Green
- **Back Button**: Top left (circle)
- **Logo**: Top center (green square + lock icon)
- **Heading**: "Forgot Password?" (large white)
- **Body**: "Don't worry! It happens. Please enter the email address associated with your account and we'll send you a link to reset your password."
- **Field**: Email Address
  - Envelope icon + placeholder
- **CTA**: "Send Reset Link" - Green button
- **Bottom**: "Remember your password? Log In" (green text)

### Screen 22: Email Sent Screen
- **Background**: Dark Green
- **Icon**: Large circle (green envelope with checkmark)
- **Heading**: "Email Sent" (large white)
- **Body**: "We've sent password reset instructions to your email address."
- **CTA**: "Back to Login →" - Green button
- **Help**: 
  - "Did not receive the email?"
  - "Resend Link" (green text)
  - "Check your spam folder just in case."

## Implementation Priority

### Phase 1: Core Flow ✅
1. ✅ Splash Screen
2. Onboarding Screen
3. Signup Screen (with validation)
4. Login Screen
5. Home Screen

### Phase 2: Add Expense Flow
6. Add Expense Screen (calculator)
7. Review Transaction Screen
8. Import MoMo Screen
9. Scan Receipt Screen
10. Review Scan Screen

### Phase 3: Main Screens
11. Budget Screen
12. Spending Insights Screen
13. Profile Screen

### Phase 4: Settings Screens
14. Currency Selection
15. Language Selection
16. Notifications Settings
17. Export Data
18. Privacy & Security
19. Edit Profile

### Phase 5: Auth Support
20. Forgot Password
21. Email Sent
22. Budget Personalization

## Critical Notes

1. **Background Colors Matter**:
   - Most screens: Dark Green (#0D1F1A)
   - Login/Signup: Pure Black (#000000)
   - Edit Profile/Notifications: Light Gray (#F5F5F5)

2. **Font Consistency**:
   - Use Inter font (Google Fonts) throughout
   - Maintain exact font sizes and weights from designs

3. **Icon Style**:
   - Use iOS-style outlined icons
   - Consistent 24px size for nav icons
   - Color: Neon green for active, Gray for inactive

4. **Button Style**:
   - Primary: Neon green background, black text, rounded
   - Secondary: Outlined, green border, green text
   - Danger: Red outlined

5. **Form Validation**:
   - Show red border + error text below field
   - Disable button when invalid
   - Real-time validation on blur

6. **Bottom Navigation**:
   - 80px height
   - Icons: 24px
   - Labels: 11px
   - Active: Neon green
   - Inactive: Gray

7. **Transitions**:
   - Smooth page transitions
   - Modal bottom sheets for add expense
   - Fade animations for loading states

## Next Steps

1. Install all required packages ✅
2. Update theme system ✅
3. Create reusable bottom nav widget ✅
4. Rebuild all screens one by one
5. Test complete flow
6. Fix any navigation issues
7. Polish animations and transitions
