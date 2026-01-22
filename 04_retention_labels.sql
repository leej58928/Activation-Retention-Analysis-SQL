-- Purpose:
-- Label users as retained at 30 days:
-- Retained_30d = user has at least 1 event on or after (signup_date + 30 days)

CREATE OR REPLACE VIEW `sql_activation_retention.v_retention_labels` AS

WITH user_events AS (
  SELECT
    u.user_id AS user_id,
    DATE(u.signup_date) AS signup_date,
    e.event_time AS event_date          -- DATE
  FROM `sql_activation_retention.users` AS u
  LEFT JOIN `sql_activation_retention.events` AS e
    ON u.user_id = e.user_id
)

SELECT
  user_id,
  signup_date,
  IF(COUNTIF(event_date >= DATE_ADD(signup_date, INTERVAL 30 DAY)) > 0, 1, 0) AS retained_30d
FROM user_events
GROUP BY user_id, signup_date
ORDER BY user_id;
