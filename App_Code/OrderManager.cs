using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using Rockying.Models;
using System.Data.Linq;
using System.Text;

namespace Rockying
{
    public enum OrderStatusType
    {
        New = 1,
        Process = 2,
        CardPaid = 3,
        CODPaid = 4,
        Shipped = 5,
        Complete = 6,
        Refund = 7,
        Deleted = 8
    }

    public class OrderManager
    {

        public decimal ShippingPriceConstant = 0;
        public decimal FreeShippingAmount = 500;
        public decimal CODFee = 0;
        public OrderManager()
        {
        }

        /// <summary>
        /// Get current cart which is stored as a cookie
        /// </summary>
        /// <returns></returns>
        public Order GetCart()
        {
            Order o = null;
            int cartid;
            if (!int.TryParse(CookieWorker.GetCookie("rockying", "cartid"), out cartid))
            {

                o = Create(string.Empty, string.Empty, null, string.Empty, string.Empty, string.Empty,
                    string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty,
                    string.Empty, string.Empty, string.Empty, OrderStatusType.New, string.Empty, string.Empty,
                    DateTime.Now, 0, 0, 0, 0, 0, 0, CODFee, "", "");
                CookieWorker.SetCookie("rockying", "cartid", o.ID.ToString(), DateTime.Now.AddHours(8));
            }
            else
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
                {
                    DataLoadOptions options = new DataLoadOptions();
                    options.LoadWith<Order>(ii => ii.OrderItems);
                    dc.LoadOptions = options;
                    o = dc.Orders.SingleOrDefault(item => item.ID == cartid);
                }
            }
            return o;
        }

        public int GetCartItemCount()
        {
            return GetCart().OrderItems.Count;
        }

        /// <summary>
        /// Create a new cart
        /// </summary>
        /// <returns></returns>
        public Order Create(string name, string email, long? memberid, string phone, string billingAddress,
            string billingCity, string billingState, string billingCountry, string billingZip,
            string shippingAddress, string shippingCity, string shippingState, string shippingCountry,
            string shippinZip, string coupon, OrderStatusType status, string trackCode, string shippingNotes,
            DateTime modified, decimal amount, decimal tax, decimal taxPercentage, decimal discount, decimal total, decimal shippingPrice,
            decimal cod, string paymentMode, string shippingService)
        {
            Order o = new Order()
            {
                Amount = amount,
                BillingAddress = billingAddress,
                BillingCity = billingCity,
                BillingCountry = billingCountry,
                BillingState = billingState,
                BillingZip = billingZip,
                Coupon = coupon,
                DateCreated = DateTime.Now,
                DateModified = modified,
                Discount = discount,
                Email = email,
                MemberID = memberid,
                Name = name,
                Phone = phone,
                ShippingAddress = shippingAddress,
                ShippingCity = shippingCity,
                ShippingCountry = shippingCountry,
                ShippingNotes = shippingNotes,
                ShippingState = shippingState,
                ShippingTrackCode = trackCode,
                ShippingZip = shippinZip,
                Status = (byte)status,
                Tax = tax,
                TaxPercentage = taxPercentage,
                Total = total,
                TransactionCode = string.Empty,
                TransactionDetail = string.Empty,
                ShippingPrice = shippingPrice,
                COD = cod,
                PaymentMode = paymentMode,
                ShippingService = shippingService
            };
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                dc.Orders.InsertOnSubmit(o);
                dc.SubmitChanges();
            }

