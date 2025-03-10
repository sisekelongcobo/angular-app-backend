# Use official .NET SDK as the build environment
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy project files and restore dependencies
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o /out

# Use ASP.NET Core runtime for the final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /out ./

# Expose port 5000 for the application
EXPOSE 5000
CMD ["dotnet", "MyWebService.dll"]
