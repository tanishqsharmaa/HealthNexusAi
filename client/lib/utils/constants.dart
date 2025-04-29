class Constants {
  // API Base URL
  static const String apiBaseUrl = 'https://api.example.com';

  // App-wide constants
  static const String appName = 'My App';
  static const String defaultAvatarUrl = 'https://example.com/default-avatar.png';

  // Timeout durations (in milliseconds)
  static const int apiTimeout = 30000; // 30 seconds

  // Pagination limits
  static const int itemsPerPage = 20;

  // Authentication
  static const String authTokenKey = 'auth_token';

  // Error Messages
  static const String networkError = 'Network error. Please try again.';
  static const String unknownError = 'An unknown error occurred.';

  // Regular Expressions
  static const String emailRegex = r'^[^@]+@[^@]+\.[^@]+$';
  static const String phoneRegex = r'^\d{10}$';

  // Date Formats
  static const String apiDateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'MMM dd, yyyy';

  // Other constants
  static const String emptyListMessage = 'No items available.';
  static const String unauthorizedMessage = 'You are not authorized to perform this action.';
}