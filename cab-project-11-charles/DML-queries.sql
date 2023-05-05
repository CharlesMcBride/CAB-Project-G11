SELECT solar_installations.municipality, energy_data.municipality, solar_installations.county, energy_data.county, energy_data.total_electricity, solar_installations.total_size_of_system, solar_installations.year, energy_data.year
FROM solar_installations
JOIN energy_data
ON solar_installations.municipality = energy_data.municipality AND solar_installations.county=energy_data.county AND solar_installations.year=energy_data.year;


SELECT solar_installations.municipality, solar_installations.county, solar_installations.total_size_of_system
FROM Solar_installations
GROUP BY total_size_of_system, municipality, county
ORDER BY COUNT (*) DESC
LIMIT 20;


DONE
SELECT electric_vehicles.municipality, electric_vehicles.county, electric_vehicles.number_of_evs, electric_vehicles.year, energy_data.total_electricity
FROM electric_vehicles
JOIN energy_data
ON electric_vehicles.municipality=energy_data.municipality AND  electric_vehicles.year=energy_data.year;


DONE
SELECT electric_vehicles.municipality, electric_vehicles.county, electric_vehicles.percent_of_evs, electric_vehicles.year, energy_data.total_electricity
FROM electric_vehicles
JOIN energy_data
ON electric_vehicles.municipality=energy_data.municipality, OR electric_vehicles.county=energy_data.county AND electric_vehicles.year=energy_data.year;


SELECT electric_vehicles.municipality, electric_vehicles.county,  electric_vehicles.total_personal_vehicles, electric_vehicles.percent_of_evs, electric_vehicles.year, energy_data.total_natural_gas, energy_data.total_electricity
FROM electric_vehicles
JOIN energy_data
ON electric_vehicles.municipality=energy_data.municipality AND  electric_vehicles.year=energy_data.year;


SELECT sp.municipality, sp.county, sp.year, sp.total_num_installations, sp.total_size_of_system, ed.total_electricity, ed.total_natural_gas
FROM solar_installations sp
JOIN energy_data ed
ON sp.municipality = ed.municipality AND sp.year = ed.year;
