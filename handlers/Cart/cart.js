function addItemToCart(img, name, code, quantity, price, successCallback, errorCallback) {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/currentcart.ashx",
        type: "POST",
        data: {
            action: "additem",
            productimg: img,
            productname: name,
            productcode: code,
            quantity: quantity,
            price: price
        },
        success: function (data) { if (data.Success) { successCallback(data.Cart); } },
        error: function (data) { errorCallback(data); }
        
    });
    
    
}
function getCartItemCount(successCallback, errorCallback) {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/currentcart.ashx",
        type: "GET",
        data: {
            action: "count"
        },
        success: function (data) { if (data.Success) { successCallback(data.Count); } },
        error: function (data) { errorCallback(data); }
    });
}
function getCart(successCallback, errorCallback) {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/currentcart.ashx",
        type: "GET",
        data: {
            action: "cart"
        },
        success: function (data) { if (data.Success) { successCallback(data.Cart); } },
        error: function (data) { errorCallback(data); }
    });
}

function setCODPayment(successCallback, errorCallback) {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/currentcart.ashx",
        type: "GET",
        data: {
            action: "codpayment"
        },
        success: function (data) { if (data.Success) { successCallback(data.Cart); } },
        error: function (data) { errorCallback(data); }
    });
}

function makeCartTable() {
    getCart(function (data) {
        $(".cartTable tbody").html("");
        var orderItems = data.OrderItems;
        for (var prop in orderItems) {
            var tr = $("<tr class='orderitemrow' />");
            tr.append($("<td />").html("<img src='" + orderItems[prop]["ProductImg"] + "' alt='' style='height:80px;' />"));
            tr.append($("<td />").html(orderItems[prop]["ProductName"]));
            tr.append($("<td />").html(orderItems[prop]["ProductCode"]));
            tr.append($("<td />").html("<i class='icon-square icon-minus-sign' onclick='addItemToCart(\"" + orderItems[prop]["ProductImg"] + "\", \"" + orderItems[prop]["ProductName"] + "\", \"" + orderItems[prop]["ProductCode"] + "\", -1, " + orderItems[prop]["Price"] + ", function(data) { makeCartTable(); }, function(data) {})'></i><span style='padding-left:5px; padding-right:5px;'>" + orderItems[prop]["Quantity"] + "</span><i class='icon-square icon-plus-sign'  onclick='addItemToCart(\"" + orderItems[prop]["ProductImg"] + "\", \"" + orderItems[prop]["ProductName"] + "\", \"" + orderItems[prop]["ProductCode"] + "\", 1, " + orderItems[prop]["Price"] + ", function(data) { makeCartTable(); }, function(data) {})'></i>"));
            tr.append($("<td />").html(orderItems[prop]["Price"]));
            tr.append($("<td />").html(orderItems[prop]["Amount"]));
            tr.append($("<td />").html("<a href='javascript:removeCartItem(" + orderItems[prop]["ID"] + ")'><i class='icon-square icon-remove'></i></a>"));
            $(".cartTable tbody").append(tr);
        }


        if (orderItems.length == 0) {
            $(".cartTable tbody").append($("<tr />").append($("<td colspan='7' style='text-align:center;'/>").html("You do not have any product in your cart.")));
        }
        else {
            var amountTr = $("<tr class='totalamountrow' />");
            amountTr.append($("<td colspan='5' style='text-align:right;'><strong>Total Amount<strong></td>"));
            amountTr.append($("<td colspan='2' />").html(data.Amount));
            $(".cartTable tbody").append(amountTr);
            var shippingTr = $("<tr class='shippingrow' />");
            shippingTr.append($("<td colspan='5' style='text-align:right;'>Shipping</td>"));
            shippingTr.append($("<td colspan='2' />").html(data.ShippingPrice));
            $(".cartTable tbody").append(shippingTr);
            if (data.Discount > 0) {
                var discountTr = $("<tr class='discountrow' />");
                discountTr.append($("<td colspan='5' style='text-align:right;'><strong>Discount<strong></td>"));
                discountTr.append($("<td colspan='2' />").html(data.Discount));
                $(".cartTable tbody").append(discountTr);
            }
            var totalTr = $("<tr class='totalrow' />");
            totalTr.append($("<td colspan='5' style='text-align:right;'><strong>Total<strong></td>"));
            totalTr.append($("<td colspan='2' />").html(data.Total));
            $(".cartTable tbody").append(totalTr);
        }
    }, function (data) { });

}

