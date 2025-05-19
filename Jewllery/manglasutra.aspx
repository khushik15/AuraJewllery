<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manglasutra.aspx.cs" Inherits="Jewllery.manglasutra" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mangalsutra Collection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .mangalsutra-card {
            border: none;
            transition: transform 0.3s ease-in-out;
        }
        .mangalsutra-card:hover {
            transform: scale(1.02);
        }
        .mangalsutra-image {
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
            <h2 class="text-center mb-4">Mangalsutra Collection</h2>
            <div class="row">
                <asp:Repeater ID="rptMangalsutra" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                            <div class="card mangalsutra-card position-relative">
                                <!-- Image -->
                                <asp:Image ID="imgMangalsutra" runat="server" CssClass="card-img-top mangalsutra-image"
                                    ImageUrl='<%# ResolveUrl("~/Images/" + Eval("ImageURL")) %>' AlternateText="Mangalsutra Image" />

                                <div class="card-body text-center">
                                    <!-- Product Name -->
                                    <h5 class="card-title">
                                        <asp:Literal ID="litName" runat="server" Text='<%# Eval("Name") %>'></asp:Literal>
                                    </h5>
                                    
                                    <!-- Material -->
                                    <p class="card-text">Material: <%# Eval("Material") %></p>
                                    
                                    <!-- Price -->
                                    <p class="card-text fw-bold text-danger">
                                        ₹<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                                    </p>

                                    <!-- HiddenField for Product ID -->
                                    <asp:HiddenField ID="hfProductId" runat="server" Value='<%# Eval("ID") %>' />

                                    <!-- Add to Cart Button -->
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
</body>
</html>
