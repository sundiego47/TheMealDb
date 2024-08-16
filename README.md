# TheMealDB iOS Application

## Overview

This project is an iOS application that interfaces with the [TheMealDB API](https://www.themealdb.com/) to display a list of desserts and detailed information about individual meals. The app demonstrates the use of the Model-View-ViewModel (MVVM) architecture pattern and leverages Swift Concurrency to efficiently manage network requests and update the user interface.

## Features

- Fetch and display a list of desserts from TheMealDB API.
- Display detailed information about a selected dessert, including its name, instructions, ingredients, and thumbnail.
- Automatically handles and filters out `nil` or empty data fields to ensure data integrity.
- Asynchronously fetches data using Swift Concurrency, making the app responsive and performant.
- The detail view dynamically adjusts based on the availability of ingredients, removing the section if none are present.

## Project Structure

### MVVM Architecture

This project is organized using the MVVM architecture, which separates concerns and promotes a clean codebase:

1. **Model**: 
   - `Dessert` and `MealDetail` structs represent the data models. These models are responsible for decoding JSON responses from TheMealDB API and storing the necessary information.
   - Each model conforms to the `Codable` protocol for easy encoding and decoding from JSON data.

2. **ViewModel**:
   - `DessertViewModel`: Manages the fetching of desserts and sorting them alphabetically before passing the data to the views. It interacts with the `DessertService` to retrieve the data asynchronously.
   - `MealDetailViewModel`: Fetches the details of a selected meal, including its ingredients and measurements, and prepares the data for display in the detail view.

3. **View**:
   - `DessertListView`: Displays a list of desserts fetched from the API.
   - `MealDetailView`: Shows detailed information about a selected dessert, including its thumbnail, name, instructions, and ingredients.

### Swift Concurrency

The project uses Swift Concurrency (`async/await`) to handle network requests and data processing, ensuring that the app remains responsive and performant:

- **Asynchronous Data Fetching**: 
  - The `DessertService` and `MealDetailsService` use `async/await` to fetch data from TheMealDB API. This ensures that the UI remains responsive while waiting for data.
  
- **Task Management**: 
  - The `Task` API is used to launch asynchronous tasks within the view models. This allows for easy cancellation and error handling of network requests.

### Error Handling

The project includes basic error handling to manage network failures and unexpected data formats. Errors are caught and logged, and the UI is updated accordingly to inform the user of any issues.

## Getting Started

### Prerequisites

- Xcode 13.0 or later
- iOS 15.0 or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/mealdb-ios-app.git
   cd mealdb-ios-app
   ```

2. Open the project in Xcode:
   ```bash
   open MealDB.xcodeproj
   ```

3. Build and run the project using the iOS Simulator or a connected device.

### API Key Configuration

The app is currently configured to use the developer test key `'1'` provided by TheMealDB API. If you have your own API key, you can update the base URL in the `DessertService` and `MealDetailService` to use it:

```swift
let baseURL = "https://www.themealdb.com/api/json/v1/YOUR_API_KEY/"
```

## Conclusion

This project serves as an example of how to implement the MVVM architecture in an iOS application, using Swift Concurrency to manage API calls and asynchronous data processing. The app is designed to be scalable and maintainable, with a clear separation of concerns and robust error handling. Feel free to explore and modify the code to suit your needs!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
