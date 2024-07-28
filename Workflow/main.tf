# Notification destination
resource "newrelic_notification_destination" "workflow-destination" {
  account_id = 4438264
  name = "React-workflow-destination"
  type = "EMAIL"

  property {
    key = "email"
    value = "divpreetkaur043@gmail.com"
  }
}

#Notification Channel
resource "newrelic_notification_channel" "workflow-Channel" {
  account_id = 4438264
  name = "React-workflow-Channel"
  type = "EMAIL"
  destination_id = newrelic_notification_destination.workflow-destination.id
  product = "IINT"

  property {
    key = "subject"
    value = "Alert"
  }

  property {
    key = "customDetailsEmail"
    value = "issue id - {{issueId}}"
  }
}

# Workflow
resource "newrelic_workflow" "workflow1" {
  name = "workflow1"
  muting_rules_handling = "NOTIFY_ALL_ISSUES"

  issues_filter {
    name = "filter"
    type = "FILTER"

    predicate {
      attribute = "labels.account_id"
      operator = "EXACTLY_MATCHES"
      values = [ "var.policy_id"]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.workflow-Channel.id
  }
}

# Muting Rule
resource "newrelic_alert_muting_rule" "Muting_rule" {
    name = "Browser Muting Rule"
    enabled = true
    description = "muting rule test."
    condition {
        conditions {
            attribute   = "conditionName"
            operator    = "EQUALS"
            values      = ["Average Duration"]
        }
        
        operator = "AND"
    }
    schedule {
      start_time = "2024-07-27T12:00:00"
      end_time = "2024-07-28T16:30:00"
      time_zone = "America/Los_Angeles"
      # repeat = "WEEKLY"
      # weekly_repeat_days = ["MONDAY", "WEDNESDAY", "FRIDAY"]
      # repeat_count = 42
    }
}