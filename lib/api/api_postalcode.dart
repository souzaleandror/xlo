import 'package:dio/dio.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repositories/api_error.dart';
import 'package:xlo/repositories/api_response.dart';

getAddressFromAPI(String postalCode) async {
  final String endpoint =
      "http://viacep.com.br/ws/${postalCode.replaceAll('.', '').replaceAll('-', '')}/json";

  try {
    final Response response = await Dio().get<Map>(endpoint);

    print(response);
    if (response.data.containsKey('erro') && response.data['error']) {
      return ApiResponse.error(
        error: ApiError(
          code: -1,
          message: "CEP Invalido",
        ),
      );
    }

    final Address address = Address(
      place: response.data["logradouro"],
      district: response.data["bairro"],
      city: response.data["localidade"],
      postalCode: response.data["cep"],
      fererativeUnit: response.data["uf"],
    );

    print(address.toString());

    return ApiResponse.success(result: address);
  } on DioError catch (e) {
    return ApiResponse.error(
        error: ApiError(code: -1, message: "FAlha ao contactar VIACEP"));
    print(e.message);
  } catch (e, ex) {
    print("$e >>> $ex");
  }
}
