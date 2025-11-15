import { Button } from "@/components/ui/button";
import { Github } from "lucide-react";
import { DEFAULT_ICON_INDEX, icons } from "@/data/icons";

export function Navigation() {
  const defaultIcon = icons[DEFAULT_ICON_INDEX];

  return (
    <nav className="border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60 sticky top-0 z-50">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between">
          <div className="flex items-center gap-2">
            <img
              src={`/icons/${defaultIcon}`}
              alt="Aero"
              className="w-8 h-8 rounded-lg"
            />
            <span className="text-xl font-bold">Aero</span>
          </div>
          <div className="hidden md:flex items-center gap-6">
            <a
              href="#features"
              className="text-sm font-medium text-muted-foreground hover:text-foreground transition-colors"
            >
              Features
            </a>
            <a
              href="#icons"
              className="text-sm font-medium text-muted-foreground hover:text-foreground transition-colors"
            >
              App Icons
            </a>
            <a
              href="#pricing"
              className="text-sm font-medium text-muted-foreground hover:text-foreground transition-colors"
            >
              Pricing
            </a>
          </div>
          <Button variant="outline" size="sm" asChild>
            <a
              href="https://github.com/phantomknight287/aero"
              target="_blank"
              rel="noopener noreferrer"
            >
              <Github className="w-4 h-4 mr-2" />
              GitHub
            </a>
          </Button>
        </div>
      </div>
    </nav>
  );
}
