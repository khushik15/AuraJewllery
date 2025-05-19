<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myOrders.aspx.cs" Inherits="Jewllery.myOrders" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }
        .order-container {
            max-width: 800px;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
        }
        .status {
            font-size: 18px;
            font-weight: bold;
            color: #28a745;
        }
        /* Tracking Progress Bar */
        .tracking-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            margin: 20px 0;
        }
        .tracking-step {
            text-align: center;
            width: 20%;
            font-size: 14px;
            position: relative;
        }
        .tracking-step span {
            display: block;
            font-size: 20px;
            color: #fff;
            background: #d4af37;
            padding: 8px;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            margin: 0 auto;
            text-align: center;
            line-height: 15px;
            font-weight: bold;
            z-index: 2;
            position: relative;
        }
        /* Dotted Line */
        .tracking-container::before {
            content: "";
            position: absolute;
            top: 15px;
            left: 10%;
            width: 80%;
            height: 5px;
            background: repeating-linear-gradient(
                to right,
                #d4af37,
                #d4af37 20px,
                transparent 10px,
                transparent 30px
            );
            z-index: 1;
        }
        .order-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-top: 15px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <div class="container">
            <h2 class="text-center text-success">📦 My Orders</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
        
                <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">

                <ItemTemplate>
                    <div class="order-container">
                        <h4>Order ID: <%# Eval("OrderID") %></h4>
                        <p><strong>Date:</strong> <%# Eval("OrderDate", "{0:dd MMM yyyy}") %></p>
                        <p><strong>Total:</strong> ₹<%# Eval("TotalAmount") %></p>
                        <p class="status"><%# Eval("ShippingStatus") %></p>
                        <p><strong>Estimated Delivery:</strong> <%# Eval("EstimatedDeliveryDate") %></p>
                        


                        <!-- Tracking Progress Bar -->
                        <div class="tracking-container">
                            <div class="tracking-step">
                                <span>✔️</span>
                                Ordered
                            </div>
                            <div class="tracking-step">
                                <span><%# Eval("ShippingStatus").ToString() == "Packed" || Eval("ShippingStatus").ToString() == "In-Transit" || Eval("ShippingStatus").ToString() == "Out for Delivery" || Eval("ShippingStatus").ToString() == "Delivered" ? "✔️" : "🔄" %></span>
                                Packed
                            </div>
                            <div class="tracking-step">
                                <span><%# Eval("ShippingStatus").ToString() == "In-Transit" || Eval("ShippingStatus").ToString() == "Out for Delivery" || Eval("ShippingStatus").ToString() == "Delivered" ? "✔️" : "🔄" %></span>
                                In-Transit
                            </div>
                            <div class="tracking-step">
                                <span><%# Eval("ShippingStatus").ToString() == "Out for Delivery" || Eval("ShippingStatus").ToString() == "Delivered" ? "✔️" : "🔄" %></span>
                                Out for Delivery
                            </div>
                            <div class="tracking-step">
                                <span><%# Eval("ShippingStatus").ToString() == "Delivered" ? "✔️" : "🔄" %></span>
                                Delivered
                            </div>
                        </div>
                       
                        

                        <!-- Order Card -->
                        <div class="order-card">
                            <p><strong>Delivery Date:</strong> <%# Eval("EstimatedDeliveryDate", "{0:dd MMM yyyy}") %></p>
                            <p><strong>Payment Status:</strong> <%# Eval("PaymentStatus") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="text-center mt-3">
                <asp:Button ID="btnBackToShop" runat="server" CssClass="btn btn-warning" Text="🏠 Back to Shop" OnClick="btnBackToShop_Click" />
            </div>
        </div>
    </form>

</body>
</html>
