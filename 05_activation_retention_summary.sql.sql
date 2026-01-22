-- Purpose:
-- Summarize 30-day retention by activation status (activated vs non-activated).

CREATE OR REPLACE VIEW `sql_activation_retention.v_activation_retention_summary` AS

SELECT 
  al.is_activated AS is_activated,
  COUNT(*) AS users,
  COUNTIF(COALESCE(rl.retained_30d, 0) = 1) AS retained_users,
  SAFE_DIVIDE(COUNTIF(COALESCE(rl.retained_30d, 0) = 1), COUNT(*)) AS retention_rate_30d
FROM `sql_activation_retention.v_activation_labels` AS al
LEFT JOIN `sql_activation_retention.v_retention_labels` AS rl
  ON al.user_id = rl.user_id
GROUP BY al.is_activated
ORDER BY al.is_activated DESC;
