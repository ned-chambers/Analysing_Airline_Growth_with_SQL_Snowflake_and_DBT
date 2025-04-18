# ✈️ Analysing airline growth with SQL, Snowflake and DBT

This project models and analyses commercial airline data to investigate growth patterns, passenger volumes, and fleet activity. It uses a modern data stack: data is stored and queried in **Snowflake**, modelled using **dbt Core**, and analysed interactively in **Deepnote**.

The project was completed as part of the RNCP35288 “Concepteur Développeur en Science des Données” certification at Jedha.

---

## 📌 Objectives

- Structure raw aviation data into clean, queryable models using dbt
- Analyse aircraft activity, airport passenger volume, and airline growth
- Apply modular, testable analytics engineering principles
- Communicate insights clearly to stakeholders using notebooks

---

## 🧰 Tools & technologies

- **Snowflake** – cloud data warehouse (data storage and compute)
- **dbt Core** – SQL modelling (sources, staging, dimensions, marts)
- **SQL** – data transformation, aggregation, business logic
- **Jinja** – templating logic for dbt model automation
- **Deepnote** – collaborative notebook for SQL analysis and presentation
- **Git / GitHub** – version control and documentation

---

## 🔄 Project workflow

### 🧱 1. DBT modelling phase

- Created **sources** for 4 raw tables in Snowflake
- Built **staging models** to standardise formats (e.g. dates, names, types)
- Designed **dimensional models**: `dim_aircraft`, `dim_airline`, `dim_airport`
- Developed **intermediate models** to answer business questions:
  - `int_max_asm_airlines` – ASM-based airline growth
  - `int_best_years` – Revenue Passenger Miles per airline/year
- Used **Jinja macros** and **tests** to ensure data quality and reusability

> *These dbt models served as the analytical foundation for further exploration in Deepnote.*

### 📊 2. Interactive analysis in Deepnote

- Connected Deepnote directly to Snowflake
- Re-ran and refined queries for readability and presentation
- Built visual summaries and business recommendations

---

## ❓ Business questions answered

1. **Which aircraft flew the most?**  
   → The Goose, with 1,008 flights

2. **Which airport transported the most passengers?**  
   → The Amazon Mothership (estimated via capacity × flight count)

3. **What was the best year for RPM per airline?**  
   → Varied by airline (2015–2016); nulls handled as zeroes

4. **What was the best year for growth based on ASM?**  
   → Goose Airways peaked in 2016 with the highest average ASM

---

## 💡 Key insights

- **Amazon Airlines** leads in volume but faces competition from **Flock Air** and **Goose Airways**.
- 2016 marked the peak growth year across several carriers.
- Suggested strategies include **fleet modernisation**, **loyalty programmes**, and **airport partnerships**.

---

## 🧠 What I learned

- How to structure and document a complete dbt project
- How to use `Jinja`, tests, and modular SQL for transformation layers
- How to connect BI tools like Deepnote to a cloud data warehouse
- How to adapt technical queries for clear stakeholder-facing insights

---

## 📁 Repo structure

Analysing_Airline_Growth_with_SQL_Snowflake_and_DBT/
├── dbt_project/
│   ├── models/
│   │   ├── staging/
│   │   ├── aircraft/
│   │   │   ├── dim_aircraft.sql
│   │   │   ├── dim_airline.sql
│   │   │   ├── dim_airport.sql
│   │   │   ├── int_max_asm_airlines.sql
│   │   │   └── int_best_years.sql
│   ├── macros/
│   ├── tests/
│   ├── dbt_project.yml
│   └── README.md
├── deepnote_report/
│   └── notebook_export.pdf
├── slides/
│   └── presentation.pptx
├── screenshots/
│   └── dbt_graph.png
└── README.md

---

## 📎 Notes

This project was completed independently using modern analytics engineering practices. The DBT portion was prototyped and tested before delivering the final analysis through Deepnote, for clarity and communication with non-technical stakeholders.
