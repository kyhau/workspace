# Tooling

- [maltrail](https://github.com/stamparm/maltrail)
    - Maltrail is a malicious traffic detection system, utilizing publicly available (black)lists containing malicious and/or generally suspicious trails, along with static trails compiled from various AV reports and custom user defined lists, where trail can be anything from domain name (e.g. zvpprsensinaix.com for Banjori malware), URL (e.g. hXXp://109.162.38.120/harsh02.exe for known malicious executable), IP address (e.g. 185.130.5.231 for known attacker) or HTTP User-Agent header value (e.g. sqlmap for automatic SQL injection and database takeover tool). Also, it uses (optional) advanced heuristic mechanisms that can help in discovery of unknown threats (e.g. new malware).

- [guarddog](https://github.com/DataDog/guarddog)
    - GuardDog is a CLI tool that allows to identify malicious PyPI and npm packages. It runs a set of heuristics on the package source code (through Semgrep rules) and on the package metadata.
    - GuardDog can be used to scan local or remote PyPI and npm packages using any of the available heuristics.

- [osv-scanner](https://github.com/google/osv-scanner)
    - Use OSV-Scanner to find existing vulnerabilities affecting your project's dependencies.
    - OSV-Scanner provides an officially supported frontend to the OSV database that connects a project’s list of dependencies with the vulnerabilities that affect them.
