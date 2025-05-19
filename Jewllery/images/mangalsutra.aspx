<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mangalsutra.aspx.cs" Inherits="Jewllery.images.mangalsutra" %>

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
                                <asp:Image ID="imgMangalsutra" runat="server" CssClass="card-img-top mangalsutra-image"
                                    ImageUrl='<%# ResolveUrl("~/images/" + Eval("ImageURL")) %>' AlternateText="Mangalsutra Image" />
                                <div class="card-body text-center">
                                    <h5 class="card-title"><%# Eval("Name") %></h5>
                                    <p class="card-text">Material: <%# Eval("Material") %></p>
                                    <p class="card-text fw-bold text-danger">₹<%# Eval("Price") %></p>
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
