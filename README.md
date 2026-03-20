# Activation & Retention Analysis (SQL)

## Project Overview
This project analyzes how early user activation behavior influences 30-day retention using a structured SQL analytics pipeline.

The core product question is:

**Do users who activate early show higher long-term retention?**

Rather than running one-off queries, this project builds a reusable transformation layer that converts raw event data into activation signals and retention outcomes.

---

## Dataset
Two relational tables were used:

**users**
- user_id  
- signup_date  

**events**
- user_id  
- event_time (DATE)  
- event_type  

Each event represents a user action within the product, including a designated *core feature* event that signals meaningful engagement.

---

## Metric Definitions

### Activation (First 7 Days)
A user is considered **activated** if both conditions are met within Day 0–6 after signup:

- At least one core feature event  
- Activity on at least two distinct days  

This definition captures **both meaningful usage and repeat engagement**, avoiding one-time or superficial activity.

---

### Retention (30 Days)
A user is considered **retained at 30 days** if they have at least one event on or after Day 30 following signup.

This measures whether early engagement translates into sustained product usage.

---

## SQL Pipeline Design

The analysis is implemented as a layered set of SQL views:

1. **Early Event Window (7 Days)**  
   Filters events within the first 7 days after signup  
   → foundation for all early engagement metrics  

2. **Early Engagement Metrics**  
   Aggregates:
   - total events  
   - core feature usage  
   - number of active days  

3. **Activation Labeling**  
   Classifies users as activated vs non-activated based on defined rules  

4. **Retention Labeling**  
   Identifies users who return at or after Day 30  

5. **Activation vs Retention Summary**  
   Compares retention outcomes by activation status  

This structure reflects how analytics teams build **reusable data layers**, rather than isolated queries.

---

## Key Results

| Activation Status | Users | Retained Users | 30-Day Retention Rate |
|------------------|------|----------------|-----------------------|
| Activated        | 269  | 175            | 65.1%                |
| Not Activated    | 731  | 183            | 25.0%                |

Activated users show a **40+ percentage point higher retention rate**, indicating a strong relationship between early engagement and long-term usage.

---

## Insights & Business Implications

- Early activation is a strong predictor of long-term retention  
- Users who do not activate within the first week are significantly more likely to churn  
- The activation definition provides a clear, measurable onboarding success metric  

### Product Implications
Product teams can improve retention by:

- Designing onboarding flows that drive early core feature usage  
- Encouraging repeat engagement within the first week  
- Identifying and targeting non-activated users early  

---

## Tools
- SQL (BigQuery-style views, aggregations, conditional logic)