function removeCartItem(itemid) {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/currentcart.ashx",
        type: "POST",
        data: {
            action: "removeitem",
            itemid: itemid
        },
        success: function (data) { makeCartTable() },
        error: function (data) { console.log(data); }
    });
}

function populateContactInfoForm() {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/currentcart.ashx",
        type: "GET",
        data: {
            action: "cart"
        },
        success: function (data) {
            if (data.Success) {
                $("#name").val(data.Cart.Name);
                $("#email").val(data.Cart.Email);
                $("#memberid").val(data.Cart.ID);
                $("#phone").val(data.Cart.Phone);
                $("#billingaddress").val(data.Cart.BillingAddress);
                $("#billingcity").val(data.Cart.BillingCity);
                $("#billingstate").val(data.Cart.BillingState);
                $("#billingcountry").val(data.Cart.BillingCountry);
                $("#billingzip").val(data.Cart.BillingZip);
                $("#shippingaddress").val(data.Cart.ShippingAddress);
                $("#shippingcity").val(data.Cart.ShippingCity);
                $("#shippingstate").val(data.Cart.ShippingState);
                $("#shippingcountry").val(data.Cart.ShippingCountry);
                $("#shippingzip").val(data.Cart.ShippingZip);
            }
        },
        error: function (data) { console.log(data); }
    });
}

function populateContactInfo() {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/currentcart.ashx",
        type: "GET",
        data: {
            action: "cart"
        },
        success: function (data) {
            if (data.Success) {
                $("#name").html(data.Cart.Name);
                $("#email").html(data.Cart.Email);
                $("#memberid").html(data.Cart.ID);
                $("#phone").html(data.Cart.Phone);
                $("#billingaddress").html(data.Cart.BillingAddress);
                $("#billingcity").html(data.Cart.BillingCity);
                $("#billingstate").html(data.Cart.BillingState);
                $("#billingcountry").html(data.Cart.BillingCountry);
                $("#billingzip").html(data.Cart.BillingZip);
                $("#shippingaddress").html(data.Cart.ShippingAddress);
                $("#shippingcity").html(data.Cart.ShippingCity);
                $("#shippingstate").html(data.Cart.ShippingState);
                $("#shippingcountry").html(data.Cart.ShippingCountry);
                $("#shippingzip").html(data.Cart.ShippingZip);
            }
        },
        error: function (data) { console.log(data); }
    });
}

function setCartContact(name, email, phone, successCallback, errorCallback) {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/currentcart.ashx",
        type: "POST",
        data: {
            action: "updatecontact",
            name: name,
            email: email,
            phone: phone,
            newsletter: true
        },
        success: function (data) { var obj = eval('(' + data + ')'); successCallback(obj); },
        error: function (data) { var obj = eval('(' + data + ')'); errorCallback(obj); }
    });
}

function setCartAddress(billingAddress, billingState, billingCity, billingCountry, billingZip,
    shippingAddress, shippingState, shippingCity, shippingCountry, shippingZip, successCallback, errorCallback) {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/currentcart.ashx",
        type: "POST",
        data: {
            action: "updateaddress",
            billingaddress: billingAddress,
            billingstate: billingState,
            billingcity: billingCity,
            billingcountry: billingCountry,
            billingzip: billingZip,
            shippingaddress: shippingAddress,
            shippingstate: shippingState,
            shippingcity: shippingCity,
            shippingcountry: shippingCountry,
            shippingzip: shippingZip
        },
        success: function (data) { var obj = eval('(' + data + ')'); successCallback(obj); },
        error: function (data) { var obj = eval('(' + data + ')'); errorCallback(obj); }
    });
}

