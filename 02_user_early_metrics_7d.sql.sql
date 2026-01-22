-- Purpose:
-- Aggregate early user activity metrics within the first 7 days after signup.

CREATE OR REPLACE VIEW `sql_activation_retention.v_user_early_metrics_7d` AS

SELECT
  user_id,
  COUNT(*) AS early_events,
  COUNTIF(event_type = 'core_feature') AS core_events,
  COUNT(DISTINCT event_date) AS active_days_7d
FROM `sql_activation_retention.v_early_events_7d`
GROUP BY user_id;
