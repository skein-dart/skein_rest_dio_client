An implementation of the [skein_rest_client](https://github.com/skein-dart/skein_rest_client) based on the [dio](https://pub.dev/packages/dio) package.

## Features

Allows to use Dio for HTTP calls on the Infrastructure layer w/o direct 
dependency on it. 

## Getting started

1. Add `skein_rest_client` and `skein_rest_dio_client` dependencies:
```
dependencies:
  skein_rest_client:
  skein_rest_dio_client:
```

2. Configure your RestClient to use `RestClientDio` implementation:
```dart
final dio = Dio();

Rest.config = Config(
  rest: RestConfig(builder: () => RestClientDio(dio), api: "https://example.com/api"),
);
```

3. Use it through the `rest()` function:
```dart
rest(path: "/user/current").get();
```

## Usage

For more usage examples see Usage section of the [skein_rest_client](https://github.com/skein-dart/skein_rest_client) 
package.