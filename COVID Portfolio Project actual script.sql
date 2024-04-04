SELECT * 
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4

--SELECT *
--FROM CovidVaccinations
--ORDER BY 3,4

--Select Data that we are going to be using
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths 
WHERE continent IS NOT NULL
ORDER BY 1,2

--Looking at Total Cases vs Total Deaths 
--Shows likelihood of dying if you contracted covid in your country
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM CovidDeaths 
WHERE location like'%States%'
AND continent IS NOT NULL
ORDER BY 1,2

--Looking at total cases vs population
--Shows what percentage of population got covid
SELECT Location, date, population, total_cases, (total_cases/population)*100 AS DeathPercentage
FROM CovidDeaths 
WHERE continent IS NOT NULL
--WHERE location like'%States%'
ORDER BY 1,2

--Looking at countries with highest infection rate compared to population
SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM CovidDeaths 
--WHERE location like'%States%'
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--Showing highest death count per population
SELECT Location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY TotalDeathCount DESC

--Showing continents with the highest death count
--BREAKING DOWN THINGS BY CONTINENT
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- Global Numbers
SELECT  SUM(new_cases) AS SumOfNewCases , SUM(CAST(new_deaths AS INT)) AS SumOfNewDeaths,
SUM(CAST(new_deaths AS INT))/SUM(new_cases) *100 AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2

-- Looking at total population vs people vaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER 
(PARTITION BY dea.Location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3




WITH CTE_PopVsVacc (Continent, Location, Date, Population, Newly_Vaccinated, RollingPeopleVaccinated)
AS 
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER 
(PARTITION BY dea.Location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM CTE_PopVsVacc



--USNG A TEMP TABLE
CREATE TABLE #temp_PopVsVacc
(
	Continent						VARCHAR(500),
	Location						VARCHAR(500),
	Date							Date,
	Population						INT,
	NewlyVaccinated					INT,
	RollingUpPeopleVaccinated		INT
)

INSERT INTO #temp_PopVsVacc
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER 
(PARTITION BY dea.Location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

SELECT *, (RollingUpPeopleVaccinated/Population)*100 
FROM #temp_PopVsVacc


--CREATING A VIEW TO STORE DATA FOR LATER VISUALIZATIONS
CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER 
(PARTITION BY dea.Location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

SELECT *
FROM PercentPopulationVaccinated