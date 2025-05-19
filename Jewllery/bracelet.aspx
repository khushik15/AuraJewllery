<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bracelet.aspx.cs" Inherits="Jewllery.bracelet" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bracelets Collection</title>
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
        .bracelet-card {
            border: none;
            transition: transform 0.3s ease-in-out;
        }
        .bracelet-card:hover {
            transform: scale(1.02);
        }
        .bracelet-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <img src="images/bracelet banner.jpg" alt="Bracelet Banner" class="header-image">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Bracelets Collection</h2>
            <div class="row">
                <asp:Repeater ID="rptBracelets" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div class="card bracelet-card">
                                <asp:Image ID="imgBracelet" runat="server" CssClass="card-img-top bracelet-image"
                                    ImageUrl='<%# "images/" + Eval("ImageUrl") %>' AlternateText="Bracelet Image" />
                                <div class="card-body text-center">
                                    <h5 class="card-title">
                                        <asp:Literal ID="litName" runat="server" Text='<%# Eval("Name") %>'></asp:Literal>
                                    </h5>
                                    <p class="card-text">Material: <%# Eval("Material") %></p>
                                    <p class="card-text fw-bold text-danger">₹
                                        <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                                    </p>

                                    <!-- Hidden field for ProductId -->
                                    <asp:HiddenField ID="hfProductId" runat="server" Value='<%# Eval("BraceletId") %>' />

                                    <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-primary"
                                        Text="Add to Bag" CommandArgument='<%# Eval("BraceletId") %>'
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
