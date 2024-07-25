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
      attribute = "labels.policyIds"
      operator = "EXACTLY_MATCHES"
      values = [ "var.policy_id"]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.workflow-Channel.id
  }
}

