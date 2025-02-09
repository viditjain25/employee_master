#!/bin/bash

# Function to update Java Home in gradle.properties
update_java_home() {
  GRADLE_PROPERTIES="android/gradle.properties"
  echo "Updating org.gradle.java.home in $GRADLE_PROPERTIES"

  # Ask user for Java JDK path
  read -p "Enter the Java JDK 17 path (e.g., C:/Program Files/Java/jdk-17): " JAVA_PATH

  # Check if the file exists
  if [[ -f "$GRADLE_PROPERTIES" ]]; then
    # Update or add the org.gradle.java.home property
    sed -i "/^org.gradle.java.home=/d" "$GRADLE_PROPERTIES"
    echo "org.gradle.java.home=$JAVA_PATH" >> "$GRADLE_PROPERTIES"
    echo "✔ Java Home updated successfully!"
  else
    echo "❌ Error: $GRADLE_PROPERTIES not found!"
    exit 1
  fi
}

# Step 1: Update Java Home Path
update_java_home

# Step 2: Use Flutter 3.27.4 via FVM
echo "🔹 Switching to Flutter 3.27.4 using FVM..."
fvm use 3.27.4
if [[ $? -ne 0 ]]; then
  echo "❌ Error: FVM is not installed or version switch failed!"
  exit 1
fi

# Step 3: Install Dependencies
echo "🔹 Running flutter pub get..."
fvm flutter pub get

# Step 4: Run build_runner for lib_common
echo "🔹 Running build_runner for lib_common..."
fvm flutter pub run build_runner build --delete-conflicting-outputs --config release --package=lib_common

# Step 5: Run build_runner for lib_employee
echo "🔹 Running build_runner for lib_employee..."
fvm flutter pub run build_runner build --delete-conflicting-outputs --config release --package=lib_employee

# Step 6: Build Release APK or App Bundle
echo "🔹 Building Flutter release APK..."
fvm flutter build apk --release

# OR Build App Bundle (for Play Store)
# echo "🔹 Building Flutter release AAB..."
# fvm flutter build appbundle --release

# Completion message
echo "✅ Build process completed successfully!"
