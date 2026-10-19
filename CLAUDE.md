# CLAUDE.md - REA Security Threat Monograph

## Overview
This repository contains an exhaustive, peer-reviewed technical monograph, cybersecurity threat model, mathematical proofs, and developer awareness manifesto evaluating the severe hidden risks of viral reverse-engineering tooling—specifically `morluto/rea` (Reverse Engineer Anything) and `rea-agents`.

## Mission & Purpose
To provide empirical facts and first-principles mathematical derivations exposing why running un-sandboxed reverse-engineering MCP servers and AI-driven code cloning workflows on developer host machines causes arbitrary host code execution, credential exfiltration (`~/.ssh`, `~/.aws`, `.env`), supply chain contamination, and statutory intellectual property infringement.

## Research Standards & Governance
- **Strict Defensive Boundary:** All research, demonstrations, and case studies are purely defensive and educational. All target demonstrations use synthetic applications (`SyntheticFinTechApp`) and theoretical models. No real-world production software is targeted, and no functional weaponized exploit payloads are distributed.
- **Mathematical Rigor:** Every vulnerability is grounded in formal formulas (Shannon Entropy, Manadhata-Wing Attack Surface Metric, Bayesian Attack Graphs, GCG Token Gradients, McCabe Cyclomatic Complexity, CVSS v4.0).
- **Rule 11 Compliance:** Five canonical root files (`README.md`, `SRS.md`, `CLAUDE.md`, `VERSION`, `CHANGELOG.md`). All deep research lives in `docs/` and `case-studies/`.
- **Level 2.2 Docstrings-Only:** No conversational narrative comments in any code examples; only contract docstrings and algorithmic 'why' documentation.

## Project Structure
- `README.md`: Executive overview, monograph summary, architecture diagrams, and developer manifesto.
- `SRS.md`: Software Requirements Specification for the research framework.
- `docs/01-architecture-deep-dive.md`: REA inward-flowing architecture, 130+ tools, and IPC bridges.
- `docs/02-threat-modeling-stride.md`: Comprehensive STRIDE matrix and trust boundary decomposition.
- `docs/03-mathematical-proofs.md`: Full derivations of $H(X)$, $\langle M,C,D \rangle$, $V(G)$, GCG gradients, and CVSS v4.0.
- `docs/04-indirect-prompt-injection.md`: Mechanics of binary string table attacks and attention hijacking.
- `docs/05-supply-chain-npx-hazards.md`: `npx` lifecycle hooks, dependency depth, and trojanized forks.
- `docs/06-legal-and-cleanroom-forensics.md`: DMCA 1201, CFAA, IT Act 2000, DPDP Act 2023, clean-room failure.
- `docs/07-zero-trust-hardening-guide.md`: MicroVM sandboxing, egress firewalls, and defense-in-depth recipes.
- `case-studies/synthetic-finapp-audit.md`: End-to-end synthetic case study tracing binary decompilation to credential theft.
