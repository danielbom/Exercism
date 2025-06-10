import ballerina/http;
import ballerina/uuid;

configurable int port = 8080;

enum CakeKind {
    BUTTER_CAKE = "Butter Cake",
    CHOCOLATE_CAKE = "Chocolate Cake",
    TRES_LECHES = "Tres Leches"
}

const map<int> MENU = {
    "Butter Cake": 15,
    "Chocolate Cake": 20,
    "Tres Leches": 25
};

enum OrderStatus {
    PENDING = "pending",
    IN_PROGRESS = "in progress",
    COMPLETED = "completed"
}

type OrderDetail record {|
    CakeKind item;
    int quantity;
|};

type Order record {|
    string username;
    OrderDetail[] order_items;
|};

type OrderUpdate record {|
    OrderDetail[] order_items;
|};

isolated map<Order> orders = {};
isolated map<OrderStatus> orderStatus = {};

service on new http:Listener(port) {
    resource function get menu() returns MENU => MENU;

    isolated resource function post 'order(@http:Payload Order & readonly newOrder) returns http:Created|http:BadRequest|error {
        var usernameValidation = validateUsername(newOrder.username);
        if usernameValidation !is () {
            return <http:BadRequest>{body: usernameValidation};
        }
        var orderItemsValidation = validateOrderItems(newOrder.order_items);
        if orderItemsValidation !is () {
            return <http:BadRequest>{body: orderItemsValidation};
        }

        var total = computeSum(newOrder.order_items);
        if total is http:BadRequest {
            return total;
        }
        var orderId = check generateOrderId();

        lock {
            orders[orderId] = newOrder;
        }
        lock {
            orderStatus[orderId] = PENDING;
        }

        return <http:Created>{body: {order_id: orderId, total}};
    }

    resource function get 'order/[string orderId]() returns http:Ok|http:NotFound {
        lock {
            var status = orderStatus[orderId];
            if status is () {
                return <http:NotFound>{};
            } else {
                return <http:Ok>{body: {order_id: orderId, status}};
            }
        }
    }

    isolated resource function put 'order/[string orderId](@http:Payload OrderUpdate & readonly updatedOrder) returns http:Ok|http:BadRequest|http:Forbidden|http:NotFound {
        lock {
            var status = orderStatus[orderId];
            if status is () {
                return <http:NotFound>{};
            }
            if status != PENDING {
                return <http:Forbidden>{};
            }
        }

        var orderItemsValidation = validateOrderItems(updatedOrder.order_items);
        if orderItemsValidation !is () {
            return <http:BadRequest>{body: orderItemsValidation};
        }

        var total = computeSum(updatedOrder.order_items);
        if total is http:BadRequest {
            return total;
        }

        lock {
            var 'order = <Order>orders[orderId];
            orders[orderId] = {
                username: 'order.username,
                order_items: updatedOrder.order_items
            };
        }

        return <http:Ok>{body: {order_id: orderId, total}};
    }

    isolated resource function delete 'order/[string orderId]() returns http:Ok|http:Forbidden|http:NotFound {
        lock {
            var status = orderStatus[orderId];
            if status is () {
                return <http:NotFound>{};
            }
            if status != PENDING {
                return <http:Forbidden>{};
            }
        }

        lock {
            var _ = orders.remove(orderId);
        }
        lock {
            var _ = orderStatus.remove(orderId);
        }
        return <http:Ok>{};
    }
}

isolated function generateOrderId() returns string|error {
    return uuid:createType4AsString();
}

isolated function computeSum(OrderDetail[] items) returns int|(http:BadRequest & readonly) {
    if items.length() == 0 {
        return <http:BadRequest & readonly>{body: {message: "missing order items"}};
    }

    int total = 0;
    map<boolean> seen = {};
    foreach OrderDetail item in items {
        if seen.hasKey(item.item) {
            return <http:BadRequest & readonly>{body: {message: "duplicate item"}};
        }
        if !MENU.hasKey(item.item) {
            return <http:BadRequest & readonly>{body: {message: "unknown item"}};
        }
        if item.quantity <= 0 {
            return <http:BadRequest & readonly>{body: {message: "must order a positive number"}};
        }
        seen[item.item] = true;
        total += MENU.get(item.item) * item.quantity;
    }
    return total;
}

isolated function validateUsername(string username) returns string? {
    if username.length() == 0 {
        return "username is empty";
    }
    return ();
}

isolated function validateOrderItems(OrderDetail[] items) returns string? {
    if items.length() == 0 {
        return "order_items is empty";
    }
    map<boolean> seen = {};
    foreach var item in items {
        if item.quantity <= 0 {
            return "negative order quatity in order_items";
        }
        if seen.hasKey(item.item) {
            return "multiple order item in order_items";
        }
        seen[item.item] = true;
    }
    return ();
}
