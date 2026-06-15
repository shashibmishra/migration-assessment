# Alert Escalation Playbook

Purpose: provide quick-run instructions when an alert fires and requires escalation.

1. Triage
  - Check Grafana dashboard `Sample App - Cluster Overview`.
  - Inspect Prometheus alert details and last evaluation.

2. Initial actions
  - If `High5xxRate`: check application logs, recent deployments, and upstream dependencies.
  - If `NodeHighCPU` or `NodeLowMemory`: drain node if needed and scale nodepool.
  - If `KubeAPIDown`: check control plane status in Azure and control plane metrics.

3. Notify
  - Post summary to the alerts channel and tag on-call.
  - Include runbook link and relevant dashboard links.

4. Escalate
  - If unresolved after 15 minutes, escalate to the platform on-call and provide actions taken.

5. Post-incident
  - Create incident ticket, capture timeline, and run a post-mortem.
