select * 
from [portfolioproject].[dbo].[coviddeaths]
where continent is not null
--select * 
--from covidvaccinations
-- select data that we are going to be using
select location,date , total_cases , new_cases , population , total_deaths
from [portfolioproject].[dbo].[coviddeaths]
order by 1,2

alter table [portfolioproject].[dbo].[coviddeaths]
alter column total_deaths int
alter table [portfolioproject].[dbo].[coviddeaths]
alter column total_cases int


--looking at total cases vs population
--show what percentage of population got covid
select location,date, total_cases , population , total_deaths , (total_cases/population)*100 as cases_percentage
from [portfolioproject].[dbo].[coviddeaths]
order by 1,2

--looking at countries with highest infection rate compared to population
select  location, total_cases , population,max(total_cases) as highestinfectcount ,(total_cases/population)*100 as infectionpercentage
from [portfolioproject].[dbo].[coviddeaths]
group by location,population,total_cases
order by infectionpercentage 

--showing countries with highest death count per population
select location ,max ( total_deaths ) as highesttotaldeath
from [portfolioproject].[dbo].[coviddeaths]
where continent is not null
group by location
order by highesttotaldeath desc

--showing continents with highest death count per population
select continent ,max ( total_deaths ) as highesttotaldeath
from [portfolioproject].[dbo].[coviddeaths]
where continent is not null
group by continent
order by highesttotaldeath desc

--global numbers
select date ,sum ( new_cases ) totalcases , sum ( total_deaths ) totaldeaths ,ISNULL( sum ( total_deaths )/nullif (sum ( new_cases ),0),0) *100 as deathpercentage
from [portfolioproject].[dbo].[coviddeaths]
where continent is not null
group by date
order by date

--looking at total population vs vacination
select dea.location,dea.date,dea.population,
vac.new_vaccinations  
from [portfolioproject].[dbo].[coviddeaths]  dea
join [portfolioproject].[dbo].[covidvaccinations] vac
on dea.location = vac.location
and dea.date = vac.date
order by 2,3


  

