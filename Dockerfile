# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copiar solo el .csproj y restaurar dependencias
COPY Portafolio/Portafolio.csproj ./Portafolio/
WORKDIR /src/Portafolio
RUN dotnet restore

# Copiar el resto del código
COPY Portafolio/. ./
RUN dotnet publish -c Release -o /app/publish --no-restore

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app

# Configurar puerto dinámico de Render
ENV ASPNETCORE_URLS=http://+:$PORT

COPY --from=build /app/publish .

EXPOSE 8080

ENTRYPOINT ["dotnet", "Portafolio.dll"]
