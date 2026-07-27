var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

// Minimal happy-path endpoints. The platform's .NET buildpack injects
// ASPNETCORE_URLS (http://0.0.0.0:${PORT}), so no port code is needed here.
app.MapGet("/", () => "azure-devops-dotnet up (v2 - auto-deploy test)");
app.MapGet("/health", () => Results.Ok(new { status = "ok" }));

app.Run();
