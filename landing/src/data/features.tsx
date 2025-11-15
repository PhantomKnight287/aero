import {
  Plane,
  Info,
  Navigation,
  Share2,
  Camera,
} from "lucide-react";
import type { ReactNode } from "react";

export type BentoFeature = {
  icon: ReactNode;
  title: string;
  description: string;
  screenshot: string | null;
  span: string;
  size: "normal" | "large" | "wide";
  imageFirst?: boolean;
};

export const bentoFeatures: BentoFeature[] = [
  {
    icon: <Plane className="w-6 h-6" />,
    title: "Track Any Flight",
    description:
      "Track any flight, across airports or airlines. Get real-time updates no matter where you're flying.",
    screenshot: "/features/tracking.png",
    span: "col-span-1",
    size: "large",
    imageFirst: true,
  },
  {
    icon: <Info className="w-6 h-6" />,
    title: "Detailed Plane Information",
    description:
      "See detailed information about your plane including model, registration, age, and more.",
    screenshot: "/features/aircraft_details.png",
    span: "col-span-1",
    size: "large",
    imageFirst: false,
  },
  {
    icon: <Navigation className="w-6 h-6" />,
    title: "Live Tracking",
    description:
      "Live tracking on app along with height, speed, heading, and real-time position on the map.",
    screenshot: "/features/live_on_map.png",
    span: "col-span-1",
    size: "large",
    imageFirst: true,
  },
  {
    icon: <Share2 className="w-6 h-6" />,
    title: "Shareable Beautiful Cards",
    description:
      "Share beautiful cards to flex between people. Show off your travels with stunning flight cards.",
    screenshot: "/features/shareable_card.png",
    span: "col-span-1",
    size: "large",
    imageFirst: false,
  },
  {
    icon: <Camera className="w-6 h-6" />,
    title: "Aircraft Photos",
    description:
      "See actual photo of your aircraft. View real images of the plane you'll be flying on.",
    screenshot: "/features/plane_image.png",
    span: "col-span-1",
    size: "large",
    imageFirst: true,
  },
];
