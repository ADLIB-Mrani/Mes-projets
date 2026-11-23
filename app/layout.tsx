import type { Metadata } from "next";
import "./globals.css";
import {Navigation} from "@/components/navigation";
import {Footer} from "@/components/portfolio";

export const metadata: Metadata = {
  title: {default:"Mohamed Mrani Alaoui — Portfolio Data",template:"%s · Mohamed Mrani Alaoui"},
  description: "Le portfolio de Mohamed Mrani Alaoui, étudiant en BUT Science des données à l’Université Marie et Louis Pasteur. Projets, compétences et parcours.",
  icons: {
    icon: "/favicon.svg",
    shortcut: "/favicon.svg",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="fr">
      <body><a href="#contenu" className="skip-link">Aller au contenu</a><Navigation/><main id="contenu">{children}</main><Footer/></body>
    </html>
  );
}
