ALTER TABLE [dbo].[Covid_19_Study] ALTER COLUMN [new_cases] FLOAT;
ALTER TABLE [dbo].[Covid_19_Study] ALTER COLUMN [total_cases] FLOAT;
ALTER TABLE [dbo].[Covid_19_Study] ALTER COLUMN [population] FLOAT;
DELETE FROM [dbo].[Covid_19_Study] WHERE [iso_code] LIKE 'OWID%';
UPDATE [dbo].[Covid_19_Study] SET [total_cases] = 1 WHERE [location] = 'Sudan' AND [date] = '2020-03-13';
ALTER TABLE [dbo].[Covid_19_Study] ALTER COLUMN [total_deaths] FLOAT;



SELECT
	[continent],
	[location],
	[date],
	[total_cases],
	[new_cases],
	([new_cases]-LAG([new_cases], 1, 0) OVER(PARTITION BY [location] ORDER BY [location], [date] ASC)) AS new_case_rate,
	[population],
	([total_cases]/[population]*100) AS infected_percent
FROM
	[dbo].[Covid_19_Study]
ORDER BY
	[location], [date];



SELECT
	[continent],
	[location],
	[date],
	[total_cases],
	[total_deaths],
	[new_deaths],
	([total_deaths]/NULLIF([total_cases],0)*100) AS fatality_percent,
	[population],
	([total_deaths]/[population]*100) AS death_percent
FROM
	[dbo].[Covid_19_Study]
ORDER BY
	[location],[date];



SELECT
	[continent],
	[location],
	[date],
	[total_vaccinations],
	[new_vaccinations],
	[total_boosters],
	[people_fully_vaccinated],
	[population],
	([total_vaccinations]/[population]*100) AS vaccinated_percent
FROM
	[dbo].[Covid_19_Study]
ORDER BY
	[location],[date];

