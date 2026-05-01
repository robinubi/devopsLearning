using Prometheus;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

// Prometheus HTTP metrics middleware
app.UseHttpMetrics();
app.MapMetrics(); // exposes /metrics for Prometheus to scrape

// Endpoints
app.MapGet("/", () => new { status = "ok", app = "DevOps Learning Lab", version = "1.0.0" });

app.MapGet("/health", () => Results.Ok(new
{
    healthy = true,
    timestamp = DateTime.UtcNow,
    environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "unknown"
}));

// Existing dummy api JSON response endpoint
app.MapGet("/api/data", () => Results.Ok(new { 
    Message = "Success", 
    Timestamp = DateTime.UtcNow 
}));

// --- NEW DUMMY ENDPOINT ---
app.MapGet("/api/status", () => Results.Ok(new { 
    status = "Active", 
    uptime_seconds = Random.Shared.Next(100, 5000),
    server_node = Environment.MachineName 
}));
// --------------------------

app.MapGet("/hello/{name}", (string name) =>
    new { message = $"Hello, {name}! Served by DevOps Lab." });

app.Run();