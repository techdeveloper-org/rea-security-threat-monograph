# Changelog

All notable changes to the REA Security Threat Monograph will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-10-19

### Added
- Comprehensive architectural deconstruction of `morluto/rea` (Reverse Engineer Anything) and `rea-agents`.
- Exhaustive STRIDE threat modeling covering all 130+ exposed REA tools and IPC endpoints.
- First-principles mathematical proofs:
  - Shannon Information Entropy $H(X)$ for packed/malicious binary payload detection.
  - Manadhata-Wing Attack Surface Metric $\langle M, C, D \rangle$ demonstrating a 1005x attack surface expansion.
  - McCabe Cyclomatic Complexity $V(G)$ and P-Code decompiler resource exhaustion proofs.
  - Bayesian Attack Graph posterior $P(\text{KillChain})$ for multi-stage host compromise.
  - Greedy Coordinate Gradients (GCG) adversarial token optimization for Indirect Prompt Injection.
  - Formal CVSS v4.0 Cardinal Scoring (9.3 Critical).
- Defensive synthetic case study (`SyntheticFinTechApp`) illustrating exact decompiler traces, string table extraction, attention-weight hijacking, and host credential exfiltration telemetry.
- Supply chain analysis of `npx` lifecycle hooks, unpinned dependencies, and fake GitHub forks.
- Legal, regulatory, and clean-room forensic analysis under DMCA § 1201, CFAA, Indian IT Act 2000 (§ 43 & § 66), and Indian DPDP Act 2023.
- Complete Zero-Trust Developer Safety Blueprint with ephemeral microVMs (Firecracker), network egress blocking, and read-only AI agent configurations.
