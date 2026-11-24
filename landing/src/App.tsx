import { Nav, Hero } from "@/components/Hero";
import { Features } from "@/components/Features";
import { Share, Details, Icons, SelfHost, Footer } from "@/components/Sections";

export default function App() {
  return (
    <>
      <Nav />
      <main>
        <Hero />
        <Features />
        <Share />
        <Details />
        <Icons />
        <SelfHost />
      </main>
      <Footer />
    </>
  );
}
