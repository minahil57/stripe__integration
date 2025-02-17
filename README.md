# Flutter Stripe Integration 🚀  

A simple yet powerful implementation of **Stripe payment gateway** in a **Flutter** application. This project demonstrates how to integrate Stripe for handling payments in a Flutter app.  

## Features ✨  
- **Secure Stripe Payment Integration** 🏦  
- **Supports Card Payments** 💳  
- **Easy Setup & Implementation** ⚡  
- **Cross-Platform (Android & iOS)** 📱  

## Getting Started 🛠  

Follow these steps to clone and run the project locally.  

### Prerequisites  
Before getting started, ensure you have the following installed:  
- Flutter SDK (latest stable)  
- Dart  
- Android Studio / Xcode  
- Stripe Account & API Keys  

### Installation & Setup  

#### 1️⃣ Clone the Repository  
```bash
git clone https://github.com/minahil57/stripe__integration
cd flutter-stripe-integration
```

#### 2️⃣ Install Dependencies  
```bash
flutter pub get
```

#### 3️⃣ Set Up Stripe API Keys
Create a .env file in the root directory and add:
```bash
STRIPE_PUBLISHABLE_KEY=your_publishable_key
STRIPE_SECRET_KEY=your_secret_key
```
## Configuration for Android & iOS

### Android 
Update android/app/build.gradle:
```bash
minSdkVersion 21
```
Add Stripe dependencies in android/app/src/main/AndroidManifest.xml:
```bash
<uses-permission android:name="android.permission.INTERNET"/>
```
### IOS 
Navigate to ios/Runner/Info.plist and add:
```bash 
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```
Run:
```bash
cd ios
pod install
```
## How It Works? ⚙️

- Users enter their card details.
- The app sends the payment request to Stripe’s API.
- Stripe processes the transaction securely.
- Success/Failure response is handled in the Flutter app.