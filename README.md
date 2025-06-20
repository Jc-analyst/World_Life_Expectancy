# 🌍 World Life Expectancy Analysis with SQL

This project explores global life expectancy trends using SQL. It is based on the *Analyst Builder: MySQL for Data Analytics* course and highlights data cleaning, exploration, and analysis using real-world indicators.

## 📦 Dataset

- **CSV File**: `WorldLifeExpectancy.csv`
- **JSON File**: `WorldLifeExpectancy.json`
- The dataset includes life expectancy, GDP, development status, BMI, and adult mortality across multiple countries over several years.

## 🧹 Data Preparation

The cleaning and transformation steps were completed using SQL and include:
- Removing duplicates with `CONCAT(Country, Year)`
- Handling missing values in `Status`, `Life expectancy`, and `BMI`
- Filtering anomalies such as zero or negative values
- Ensuring data types and constraints for analysis

## 🧠 Analysis

Key queries were performed in the script:
- `World_Life_Expectacy_Script.sql`

Insights include:
- Trends in life expectancy by country and development status
- Correlations with GDP, BMI, and adult mortality
- Outlier detection and year-over-year improvements

## 📤 Output

- Cleaned and analyzed results exported as:  
  `World_life_expectancy_output.csv`

This file includes top countries by life expectancy, yearly trends, and categorical summaries.

## 📁 Repository Structure
├── data/ │ ├── WorldLifeExpectancy.csv  │ └── WorldLifeExpectancy.json  
├── scripts/ │ └── World_Life_Expectacy_Script.sql 
├── output/ │ └── World_life_expectancy_output.csv └── README.md


## 🛠️ Tools Used

- MySQL / SQL Workbench
- Git & GitHub
- Data from Analyst Builder course

## 📌 Key Takeaways

- Life expectancy rises with economic development and healthcare investment.
- Developing countries show greater volatility in trends.
- Adult mortality and BMI are strong life expectancy indicators.

---

*Project created for educational and portfolio purposes.*  
Feel free to fork or star ⭐ the repo if you find it useful!


