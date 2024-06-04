SELECT TOP (1000) [Car_Model]
      ,[Manufacturer]
      ,[Year]
      ,[Battery_Size_kWh]
      ,[Range_miles]
      ,[Power_hp]
      ,[_0_60_mph_seconds]
      ,[Top_Speed_mph]
      ,[Price_USD]
      ,[Charge_Time_hours]
      ,[Efficiency_Wh_mi]
      ,[Sales_units]
      ,[Annual_Maintenance_Cost_USD]
      ,[Warranty_Period_years]
      ,[Federal_Tax_Credit_USD]
      ,[Insurance_Cost_USD_year]
      ,[Resale_Value_USD]
      ,[Safety_Rating]
      ,[Interior_Comfort_Rating]
      ,[Technology_Rating]
  FROM [Electric_Car_Sales].[dbo].[ElectricCars]



 -- "Can you identify which electric vehicles offer the best balance between their price and the range they can travel on a single charge?"
SELECT Car_Model, 
       AVG(Price_USD) as Average_Price, 
       AVG(Range_miles) as Average_Range,
       (AVG(Range_miles) / AVG(Price_USD)) * 1000 as Value_Score
FROM ElectricCars
GROUP BY Car_Model
ORDER BY Value_Score DESC;


 --"I want a car that doesn't take too long to charge. Which models have the shortest charging time but still offer a good range?"
 SELECT Car_Model,
 FLOOR(AVG(Charge_Time_Hours)) AS Average_ChargeTime,
 FLOOR(AVG(Range_miles)) AS Average_Range,
 ROUND(AVG(Charge_Time_Hours) / AVG(Range_miles),3) As Efficiency_Score
 FROM ElectricCars
 GROUP BY Car_Model
 ORDER BY Efficiency_Score DESC,Average_ChargeTime ASC;


 --"I'm interested in the most energy-efficient cars. Which ones consume the least energy per mile?"

 SELECT Car_Model, 
       AVG(Price_USD) as Average_Price,
       AVG(Range_miles) as Average_Range,
       AVG(Efficiency_Wh_mi) as Average_Energy_Consumption,
       ROUND(AVG(Range_miles) / AVG(Efficiency_Wh_mi), 2) as Efficiency_Score
FROM ElectricCars
GROUP BY Car_Model
ORDER BY Average_Energy_Consumption ASC, Efficiency_Score DESC;


--"Resale value is important to me. Can you tell me which electric cars are expected to retain their value the best over time?"

SELECT 
    Car_Model,
    Manufacturer,
    AVG(Price_USD) as Average_Price,
    AVG(Resale_Value_USD) as Average_Resale_Value,
    (AVG(Resale_Value_USD) / AVG(Price_USD)) * 100 as Resale_Value_Percentage
FROM 
    ElectricCars
GROUP BY 
    Car_Model, Manufacturer
ORDER BY 
    Resale_Value_Percentage DESC;


--"What are the typical annual maintenance costs for these vehicles, and which models come with the longest warranty period?"
SELECT 
    Car_Model,
    Manufacturer,
    AVG(Annual_Maintenance_Cost_USD) as Average_Annual_Maintenance_Cost,
    MAX(Warranty_Period_years) as Longest_Warranty_Period
FROM 
    ElectricCars
GROUP BY 
    Car_Model, Manufacturer
ORDER BY 
    Longest_Warranty_Period DESC, Average_Annual_Maintenance_Cost ASC;
