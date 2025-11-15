import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { icons, DEFAULT_ICON_INDEX } from "@/data/icons";

export function IconShowcase() {
  return (
    <section
      id="icons"
      className="container mx-auto px-4 sm:px-6 lg:px-8 py-20"
    >
      <div className="max-w-6xl mx-auto">
        <div className="text-center mb-16">
          <h2 className="text-3xl sm:text-4xl font-bold mb-4">
            Choose Your App Icon
          </h2>
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
            Customize Aero to match your style. Choose from 12 beautiful app
            icons.
          </p>
        </div>
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-6">
          {icons.map((icon, index) => {
            const isDefault = index === DEFAULT_ICON_INDEX;
            return (
              <Card
                key={index}
                className="group cursor-pointer hover:border-primary transition-all hover:shadow-lg relative"
              >
                {isDefault && (
                  <Badge 
                    className="absolute top-2 right-2 z-10 text-xs"
                    variant="default"
                  >
                    Default
                  </Badge>
                )}
                <CardContent className="p-4 flex flex-col items-center justify-center aspect-square">
                  <div className="w-24 h-24 rounded-2xl bg-transparent flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
                    <img
                      src={`/icons/${icon}`}
                      alt={`Aero icon ${index + 1}`}
                      className="w-20 h-20 rounded-xl object-contain"
                    />
                  </div>
                  <Badge variant="outline" className="text-xs">
                    Icon {index + 1}
                  </Badge>
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>
    </section>
  );
}

