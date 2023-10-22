#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SoftUniBazar/SoftUniBazar.csproj", "SoftUniBazar/"]
COPY ["SoftUniBazar.Data/SoftUniBazar.Data.csproj", "SoftUniBazar.Data/"]
RUN dotnet restore "SoftUniBazar/SoftUniBazar.csproj"
COPY . .
WORKDIR "/src/SoftUniBazar"
RUN dotnet build "SoftUniBazar.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SoftUniBazar.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SoftUniBazar.dll"]
