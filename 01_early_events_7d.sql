-- Purpose:
-- Identify events that occurred within the first 7 days after user signup (day 0 to day 6).
-- This view is the foundation for early activation metrics.

CREATE OR REPLACE VIEW `sql_activation_retention.v_early_events_7d` AS

WITH user_events AS (
  SELECT
    u.user_id AS user_id,
    DATE(u.signup_date) AS signup_date,
    e.event_time AS event_date,          -- events.event_time is DATE
    e.event_type AS event_type
  FROM `sql_activation_retention.users` AS u
  LEFT JOIN `sql_activation_retention.events` AS e
    ON u.user_id = e.user_id
)

SELECT
  user_id,
  signup_date,
  event_date,
  event_type
FROM user_events
WHERE event_date IS NOT NULL
  AND event_date BETWEEN signup_date AND DATE_ADD(signup_date, INTERVAL 6 DAY);