function copyBillingInfo() {
    $('#shippingaddress').val($('#billingaddress').val());
    $('#shippingcity').val($('#billingcity').val());
    $('#shippingstate').val($('#billingstate').val());
    $('#shippingcountry').val($('#billingcountry').val());
    $('#shippingzip').val($('#billingzip').val());
}
function contactInfoSuccess(data) {
    if (data.Success) {
        setCartAddress($('#billingaddress').val(), $('#billingstate').val(), $('#billingcity').val(), $('#billingcountry').val(),
$('#billingzip').val(), $('#shippingaddress').val(), $('#shippingstate').val(), $('#shippingcity').val(), $('#shippingcountry').val(),
$('#shippingzip').val(), addressSuccess, addressError);
        $("#result").html("<div class='alert alert-success'><button type='button' class='close' data-dismiss='alert'>×</button><strong>Good, your contact information is saved also provide shipping and billing address.</strong></div>");
    } else {
        var errorDiv = $("<div class='alert alert-error' />");
        errorDiv.append($("<button class='close' data-dismiss='alert'>x</button>"));
        var errorList = $("<ul />");
        for (var obj in data.Error) {
            errorList.append($("<li />").html(data.Error[obj].Message));
        }
        errorDiv.append(errorList);
        $("#result").html("");
        $("#result").append(errorDiv);
    }
}

function contactInfoError(data) {
    var errorDiv = $("<div class='alert alert-error' />");
    errorDiv.append($("<button class='close' data-dismiss='alert'>x</button>"));
    var errorList = $("<ul />");
    for (var obj in data.Error) {
        errorList.append($("<li />").html(data.Error[obj].Message));
    }
    errorDiv.append(errorList);
    $("#result").html("");
    $("#result").append(errorDiv);
}

function addressSuccess(data) {
    if (data.Success) {
        $("#result").html("<div class='alert alert-success'><button type='button' class='close' data-dismiss='alert'>×</button><strong>Good, your shipping and billing address is saved proceed to check out.</strong></div>");
        location.href = "checkout";
    } else {
        var errorDiv = $("<div class='alert alert-error' />");
        errorDiv.append($("<button class='close' data-dismiss='alert'>x</button>"));
        var errorList = $("<ul />");
        for (var obj in data.Error) {
            errorList.append($("<li />").html(data.Error[obj].Message));
        }
        errorDiv.append(errorList);
        $("#result").html("");
        $("#result").append(errorDiv);
        return false;
    }
}
function addressError(data) {
    var errorDiv = $("<div class='alert alert-error' />");
    errorDiv.append($("<button class='close' data-dismiss='alert'>x</button>"));
    var errorList = $("<ul />");
    for (var obj in data.Error) {
        errorList.append($("<li />").html(data.Error[obj].Message));
    }
    errorDiv.append(errorList);
    $("#result").html("");
    $("#result").append(errorDiv);
}

function getMyOrderList() {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/myorders.ashx",
        type: "GET",
        data: {
            action: "orders"
        },
        success: function (data) {
            if (data.Success) {
                $(".orderTable tbody").html("");
                var orders = data.Orders;
                for (var prop in orders) {
                    var tr = $("<tr class='orderrow' />");
                    tr.append($("<td />").html(orders[prop]["ID"]));
                    tr.append($("<td />").html(orders[prop]["DateCreated"]));
                    tr.append($("<td />").html(orders[prop]["Status"]));
                    tr.append($("<td />").html(orders[prop]["Amount"]));
                    tr.append($("<td />").html(orders[prop]["Name"]));
                    tr.append($("<td />").html(orders[prop]["Phone"]));
                    tr.append($("<td />").html("<a href='http://www.rockying.com/myorder?orderid=" + orders[prop]["ID"] + "'>View</a>"));
                    $(".orderTable tbody").append(tr);
                }
                if (orders.length == 0) {
                    $(".orderTable tbody").append($("<tr />").append($("<td colspan='7' style='text-align:center;'/>").html("You have not made any purchases.")));
                }
            }
            else {
                $(".orderTable tbody").append($("<tr />").append($("<td colspan='7' style='text-align:center;'/>").html("We are unable to fetch your order history, please try after some time.")));
            }
        },
        error: function (data) { $(".orderTable tbody").append($("<tr />").append($("<td colspan='7' style='text-align:center;'/>").html("We are unable to fetch your order history, please try after some time."))); }
    });
}

