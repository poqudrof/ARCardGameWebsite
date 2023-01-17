// import '@/styles/globals.css'

// export default function App({ Component, pageProps }) {
//   return <Component {...pageProps} />
// }

import App from "next/app";
import Head from "next/head";
import "@/styles/globals.css";
import { createContext } from "react";
import { fetchAPI } from "./api/api";
import { getStrapiMedia } from "./api/media";

// Store Strapi Global object in context
export const GlobalContext = createContext({});

const MyApp = ({ Component, pageProps }) => {
  const { global } = pageProps;

  console.log("Connected??", pageProps);
  return (
    <>
      <GlobalContext.Provider value={global}>
        <Component {...pageProps} />
      </GlobalContext.Provider>
    </>
  );
};

// getInitialProps disables automatic static optimization for pages that don't
// have getStaticProps. So article, category and home pages still get SSG.
// Hopefully we can replace this with getStaticProps once this issue is fixed:
// https://github.com/vercel/next.js/discussions/10949
MyApp.getInitialProps = async (ctx) => {
  // Calls page's `getInitialProps` and fills `appProps.pageProps`
  const appProps = await App.getInitialProps(ctx);
  // Fetch global site settings from Strapi
  // const globalRes = await fetchAPI("/global", {
  //   populate: {
  //     favicon: "*",
  //     defaultSeo: {
  //       populate: "*",
  //     },
  //   },
  // });

  // Get list of decks
  const globalRes = await fetchAPI("/decks");
  // Pass the data to our page via props
  return { ...appProps, pageProps: { global: globalRes } };
};

export default MyApp;