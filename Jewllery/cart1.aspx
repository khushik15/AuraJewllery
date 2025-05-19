
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cart1.aspx.cs" Inherits="Jewllery.cart1" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Shopping Cart</title>
    <style>
        .cart-container { width: 80%; margin: auto; padding: 20px; font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f4f4f4; }
        .btn { padding: 10px 15px; cursor: pointer; border: none; font-size: 14px; }
        .btn-remove { background-color: red; color: white; }
        .btn-update { background-color: green; color: white; }
        .btn-checkout { background-color: blue; color: white; font-size: 16px; }
        .btn-back { background-color: gray; color: white; font-size: 16px; margin-top: 10px; }
        .total-container { margin-top: 20px; text-align: right; font-size: 18px; font-weight: bold; }
    </style>
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cart-container">
            <h2>Shopping Cart</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
            <asp:GridView ID="GridViewCart" runat="server" AutoGenerateColumns="False"
                OnRowCommand="GridViewCart_RowCommand" ShowFooter="true">
                <Columns>
                    <asp:BoundField DataField="ProductType" HeaderText="Category" />
                    <asp:BoundField DataField="Name" HeaderText="Product Name" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />

                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <asp:HiddenField ID="hfCartId" runat="server" Value='<%# Eval("CartId") %>' />
                            <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' Width="40px"></asp:TextBox>
                            <asp:Button ID="btnUpdate" runat="server" CommandName="UpdateQuantity"
                                CommandArgument='<%# Eval("CartId") %>' CssClass="btn btn-update" Text="Update" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" DataFormatString="{0:C}" />

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnRemove" runat="server" CommandName="RemoveItem"
                                CommandArgument='<%# Eval("CartId") %>' CssClass="btn btn-remove" Text="Remove" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="total-container">
                Total: <asp:Label ID="lblTotalAmount" runat="server" Text="0"></asp:Label>
            </div>

            <asp:Button ID="btnCheckout" runat="server" CssClass="btn btn-checkout" Text="Checkout" OnClick="btnCheckout_Click" />

            <!-- Back Button -->
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-secondary" OnClientClick="history.back(); return false;" />



        </div>
    </form>
</body>
</html>
