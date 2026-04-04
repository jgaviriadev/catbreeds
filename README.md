# Cat Breeds App 🐱

Flutter sample application that consumes [The Cat API](https://documenter.getpostman.com/view/5578104/RWgqUxxh) to display information about different cat breeds.

## Features

- **Splash Screen**: Initial welcome screen
- **Breeds List**: Browse breeds with infinite scroll
- **Breed Details**: Detailed information for each breed
- **Favorites**: Save your favorite breeds
- **Themes**: Light and dark mode with persistence

## Requirements

- Flutter 3.41.1
- Configuration file `.env/env.json` with required environment variables

## Setup

### 1. Environment Variables File

Create the `.env/env.json` file in the project root with your API key:

```json
{
    "api.url": "https://api.thecatapi.com/v1",
    "api.key": "XXXXXXXXXXX"
}
```

### 2. Run the Application

#### Option A: From Console

```bash
flutter run --dart-define-from-file=.env/env.json
```

#### Option B: Configure launch.json (VS Code)

Create or update the `.vscode/launch.json` file:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Flutter (Debug)",
            "type": "dart",
            "request": "launch",
            "toolArgs": [
                "--dart-define-from-file=.env/env.json"
            ]
        },
        {
            "name": "Flutter (Release)",
            "type": "dart",
            "request": "launch",
            "flutterMode": "release",
            "toolArgs": [
                "--dart-define-from-file=.env/env.json"
            ]
        }
    ]
}
```

## API Used

This application consumes [The Cat API](https://documenter.getpostman.com/view/5578104/RWgqUxxh) to retrieve information about cat breeds.

## Installation

```bash
# Get dependencies
flutter pub get

# Run the application
flutter run --dart-define-from-file=.env/env.json
```
