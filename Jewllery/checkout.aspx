<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="Jewllery.checkout" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Checkout - Aura Jewellery</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        body {
            background-image: url('images/checkout1.jpg'); /* Change to your image */
            background-size: cover;
            background-position: center;
            font-family: 'Poppins', sans-serif;
        }
        .container {
            max-width: 850px;
            margin-top: 50px;
        }
        .checkout-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
        }
        .checkout-card::before {
            content: "";
            background: url('images/jewellery-back.jpg'); /* Back Image */
            background-size: cover;
            background-position: center;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            opacity: 0.2;
            z-index: -1;
        }
        h2 {
            text-align: center;
            color: #6c757d;
            font-weight: bold;
            margin-bottom: 15px;
        }
        h4 {
            font-size: 18px; /* Reduced size */
            font-weight: bold;
            color: #6c757d;
            margin-bottom: 12px;
        }
        h5 {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-control {
            border-radius: 5px;
        }
        .btn-custom {
            background-color: #d4af37;
            color: white;
            font-weight: bold;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
        }
        .btn-custom:hover {
            background-color: #c29830;
        }
        .table {
            margin-top: 20px;
        }
        .total-amount, .shipping-options, .delivery-mode {
            font-size: 16px; /* Smaller font */
            font-weight: bold;
            margin-bottom: 15px; /* Added space */
        }
        .hide {
            display: none;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="checkout-card">
        <h2>Checkout</h2>

        <form id="form1" runat="server">
            
            <!-- Order Summary Heading -->
            <h4 class="text-start fw-bold text-secondary">Order Summary</h4>

            <!-- Cart Summary -->
            <asp:GridView ID="gvCheckout" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Product Name" />
                    <asp:BoundField DataField="ProductType" HeaderText="Category" />
                    <asp:BoundField DataField="Price" HeaderText="Price (₹)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                    <asp:BoundField DataField="TotalPrice" HeaderText="Total (₹)" DataFormatString="{0:N2}" />
                </Columns>
            </asp:GridView>

            <!-- Total Price -->
            <div class="total-amount">
                Total Amount: <asp:Label ID="lblTotalAmount" runat="server" ForeColor="DarkRed"></asp:Label>
            </div>

            <hr>

            <!-- Shipping Details -->
            <h4>Shipping Details</h4>
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Enter your shipping address"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
            </div>

            <!-- Shipping Options -->
            <h4>Shipping Options</h4>
            <div class="shipping-options">
                <asp:RadioButtonList ID="rblShippingOptions" runat="server" CssClass="form-check" AutoPostBack="true" OnSelectedIndexChanged="rblShippingOptions_SelectedIndexChanged">
                    <asp:ListItem Value="Free" Selected="True">Free Shipping (3-5 Days) (₹0)</asp:ListItem>
                    <asp:ListItem Value="Express">Express Delivery (1-2 Days) (₹150)</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <!-- Shipping Bill -->
            <div id="shippingBill" runat="server" class="hide">
                <h5>Shipping Charges: ₹150</h5>
            </div>

            <hr>

            <!-- Total Payable Amount -->
            <h4>Total Payable Amount: <asp:Label ID="lblFinalAmount" runat="server" ForeColor="DarkRed"></asp:Label></h4>

            <hr>

            <!-- Mode of Delivery -->
            <h4>Mode of Delivery</h4>
            <div class="delivery-mode">
                <asp:RadioButtonList ID="rblDeliveryMode" runat="server" CssClass="form-check">
                    <asp:ListItem Value="COD">Cash on Delivery (₹0)</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <!-- Place Order Button -->
            <asp:Button ID="btnPlaceOrder" runat="server" CssClass="btn btn-custom" Text="Place Order" OnClick="btnPlaceOrder_Click" />

        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var shippingOptions = document.querySelectorAll("[id*=rblShippingOptions] input");
        var shippingBill = document.getElementById("shippingBill");

        shippingOptions.forEach(option => {
            option.addEventListener("change", function () {
                if (option.value === "Express") {
                    shippingBill.classList.remove("hide");
                } else {
                    shippingBill.classList.add("hide");
                }
            });
        });
    });
</script>

</body>
</html>
