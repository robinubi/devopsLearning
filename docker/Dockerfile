# Stage 3: Docker — Multi-stage build for .NET 9 API
# Multi-stage keeps the final image small (~100MB vs ~800MB)

# ── Stage 1: Build ──────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy csproj first (layer caching — only re-restores if .csproj changes)
COPY src/DevOpsLab.Api/*.csproj ./
RUN dotnet restore

# Copy source and publish
COPY src/DevOpsLab.Api/ ./
RUN dotnet publish -c Release -o /out --no-restore

# ── Stage 2: Runtime (no SDK, much smaller) ──────────────────
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Non-root user for security
RUN adduser --disabled-password --gecos '' appuser
USER appuser

COPY --from=build /out .

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["dotnet", "DevOpsLab.Api.dll"]
