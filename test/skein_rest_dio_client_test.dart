import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:skein_rest_client/skein_rest_client.dart';
import 'package:skein_rest_dio_client/src/rest_client_dio.dart';
import 'package:test/test.dart';

import 'skein_rest_dio_client_test.mocks.dart';
import 'stub/stub_data.dart';
import 'stub/stub_json.dart';

@GenerateMocks([Dio])
void main() {

  final api = "https://example.com/api";

  final dio = MockDio();

  Rest.config = Config(
    rest: RestConfig(builder: () => RestClientDio(dio), api: api),
    auth: AuthConfig(builder: () => BearerAuthorization(token: "test_access_token")),
  );

  group("POST method", () {
    tearDown(() {
      reset(dio);
    });

    test("Sends request with expected params", () async {

      when(
        dio.request(
          argThat(equals("$api/user/current")),
          cancelToken: argThat(isNotNull, named: "cancelToken"),
          data: argThat(isA<Map<String, dynamic>>()
            .having((d) => d, "profile data contains first name", containsPair("first_name", "John"))
            .having((d) => d, "profile data contains last name", containsPair("last_name", "Doe")),
            named: "data"
          ),
          options: argThat(isA<Options>()
            .having((o) => o.headers, "headers", containsPair("Authorization", "Bearer test_access_token"))
            .having((o) => o.method, "method", equals("POST")),
            named: "options"
          )
        )
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ""), data: userProfileResponse));

      final CancelableOperation<UserProfile> o = rest(path: "/user/current")
        .encode(withEncoder: (data) => data.toJson())
        .decode(withDecoder: (json) => UserProfile.fromJson(json))
      .post(UserProfile("John", "Doe"));

      await o.value;

    });

    test("Overrides default Authorization header", () async {

      when(
        dio.request(
          argThat(equals("$api/user/current")),
          cancelToken: argThat(isNotNull, named: "cancelToken"),
          data: argThat(isA<Map<String, dynamic>>(), named: "data"),
          options: argThat(isA<Options>()
            .having((o) => o.headers, "headers", containsPair("Authorization", "Bearer overridden_access_token"))
            .having((o) => o.method, "method", equals("POST")),
            named: "options"
          )
        )
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ""), data: userProfileResponse));

      final CancelableOperation<UserProfile> o = rest(path: "/user/current")
        .authorization(() => BearerAuthorization(token: "overridden_access_token"))
        .encode(withEncoder: (data) => data.toJson())
        .decode(withDecoder: (json) => UserProfile.fromJson(json))
      .post(UserProfile("John", "Doe"));

      await o.value;

    });

    test("Removes default Authorization header", () async {

      when(
        dio.request(
          argThat(equals("$api/auth/sign-in")),
          cancelToken: argThat(isNotNull, named: "cancelToken"),
          data: argThat(isA<Map<String, dynamic>>(), named: "data"),
          options: argThat(isA<Options>()
            .having((o) => o.headers, "headers", isNot(contains("Authorization")))
            .having((o) => o.method, "method", equals("POST")),
            named: "options"
          )
        )
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ""), data: signInResponse));

      final CancelableOperation<SignInResponse> o = rest(path: "/auth/sign-in")
        .authorization(() => null)
        .encode(withEncoder: (data) => data.toJson())
        .decode(withDecoder: (json) => SignInResponse.fromJson(json))
      .post(SignInRequest("john", "password"));

      await o.value;

    });

  });

  group("GET method", () {
    tearDown(() {
      reset(dio);
    });

    test("Sends method with expected params", () async {

      when(dio.request(argThat(equals("$api/user/current")),
        cancelToken: argThat(isNotNull, named: "cancelToken"),
        data: isNull,
        options: argThat(isA<Options>()
            .having((o) => o.headers, "Contains Authorization header", containsPair("Authorization", "Bearer test_access_token"))
            .having((o) => o.method, "Method is GET", equals("GET")),
          named: "options"
        )
      )).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ""), data: userProfileResponse));

      final CancelableOperation<UserProfile> o = rest(path: "/user/current")
        .decode(withDecoder: (json) => UserProfile.fromJson(json))
      .get();
      
      final user = await o.value;
      
      expect(user, UserProfile("John", "Doe"));

    });

  });
}
