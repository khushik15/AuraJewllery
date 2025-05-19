<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rings.aspx.cs" Inherits="Jewllery.rings" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rings Collection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .header-image {
            width: 100%;
            height: 400px; /* Adjust height as needed */
            object-fit: cover;
            border-bottom: 4px solid #b21f2d;
        }

        .ring-card {
            border: none;
            transition: transform 0.3s ease-in-out;
        }
        .ring-card:hover {
            transform: scale(1.02);
        }
        .ring-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <img src="images/rings coll.jpg" alt="Earrings Banner" class="header-image">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Rings Collection</h2>
            <div class="row">
                <asp:Repeater ID="rptRings" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div class="card ring-card position-relative">
                                <!-- Display Product Image -->
                                <asp:Image ID="imgRing" runat="server" CssClass="card-img-top ring-image"
                                    ImageUrl='<%# "images/" + Eval("ImageUrl") %>' AlternateText="Ring Image" />

                                <div class="card-body text-center">
                                    <!-- Hidden Field for Product ID -->
                                    <asp:HiddenField ID="hfProductId" runat="server" Value='<%# Eval("RingId") %>' />

                                    <!-- Product Name -->
                                    <h5 class="card-title">
                                        <span id="lblName" runat="server"><%# Eval("Name") %></span>
                                    </h5>

                                    <!-- Product Color -->
                                    <p class="card-text">Color: <%# Eval("Color") %></p>

                                    <!-- Product Price -->
                                    <p class="card-text fw-bold text-danger">
                                        ₹<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                                    </p>

                                    <!-- Add to Cart Button -->
                                    <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-primary"
                                        Text="Add to Bag" CommandArgument='<%# Eval("RingId") %>'
                                        OnClick="btnAddToCart_Click" UseSubmitBehavior="false" />
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
