# Some GitHub notes

Jump to
- [GH CLI](#gh-cli)
- [GitHub Actions](#github-actions)
- [GitHub Runners](#github-runners)
- [Audit Log](#audit-log)

---
## GH CLI

- GH CLI multi-account switch https://gist.github.com/yermulnik/017837c01879ed3c7489cc7cf749ae47


---
## GitHub Actions

For GitHub Actions
- OpenID Configuration URI https://token.actions.githubusercontent.com/.well-known/openid-configuration
- Json Web Key Service URI https://token.actions.githubusercontent.com/.well-known/jwks


---
## GitHub Runners
- Software difference between Ubuntu 20 and Ubuntu 22  https://github.com/actions/runner-images/issues/5490
- GitHub runner supported
    - Go version https://raw.githubusercontent.com/actions/go-versions/main/versions-manifest.json
    - Python version https://raw.githubusercontent.com/actions/python-versions/main/versions-manifest.json


---
## Audit Log

For [Audit Log](https://docs.github.com/en/enterprise-cloud@latest/admin/monitoring-activity-in-your-enterprise/reviewing-audit-logs-for-your-enterprise/streaming-the-audit-log-for-your-enterprise#setting-up-streaming-to-s3-with-openid-connect)
- OpenID Configuration URI https://oidc-configuration.audit-log.githubusercontent.com/.well-known/openid-configuration
- Json Web Key Service URI https://oidc-configuration.audit-log.githubusercontent.com/.well-known/jwks
