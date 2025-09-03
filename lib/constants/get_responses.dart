class HttpStatusHandler {
  /// Takes an HTTP status code and returns a user-friendly message.
  static String getMessage(int statusCode) {
    switch (statusCode) {
      // --- Success (2xx) ---
      case 200:
        return 'Success: The request was completed successfully.';
      case 201:
        return 'Success: The resource was created successfully.'; // Common for POST, but can occur
      case 204:
        return 'Success: No content to display.';

      // --- Client Errors (4xx) ---
      case 400:
        return 'Error: Bad request. The server could not understand the request.';
      case 401:
        return 'Error: Unauthorized. Authentication is required to access this resource.';
      case 403:
        return 'Error: Forbidden. You do not have permission to access this resource.';
      case 404:
        return 'Error: Not Found. The requested resource could not be found on the server.';
      case 429:
        return 'Error: Too many requests. Please try again later.';

      // --- Server Errors (5xx) ---
      case 500:
        return 'Error: Internal Server Error. Please try again later.';
      case 502:
        return 'Error: Bad Gateway. The server received an invalid response.';
      case 503:
        return 'Error: Service Unavailable. The server is currently unable to handle the request.';

      // --- Default Case ---
      default:
        // You can check for ranges if you want to be more generic
        if (statusCode >= 200 && statusCode < 300) {
          return 'The request was successful (Code: $statusCode).';
        } else if (statusCode >= 400 && statusCode < 500) {
          return 'A client error occurred (Code: $statusCode).';
        } else if (statusCode >= 500 && statusCode < 600) {
          return 'A server error occurred (Code: $statusCode).';
        }
        return 'An unexpected error occurred (Code: $statusCode).';
    }
  }
}
