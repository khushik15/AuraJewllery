<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ring1.aspx.cs" Inherits="Jewllery.images.ring1" %>




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
        <div class="container mt-4">
            <h2 class="text-center mb-4">Rings Collection</h2>
            <div class="row">
                <asp:Repeater ID="rptRings" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div class="card ring-card position-relative">
                                <!-- Display Product Image -->
                                <asp:Image ID="imgRing" runat="server" CssClass="card-img-top ring-image"
                                    ImageUrl='<%# "images/" + Eval("ImageURL") %>' AlternateText="Ring Image" />

                                <div class="card-body text-center">
                                    <!-- Hidden Field for Product ID -->
                                    <asp:HiddenField ID="hfRingId" runat="server" Value='<%# Eval("RingId") %>' />

                                    <!-- Product Name -->
                                    <h5 class="card-title">
                                        <span id="lblName" runat="server"><%# Eval("Name") %></span>
                                    </h5>

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
