<%@ WebHandler Language="C#" Class="currentcart" %>

using System;
using System.Web;
using System.Web.UI;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web.Script.Serialization;
using Rockying;
using Rockying.Models;

public class currentcart : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        var error = new List<dynamic>();
        var serializer = new JavaScriptSerializer();
        try
        {
            if (context.Request["action"] != null)
            {
                OrderManager om = new OrderManager();
                string action = context.Request["action"].Trim().ToLower();
                if (action == "count")
                {
                    context.Response.ContentType = "text/json";
                    context.Response.Write(serializer.Serialize(new { Count = om.GetCartItemCount(), Success = true }));
                }
                else if (action == "cart")
                {
                    context.Response.ContentType = "text/json";
                    context.Response.Write(serializer.Serialize(new { Cart = GetCartDynamicObject(om.GetCart()), Success = true }));
                }
                else if (action == "codpayment")
                {
                    om.UpdateOrderPayment(int.Parse(CookieWorker.GetCookie("indiabobbles", "cartid")), "COD", DateTime.Now, "Cash on Delivery");
                    om.UpdateOrderStatus(int.Parse(CookieWorker.GetCookie("indiabobbles", "cartid")), OrderStatusType.CODPaid, "Payment will be done on delivery.");
                    context.Response.ContentType = "text/json";
                    context.Response.Write(serializer.Serialize(new { Cart = GetCartDynamicObject(om.GetCart()), Success = true }));
                }
                else if (action == "cardpayment")
                {
                }
                else if (action == "additem")
                {

                    string productImg = string.Empty;
                    if (context.Request["productimg"] != null)
                    {
                        productImg = context.Request["productimg"].Trim();
                    }
                    string productName = string.Empty;
                    if (context.Request["productname"] != null)
                    {
                        productName = context.Request["productname"].Trim();
                    }
                    string productCode = string.Empty;
                    if (context.Request["productcode"] != null)
                    {
                        productCode = context.Request["productcode"].Trim();
                    }
                    int quantity = 0;
                    if (context.Request["quantity"] != null)
                    {
                        if (!int.TryParse(context.Request["quantity"].Trim(), out quantity))
                        {
                            quantity = 0;
                            error.Add(new { Message = "Quantity should only be a number." });
                        }
                    }
                    else
                    {
                        error.Add(new { Message = "Quantity is required." });
                    }
                    decimal price = 0;
                    if (context.Request["price"] != null)
                    {
                        if (!decimal.TryParse(context.Request["price"].Trim(), out price))
                        {
                            price = 0;
                            error.Add(new { Message = "Price should only be a number." });
                        }
                    }
                    else
                    {
                        error.Add(new { Message = "Price is required." });
                    }

                    if (!Utility.ValidateRequired(productImg))
                    {
                        error.Add(new { Message = "Product Image is required." });
                    }
                    if (!Utility.ValidateRequired(productCode))
                    {
                        error.Add(new { Message = "Product Code is required." });
                    }
                    if (!Utility.ValidateRequired(productName))
                    {
                        error.Add(new { Message = "Product Name is required." });
                    }

                    context.Response.ContentType = "text/json";
                    if (error.Count == 0)
                    {
                        om.AddItem(quantity, om.GetCart().ID, productImg, productName, productCode, price);
                        context.Response.Write(serializer.Serialize(new { Cart = GetCartDynamicObject(om.GetCart()), Success = true }));
                    }
                    else
                    {
                        context.Response.Write(serializer.Serialize(new { Success = false, Error = error }));
                    }


                }
                else if (action == "removeitem")
                {
                    int itemid = 0;
                    if (context.Request["itemid"] != null)
                    {
                        if (!int.TryParse(context.Request["itemid"].Trim(), out itemid))
                        {
                            itemid = 0;
                            error.Add(new { Message = "No item selected." });
                        }
                    }
                    else
                    {
                        error.Add(new { Message = "No item selected." });
                    }

                    context.Response.ContentType = "text/json";

                    if (error.Count == 0)
                    {
                        om.RemoveItem(itemid, int.Parse(CookieWorker.GetCookie("indiabobbles", "cartid")));
                        context.Response.Write(serializer.Serialize(new { Cart = GetCartDynamicObject(om.GetCart()), Success = true }));
                    }
                    else
                    {
                        context.Response.Write(serializer.Serialize(new { Success = false, Error = error }));
                    }
                }
                else if (action == "updateitem")
                {
                    int itemid = 0;
                    if (context.Request["itemid"] != null)
                    {
                        if (!int.TryParse(context.Request["itemid"].Trim(), out itemid))
                        {
                            itemid = 0;
                            error.Add(new { Message = "No item selected." });
                        }
                    }
                    else
                    {
                        error.Add(new { Message = "No item selected." });
                    }

                    string productImg = string.Empty;
                    if (context.Request["productimg"] != null)
                    {
                        productImg = context.Request["productimg"].Trim();
                    }
                    string productName = string.Empty;
                    if (context.Request["productname"] != null)
                    {
                        productName = context.Request["productname"].Trim();
                    }
                    string productCode = string.Empty;
                    if (context.Request["productcode"] != null)
                    {
                        productCode = context.Request["productcode"].Trim();
                    }
                    int quantity = 0;
                    if (context.Request["quantity"] != null)
                    {
                        if (!int.TryParse(context.Request["quantity"].Trim(), out quantity))
                        {
                            quantity = 0;
                            error.Add(new { Message = "Quantity should only be a number." });
                        }
                    }
                    else
                    {
                        error.Add(new { Message = "Quantity is required." });
                    }
                    decimal price = 0;
                    if (context.Request["price"] != null)
                    {
                        if (!decimal.TryParse(context.Request["price"].Trim(), out price))
                        {
                            price = 0;
                            error.Add(new { Message = "Price should only be a number." });
                        }
                    }
                    else
                    {
                        error.Add(new { Message = "Price is required." });
                    }

                    if (!Utility.ValidateRequired(productImg))
                    {
                        error.Add(new { Message = "Product Image is required." });
                    }
                    if (!Utility.ValidateRequired(productCode))
                    {
                        error.Add(new { Message = "Product Code is required." });
                    }
                    if (!Utility.ValidateRequired(productName))
                    {
                        error.Add(new { Message = "Product Name is required." });
                    }

                    context.Response.ContentType = "text/json";
                    if (error.Count == 0)
                    {
                        om.UpdateItem(itemid, quantity, int.Parse(CookieWorker.GetCookie("indiabobbles", "cartid")), productImg, productName, productCode, price);
                        context.Response.Write(serializer.Serialize(new { Cart = GetCartDynamicObject(om.GetCart()), Success = true }));
                    }
                    else
                    {
                        context.Response.Write(serializer.Serialize(new { Success = false, Error = error }));
                    }
                }
                else if (action == "updateshippingaddress")
                {
                    string shippingAddress = string.Empty;
                    if (context.Request["shippingaddress"] != null)
                    {
                        shippingAddress = context.Request["shippingaddress"].Trim();
                    }
                    string shippingCity = string.Empty;
                    if (context.Request["shippingcity"] != null)
                    {
                        shippingCity = context.Request["shippingcity"].Trim();
                    }
                    string shippingState = string.Empty;
                    if (context.Request["shippingstate"] != null)
                    {
                        shippingState = context.Request["shippingstate"].Trim();
                    }
                    string shippingCountry = string.Empty;
                    if (context.Request["shippingcountry"] != null)
                    {
                        shippingCountry = context.Request["shippingcountry"].Trim();
                    }
                    string shippingZip = string.Empty;
                    if (context.Request["shippingzip"] != null)
                    {
                        shippingZip = context.Request["shippingzip"].Trim();
                    }

                    if (!Utility.ValidateRequired(shippingAddress))
                    {
                        error.Add(new { Message = "Shipping Address is required." });
                    }
                    if (!Utility.ValidateRequired(shippingCity))
                    {
                        error.Add(new { Message = "Shipping City is required." });
                    }
                    if (!Utility.ValidateRequired(shippingState))
                    {
                        error.Add(new { Message = "Shipping State is required." });
                    }
                    if (!Utility.ValidateRequired(shippingCountry))
                    {
                        error.Add(new { Message = "Shipping Country is required." });
                    }
                    if (!Utility.ValidateRequired(shippingZip))
                    {
                        error.Add(new { Message = "Shipping Pincode is required." });
                    }

                    if (error.Count == 0)
                    {
                        om.UpdateOrderShippingAddress(int.Parse(CookieWorker.GetCookie("indiabobbles", "cartid")), shippingAddress,
                            shippingCity, shippingState, shippingCountry, shippingZip);
                        context.Response.Write(serializer.Serialize(new { Success = true }));
                    }
                    else
                    {
                        context.Response.Write(serializer.Serialize(new { Success = false, Error = error }));
                    }
                }
                else if (action == "updatebillingaddress")
                {
                    string billingAddress = string.Empty;
                    if (context.Request["billingaddress"] != null)
                    {
                        billingAddress = context.Request["billingaddress"].Trim();
                    }
                    string billingCity = string.Empty;
                    if (context.Request["billingcity"] != null)
                    {
                        billingCity = context.Request["billingcity"].Trim();
                    }
                    string billingState = string.Empty;
                    if (context.Request["billingstate"] != null)
                    {
                        billingState = context.Request["billingstate"].Trim();
                    }
                    string billingCountry = string.Empty;
                    if (context.Request["billingcountry"] != null)
                    {
                        billingCountry = context.Request["billingcountry"].Trim();
                    }
                    string billingZip = string.Empty;
                    if (context.Request["billingzip"] != null)
                    {
                        billingZip = context.Request["billingzip"].Trim();
                    }

                    if (!Utility.ValidateRequired(billingAddress))
                    {
                        error.Add(new { Message = "Billing Address is required." });
                    }
                    if (!Utility.ValidateRequired(billingCity))
                    {
                        error.Add(new { Message = "Billing City is required." });
                    }
                    if (!Utility.ValidateRequired(billingState))
                    {
                        error.Add(new { Message = "Billing State is required." });
                    }
                    if (!Utility.ValidateRequired(billingCountry))
                    {
                        error.Add(new { Message = "Billing Country is required." });
                    }
                    if (!Utility.ValidateRequired(billingZip))
                    {
                        error.Add(new { Message = "Billing Pincode is required." });
                    }

                    if (error.Count == 0)
                    {
                        om.UpdateOrderBillingAddress(int.Parse(CookieWorker.GetCookie("indiabobbles", "cartid")), billingAddress,
                            billingCity, billingState, billingCountry, billingZip);
                        context.Response.Write(serializer.Serialize(new { Success = true }));
                    }
                    else
                    {
                        context.Response.Write(serializer.Serialize(new { Success = false, Error = error }));
                    }
                }
                else if (action == "updateaddress")
                {
                    string shippingAddress = string.Empty;
                    if (context.Request["shippingaddress"] != null)
                    {
                        shippingAddress = context.Request["shippingaddress"].Trim();
                    }
                    string shippingCity = string.Empty;
                    if (context.Request["shippingcity"] != null)
                    {
                        shippingCity = context.Request["shippingcity"].Trim();
                    }
                    string shippingState = string.Empty;
                    if (context.Request["shippingstate"] != null)
                    {
                        shippingState = context.Request["shippingstate"].Trim();
                    }
                    string shippingCountry = string.Empty;
                    if (context.Request["shippingcountry"] != null)
                    {
                        shippingCountry = context.Request["shippingcountry"].Trim();
                    }
                    string shippingZip = string.Empty;
                    if (context.Request["shippingzip"] != null)
                    {
                        shippingZip = context.Request["shippingzip"].Trim();
                    }

                    if (!Utility.ValidateRequired(shippingAddress))
                    {
                        error.Add(new { Message = "Shipping Address is required." });
                    }
                    if (!Utility.ValidateRequired(shippingCity))
                    {
                        error.Add(new { Message = "Shipping City is required." });
                    }
                    if (!Utility.ValidateRequired(shippingState))
                    {
                        error.Add(new { Message = "Shipping State is required." });
                    }
                    if (!Utility.ValidateRequired(shippingCountry))
                    {
                        error.Add(new { Message = "Shipping Country is required." });
                    }
                    if (!Utility.ValidateRequired(shippingZip))
                    {
                        error.Add(new { Message = "Shipping Pincode is required." });
                    }

                    string billingAddress = string.Empty;
                    if (context.Request["billingaddress"] != null)
                    {
                        billingAddress = context.Request["billingaddress"].Trim();
                    }
                    string billingCity = string.Empty;
                    if (context.Request["billingcity"] != null)
                    {
                        billingCity = context.Request["billingcity"].Trim();
                    }
                    string billingState = string.Empty;
                    if (context.Request["billingstate"] != null)
                    {
                        billingState = context.Request["billingstate"].Trim();
                    }
                    string billingCountry = string.Empty;
                    if (context.Request["billingcountry"] != null)
                    {
                        billingCountry = context.Request["billingcountry"].Trim();
                    }
                    string billingZip = string.Empty;
                    if (context.Request["billingzip"] != null)
                    {
                        billingZip = context.Request["billingzip"].Trim();
                    }

                    if (!Utility.ValidateRequired(billingAddress))
                    {
                        error.Add(new { Message = "Billing Address is required." });
                    }
                    if (!Utility.ValidateRequired(billingCity))
                    {
                        error.Add(new { Message = "Billing City is required." });
                    }
                    if (!Utility.ValidateRequired(billingState))
                    {
                        error.Add(new { Message = "Billing State is required." });
                    }
                    if (!Utility.ValidateRequired(billingCountry))
                    {
                        error.Add(new { Message = "Billing Country is required." });
                    }
                    if (!Utility.ValidateRequired(billingZip))
                    {
                        error.Add(new { Message = "Billing Zip is required." });
                    }

                    if (error.Count == 0)
                    {
                        om.UpdateOrderShippingAddress(int.Parse(CookieWorker.GetCookie("indiabobbles", "cartid")), shippingAddress,
                            shippingCity, shippingState, shippingCountry, shippingZip);
                        om.UpdateOrderBillingAddress(int.Parse(CookieWorker.GetCookie("indiabobbles", "cartid")), billingAddress,
                            billingCity, billingState, billingCountry, billingZip);
                        context.Response.Write(serializer.Serialize(new { Success = true }));
                    }
                    else
                    {
                        context.Response.Write(serializer.Serialize(new { Success = false, Error = error }));
                    }
                }
                else if (action == "updatecontact")
                {
                    string name = string.Empty;
                    if (context.Request["name"] != null)
                    {
                        name = context.Request["name"].Trim();
                    }

                    string email = string.Empty;
                    if (context.Request["email"] != null)
                    {
                        email = context.Request["email"].Trim();
                    }

                    string phone = string.Empty;
                    if (context.Request["phone"] != null)
                    {
                        phone = context.Request["phone"].Trim();
                    }
                    
                    bool newsletter = false;
                    if(context.Request["newsletter"] != null){
                        if(bool.TryParse(context.Request["newsletter"].Trim(), out newsletter)){
                        }
                    }

                    long? memberid = null;
                    if (context.Request.IsAuthenticated)
                    {
                        memberid = MemberManager.GetUser(HttpContext.Current.User.Identity.Name.ToString()).ID;
                    }

                    if (!Utility.ValidateRequired(name))
                    {
                        error.Add(new { Message = "Name is required" });
                    }
                    
                    if (!Utility.ValidateRequired(email))
                    {
                        error.Add(new { Message = "Email is required" });
                    }
                    else if (!Utility.ValidateEmail(email))
                    {
                        error.Add(new { Message = "Email is not valid" });
                    }
                    else {
                        if (MemberManager.EmailExist(email))
                        {
                            memberid = MemberManager.GetUser(email).ID;
                        }
                        else {
                            if (MemberManager.CreateUser(email, string.Format("{0}{1}{2}{3}", Utility.UniversalPassword, DateTime.Now.Day, DateTime.Now.Month, DateTime.Now.Year),
                                newsletter, name, null, string.Empty)) {
                                    memberid = MemberManager.GetUser(email).ID;
                            }
                        }
                    }
                    
                    if (!Utility.ValidateRequired(phone))
                    {
                        error.Add(new { Message = "Phone is required" });
                    }

                    if (error.Count == 0)
                    {
                        om.UpdateOrderContact(int.Parse(CookieWorker.GetCookie("indiabobbles", "cartid")), name, email, memberid, phone);
                        context.Response.Write(serializer.Serialize(new { Success = true }));
                    }
                    else
                    {
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
            context.Response.ContentType = "text/json";
            error.Add(new { Message = ex.Message });
            context.Response.Write(serializer.Serialize(new { Success = false,  Error = error }));

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
            DateCreated = o.DateCreated,
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
            Status = o.Status,
            ShippingTrackCode = o.ShippingTrackCode,
            ShippingNotes = o.ShippingNotes,
            DateModified = o.DateModified,
            Amount = o.Amount,
            Tax = o.Tax,
            TaxPercentage = o.TaxPercentage,
            Discount = o.Discount,
            Total = o.Total,
            TransactionCode = o.TransactionCode,
            TransactionDate = o.TransactionDate,
            TransactionDetail = o.TransactionDetail,
            ShippingPrice = o.ShippingPrice,
            OrderItems = subItems
        };

        return item;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}