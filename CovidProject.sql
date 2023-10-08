select *
from CovidDeaths
where continent is not null
order by 3,4



--Select Data what we are going to be using 
select continent,date,total_cases,new_cases,total_deaths, population
from CovidDeaths
where continent is not null
order by 1,2

--Looking at Total Cases v Total Deaths
--Shows likelihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage
from CovidDeaths
where location like '%states'
and continent is not null
order by 1,2

--Looking at Total Cases vs Population
--Shows what percentage of population got COVID

select location,date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from CovidDeaths
where location like '%states'
and continent is not null
order by 1,2

--Looking at countries with Highest Infection Rate compared to population
select location, population, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as PercentPopulationInfected 
from CovidDeaths
group by location,population
order by 1,2

--Showing countries with highest Death count per population
select location, max(cast (total_deaths as int)) as TotalDeath 
from CovidDeaths
where continent is not null
group by location
order by TotalDeath desc



--Let's break things down by continent


--showing continents with the highest death count per population

select continent , max(cast (total_deaths as int)) as TotalDeath 
from CovidDeaths
where continent is not null
group by continent
order by TotalDeath desc


-- Global numbers
select  sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(New_deaths as int))/Sum(new_cases)*100 as DeathPercentage 
from CovidDeaths
where continent is not null
--group by date
order by 1,2

--Looking at Total Population vs Vaccinations
With PopvsVacc (continent, location,date,population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations, sum(cast(vacc.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from CovidDeaths as dea
join CovidVaccinations as vacc
on dea.location=vacc.location and dea.date=vacc.date
where dea.continent is not null)
--order by 2,3)

select*, (RollingPeopleVaccinated/population)*100
from PopvsVacc


--Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations, sum(cast(vacc.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from CovidDeaths as dea
join CovidVaccinations as vacc
on dea.location=vacc.location and dea.date=vacc.date
where dea.continent is not null
--order by 2,3)

select*
from PercentPopulationVaccinated


























