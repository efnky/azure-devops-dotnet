FROM mcr.microsoft.com/dotnet/sdk:9.0 AS builder
WORKDIR /src
COPY azure-devops-dotnet.csproj global.json ./
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o /app/publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:9.0
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV ASPNETCORE_URLS=http://+:5000
WORKDIR /app
COPY --from=builder /app/publish ./
EXPOSE 5000
USER 1654
ENTRYPOINT ["dotnet", "azure-devops-dotnet.dll"]