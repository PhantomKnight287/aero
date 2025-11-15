import { Button } from "@/components/ui/button";
import { Github } from "lucide-react";

export function Hero() {
  return (
    <section className="container mx-auto px-4 sm:px-6 lg:px-8 py-20 lg:py-32">
      <div className="max-w-4xl mx-auto text-center">
        <h1 className="text-4xl sm:text-5xl lg:text-6xl font-bold tracking-tight mb-6">
          Track your flights, from different airlines, all in one app
        </h1>
        <p className="text-xl text-muted-foreground mb-8 max-w-2xl mx-auto">
          Aero is the flight companion you've been waiting for. Track your live
          flights, log your past adventures, and tell a story about your
          journey.
        </p>
        <Button size="lg" asChild>
          <a
            href="https://github.com/phantomknight287/aero"
            target="_blank"
            rel="noopener noreferrer"
          >
            <Github className="w-5 h-5 mr-2" />
            View on GitHub
          </a>
        </Button>
      </div>
    </section>
  );
}
