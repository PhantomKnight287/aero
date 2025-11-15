import { DEFAULT_ICON_INDEX, icons } from "@/data/icons";

export function Footer() {
  const defaultIcon = icons[DEFAULT_ICON_INDEX];

  return (
    <footer className="border-t bg-muted/30">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div className="space-y-4">
            <div className="flex items-center gap-2">
              <img
                src={`/icons/${defaultIcon}`}
                alt="Aero"
                className="w-8 h-8 rounded-lg"
              />
              <span className="text-xl font-bold">Aero</span>
            </div>
            <p className="text-sm text-muted-foreground">
              Your flight companion for tracking, organizing, and remembering
              your journeys.
            </p>
          </div>
          <div>
            <h3 className="font-semibold mb-4">Product</h3>
            <ul className="space-y-2 text-sm">
              <li>
                <a
                  href="#features"
                  className="text-muted-foreground hover:text-foreground transition-colors"
                >
                  Features
                </a>
              </li>
              <li>
                <a
                  href="#icons"
                  className="text-muted-foreground hover:text-foreground transition-colors"
                >
                  App Icons
                </a>
              </li>
              <li>
                <a
                  href="#pricing"
                  className="text-muted-foreground hover:text-foreground transition-colors"
                >
                  Pricing
                </a>
              </li>
            </ul>
          </div>

          <div>
            <h3 className="font-semibold mb-4">Connect</h3>
            <ul className="space-y-2 text-sm">
              <li>
                <a
                  href="https://github.com/phantomknight287/aero"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-muted-foreground hover:text-foreground transition-colors"
                >
                  GitHub
                </a>
              </li>
            </ul>
          </div>
        </div>
        <div className="mt-12 pt-8 border-t text-center text-sm text-muted-foreground">
          <p>© 2025 Aero. All Rights Reserved.</p>
        </div>
      </div>
    </footer>
  );
}
