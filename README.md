## Pokémon Challenge - Built with Flutter in 59 Minutes 🚀

This repository showcases a Flutter application that fetches and displays a list of Pokémon from the PokéAPI. Navigate to a detailed view to learn more about each Pokémon's stats, abilities, and types.

![0624 (1)](https://github.com/trongnhangle/pokemon_challenge/assets/108941086/c113a021-3b98-4e11-8207-dec12454946b)


###  Features ✨

- **Lightning-fast Performance:**  Built in under an hour, this app boasts swift data fetching and smooth UI transitions.
- **Robust Error Handling:**  Gracefully handles network errors, timeouts, and API issues, providing clear feedback to the user.
- **Clean Architecture:**  Employs a layered architecture (data, domain, presentation) for maintainability and scalability.
- **State Management with Provider:** Utilizes Provider for efficient and reactive state management, keeping the UI in sync.
- **Image Caching:**  Leverages `cached_network_image` to cache Pokémon images for faster loading and reduced network requests. 

### How to Run the App 🏃‍♂️

1. **Clone the Repository:** `https://github.com/trongnhangle/pokemon_challenge.git`
2. **Navigate to the Project Directory:**  `cd pokemon_challenge`
3. **Install Dependencies:**  `flutter pub get`
4. **Run the App:** `flutter run`

### Error Handling 💪

The app is built to be resilient against various errors:

- **Network Errors:** Detects `SocketException` (no internet connection) and `TimeoutException`. Displays a clear error message and a "Retry" button to allow the user to try again.
- **API Errors:** Handles HTTP error codes from the PokéAPI and displays a generic error message to the user.
- **Image Loading Errors:** Uses the `errorWidget` property of `CachedNetworkImage` to display an error icon if an image fails to load.

###  Architecture 🏛️

This project follows a clean architecture pattern with three distinct layers:

- **Data:**  Handles data access and manipulation. Contains repositories, data sources (API interaction), and data models. 
- **Domain:**  Contains the business logic of the app, independent of any framework or UI. Houses use cases and repository interfaces.
- **Presentation:**  Responsible for presenting data to the user. Includes widgets, screens, and view models (using Provider).

### What Else is Cool? 😎

- **Dependency Injection with GetIt:** Simplifies dependency management and improves code testability.
- **Clear Code Structure:**  Organizes code into well-defined folders and files for easy navigation and maintenance.
- **Detailed Comments:** Includes comments throughout the codebase to enhance readability and understanding.


