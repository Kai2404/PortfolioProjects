-- How many accidents have occured in urban areas versus rural areas?

select count(distinct AccidentIndex) as number_of_car_accidents, area
from accident
group by Area
order by number_of_car_accidents desc

-- What day of the week has the hughest number of accidents?

select day, count(distinct AccidentIndex) as number_of_car_accidents
from accident
group by day
order by number_of_car_accidents desc

-- What is the average age of vehicles involved in accidents based on their type?

select avg(AgeVehicle) as Average_Age, count(AccidentIndex) as number_of_car_accidents,   VehicleType
from vehicle
where 
AgeVehicle is not null 
group by VehicleType
order by number_of_car_accidents desc

-- Can we identify any trends in accidents based on the age of vehicles involved?

select count(AccidentIndex) as Total_Accidents, avg(AgeVehicle) as Average_Age,AgeGroup
from (
select AccidentIndex, AgeVehicle,
case
	when AgeVehicle between 0 and 5 then 'New' 
	when AgeVehicle between 6 and 10 then 'Regular'
	else 'Old'
end as AgeGroup
from vehicle)as SubQuery
group by AgeGroup

-- Are there any specific weather conditions that contribute to severe accidents?
Declare @severity varchar(100)
set @severity = 'Fatal'
select  count(severity) as Total_Accidents, WeatherConditions
from accident
where Severity = @severity
group by WeatherConditions
order by Total_Accidents desc

-- Do accidents often involve impacts on the left-hand side of vehicles?
select count(AccidentIndex) as Total_Accidents, LeftHand
from vehicle
group by LeftHand
having LeftHand is not null 
order by Total_Accidents desc

-- Are there any relationships between journey purposes and the severity of accidents?
--declare @severity varchar(100)
--set @severity = 'Fatal'
select count(severity) as Total_Accidents, JourneyPurpose,
case when count(severity) between 0 and 1000 then 'Low'
	when count(severity) between 1001 and 3000 then 'Moderate'
	else 'High'
	end as 'Level'
from accident as acc
inner join vehicle as veh on acc.AccidentIndex=veh.AccidentIndex

--where Severity = @severity
group by JourneyPurpose
order by Total_Accidents desc

-- Calculate the average age of vehicles involved in accidents, considering Day light and point of impact
Declare @LightConditions varchar (100)
set @LightConditions = 'Darkness'
Declare @PointImpact varchar (100)
set @PointImpact = 'Offside'
select avg(veh.AgeVehicle) as Average_Year, LightConditions, PointImpact
from accident as acc
inner join vehicle as veh on acc.AccidentIndex=veh.AccidentIndex
where LightConditions=@LightConditions and PointImpact=@PointImpact
Group by LightConditions, PointImpact











