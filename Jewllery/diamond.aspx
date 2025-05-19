<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="diamond.aspx.cs" Inherits="Jewllery.diamond" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diamond Collection</title>
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
    margin-bottom: 90px;
}
        .diamond-card {
            border: none;
            transition: transform 0.3s ease-in-out;
        }
        .diamond-card:hover {
            transform: scale(1.02);
        }
        .diamond-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <img src="images/dimond banner.jpg" alt="Diamond Banner" class="header-image">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Diamond Collection</h2>
            <div class="row">
                <asp:Repeater ID="rptDiamond" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div class="card diamond-card position-relative">
                                <!-- Display Product Image -->
                                <asp:Image ID="imgDiamond" runat="server" CssClass="card-img-top diamond-image"
                                    ImageUrl='<%# "images/" + Eval("ImageURL") %>' AlternateText="Diamond Image" />

                                <div class="card-body text-center">
                                    <!-- Hidden Field for Product ID -->
                                    <asp:HiddenField ID="hfDiamondId" runat="server" Value='<%# Eval("DiamondId") %>' />

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
                                        Text="Add to Bag" CommandArgument='<%# Eval("DiamondId") %>'
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
