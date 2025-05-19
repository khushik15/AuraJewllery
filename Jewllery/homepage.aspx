<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homepage.aspx.cs" Inherits="Jewllery.homepage" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aura Jewellery</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        /* Header (Navbar) */
        header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 50px;
            background: white;
            box-shadow: 0px 4px 6px rgba(0,0,0,0.1);
        }

        .logo img {
            height: 50px;
        }

        .search-bar {
            display: flex;
            flex-grow: 1;
            margin-left: 20px;
        }

        .search-bar input {
            width: 60%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .search-bar button {
            padding: 8px 12px;
            border: none;
            background: #b21f2d;
            color: white;
            cursor: pointer;
        }

        nav ul {
            display: flex;
            list-style: none;
        }

        nav ul li {
            margin: 0 15px;
            position: relative;
        }

        nav ul li a {
            text-decoration: none;
            color: black;
            font-weight: bold;
        }
         .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 150px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }

        .dropdown-content a {
            color: black;
            padding: 10px;
            display: block;
            text-decoration: none;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        /* Image Slider */
        .carousel-item img {
            height: 500px;
            object-fit: cover;
        }

        /* Footer */
        footer {
            background: #f8f8f8;
            padding: 20px;
            margin-top: 100px;
        }

        footer h3 {
            text-align: center;
            color: #b21f2d;
            margin-bottom: 20px;
        }

        /* Jewellery Category Section */
        .categories {
            display: flex;
            justify-content: center;
            flex-wrap: nowrap;
            gap: 20px;
            padding: 20px;
            overflow-x: auto; /* Allows scrolling if needed */
            white-space: nowrap;
             margin-top: 50px;
        }

        .category-item {
            text-align: center;
            min-width: 160px;
        }

        .category-item img {
            width: 200px;
            height: 220px;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .category-item:hover img {
            transform: scale(1.1);
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.2);
        }

        .category-card {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            cursor: pointer;
        }

        .category-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 10px;
            transition: transform 0.3s ease-in-out;
        }

        .category-card:hover .category-image {
            transform: scale(1.05);
        }

        .overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 40%;
            background: linear-gradient(to top, rgba(0, 0, 0, 0.6), transparent);
            border-radius: 10px;
        }

        .category-title {
            position: absolute;
            bottom: 15px;
            left: 50%;
            transform: translateX(-50%);
            color: white;
            font-size: 22px;
            font-weight: bold;
            z-index: 2;
        }
         .video-container {
            text-align: center;
            margin-top: 50px;
        }

        .video-container video {
            width: 80%;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }
        .features-section {
    display: flex;
    justify-content: space-around;
    background-color: #f9f9f9;
    padding: 20px 0;
  }

  .feature {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .feature img {
    width: 40px;
    height: 40px;
  }

  .feature p {
    font-size: 16px;
    color: #4b2674;
  }
   .icon-section {
  display: flex;
  justify-content: space-around;
   margin-top: 40px;
  padding: 20px;
  background-color: #f9f9f9;
}

.icon-section div {
  text-align: center;
}

.icon-section i {
  font-size: 24px;
  color: #4b0082;
  margin-bottom: 8px;
}

.icon-section p {
  font-size: 14px;
  color: #333;
}
#searchResults {
    position: absolute;
    background: white;
    border: 1px solid #ccc;
    width: 250px;
    max-height: 200px;
    overflow-y: auto;
    display: none; /* Initially hidden */
    z-index: 1000; /* Ensure it appears above other elements */
    top: 40px; /* Adjust distance from search bar */
    left: 0;
    padding: 5px;
    border-radius: 5px;
}
#searchResults p {
    padding: 8px;
    margin: 0;
    cursor: pointer;
    transition: background 0.3s;
}
#searchResults p:hover {
    background: #f2f2f2;
}


    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <!-- Navbar -->
        <header>
            <div class="logo">
        <img src="images/images.jpg" alt="Aura Jewellery">
    </div>
    <div class="search-bar">
        <input type="text" id="searchInput" placeholder="Search for jewellery" onkeyup="searchJewellery()">
        <button type="button" onclick="searchJewellery()"><i class="fa fa-search"></i></button>
    </div>
    <div id="searchResults" class="search-results"></div>

    <script>
        function searchJewellery() {
            var query = document.getElementById("searchInput").value.toLowerCase().trim();
            var results = document.getElementById("searchResults");
            var products = [
                { name: "earrings", link: "earring.aspx" },
                { name: "rings", link: "rings.aspx" },
                { name: "pendant", link: "pendant.aspx" },
                { name: "bangles", link: "bangle.aspx" },
                { name: "bracelet", link: "bracelet.aspx" },
                { name: "mangalsutra", link: "manglasutra.aspx" },
                { name: "gold jewellery", link: "gold.aspx" },
                { name: "genz jewellery", link: "genz.aspx" },
                { name: "diamond jewllery", link: "diamond.aspx" },
                { name: " wedding", link: "wedding.aspx" },



            ];

            results.innerHTML = ""; // Clear previous results

            if (query === "") {
                results.style.display = "none"; // Hide when empty
                return;
            }

            var found = false;
            products.forEach(item => {
                if (item.name.includes(query)) {
                    results.innerHTML += `<p onclick="location.href='${item.link}'">🔍 ${item.name}</p>`;
                    found = true;
                }
            });

            results.style.display = found ? "block" : "none"; // Show only if results exist
        }

    </script>
               <nav>
        <ul>
            <li class="dropdown">
                <a href="#">All Jewellery </a>
                <div class="dropdown-content">
                    <a href="rings.aspx">Rings</a>
                    <a href="bracelet.aspx">Bracelets</a>
                    <a href="bangle.aspx">Bangles</a>
                    <a href="pendant.aspx">Pendants</a>
                    <a href="manglasutra.aspx">Mangalsutras</a>
                </div>
            </li>
            <li><a href="gold.aspx">Gold</a></li>
            <li><a href="diamond.aspx">Diamond</a></li>
            <li><a href="earring.aspx">Earrings</a></li>
            <li><a href="wedding.aspx">Wedding</a></li>
            <li><a href="genz.aspx">GenZ</a></li>
            <li><a href="cart1.aspx">🛒 Cart</a></li>
            <li><a href="myOrders.aspx">📦 Orders</a></li>
            <li><a href="login.aspx">👤 Login</a></li>
        </ul>
    </nav>
        </header>

        <!-- Image Slider (Carousel) -->
        <div id="imageCarousel" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img src="images/jewllery1.jpg" class="d-block w-100" alt="Jewellery 1">
            </div>
            <div class="carousel-item">
              <img src="images/images2.jpg" class="d-block w-100" alt="Jewellery 2">
            </div>
            <div class="carousel-item">
              <img src="images/header2.jpg" class="d-block w-100" alt="Jewellery 3">
            </div>
          </div>
        </div>

        <!-- Footer Section -->
        <footer>
            <h3>Our Jewellery Categories</h3>
            <div class="categories">
                <div class="category-item"><a href="earring.aspx"><img src="images/earring.jpg" alt="Earrings"></a><p>Earrings</p></div>
                <div class="category-item"><a href="rings.aspx"><img src="images/ring.jpg" alt="Rings"></a><p>Rings</p></div>
                <div class="category-item"><a href="bracelet.aspx"><img src="images/bracelet1.jpg" alt="Bracelets"></a><p>Bracelets</p></div>
                <div class="category-item"><a href="bangle.aspx"><img src="images/bangle.jpg" alt="Bangles"></a><p>Bangles</p></div>
                <div class="category-item"><a href="pendant.aspx"><img src="images/pendantimg.jpg" alt="Pendants"></a><p>Pendants</p></div>
                <div class="category-item"><a href="manglasutra.aspx"><img src="images/maglasutra.jpg" alt="Mangalsutras"></a><p>Mangalsutras</p></div>
            </div>
            </footer>
            <!-- Jewellery Collection Section (Restored) -->
        <footer
            <section class="container mt-5">
                <h2 class="text-center fw-bold">Aura Jewellery Collection</h2>
                <p class="text-center text-muted">A companion for every occasion</p>

                <div class="row mt-4">
                    <div class="col-md-6 mb-3">
                         <a href="wedding.aspx">
                        <div class="category-card">
                            <img src="images/images7.jpg" alt="Wedding Jewellery" class="category-image">
                            <div class="overlay"></div>
                            <h3 class="category-title">Wedding</h3>
                        </div>
                             </a>
                    </div>
                    <div class="col-md-6 mb-3">
                        <a href="diamond.aspx">
                        <div class="category-card">
                            <img src="images/images6.jpg" alt="Diamond Jewellery" class="category-image">
                            <div class="overlay"></div>
                            <h3 class="category-title">Diamond</h3>
                        </div>
                        </a>
                    </div>
                      <!-- Gold -->
                <div class="col-md-6 mb-3">
                    <a href="gold.aspx">
                    <div class="category-card">
                        <img src="images/goldcoll.jpg" alt="Gold Jewellery" class="category-image">
                        <div class="overlay"></div>
                        <h3 class="category-title">Gold</h3>
                    </div>
                        </a>
                </div>
                        <!-- Dailywear -->
                <div class="col-md-6 mb-3">
                    <a href="genz.aspx">
                    <div class="category-card">
                        <img src="images/dailywear.jpg" alt="Dailywear Jewellery" class="category-image">
                        <div class="overlay"></div>
                        <h3 class="category-title">Genz</h3>
                    </div>
                        </a>
                </div>
                </div>
            </section>

        </footer>
            <section class="icon-section">
  <div>
    <i class="fa-solid fa-indian-rupee-sign"></i>
    <p>15 Day Exchange</p>
  </div>
  <div>
    <i class="fa-solid fa-calendar-days"></i>
    <p>1 Year Warranty</p>
  </div>
  <div>
    <i class="fa-solid fa-certificate"></i>
    <p>100% Certified</p>
  </div>
  <div>
    <i class="fa-solid fa-arrows-rotate"></i>
    <p>Lifetime Exchange</p>
  </div>
