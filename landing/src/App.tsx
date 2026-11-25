import { useEffect, useState } from "react";
import { Nav, Hero } from "@/components/Hero";
import { FlightStory } from "@/components/FlightStory";
import { Features } from "@/components/Features";
import { Share, Details, Icons, SelfHost, Footer } from "@/components/Sections";
import { icons, DEFAULT_ICON_INDEX } from "@/data/icons";

export default function App() {
  const [icon, setIcon] = useState<string>(icons[DEFAULT_ICON_INDEX]);

  // The picked icon also becomes the tab's favicon.
  useEffect(() => {
    document
      .querySelectorAll<HTMLLinkElement>('link[rel="icon"]')
      .forEach((l) => (l.href = `/icons/${icon}`));
  }, [icon]);

  return (
    <>
      <Nav icon={icon} />
      <main>
        <Hero />
        <FlightStory />
        <Features />
        <Share />
        <Details />
        <Icons icon={icon} onPick={setIcon} />
        <SelfHost />
      </main>
      <Footer icon={icon} />
    </>
  );
}
