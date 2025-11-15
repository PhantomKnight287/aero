import { useState } from "react";
import { Smartphone } from "lucide-react";
import type { BentoFeature } from "@/data/features";

type FeatureItemProps = {
  feature: BentoFeature;
  index: number;
};

export function FeatureItem({ feature, index }: FeatureItemProps) {
  const [imageError, setImageError] = useState(false);
  const isEven = index % 2 === 0;

  return (
    <div
      className={`flex flex-col ${
        isEven ? "lg:flex-row" : "lg:flex-row-reverse"
      } items-center gap-12 lg:gap-16`}
    >
      {/* Content Section */}
      <div className="flex-1 space-y-6">
        <div className="w-14 h-14 rounded-xl bg-primary/10 flex items-center justify-center text-primary">
          {feature.icon}
        </div>
        <h3 className="text-2xl sm:text-3xl font-bold">{feature.title}</h3>
        <p className="text-lg text-muted-foreground leading-relaxed">
          {feature.description}
        </p>
      </div>

      {/* Image Section */}
      {feature.screenshot && (
        <div className="flex-1 w-full max-w-md">
          <div className="relative rounded-2xl flex items-center justify-center overflow-hidden group">
            {!imageError ? (
              <img
                src={feature.screenshot}
                alt={feature.title}
                className="w-full h-full object-contain transition-transform duration-500"
                onError={() => setImageError(true)}
              />
            ) : (
              <Smartphone className="w-32 h-32 text-primary/30" />
            )}
          </div>
        </div>
      )}
    </div>
  );
}
