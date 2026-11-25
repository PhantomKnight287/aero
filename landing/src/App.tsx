import { Nav, Hero } from "@/components/Hero";
import { FlightStory } from "@/components/FlightStory";
import { Features } from "@/components/Features";
import { Share, Details, Icons, SelfHost, Footer } from "@/components/Sections";

export default function App() {
  return (
    <>
      <Nav />
      <main>
        <Hero />
        <FlightStory />
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
