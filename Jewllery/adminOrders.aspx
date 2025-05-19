<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminOrders.aspx.cs" Inherits="Jewllery.adminOrders" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Orders</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .table {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
        }
        th {
            background-color: #d4af37;
            color: white;
        }
        .btn-update {
            background-color: #28a745;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-update:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 class="text-center text-primary">📦 Admin - Manage Orders</h2>

        <form id="form1" runat="server">
            <asp:GridView ID="gvOrders" runat="server" CssClass="table table-bordered text-center" AutoGenerateColumns="False" OnRowCommand="gvOrders_RowCommand">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount (₹)" />
                    <asp:BoundField DataField="PaymentStatus" HeaderText="Payment Status" />
                    <asp:BoundField DataField="ShippingStatus" HeaderText="Shipping Status" />
                    <asp:BoundField DataField="EstimatedDeliveryDate" HeaderText="Estimated Delivery" DataFormatString="{0:dd MMM yyyy}" />

                    
                    <asp:TemplateField HeaderText="Update Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server">
                                <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                <asp:ListItem Text="Packed" Value="Packed"></asp:ListItem>
                                <asp:ListItem Text="In-Transit" Value="In-Transit"></asp:ListItem>
                                <asp:ListItem Text="Out for Delivery" Value="Out for Delivery"></asp:ListItem>
                                <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnUpdateStatus" runat="server" CssClass="btn-update" Text="✔ Update" CommandName="UpdateStatus" CommandArgument='<%# Eval("OrderID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </form>
    </div>

</body>
</html>
