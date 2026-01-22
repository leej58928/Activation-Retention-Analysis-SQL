-- Purpose:
-- Label users as activated based on early engagement:
-- Activated = (core_events_7d >= 1) AND (active_days_7d >= 2)

CREATE OR REPLACE VIEW `sql_activation_retention.v_activation_labels` AS

WITH base_users AS (
  SELECT
    u.user_id AS user_id,
    DATE(u.signup_date) AS signup_date
  FROM `sql_activation_retention.users` AS u
),
joined AS (
  SELECT
    bu.user_id AS user_id,
    bu.signup_date AS signup_date,
    COALESCE(em.core_events, 0) AS core_events_7d,
    COALESCE(em.active_days_7d, 0) AS active_days_7d
  FROM base_users AS bu
  LEFT JOIN `sql_activation_retention.v_user_early_metrics_7d` AS em
    ON bu.user_id = em.user_id
)

SELECT
  user_id,
  signup_date,
  core_events_7d,
  active_days_7d,
  IF(core_events_7d >= 1 AND active_days_7d >= 2, 1, 0) AS is_activated
FROM joined
ORDER BY user_id;
