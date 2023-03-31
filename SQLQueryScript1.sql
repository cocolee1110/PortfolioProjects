Select *
From ProjectPortfolio..CovidDeaths
Where continent is not null -- some Location is not countries, but continents (exclude those)
Order by 3,4

--Select *
--From ProjectPortfolio..CovidVaccinations
--Order by 3,4

-- Select Data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From ProjectPortfolio..CovidDeaths
Order by 1,2

-- Looking at Total Cases vs Total Deaths, 
-- Showing likelihood of dying if you contract covid in United states

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From ProjectPortfolio..CovidDeaths
Where location like '%kingdom%'
Order by 1,2

-- Looking at Total Cases vs population
-- Shows what percentage of population got Covid

Select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
From ProjectPortfolio..CovidDeaths
Where location like '%kingdom%'
Order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From ProjectPortfolio..CovidDeaths
Group by Location, population
Order by PercentPopulationInfected DESC

-- Showing Countries with Highest Death Count per Population

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From ProjectPortfolio..CovidDeaths
Where continent is not null 
Group by Location
Order by TotalDeathCount DESC

-- Showing Continents with Highest Death Count per Population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From ProjectPortfolio..CovidDeaths
Where continent is not null 
Group by continent
Order by TotalDeathCount DESC

	---- DATA file included continents numbers in location where continent is null, so correct numbers would be:
	--Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
	--From ProjectPortfolio..CovidDeaths
	--WHERE continent is null 
	--Group by Location
	--Order by TotalDeathCount DESC
	---- but we are not using this -_-



-- GLOBAL NUMBERS along timestamps

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths AS int)) as total_deaths, SUM(cast(new_deaths AS int))/SUM(new_cases)*100 as GlobalDeathPercentage
From ProjectPortfolio..CovidDeaths
Where continent is not null
Group By date
Order by 1,2

-- GLOBAL NUMBER total number 

Select  SUM(new_cases) as total_cases, SUM(cast(new_deaths AS int)) as total_deaths, SUM(cast(new_deaths AS int))/SUM(new_cases)*100 as GlobalDeathPercentage
From ProjectPortfolio..CovidDeaths
Where continent is not null
Order by 1,2


-- Looking at Total Population vs Vaccinations = Percentage of people vaccinated in the country

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations AS bigint)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingPeopleVaccinated
FROM ProjectPortfolio..CovidDeaths AS dea
JOIN ProjectPortfolio..CovidVaccinations AS vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

-- using CTE

--WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
--AS 
--(
--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--FROM ProjectPortfolio..CovidDeaths AS dea
--JOIN ProjectPortfolio..CovidVaccinations AS vac
--	ON dea.location = vac.location
--	and dea.date = vac.date
--WHERE dea.continent is not null
----order by 2,3
--)

-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255), 
Location nvarchar(255), 
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations AS bigint)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingPeopleVaccinated
FROM ProjectPortfolio..CovidDeaths AS dea
JOIN ProjectPortfolio..CovidVaccinations AS vac
	ON dea.location = vac.location
	and dea.date = vac.date
--WHERE dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations AS bigint)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingPeopleVaccinated
FROM ProjectPortfolio..CovidDeaths AS dea
JOIN ProjectPortfolio..CovidVaccinations AS vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
-- order by 2,3


Select *
From PercentPopulationVaccinated