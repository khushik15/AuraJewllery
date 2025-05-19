<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="JewelleryWebsite.Orders" %>

<!DOCTYPE html>
<html>
<head>
    <title>Place Order</title>
</head>
<body>
    <form id="form1" runat="server">
        <label>Total Amount:</label>
        <asp:TextBox ID="txtTotalAmount" runat="server"></asp:TextBox>
        <br />

        <label>Payment Status:</label>
        <asp:DropDownList ID="ddlPaymentStatus" runat="server">
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
        </asp:DropDownList>
        <br />

        <label>Shipping Status:</label>
        <asp:DropDownList ID="ddlShippingStatus" runat="server">
            <asp:ListItem Text="Processing" Value="Processing"></asp:ListItem>
            <asp:ListItem Text="Shipped" Value="Shipped"></asp:ListItem>
            <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
        </asp:DropDownList>
        <br />

        <label>Address:</label>
        <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
        <br />

        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" OnClick="btnPlaceOrder_Click" />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
    </form>
</body>
</html>
