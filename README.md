# Activation & Retention Analysis (SQL)

## Key Results

- Activated users: **65.1% 30-day retention** (175 / 269)
- Non-activated users: **25.0% retention** (183 / 731)
- Early activation is associated with a **40+ percentage point increase** in retention, making it a critical lever for improving user retention

---

## Project Overview

This project analyzes how early user activation within the first 7 days drives long-term retention.

Users who complete key activation behaviors early are significantly more likely to remain active after 30 days, highlighting activation as a critical lever for product growth.

The analysis shows that users who complete key activation behaviors early are significantly more likely to remain active after 30 days, highlighting activation as a critical driver of product retention.

---

## Business Question

Do users who complete key activation behaviors within the first 7 days show higher long-term retention?

---

## Approach

- Structured raw event data into a reusable SQL pipeline to enable consistent activation and retention measurement  
- Defined activation using both depth (core feature usage) and frequency (active days) to capture meaningful engagement  
- Evaluated whether early activation behavior leads to higher long-term retention by comparing user cohorts

---

## SQL Pipeline

The analysis is implemented as a structured set of SQL views:

1. **Early Event Window (0–6 days)**  
   Filters events within the first 7 days after signup  

2. **Early Engagement Metrics**  
   Aggregates:
   - total events  
   - core feature usage  
   - number of active days  

3. **Activation Labeling**  
   Classifies users as activated vs non-activated  

4. **Retention Labeling**  
   Identifies users active on or after Day 30  

5. **Final Summary**  
   Compares retention outcomes by activation status  

This structure reflects how analytics teams build reusable data layers to support consistent metric definitions and scalable analysis.

---

## Dashboard
![Dashboard](./dashboard.png)

The Tableau dashboard translates the SQL analysis into a business-facing view of activation and retention performance:

- Activation and retention KPIs  
- Retention differences between activated and non-activated users  
- The relationship between early engagement and retention  

---

## Product Implications

- Improve onboarding flows to drive early core feature adoption  
- Encourage repeat engagement within the first week to reinforce user habits  
- Identify and intervene on non-activated users before churn risk increases  

---

## Definitions

### Activation (First 7 Days)

A user is considered activated if both conditions are met within Day 0–6 after signup:

- At least one core feature event  
- Activity on at least two distinct days  

This definition captures both meaningful usage and repeat engagement.

---

### Retention (30 Days)

A user is considered retained if they have at least one event on or after Day 30 following signup.

---

## Dataset

Two relational tables:

**users**
- user_id  
- signup_date  

**events**
- user_id  
- event_time (DATE)  
- event_type  

Each event represents a user action within the product, including a core feature event.

---

## Tools

- SQL (BigQuery-style views, aggregations, conditional logic)  
- Tableau (dashboard visualization)  
