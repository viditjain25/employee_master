Employee Master
A Flutter application for managing employee data with BLoC state management and Hive local database.


Features
1. Add, edit, delete and undo employee data.
2. Employee data is persisted using Hive (local database).
3. Uses BLoC/Cubit for efficient state management.
4. Fully responsive and pixel-perfect UI across all mobile resolutions.
5. Custom Date Picker designed to match the provided UI.

Tech Stack
Flutter: v3.27.4
State Management: BLoC
Local Database: Hive
Dependency Injection: get_it

Netlify deployment link   :https://genuine-begonia-8f3130.netlify.app/

1 Form Validations
  (1) Employee Name Cannot Be Empty

Users must enter a name before saving the employee record.
If left blank, an error message is shown.
  (2) Role Selection is Mandatory

Users cannot add an employee without selecting a role.
The role field must be populated before submission.
  (3) End Date Cannot Be Before Start Date

If the user selects an end date earlier than the start date, it will automatically reset to "No Date" instead of an invalid selection.
2 Undo Feature for Deletion
  (4) Allows Users to Undo a Delete Action

If an employee is deleted, an undo option is provided.
Clicking undo restores the deleted employee record.
3 UI & Experience Enhancements
  (5) Status Bar Handling for Bottom Sheet & Calendar

Ensures the status bar does not overlap with modal bottom sheets and the calendar picker.
Prevents UI clipping issues on different screen sizes.
  (6) Arrow Navigation in Calendar

Left arrow is disabled if the user cannot navigate beyond the first displayed month.
Prevents unnecessary navigation when already at the earliest allowed date.
  (7) Keyboard & Bottom Navigation Handling

Ensures bottom navigation moves above the keyboard when it opens.
Prevents UI elements from being blocked by the keyboard.
