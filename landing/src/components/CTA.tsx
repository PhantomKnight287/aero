import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Github, Sparkles } from "lucide-react";

export function CTA() {
  return (
    <section className="container mx-auto px-4 sm:px-6 lg:px-8 py-20">
      <Card className="max-w-4xl mx-auto border-2 border-primary/20 bg-gradient-to-br from-primary/5 to-primary/10">
        <CardHeader className="text-center">
          <CardTitle className="text-3xl mb-2">
            Ready to Track Your Flights?
          </CardTitle>
          <CardDescription className="text-lg">
            Get started with Aero today. Clone the repository and set up your
            own instance.
          </CardDescription>
        </CardHeader>
        <CardContent className="flex flex-col sm:flex-row gap-4 justify-center pb-6">
          <Button size="lg" className="w-full sm:w-auto" asChild>
            <a
              href="https://github.com/phantomknight287/aero"
              target="_blank"
              rel="noopener noreferrer"
            >
              <Github className="w-5 h-5 mr-2" />
              View on GitHub
            </a>
          </Button>
          <Button
            size="lg"
            variant="outline"
            className="w-full sm:w-auto bg-background"
            asChild
          >
            <a
              href="https://github.com/phantomknight287/aero"
              target="_blank"
              rel="noopener noreferrer"
            >
              <Sparkles className="w-5 h-5 mr-2" />
              Documentation
            </a>
          </Button>
        </CardContent>
      </Card>
    </section>
  );
}

