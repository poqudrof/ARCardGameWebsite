import Head from 'next/head'
import NextImage from 'next/image'
import { Inter } from '@next/font/google'
import styles from '@/styles/Home.module.css'

const inter = Inter({ subsets: ['latin'] })


export default function Home( {website}) {
  return (
    <>
      <Head>
        <title>JMG website</title>
        <meta name="description" content="JMG website" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		  	<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>

        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main >
    
        {/* <div className={styles.description}>
          <p> 
            {  website.title }  Welcome to ARCard. 
          </p>      
        </div> */}

      <header id="header">
				<div className="content">
					<h1><a href="#">Fractal</a></h1>
					<p>Just a simple, single page responsive<br />
					template brought to you by <a href="http://html5up.net">HTML5 UP</a></p>
					<ul className="actions">
						<li><a href="#" className="button primary icon solid fa-download">Download</a></li>
						<li><a href="#one" className="button icon solid fa-chevron-down scrolly">Learn More</a></li>
					</ul>
				</div>
				<div className="image phone"><div className="inner"><img src="images/screen.jpg" alt="" /></div></div>
			</header>

			<section id="one" className="wrapper style2 special">
				<header className="major">
					<h2>Sed ipsum magna lorem tempus amet<br />
					vehicula et gravida elementum</h2>
				</header>
				<ul className="icons major">
					<li><span className="icon solid fa-camera-retro"><span className="label">Shoot</span></span></li>
					<li><span className="icon solid fa-sync"><span className="label">Process</span></span></li>
					<li><span className="icon solid fa-cloud"><span className="label">Upload</span></span></li>
				</ul>
			</section>

      <section id="two" className="wrapper">
				<div className="inner alt">
					<section className="spotlight">
						<div className="image"><img src="images/pic01.jpg" alt="" /></div>
						<div className="content">
							<h3>Magna sed ultrices</h3>
							<p>Morbi mattis ornare ornare. Duis quam turpis, gravida at leo elementum elit fusce accumsan dui libero, quis vehicula lectus ultricies eu. In convallis amet leo non sapien iaculis efficitur consequat lorem ipsum.</p>
						</div>
					</section>
					<section className="spotlight">
						<div className="image"><img src="images/pic02.jpg" alt="" /></div>
						<div className="content">
							<h3>Ultrices nullam aliquam</h3>
							<p>Morbi mattis ornare ornare. Duis quam turpis, gravida at leo elementum elit fusce accumsan dui libero, quis vehicula lectus ultricies eu. In convallis amet leo non sapien iaculis efficitur consequat lorem ipsum.</p>
						</div>
					</section>
					<section className="spotlight">
						<div className="image"><img src="images/pic03.jpg" alt="" /></div>
						<div className="content">
							<h3>Aliquam sed magna</h3>
							<p>Morbi mattis ornare ornare. Duis quam turpis, gravida at leo elementum elit fusce accumsan dui libero, quis vehicula lectus ultricies eu. In convallis amet leo non sapien iaculis efficitur consequat lorem ipsum.</p>
						</div>
					</section>
					<section className="special">
						<ul className="icons labeled">
							<li><span className="icon solid fa-camera-retro"><span className="label">Ipsum lorem accumsan</span></span></li>
							<li><span className="icon solid fa-sync"><span className="label">Sed vehicula elementum</span></span></li>
							<li><span className="icon solid fa-cloud"><span className="label">Elit fusce consequat</span></span></li>
							<li><span className="icon solid fa-code"><span className="label">Lorem nullam tempus</span></span></li>
							<li><span className="icon solid fa-desktop"><span className="label">Adipiscing amet sapien</span></span></li>
						</ul>
					</section>
				</div>
			</section>


			<section id="three" className="wrapper style2 special">
				<header className="major">
					<h2>Magna leo sapien gravida</h2>
					<p>Gravida at leo elementum elit fusce accumsan dui libero, quis vehicula<br />
					lectus ultricies eu. In convallis amet leo sapien iaculis efficitur.</p>
				</header>
				<ul className="actions special">
					<li><a href="#" className="button primary icon solid fa-download">Download</a></li>
					<li><a href="#" className="button">Learn More</a></li>
				</ul>
			</section>

      </main>

      <footer id="footer">
				<ul className="icons">
					<li><a href="#" className="icon brands fa-facebook-f"><span className="label">Facebook</span></a></li>
					<li><a href="#" className="icon brands fa-twitter"><span className="label">Twitter</span></a></li>
					<li><a href="#" className="icon brands fa-instagram"><span className="label">Instagram</span></a></li>
				</ul>
				<p className="copyright">&copy; Untitled. Credits: <a href="http://html5up.net">HTML5 UP</a></p>
			</footer>

			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

    </>
  )
}



export async function getStaticProps(context) {

 

  // const res = await fetch("http://localhost:1337/website")
  // const website = await res.json()

  const website = { title: "Helloz"}

  return {
    props: {website}, // will be passed to the page component as props
  }
}