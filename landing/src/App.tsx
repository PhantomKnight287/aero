import "./App.css";
import { Navigation } from "@/components/Navigation";
import { Hero } from "@/components/Hero";
import { BentoFeatures } from "@/components/BentoFeatures";
import { Pricing } from "@/components/Pricing";
import { IconShowcase } from "@/components/IconShowcase";
import { CTA } from "@/components/CTA";
import { Footer } from "@/components/Footer";

function App() {
  return (
    <div className="min-h-screen bg-background">
      <Navigation />
      <Hero />
      <BentoFeatures />
      <Pricing />
      <IconShowcase />
      <CTA />
      <Footer />
    </div>
  );
}

export default App;