            return o;
        }

        public void AddItem(int quantity, int orderId, string productImg, string productName, string productCode, decimal price)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                OrderItem oi = dc.OrderItems.SingleOrDefault(item => item.OrderID == orderId && item.ProductCode == productCode);
                if (oi == null)
                {
                    oi = new OrderItem();
                    oi.OrderID = orderId;
                    oi.Price = price;
                    oi.ProductCode = productCode;
                    oi.ProductImg = productImg;
                    oi.ProductName = productName;
                    oi.Quantity = quantity;
                    oi.Amount = price * quantity;
                    dc.OrderItems.InsertOnSubmit(oi);
                }
                else
                {
                    oi.Price = price;
                    oi.Quantity = oi.Quantity + quantity;
                    oi.Amount = oi.Quantity * oi.Price;

                    if (oi.Quantity <= 0)
                    {
                        dc.OrderItems.DeleteOnSubmit(oi);
                    }
                }
                dc.SubmitChanges();
                //Get all items of the order
                var list = from item in dc.OrderItems
                           where item.OrderID == orderId
                           select item;
                decimal amount = 0;
                //caculate amount
                foreach (var item in list)
                {
                    amount += item.Amount;
                }
                //Update amount of order
                Order o = dc.Orders.SingleOrDefault(item => item.ID == orderId);
                o.Amount = amount;
                if (o.Amount < FreeShippingAmount)
                {
                    o.ShippingPrice = ShippingPriceConstant;
                }
                else
                {
                    o.ShippingPrice = 0;
                }
                o.Total = o.Amount + o.ShippingPrice - o.Discount;
                dc.SubmitChanges();
            }
        }

        public void RemoveItem(int itemId, int orderId)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                OrderItem oi = dc.OrderItems.SingleOrDefault(item => item.ID == itemId && item.OrderID == orderId);
                dc.OrderItems.DeleteOnSubmit(oi);
                dc.SubmitChanges();
                //Get all items of the order
                var list = from item in dc.OrderItems
                           where item.OrderID == orderId
                           select item;
                decimal amount = 0;
                //caculate amount
                foreach (var item in list)
                {
                    amount += item.Amount;
                }

                //Update amount of order
                Order o = dc.Orders.SingleOrDefault(item => item.ID == orderId);
                o.Amount = amount;
                if (o.Amount == 0)
                {
                    o.Coupon = "";
                    o.Discount = 0;
                    o.ShippingPrice = 0;
                    o.COD = 0;
                    o.PaymentMode = "";
                }
                o.Total = o.Amount + o.ShippingPrice - o.Discount;
                dc.SubmitChanges();
            }
        }

        public void AddItemQuantity(int itemId, int orderId)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                OrderItem oi = dc.OrderItems.SingleOrDefault(item => item.ID == itemId && item.OrderID == orderId);
                oi.Quantity = oi.Quantity + 1;
                oi.Amount = oi.Quantity * oi.Price;
                dc.SubmitChanges();
                Order o = dc.Orders.Single(item => item.ID == orderId);
                decimal amount = 0;
                foreach (OrderItem i in o.OrderItems)
                {
                    amount += i.Amount;
                }
                o.Amount = amount;
                if (o.Amount == 0)
                {
                    o.Coupon = "";
                    o.Discount = 0;
                    o.ShippingPrice = 0;
                    o.COD = 0;
                    o.PaymentMode = "";
                }
                dc.SubmitChanges();
            }
        }

        public void ReduceItemQuantity(int itemId, int orderId)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                OrderItem oi = dc.OrderItems.SingleOrDefault(item => item.ID == itemId && item.OrderID == orderId);
                oi.Quantity = oi.Quantity - 1;
                oi.Amount = oi.Quantity * oi.Price;
                dc.SubmitChanges();

                if (oi.Quantity == 0)
                {
                    //RemoveItem(itemId, orderId);
                    dc.OrderItems.DeleteOnSubmit(oi);
                    dc.SubmitChanges();
                }

                Order o = dc.Orders.Single(item => item.ID == orderId);
                decimal amount = 0;
                foreach (OrderItem i in o.OrderItems)
                {
                    amount += i.Amount;
                }
                o.Amount = amount;
                if (o.Amount == 0)
                {
                    o.Coupon = "";
                    o.Discount = 0;
                    o.ShippingPrice = 0;
                    o.COD = 0;
                    o.PaymentMode = "";
                }
                dc.SubmitChanges();
            }
        }

        public void UpdateItem(int itemId, int quantity, int orderId, string productImg, string productName, string productCode, decimal price)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                OrderItem oi = dc.OrderItems.SingleOrDefault(item => item.ID == itemId && item.OrderID == orderId);
                oi.Price = price;
                oi.ProductCode = productCode;
                oi.ProductImg = productImg;
                oi.ProductName = productName;
                oi.Quantity = quantity;
                oi.Amount = price * quantity;
                dc.SubmitChanges();
            }
        }


        public void DeleteOrder(int orderId)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                dc.OrderItems.DeleteAllOnSubmit(o.OrderItems);
                dc.Orders.DeleteOnSubmit(o);
                dc.SubmitChanges();
            }
        }
        public void UpdateOrder(int orderId, string name, string email, long? memberid, string phone, string billingAddress,
            string billingCity, string billingState, string billingCountry, string billingZip,
            string shippingAddress, string shippingCity, string shippingState, string shippingCountry,
            string shippinZip, string coupon, OrderStatusType status, string trackCode, string shippingNotes,
            DateTime modified, decimal amount, decimal tax, decimal taxPercentage, decimal discount, decimal total, decimal shippingPrice, decimal cod)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.BillingAddress = billingAddress;
                o.BillingCity = billingCity;
                o.BillingCountry = billingCountry;
                o.BillingState = billingState;
                o.BillingZip = billingZip;
                o.Coupon = coupon;
                o.DateModified = DateTime.Now;
                o.Discount = discount;
                o.Email = email;
                o.MemberID = memberid;
                o.Name = name;
                o.Phone = phone;
                o.ShippingAddress = shippingAddress;
                o.ShippingCity = shippingCity;
                o.ShippingCountry = shippingCountry;
                o.ShippingNotes = shippingNotes;
                o.ShippingState = shippingState;
                o.ShippingTrackCode = trackCode;
                o.ShippingZip = shippinZip;
                o.Status = (byte)status;
                o.Tax = tax;
                o.TaxPercentage = taxPercentage;
                o.Total = total;
                o.Amount = amount;
                o.ShippingPrice = shippingPrice;
                o.COD = cod;
                dc.SubmitChanges();
            }
        }

        public void UpdateOrderBillingAddress(int orderId, string billingAddress,
            string billingCity, string billingState, string billingCountry, string billingZip)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.BillingAddress = billingAddress;
                o.BillingCity = billingCity;
                o.BillingCountry = billingCountry;
                o.BillingState = billingState;
                o.BillingZip = billingZip;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateOrderShippingAddress(int orderId, string shippingAddress,
            string shippingCity, string shippingState, string shippingCountry, string shippingZip)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.ShippingAddress = shippingAddress;
                o.ShippingCity = shippingCity;
                o.ShippingCountry = shippingCountry;
                o.ShippingState = shippingState;
                o.ShippingZip = shippingZip;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateOrderContact(int orderId, string name, string email, long? memberid, string phone)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.Name = name;
                o.Email = email;
                o.MemberID = memberid;
                o.Phone = phone;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateCOD(int orderId)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                if (o.PaymentMode == "COD")
                {
                    if ((o.Amount + o.ShippingPrice + o.Tax - o.Discount) > 2000)
                    {
                        o.COD = 0; // ((o.Amount + o.ShippingPrice + o.Tax - o.Discount) / 100) * 2;
                    }
                    else
                    {
                        o.COD = 0; // 40; 
                    }
                }
                else { o.COD = 0; }

                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateShippingPrice(int orderId)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                int quantity = 0;
                foreach (OrderItem item in o.OrderItems)
                {
                    quantity += item.Quantity;
                }

                if (o.ShippingState.ToLower() == "jammu and kashmir" ||
                    o.ShippingState.ToLower() == "andaman and nicobar islands" ||
                    o.ShippingState.ToLower() == "lakshadweep")
                {
                    o.ShippingPrice = quantity * 200;
                }
                else if (o.ShippingState.ToLower() == "national capital territory of delhi")
                {
                    o.ShippingPrice = quantity * 0;
                }
                else
                {
                    o.ShippingPrice = 0;
                }
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateTotal(int orderId)
        {
            UpdateShippingPrice(orderId);
            UpdateCOD(orderId);
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.Total = o.Amount + o.ShippingPrice + o.COD + o.Tax - o.Discount;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateOrderShippingService(int orderId, string shippingservice)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.ShippingService = shippingservice;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateOrderShippingCode(int orderId, string trackingCode)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.ShippingTrackCode = trackingCode;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }
        public void UpdateCouponCode(int orderId, string coupon)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);

                if (coupon.ToLower() == "theek theek laga lo")
                {
                    //o.Coupon = coupon;
                    //o.Discount = 50;
                    //o.DateModified = DateTime.Now;
                }
                else if (coupon.ToLower() == "happy15")
                {
                    o.Coupon = coupon;
                    o.Discount = (o.Amount / 100) * 15;
                    o.DateModified = DateTime.Now;
                }
                else if (coupon.ToLower() == "100c")
                {
                    //o.Coupon = coupon;
                    //o.Discount = 100;
                    //o.DateModified = DateTime.Now;
                }
                else if (coupon.ToLower() == "50c")
                {
                    //o.Coupon = coupon;
                    //o.Discount = 50;
                    //o.DateModified = DateTime.Now;
                }
                else if (coupon.ToLower() == "20c")
                {
                    o.Coupon = coupon;
                    o.Discount = 20;
                    o.DateModified = DateTime.Now;
                }
                else if (coupon.ToLower() == "")
                {
                    o.Coupon = string.Empty;
                    o.Discount = 0;
                    o.DateModified = DateTime.Now;
                }

                if (o.OrderItems.Count > 1)
                {
                    o.Discount = o.Discount + 40;
                    o.DateModified = DateTime.Now;
                }

                dc.SubmitChanges();
            }
        }

        public void UpdateOrderShippingNotes(int orderId, string shippingNotes)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.ShippingNotes = shippingNotes;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateOrderStatus(int orderId, OrderStatusType status, string notes)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.Status = (byte)status;
                o.ShippingNotes = notes;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateShippingTrackingCode(int orderId, string trackingcode)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.ShippingTrackCode = trackingcode;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateOrderPayment(int orderId, string transactionCode, DateTime transactionDate, string transactionDetail)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.TransactionCode = transactionCode;
                o.TransactionDate = transactionDate;
                o.TransactionDetail = transactionDetail;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public void UpdateOrderTransactionDetail(int orderId, string transactionDetail)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.TransactionDetail = transactionDetail;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }

        public List<Order> GetUserOrderList(long memberId)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                DataLoadOptions options = new DataLoadOptions();
                options.LoadWith<Order>(ii => ii.OrderItems);
                dc.LoadOptions = options;
                var list = from item in dc.Orders where item.MemberID.Value == memberId select item;
                if (list.Count() > 0)
                {
                    return list.ToList<Order>();
                }
                else { return new List<Order>(); }
            }
        }

        public Order GetOrderDetail(int orderId)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                DataLoadOptions options = new DataLoadOptions();
                options.LoadWith<Order>(ii => ii.OrderItems);
                dc.LoadOptions = options;
                return dc.Orders.SingleOrDefault(item => item.ID == orderId);
            }
        }

        public List<Order> GetOrderList(string keyword)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                DataLoadOptions options = new DataLoadOptions();
                options.LoadWith<Order>(ii => ii.OrderItems);
                dc.LoadOptions = options;
                int orderid;
                if (int.TryParse(keyword, out orderid))
                {
                    var query = from d in dc.Orders
                                where d.ID == orderid
                                orderby d.ID descending
                                select d;
                    return query.ToList();
                }
                else
                {
                    var query = from d in dc.Orders
                                where d.Phone == keyword || d.Email == keyword
                                orderby d.ID descending
                                select d;
                    return query.ToList();
                }
            }
        }

        public string GenerateReceipt(int orderId)
        {
            StringBuilder builder = new StringBuilder();
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                DataLoadOptions options = new DataLoadOptions();
                options.LoadWith<Order>(ii => ii.OrderItems);
                dc.LoadOptions = options;
                Order o = dc.Orders.SingleOrDefault(item => item.ID == orderId);
                builder.Append(string.Format("<h1>Order Number: {0}</h1>", o.ID));
                builder.Append("<table style='width:100%;'>");
                builder.Append("<thead><th style='text-align:left;'>Name</th><th style='text-align:left;'>Code</th><th style='text-align:left;'>Price</th><th style='text-align:left;'>Quantity</th><th style='text-align:left;'>Amount</th></tr></thead>");
                builder.Append("<tbody>");
                foreach (OrderItem oi in o.OrderItems)
                {
                    builder.Append("<tr>");
                    builder.Append(string.Format("<td style='text-align:left;'>{0}</td>", oi.ProductName));
                    builder.Append(string.Format("<td style='text-align:left;'>{0}</td>", oi.ProductCode));
                    builder.Append(string.Format("<td style='text-align:left;'>{0}</td>", oi.Price));
                    builder.Append(string.Format("<td style='text-align:left;'>{0}</td>", oi.Quantity));
                    builder.Append(string.Format("<td style='text-align:left;'>{0}</td>", oi.Amount));
                    builder.Append("</tr>");
                }
                builder.Append(string.Format("<tr><td colspan='4' align='right'>Amount</td><td>{0}</td></tr>", o.Amount.ToString("##00.00")));
                builder.Append(string.Format("<tr><td colspan='4' align='right'>Shipping</td><td>{0}</td></tr>", o.ShippingPrice.ToString("##00.00")));
                if (o.Discount > 0)
                {
                    builder.Append(string.Format("<tr><td colspan='4' align='right'>Discount</td><td>- {0}</td></tr>", o.Discount.ToString("##00.00")));
                }
                if (o.Coupon != string.Empty)
                {
                    builder.Append(string.Format("<tr><td colspan='4' align='right'>Coupon</td><td>{0}</td></tr>", o.Coupon));
                }
                if (o.PaymentMode == "COD")
                {
                    builder.Append(string.Format("<tr><td colspan='4' align='right'>COD</td><td>{0}</td></tr>", o.COD.ToString("##00.00")));
                }
                else { }
                builder.Append(string.Format("<tr><td colspan='4' align='right'>Total</td><td>{0}</td></tr>", o.Total.ToString("##00.00")));
                builder.Append("</tbody>");
                builder.Append("</table>");

                builder.Append("<table style='width:100%; border:0px;'>");
                builder.Append("<tr>");
                builder.Append("<td><h3>Contact Information</h3>");
                builder.Append(string.Format("<div>{0}</div>", o.Name));
                builder.Append(string.Format("<div>{0}</div>", o.Email));
                builder.Append(string.Format("<div>{0}</div>", o.Phone));
                builder.Append("</td>");
                builder.Append("<td><h3>Billing Address</h3>");
                builder.Append(string.Format("<div>{0}</div>", o.BillingAddress));
                builder.Append(string.Format("<div>{0}</div>", o.BillingCity));
                builder.Append(string.Format("<div>{0}</div>", o.BillingState));
                builder.Append(string.Format("<div>{0}</div>", o.BillingZip));
                builder.Append(string.Format("<div>{0}</div>", o.BillingCountry));
                builder.Append("</td>");
                builder.Append("<td><h3>Shipping Address</h3>");
                builder.Append(string.Format("<div>{0}</div>", o.ShippingAddress));
                builder.Append(string.Format("<div>{0}</div>", o.ShippingCity));
                builder.Append(string.Format("<div>{0}</div>", o.ShippingState));
                builder.Append(string.Format("<div>{0}</div>", o.ShippingZip));
                builder.Append(string.Format("<div>{0}</div>", o.ShippingCountry));
                builder.Append("</td>");
                builder.Append("</tr>");
                builder.Append("</table>");
                builder.Append("<div>");
                builder.Append(string.Format("<div>Order Status : {0}</div>", Enum.Parse(typeof(OrderStatusType), o.Status.ToString()).ToString()));
                if (o.ShippingTrackCode != "")
                {
                    builder.Append(string.Format("<div>Shipping Tracking Code : {0}</div>", o.ShippingTrackCode));
                }
                if (o.TransactionCode != "")
                {
                    builder.Append(string.Format("<div>Transaction Code : {0}</div>", o.TransactionCode));
                }
                if (o.TransactionDate.HasValue)
                {
                    builder.Append(string.Format("<div>Transaction Date : {0}</div>", o.TransactionDate.Value.ToString()));
                }
                builder.Append("<p>Thanks for your Purchase. If you have any questions please contact us at preeti@rockying.com or call us at 9871500276. Please provide your order number.</p>");
                builder.Append("</div>");
            }

            return builder.ToString();
        }

        public void UpdatePaymentMode(int orderId, string paymentmode)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Order o = dc.Orders.Single(item => item.ID == orderId);
                o.PaymentMode = paymentmode;
                o.DateModified = DateTime.Now;
                dc.SubmitChanges();
            }
        }
    }
}