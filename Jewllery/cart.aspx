<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="Jewllery.cart" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .cart-table {
            width: 100%;
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .cart-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Shopping Cart</h2>
            <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="table cart-table"
                OnRowCommand="gvCart_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <asp:Image ID="imgRing" runat="server" CssClass="cart-image" ImageUrl='<%# "images/" + Eval("ImageUrl") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Name" HeaderText="Ring Name" />
                    <asp:BoundField DataField="Color" HeaderText="Color" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₹{0:N2}" />
                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' CssClass="form-control text-center" Width="50px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total">
                        <ItemTemplate>
                            ₹<%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnRemove" runat="server" CssClass="btn btn-danger" Text="Remove" CommandName="Remove" CommandArgument='<%# Eval("CartId") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div class="text-end">
                <asp:Label ID="lblTotalPrice" runat="server" CssClass="fw-bold fs-5 text-danger"></asp:Label>
            </div>
            <div class="text-end mt-3">
                <asp:Button ID="btnCheckout" runat="server" CssClass="btn btn-success" Text="Proceed to Checkout" OnClick="btnCheckout_Click" />
            </div>
            <div class="text-start mt-3">
                
                <asp:Button ID="btnBack" runat="server" CssClass="btn btn-secondary" Text="Back" OnClientClick="javascript:history.back(); return false;" />
            </div>
           
        </div>
    </form>
</body>
</html>
