# azure-devops-dotnet

Minimal **ASP.NET Core Minimal API** (net9.0), dependency-free — kaynak repo'yu
**Azure DevOps** üzerinde barındırıp komuta'nın **Azure DevOps repo bağlantısını**
test etmek için hazırlanmıştır.

- `Program.cs`: top-level Minimal API. Endpoint'ler:
  - `GET /` → `azure-devops-dotnet up`
  - `GET /health` → `{ "status": "ok" }`
- Port koda gömülü değildir. Platformun .NET buildpack'i çalıştırırken
  `ASPNETCORE_URLS=http://0.0.0.0:${PORT}` enjekte eder; uygulama varsayılan
  ASP.NET davranışıyla bu portu dinler.
- SDK `global.json` ile **9.0.301** (`rollForward: latestPatch`) olarak sabitlenmiştir.

## Lokal çalıştırma

```bash
dotnet run
# http://localhost:5099
```

Port simülasyonu (buildpack davranışı):

```bash
ASPNETCORE_URLS=http://0.0.0.0:8080 dotnet run
curl http://localhost:8080/        # azure-devops-dotnet up
curl http://localhost:8080/health  # {"status":"ok"}
```

## Azure DevOps'a push

```bash
git init
git add -A
git commit -m "azure-devops-dotnet: minimal net9.0 Minimal API"
git branch -M main
git remote add origin https://dev.azure.com/<ORG>/<PROJECT>/_git/azure-devops-dotnet
git push -u origin main
```

## Beklenen (komuta)
.NET olarak tespit → buildpack ile derleme → `${PORT}` üzerinde HTTP 200. Happy-path.
