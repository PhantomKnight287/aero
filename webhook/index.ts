const server = Bun.serve({
  async fetch(request, server) {
    const url = new URL(request.url);
    if (url.pathname === "/webhook") {
      console.log(request);
      console.log(await request.json());
      return Response.json({ message: "Hello World" });
    }

    return new Response("Bun!");
  },
  port: 5000,
});

console.log("Up at 5000")