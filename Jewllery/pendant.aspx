<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pendant.aspx.cs" Inherits="Jewllery.pendant" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pendant Collection</title>
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
        .pendant-card {
            border: none;
            transition: transform 0.3s ease-in-out;
        }
        .pendant-card:hover {
            transform: scale(1.02);
        }
        .pendant-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <img src="images/chains pendents.jpg" alt="Earrings Banner" class="header-image">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Pendant Collection</h2>
            <div class="row">
                <asp:Repeater ID="rptPendants" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div class="card pendant-card position-relative">
                                <asp:Image ID="imgPendant" runat="server" CssClass="card-img-top pendant-image"
                                    ImageUrl='<%# ResolveUrl("~/images/") + Eval("ImageURL") %>' AlternateText="Pendant Image" />
                                <div class="card-body text-center">
                                    <h5 id="lblName" runat="server" class="card-title"><%# Eval("Name") %></h5>
                                    <p class="card-text">Material: <%# Eval("Material") %></p>
                                    <p class="card-text fw-bold text-danger">
                                        ₹<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                                    </p>

                                    <!-- Hidden field to store Product ID -->
                                    <asp:HiddenField ID="hfProductId" runat="server" Value='<%# Eval("ID") %>' />

                                    <!-- Add to Bag Button -->
                                    <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-primary"
                                        Text="Add to Bag" CommandArgument='<%# Eval("ID") %>'
                                        OnClick="btnAddToCart_Click" UseSubmitBehavior="false" />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
