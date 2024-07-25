resource "newrelic_alert_policy" "policy1" {

  name = "Browser Performance"
  incident_preference = "PER_CONDITION" # PER_POLICY is default
}


resource "newrelic_nrql_alert_condition" "Condition1" {
  account_id                     = 4438264
  policy_id                      = newrelic_alert_policy.policy1.id
  type                           = "static"
  name                           = "Average Duration"
  description                    = "Alert when transactions are taking too long"
  runbook_url                    = "https://www.example.com"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "static"
  fill_value                     = 1.0
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 120
  expiration_duration            = 120
  open_violation_on_expiration   = true
  close_violations_on_expiration = true
  slide_by                       = 30

  nrql {
    query = "SELECT average(duration) FROM BrowserInteraction where appName = 'React Application'"
  }

  critical {
    operator              = "above"
    threshold             = 4
    threshold_duration    = 300
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "above"
    threshold             = 3
    threshold_duration    = 600
    threshold_occurrences = "ALL"
  }

}


# Condition 2

resource "newrelic_nrql_alert_condition" "Condition2" {
  account_id                     = 4438264
  policy_id                      = newrelic_alert_policy.policy1.id
  type                           = "static"
  name                           = "Backend Duration"
  description                    = "Alert when backend durations are taking too long"
  runbook_url                    = "https://www.example.com"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "static"
  fill_value                     = 1.0
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 120
  expiration_duration            = 120
  open_violation_on_expiration   = true
  close_violations_on_expiration = true
  slide_by                       = 30

  nrql {
    query = "SELECT average(backendDuration) from PageView where appName = 'React Application'"
  }

  critical {
    operator              = "above"
    threshold             = 5
    threshold_duration    = 300
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "above"
    threshold             = 4
    threshold_duration    = 600
    threshold_occurrences = "ALL"
  }

}