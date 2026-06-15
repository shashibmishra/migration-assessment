# Alertmanager Receivers — examples & setup

This file shows example Alertmanager receiver configurations for Slack and PagerDuty and steps to wire them into Alertmanager.

1) Slack receiver example

```
receivers:
  - name: 'slack-notifications'
    slack_configs:
      - api_url: 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX'
        channel: '#alerts'
        title: '{{ template "slack.default.title" . }}'
```

Steps:
- Create a Secret in `monitoring` with your Slack webhook or store it in your secret manager and reference via templates.
- Update `observability/alertmanager/alertmanager.yml` to add the `slack-notifications` receiver and route alerts to it.

2) PagerDuty receiver example

```
receivers:
  - name: 'pagerduty'
    pagerduty_configs:
      - service_key: 'your-pagerduty-integration-key'
        severity: '{{ .CommonLabels.severity }}'
```

Steps:
- Use a secure secret for the PagerDuty integration key (Kubernetes Secret or Key Vault) and reference it in the Alertmanager config via templating or SecretRef when using the Prometheus Operator.
- Test by sending a sample alert through Promtool or firing a test alert.

Note: When deploying via the Prometheus Operator (kube-prometheus-stack), you can provide Alertmanager configuration through a `Secret` named `alertmanager-main` in the `monitoring` namespace or use the `alertmanager.config` Helm value.
