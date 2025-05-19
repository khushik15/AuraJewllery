<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gold.aspx.cs" Inherits="Jewllery.gold" %>



<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gold Collection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .header-image {
             width: 100vw; /* Full width of the viewport */
             height: 400px; /* Adjust height as needed */
             object-fit: cover; /* Ensures the image covers the area */
             display: block;
       }
        .gold-card {
            border: none;
            transition: transform 0.3s ease-in-out;
        }
        .gold-card:hover {
            transform: scale(1.05);
        }
        .gold-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <img src="images/gold banner.jpg" alt="gold Banner" class="header-image">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Gold Collection</h2>
            <div class="row">
                <asp:Repeater ID="rptGold" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div class="card gold-card">
                                <!-- Display Product Image -->
                                <asp:Image ID="imgGold" runat="server" CssClass="card-img-top gold-image"
                                    ImageUrl='<%# "images/" + Eval("ImageURL") %>' AlternateText="Gold Image" />

                                <div class="card-body text-center">
                                    <!-- Hidden Field for Product ID -->
                                    <asp:HiddenField ID="hfGoldId" runat="server" Value='<%# Eval("GoldId") %>' />

                                    <!-- Product Name -->
                                    <h5 class="card-title">
                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                    </h5>

                                    <!-- Product Price -->
                                    <p class="card-text fw-bold text-danger">
                                        ₹<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                                    </p>

                                    <!-- Add to Cart Button -->
                                    <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-primary"
                                        Text="Add to Bag" CommandArgument='<%# Eval("GoldId") %>'
                                        OnClick="btnAddToCart_Click" />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>
