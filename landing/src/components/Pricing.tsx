import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { CheckCircle2, Github } from "lucide-react";

export function Pricing() {
  return (
    <section
      id="pricing"
      className="container mx-auto px-4 sm:px-6 lg:px-8 py-20 bg-muted/30"
    >
      <div className="max-w-4xl mx-auto">
        <div className="text-center mb-16">
          <h2 className="text-3xl sm:text-4xl font-bold mb-4">Pricing</h2>
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
            Aero is completely free and open source. Run your own instance and
            pay only for the APIs you use.
          </p>
        </div>
        <div className="max-w-md mx-auto">
          <Card className="border-2 border-primary/20 relative overflow-hidden">
            <div className="absolute top-0 right-0 w-32 h-32 bg-primary/10 rounded-full blur-3xl -mr-16 -mt-16"></div>
            <CardHeader className="relative">
              <Badge className="w-fit mb-4" variant="secondary">
                Free Forever
              </Badge>
              <CardTitle className="text-3xl mb-2">Free</CardTitle>
              <CardDescription className="text-base">
                <span className="text-4xl font-bold text-foreground">$0</span>
                <span className="text-muted-foreground">/month</span>
              </CardDescription>
            </CardHeader>
            <CardContent className="relative space-y-4">
              <div className="space-y-3">
                <div className="flex items-start gap-3">
                  <CheckCircle2 className="w-5 h-5 text-primary mt-0.5 shrink-0" />
                  <div>
                    <p className="font-medium">Self-hosted</p>
                    <p className="text-sm text-muted-foreground">
                      Run your own instance with full control
                    </p>
                  </div>
                </div>
                <div className="flex items-start gap-3">
                  <CheckCircle2 className="w-5 h-5 text-primary mt-0.5 shrink-0" />
                  <div>
                    <p className="font-medium">Open Source</p>
                    <p className="text-sm text-muted-foreground">
                      Fully transparent
                    </p>
                  </div>
                </div>
                <div className="flex items-start gap-3">
                  <CheckCircle2 className="w-5 h-5 text-primary mt-0.5 shrink-0" />
                  <div>
                    <p className="font-medium">Pay for What You Use</p>
                    <p className="text-sm text-muted-foreground">
                      Only pay for API costs you incur
                    </p>
                  </div>
                </div>
                <div className="flex items-start gap-3">
                  <CheckCircle2 className="w-5 h-5 text-primary mt-0.5 shrink-0" />
                  <div>
                    <p className="font-medium">All Features Included</p>
                    <p className="text-sm text-muted-foreground">
                      No restrictions, no limitations
                    </p>
                  </div>
                </div>
                <div className="flex items-start gap-3">
                  <CheckCircle2 className="w-5 h-5 text-primary mt-0.5 shrink-0" />
                  <div>
                    <p className="font-medium">Community Support</p>
                    <p className="text-sm text-muted-foreground">
                      Get help from the community on GitHub
                    </p>
                  </div>
                </div>
              </div>
              <Button size="lg" className="w-full mt-6" asChild>
                <a
                  href="https://github.com/phantomknight287/aero"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <Github className="w-5 h-5 mr-2" />
                  Get Started on GitHub
                </a>
              </Button>
            </CardContent>
          </Card>
        </div>
      </div>
    </section>
  );
}

