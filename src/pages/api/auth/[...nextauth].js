import NextAuth from "next-auth";
// import Providers from "next-auth/providers";
import GoogleProvider from "next-auth/providers/google";

export const authOptions = {
  providers: [
   GoogleProvider({
       clientId: process.env.GOOGLE_CLIENT_ID,
       clientSecret: process.env.GOOGLE_CLIENT_SECRET,
   }),
  ],
  session: {
   strategy: 'jwt',
  },
 };
 export default NextAuth(authOptions);

 
// const options = {
//   secret: process.env.NEXTAUTH_SECRET,
//   providers: [
//     GoogleProvider({
//       clientId: process.env.GOOGLE_CLIENT_ID,
//       clientSecret: process.env.GOOGLE_CLIENT_SECRET,
//       // authorization: {
//       //   params: {
//       //     prompt: "consent",
//       //     access_type: "offline",
//       //     response_type: "code"
//       //   }
//       // }
//     }),
//   ],
//   database: process.env.NEXT_PUBLIC_DATABASE_URL,
//   session: {
//     strategy: 'jwt',
//    },
//   callbacks: {
//     session: async (session, user) => {
//       session.jwt = user.jwt;
//       session.id = user.id;
//       return Promise.resolve(session);
//     },
//     jwt: async (token, user, account) => {
//       const isSignIn = user ? true : false;
//       if (isSignIn) {
//         const response = await fetch(
//           `${process.env.NEXT_PUBLIC_API_URL}/auth/${account.provider}/callback?access_token=${account?.accessToken}`
//         );
//         const data = await response.json();
//         token.jwt = data.jwt;
//         token.id = data.user.id;
//       }
//       return Promise.resolve(token);
//     },
//   },
// };

// const Auth = (req, res) =>
//   NextAuth(req, res, options);

// export default Auth;