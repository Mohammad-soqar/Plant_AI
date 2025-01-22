
# Plant AI App 🌱

Plant AI App is a mobile application designed to identify plants and provide care instructions using AI technology. The app integrates with the **Plant.id API** provided by Kindwise to offer accurate plant identification and health assessment capabilities.

## Features

- **Plant Identification**: Identify indoor plants, wildflowers, trees, grasses, and other plant species from images.
- **Health Assessment**: Evaluate the health of plants and detect potential diseases or pests.
- **Care Instructions**: Provide detailed guidance on optimal watering, light conditions, and soil types for identified plants.
- **Search History**: Keep track of past identifications for easy reference.
- **Photo Sharing**: Share plant identification results with friends and family.

## Technology Stack

- **Frontend**: Flutter (for cross-platform mobile development)
- **Backend**: Firebase (with optional Node.js integration)
- **API**: Plant.id API v3 by Kindwise

## Getting Started

### Prerequisites

- Install Flutter SDK on your machine. Refer to the [Flutter Installation Guide](https://flutter.dev/docs/get-started/install) for more details.
- Obtain an API key from the [Plant.id API](https://web.plant.id/) by registering an account.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/plant-ai-app.git
   cd plant-ai-app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Set up environment variables:
   - Create a `.env` file in the project root directory.
   - Add your Plant.id API key:
     ```
     PLANT_ID_API_KEY=your_api_key_here
     ```

4. Run the app:
   ```bash
   flutter run
   ```

### API Integration

This app leverages the Plant.id API for its core functionalities. The API provides two key services:
1. **Identification**: Determines the plant species from one or more images.
2. **Health Assessment**: Evaluates the health of the plant and detects potential diseases.

To use these services:
- Ensure the API key is included in all requests using the `Api-Key` header.
- Refer to the [Plant.id API Documentation](https://web.plant.id/documentation) for details on request parameters and response structures.

## Contributing

We welcome contributions to enhance the app! To contribute:
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and push them to your fork:
   ```bash
   git push origin feature-name
   ```
4. Open a pull request on the main repository.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- **Plant.id by Kindwise**: For providing the plant identification and health assessment services.
- Flutter and Firebase communities for their excellent tools and documentation.

## Contact

For inquiries or support, please contact [your_email@example.com].

---

Thank you for using Plant AI App! Happy gardening! 🌿
