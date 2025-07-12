# Imagen base para el build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar el archivo de proyecto y restaurar dependencias
COPY Portafolio/Portafolio.csproj ./Portafolio/
WORKDIR /src/Portafolio
RUN dotnet restore

# Copiar el resto del código
COPY . .

# Publicar la aplicación
RUN dotnet publish -c Release -o /app/publish

# Imagen base para el runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
COPY --from=build /app/publish .

# Comando para ejecutar la app
ENTRYPOINT ["dotnet", "Portafolio.dll"]
