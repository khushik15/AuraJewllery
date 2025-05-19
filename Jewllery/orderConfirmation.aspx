<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="orderConfirmation.aspx.cs" Inherits="Jewllery.orderConfirmation" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }
        .order-box {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            margin: 50px auto;
            text-align: center;
        }
        .btn-custom {
            background-color: #d4af37;
            color: white;
            font-weight: bold;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            margin-top: 10px;
        }
        .btn-custom:hover {
            background-color: #c29830;
        }
        h2 {
            color: green;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">  <!-- ✅ Keep only one form -->
        <div class="order-box">
            <h2>🎉 Order Placed Successfully! 🎉</h2>

            <p><strong>Order ID:</strong> <asp:Label ID="lblOrderID" runat="server" ForeColor="Red"></asp:Label></p>
            <p><strong>Total Amount:</strong> <asp:Label ID="lblTotalAmount" runat="server"></asp:Label></p>
            <p><strong>Shipping Address:</strong> <asp:Label ID="lblShippingAddress" runat="server"></asp:Label></p>
            <p><strong>Shipping Option:</strong> <asp:Label ID="lblShippingOption" runat="server"></asp:Label></p>
            <p><strong>Mode of Payment:</strong> <asp:Label ID="lblModeOfPayment" runat="server"></asp:Label></p>
            <p><strong>Estimated Delivery:</strong> <asp:Label ID="lblDeliveryDate" runat="server"></asp:Label></p>

            <hr>

            <!-- Continue Shopping Button -->
            <asp:Button ID="btnContinueShopping" runat="server" CssClass="btn btn-custom" Text="Continue Shopping" OnClick="btnContinueShopping_Click" />

            <!-- View Orders Button (New) -->
            <asp:Button ID="btnViewOrders" runat="server" CssClass="btn btn-custom" Text="View Orders" OnClick="btnViewOrders_Click" />
        </div>
    </form>

</body>
</html>
