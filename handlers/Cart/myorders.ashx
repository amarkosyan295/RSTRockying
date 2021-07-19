<%@ WebHandler Language="C#" Class="myorders" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web.Script.Serialization;
using Rockying;
using Rockying.Models;

public class myorders : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/json";
        var error = new List<dynamic>();
        var serializer = new JavaScriptSerializer();
        OrderManager om = new OrderManager();
        try
        {
            long? memberid = null;
            if (context.Request.IsAuthenticated)
            {
                memberid = MemberManager.GetUser(HttpContext.Current.User.Identity.Name.ToString()).ID;
            }

            if (!memberid.HasValue)
            {
                error.Add(new { Message = "User not logged in." });
                context.Response.Write(serializer.Serialize(new { Success = false, Error = error }));
            }

            if (context.Request["action"] != null && memberid.HasValue)
            {
                if (context.Request["action"].ToString() == "orders")
                {
                    List<Order> list = om.GetUserOrderList(memberid.Value);
                    List<dynamic> orderList = new List<dynamic>();
                    foreach (Order o in list)
                    {
                        orderList.Add(GetCartDynamicObject(o));
                    }

                    context.Response.Write(serializer.Serialize(new { Success = true, Orders = orderList }));
                }
                else if (context.Request["action"].ToString() == "order")
                {
                    int orderId = 0;
                    if (context.Request["orderid"] != null)
                    {
                        if (!int.TryParse(context.Request["orderid"].Trim(), out orderId))
                        {
                            error.Add(new { Message = "No order id provided" });
                        }
                    }
                    else { error.Add(new { Message = "No order id provided" }); }
                    
                    if (error.Count == 0) {
                        context.Response.Write(serializer.Serialize(new { Success = true, Order = GetCartDynamicObject(om.GetOrderDetail(orderId)) }));
                    }
                    else {
                        context.Response.Write(serializer.Serialize(new { Success = false, Error = error }));
                    }
                }
            }
        }
        catch (Exception ex)
        {
            context.Trace.Write(ex.Message);
            context.Trace.Write(ex.Source);
            context.Trace.Write(ex.StackTrace);
            error.Add(new { Message = ex.Message });
            context.Response.Write(serializer.Serialize(new { Success = false, Error = error }));
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    private dynamic GetCartDynamicObject(Order o)
    {
        List<dynamic> subItems = new List<dynamic>();
        foreach (OrderItem oi in o.OrderItems)
        {
            subItems.Add(new
            {
                ID = oi.ID,
                OrderID = oi.OrderID,
                ProductImg = oi.ProductImg,
                ProductName = oi.ProductName,
                ProductCode = oi.ProductCode,
                Quantity = oi.Quantity,
                Price = oi.Price,
                Amount = oi.Amount
            });
        }
        var item = new
        {
            ID = o.ID,
            DateCreated = o.DateCreated.ToShortDateString(),
            Name = o.Name,
            Email = o.Email,
            MemberID = o.MemberID,
            Phone = o.Phone,
            BillingAddress = o.BillingAddress,
            BillingCity = o.BillingCity,
            BillingCountry = o.BillingCountry,
            BillingZip = o.BillingZip,
            BillingState = o.BillingState,
            ShippingAddress = o.ShippingAddress,
            ShippingCity = o.ShippingCity,
            ShippingState = o.ShippingState,
            ShippingCountry = o.ShippingCountry,
            ShippingZip = o.ShippingZip,
            Coupon = o.Coupon,
            Status = Enum.Parse(typeof(OrderStatusType), o.Status.ToString()).ToString(),
            ShippingTrackCode = o.ShippingTrackCode,
            ShippingNotes = o.ShippingNotes,
            DateModified = o.DateModified,
            Amount = o.Amount,
            Tax = o.Tax,
            TaxPercentage = o.TaxPercentage,
            Discount = o.Discount,
            Total = o.Total,
            TransactionCode = o.TransactionCode,
            TransactionDate = o.TransactionDate.HasValue ? o.TransactionDate.Value.ToString() : "",
            TransactionDetail = o.TransactionDetail,
            ShippingPrice = o.ShippingPrice,
            OrderItems = subItems
        };

        return item;
    }

}