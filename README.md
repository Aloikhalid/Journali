🖋️ journali 
Your personal digital diary. Easily write, organize, and reflect on your thoughts, experiences, and feelings in a private and secure space. 📓

Journali is a clean, minimal journaling app that lets you quickly capture thoughts with a title and rich text content. Entries are timestamped, can be bookmarked for quick access, and support swipe-to-delete with a confirmation step. You can sort by bookmark priority or by most recent entry, and filter to view only your bookmarked journals.



<img width="1080" height="1080" alt="image" src="https://github.com/user-attachments/assets/4d6f197e-30b9-4404-bfea-d5bc73965b0d" />




💻 The app is built using the MVVM architecture:
• Model: MainCardItem represents a single journal entry with id, date, content, and bookmark state.
• ViewModel: JournalViewModel manages the list of entries, sorting/filtering logic, bookmarking, deletion, and persistence.
• Views: SwiftUI views like MainView, CardView, SwipeableCard, FilterPanel, NewEntrySheet, and SplashView present the UI and bind to the ViewModel.

Data persistence stores your entries locally so they remain available across app launches, and the UI uses smooth animations, a custom toolbar, and a splash screen for a polished experience.
