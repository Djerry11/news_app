# News App

A Flutter news application that showcases trending and breaking news. The app supports Favoriteing articles and saves them locally using SharedPreferences.

## Features

- Dual Theme (Light and Dark)
- Breaking news section
- Search functionality
- Favorite articles
- Pull Refresh for new articles
- Add favorites
- Persistent storage for favorites
- Read full article in webview

## Screenshots

![thumbnail](screenshots/duothumbnail.png)
![thumbnail](screenshots/dualtoneAio.png)
![thumbnail](screenshots/banner.png)
![thumbnail](screenshots/banner2.png) |

## Getting Started

### Prerequisites

- Flutter SDK
- Dart

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Djerry11/news_app.git
   cd news_app
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   - Replace `'YOUR_API_KEY'` with your News API key.

   ```bash
   flutter run --dart-define NEWS_API_KEY=YOUR_API_KEY
   ```

## Usage

- **Home Page**: Displays the trending and latest news.
- **Search**: Use the search bar to find news articles.
- **Favorite**: Tap on the Favorite icon to save articles locally.

## Contributing

Contributions are welcome! Please create a pull request or submit an issue if you find any bugs or have feature requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
