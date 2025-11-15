import { FeatureItem } from "./FeatureItem";
import { bentoFeatures } from "@/data/features";

export function BentoFeatures() {
  return (
    <section
      id="features"
      className="container mx-auto px-4 sm:px-6 lg:px-8 py-20"
    >
      <div className="max-w-6xl mx-auto">
        <div className="text-center mb-16">
          <h2 className="text-3xl sm:text-4xl font-bold mb-4">
            Why People Love Aero
          </h2>
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
            Everything you need to stay on top of your flights and travel
            plans.
          </p>
        </div>
        
        <div className="space-y-24">
          {bentoFeatures.map((feature, index) => (
            <FeatureItem
              key={index}
              feature={feature}
              index={index}
            />
          ))}
        </div>
      </div>
    </section>
  );
}
