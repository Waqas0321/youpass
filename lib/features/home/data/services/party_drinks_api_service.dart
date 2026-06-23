import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/home/data/models/event_drink_menu_response_model.dart';
import 'package:youpass/features/home/data/models/event_drink_order_response_model.dart';

class PartyDrinksApiService extends BaseApiService {
  PartyDrinksApiService(super.apiClient);

  Future<EventDrinkMenuResponseModel> fetchEventDrinkMenu(String eventId) {
    return getModel(
      ApiEndpoints.eventDrinkMenu(eventId),
      fromJson: EventDrinkMenuResponseModel.fromJson,
      authenticated: true,
    );
  }

  Future<EventDrinkOrderModel> createDrinkOrder({
    required String eventId,
    required Map<String, int> quantities,
  }) {
    return postModel(
      ApiEndpoints.eventDrinkOrders(eventId),
      body: {
        'items': quantities.entries
            .where((entry) => entry.value > 0)
            .map(
              (entry) => {
                'product_id': entry.key,
                'quantity': entry.value,
              },
            )
            .toList(),
      },
      fromJson: EventDrinkOrderModel.fromJson,
      authenticated: true,
    );
  }

  Future<EventDrinkOrdersListModel> fetchMyDrinkOrders({bool? complimentary}) {
    return getModel(
      ApiEndpoints.usersMeDrinkOrders(complimentary: complimentary),
      fromJson: EventDrinkOrdersListModel.fromJson,
      authenticated: true,
    );
  }

  Future<EventDrinkOrderModel> fetchDrinkOrder(String orderId) {
    return getModel(
      ApiEndpoints.userDrinkOrder(orderId),
      fromJson: EventDrinkOrderModel.fromJson,
      authenticated: true,
    );
  }
}