function getMyOrder(id) {
    $.ajax({
        url: "http://www.rockying.com/handlers/cart/myorders.ashx",
        type: "GET",
        data: {
            action: "order",
            orderid: id
        },
        success: function (data) {
            if (data.Success) {
                $(".cartTable tbody").html("");
                var orderItems = data.Order.OrderItems;
                for (var prop in orderItems) {
                    var tr = $("<tr class='orderitemrow' />");
                    tr.append($("<td />").html("<img src='" + orderItems[prop]["ProductImg"] + "' alt='' style='height:80px;' />"));
                    tr.append($("<td />").html(orderItems[prop]["ProductName"]));
                    tr.append($("<td />").html(orderItems[prop]["ProductCode"]));
                    tr.append($("<td />").html(orderItems[prop]["Quantity"]));
                    tr.append($("<td />").html(orderItems[prop]["Price"]));
                    tr.append($("<td />").html(orderItems[prop]["Amount"]));
                    $(".cartTable tbody").append(tr);
                }


                if (orderItems.length == 0) {
                    $(".cartTable tbody").append($("<tr />").append($("<td colspan='6' style='text-align:center;'/>").html("You do not have any product in your cart.")));
                }
                else {
                    var amountTr = $("<tr class='totalamountrow' />");
                    amountTr.append($("<td colspan='5' style='text-align:right;'><strong>Total Amount<strong></td>"));
                    amountTr.append($("<td colspan='1' />").html(data.Order.Amount));
                    $(".cartTable tbody").append(amountTr);
                    var shippingTr = $("<tr class='shippingrow' />");
                    shippingTr.append($("<td colspan='5' style='text-align:right;'>Shipping</td>"));
                    shippingTr.append($("<td colspan='1' />").html(data.Order.ShippingPrice));
                    $(".cartTable tbody").append(shippingTr);
                    if (data.Discount > 0) {
                        var discountTr = $("<tr class='discountrow' />");
                        discountTr.append($("<td colspan='5' style='text-align:right;'><strong>Discount<strong></td>"));
                        discountTr.append($("<td colspan='1' />").html(data.Order.Discount));
                        $(".cartTable tbody").append(discountTr);
                    }
                    var totalTr = $("<tr class='totalrow' />");
                    totalTr.append($("<td colspan='5' style='text-align:right;'><strong>Total<strong></td>"));
                    totalTr.append($("<td colspan='1' />").html(data.Order.Total));
                    $(".cartTable tbody").append(totalTr);

                    $("#name").html(data.Order.Name);
                    $("#email").html(data.Order.Email);
                    $("#memberid").html(data.Order.ID);
                    $("#phone").html(data.Order.Phone);
                    $("#billingaddress").html(data.Order.BillingAddress);
                    $("#billingcity").html(data.Order.BillingCity);
                    $("#billingstate").html(data.Order.BillingState);
                    $("#billingcountry").html(data.Order.BillingCountry);
                    $("#billingzip").html(data.Order.BillingZip);
                    $("#shippingaddress").html(data.Order.ShippingAddress);
                    $("#shippingcity").html(data.Order.ShippingCity);
                    $("#shippingstate").html(data.Order.ShippingState);
                    $("#shippingcountry").html(data.Order.ShippingCountry);
                    $("#shippingzip").html(data.Order.ShippingZip);
                    $("#ordernumber").html("Order Number : " + data.Order.ID);
                    if (data.Order.TransactionCode != "") {
                        $("#ordertransactioncode").html("Payment Transaction Code : " + data.Order.TransactionCode);
                    } else {
                        $("#ordertransactioncode").html("");
                    }
                    if (data.Order.TransactionDate != "") {
                        $("#ordertransactiondate").html("Payment Transaction Date : " + data.Order.TransactionDate);
                    } else {
                        $("#ordertransactiondate").html("");
                    }
                    if (data.Order.Status != "") {
                        $("#orderstatus").html("Order Status : " + data.Order.Status);
                    } else { $("#orderstatus").html(""); }
                    if (data.Order.ShippingTrackCode != "") {
                        $("#shippingtrackcode").html("Shipping Track Code : " + data.Order.ShippingTrackCode);
                    } else {
                        $("#shippingtrackcode").html("");
                    }
                }
            }
        },
        error: function (data) { }
    });
}