</section>
        <div class="video-container">
            <h2 class="text-center fw-bold mt-4">Experience Our Jewellery</h2>
            <video controls>
                <source src="videos/jewllery video.mp4" type="video/mp4">
                Your browser does not support the video tag.
            </video>
        </div>
    </form>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    

    

     <footer class="bg-light text-dark py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-3">
          <h5>Know Your Jewellery</h5>
          <ul class="list-unstyled">
            <li>Diamond guide</li>
            <li>Jewellery guide</li>
            <li>Gemstones guide</li>
            <li>Gold rate</li>
            <li>Plan of purchase</li>
            <li>Glossary</li>
          </ul>
        </div>
        <div class="col-md-3">
          <h5>Aura Advantage</h5>
          <ul class="list-unstyled">
            <li>15-day returns</li>
            <li>Free shipping</li>
            <li>Postcards</li>
            <li>Gold exchange</li>
            <li>Gift cards</li>
          </ul>
        </div>
        <div class="col-md-3">
          <h5>Customer Service</h5>
          <ul class="list-unstyled">
            <li>Return policy</li>
            <li>Order status</li>
          </ul>
        </div>
        <div class="col-md-3">
          <h5>Contact Us</h5>
          <p>Aura Trading Pvt Ltd<br>No:727, 1st Floor, TIL Park Anna Salai,<br>Pathari Road, Thousand Lights, Chennai, Tamil Nadu 600006.</p>
          <p>General: <a href="mailto:contactus@aura.com">contactus@caratlane.com</a></p>
          
          
        </div>
      </div>
      <div class="text-center mt-4">
        <button class="btn btn-dark me-2">Download on the App Store</button>
        <button class="btn btn-dark">Get it on Google Play</button>
      </div>
    </div>
  </footer>
</body>
</html>
