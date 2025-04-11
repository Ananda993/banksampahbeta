<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bali Bersih | Bank Sampah Br. Baleran</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4CAF50;
            --secondary-color: #8BC34A;
            --accent-color: #FFC107;
            --text-light: #ffffff;
            --text-dark: #333333;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            line-height: 1.6;
            color: var(--text-dark);
        }

        header {
            background: rgba(0, 0, 0, 0.8);
            position: fixed;
            width: 100%;
            z-index: 1000;
            padding: 1rem 5%;
        }

        .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            color: var(--text-light);
            font-size: 1.5rem;
            font-weight: 700;
            text-decoration: none;
        }

        nav a {
            color: var(--text-light);
            text-decoration: none;
            margin-left: 2rem;
            font-weight: 400;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: var(--accent-color);
        }

        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url('/api/placeholder/1920/1080');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            align-items: center;
            text-align: center;
            color: var(--text-light);
            padding: 0 1rem;
        }

        .hero-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1.5rem;
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }

        .cta-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .btn {
            padding: 1rem 2rem;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--accent-color);
            color: var(--text-dark);
        }

        .btn-secondary {
            background: transparent;
            color: var(--text-light);
            border: 2px solid var(--text-light);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .section {
            padding: 5rem 1rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            padding: 2rem;
        }

        .feature-card {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            padding: 2rem;
        }

        .gallery-item {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            height: 250px;
        }

        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        footer {
            background: var(--text-dark);
            color: var(--text-light);
            padding: 3rem 1rem;
            text-align: center;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            text-align: left;
        }

        .footer-section h3 {
            margin-bottom: 1rem;
        }

        .footer-bottom {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2rem;
            }

            nav {
                display: none;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="nav-container">
            <a href="#" class="logo">Bali Bersih</a>
            <nav>
                <a href="#tentang">Tentang</a>
                <a href="#program">Program</a>
                <a href="#dokumentasi">Dokumentasi</a>
                <a href="#lokasi">Lokasi</a>
                <a href="#kontak">Kontak</a>
                <a href="pages/login.php">Login</a>
            </nav>
        </div>
    </header>

    <section class="hero">
        <div class="hero-content">
            <h1>Wujudkan Bali Bersih dan Lestari</h1>
            <p>Bergabunglah dalam gerakan Bank Sampah Br. Baleran untuk menciptakan Pulau Dewata yang bebas dari sampah dan menjaga keberlanjutan lingkungan untuk generasi mendatang.</p>
            <div class="cta-buttons">
                <a href="pages/register.php" class="btn btn-primary">Bergabung Sekarang</a>
                <a href="#program" class="btn btn-secondary">Pelajari Lebih Lanjut</a>
            </div>
        </div>
    </section>

    <section id="tentang" class="section">
        <div class="container">
            <h2 class="section-title">Tentang Kami</h2>
            <p>Bank Sampah Br. Baleran adalah inisiatif masyarakat untuk mengelola sampah secara modern dan berkelanjutan. Kami berkomitmen untuk menciptakan lingkungan yang bersih dan sehat di Pulau Bali.</p>
        </div>
    </section>

    <section id="program" class="section" style="background-color: #f5f5f5;">
        <div class="container">
            <h2 class="section-title">Program Kami</h2>
            <div class="features">
                <div class="feature-card">
                    <h3>Pengelolaan Sampah</h3>
                    <p>Sistem pengumpulan dan pemilahan sampah modern untuk mendukung daur ulang yang efektif.</p>
                </div>
                <div class="feature-card">
                    <h3>Edukasi Masyarakat</h3>
                    <p>Program pelatihan dan workshop tentang pengelolaan sampah dan gaya hidup berkelanjutan.</p>
                </div>
                <div class="feature-card">
                    <h3>Daur Ulang Kreatif</h3>
                    <p>Mengubah sampah menjadi produk bernilai ekonomi melalui program daur ulang kreatif.</p>
                </div>
            </div>
        </div>
    </section>

    <section id="dokumentasi" class="section">
        <div class="container">
            <h2 class="section-title">Dokumentasi Kegiatan</h2>
            <div class="gallery">
                <div class="gallery-item">
                    <img src="assets/images/gambar1.jpeg" alt="Kegiatan Bersih Pantai">
                </div>
                <div class="gallery-item">
                    <img src="assets/images/gambar2.jpeg" alt="Workshop Daur Ulang">
                </div>
                <div class="gallery-item">
                    <img src="assets/images/gambar3.jpeg" alt="Pemilahan Sampah">
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>Kontak</h3>
                <p>Email: info@balibersih.id</p>
                <p>Telepon: (0361) 123456</p>
                <p>Alamat: Br. Baleran, Bali</p>
            </div>
            <div class="footer-section">
                <h3>Program</h3>
                <p>Bank Sampah</p>
                <p>Edukasi Lingkungan</p>
                <p>Daur Ulang</p>
            </div>
            <div class="footer-section">
                <h3>Ikuti Kami</h3>
                <p>Instagram</p>
                <p>Facebook</p>
                <p>Twitter</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Bank Sampah Br. Baleran. Semua hak dilindungi.</p>
        </div>
    </footer>
</body>
</html>