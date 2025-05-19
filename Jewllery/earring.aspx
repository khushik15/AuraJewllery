<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="earring.aspx.cs" Inherits="Jewllery.earring" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Earrings Collection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
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
       

        .earring-card {
            border: none;
            transition: transform 0.3s ease-in-out;
        }
        .earring-card:hover {
            transform: scale(1.02);
        }
        .earring-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
          <img src="images/earrings banner.jpg" alt="Earrings Banner" class="header-image">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Earrings Collection</h2>
            <div class="row">
                <asp:Repeater ID="rptEarrings" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div class="card earring-card position-relative">
                                <!-- Product Image -->
                                <asp:Image ID="imgEarring" runat="server" CssClass="card-img-top earring-image"
                                    ImageUrl='<%# "Images/" + Eval("ImageUrl") %>' AlternateText="Earring Image" />

                                <div class="card-body text-center">
                                    <!-- Product Name -->
                                    <h5 class="card-title">
                                        <span id="lblName" runat="server"><%# Eval("Name") %></span>
                                    </h5>
                                    <!-- Product Color -->
                                    <p class="card-text">Color: <%# Eval("Color") %></p>
                                    <!-- Product Price -->
                                    <p class="card-text fw-bold text-danger">₹<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label></p>

                                    <!-- Hidden Field for Product ID -->
                                    <asp:HiddenField ID="hfProductId" runat="server" Value='<%# Eval("EarringId") %>' />

                                    <!-- Add to Bag Button -->
                                    <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-primary"
                                        Text="Add to Bag" OnClick="btnAddToCart_Click" />
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
