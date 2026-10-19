# Software Requirements Specification (SRS)

## 1. Purpose
This document specifies the requirements, scope, threat modeling frameworks, and mathematical validation criteria for the **REA Security Threat Monograph & Audit Framework**. The framework serves as an authoritative cybersecurity research platform designed to dissect, measure, and publicly expose the architectural vulnerabilities, host execution risks, and legal implications of viral AI-driven reverse-engineering tooling (specifically `morluto/rea` and `rea-agents`).

## 2. Scope
The scope of this research covers:
- Complete architectural decomposition of REA's inward-flowing dependency model and provider adapters (Ghidra, Hopper, IDA Pro, JADX, radare2).
- Quantitative threat modeling across all 130+ exposed MCP tools and IPC channels using STRIDE and the Manadhata-Wing Attack Surface Metric.
- First-principles mathematical derivations of binary entropy, control-flow graph complexity, Bayesian kill-chain probabilities, and adversarial token optimization.
- Modeling the attack vector of Indirect Prompt Injection (IPI) embedded in binary string tables.
- Synthetic case study simulation demonstrating the end-to-end telemetry of host credential theft without attacking third-party production systems.
- Statutory legal and compliance evaluation under international and Indian cybersecurity statutes.
- Architectural design of a Zero-Trust microVM containment standard.

## 3. Requirements

### 3.1 Functional Requirements
- **FR-01 (Architectural Mapping):** The framework shall map every layer of REA's MCP daemon, including JSON-RPC transport, loopback TCP bindings on Windows, Unix domain sockets on POSIX, and capability token validation.
- **FR-02 (STRIDE Threat Matrix):** The framework shall produce a comprehensive STRIDE matrix enumerating threats for Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, and Elevation of Privilege across the REA stack.
- **FR-03 (Mathematical Derivations):** The framework shall provide closed-form mathematical equations and proofs for Shannon Entropy $H(X)$, Manadhata-Wing Attack Surface Metric $\langle M,C,D \rangle$, McCabe Cyclomatic Complexity $V(G)$, Bayesian Kill-Chain Posterior $P(\text{KillChain})$, and GCG adversarial token optimization.
- **FR-04 (Synthetic Case Study Telemetry):** The framework shall provide a realistic, synthetic application trace (`SyntheticFinTechApp`) modeling decompilation artifacts, string pool extraction, context injection, and process tree propagation.
- **FR-05 (Supply Chain Audit):** The framework shall document the risks of unpinned `npx` execution, lifecycle hooks in `package.json`, and typosquatted GitHub forks.
- **FR-06 (Regulatory Mapping):** The framework shall map statutory liabilities under US DMCA § 1201, CFAA, Indian IT Act 2000 (§ 43 & § 66), and Indian DPDP Act 2023.

### 3.2 Non-Functional Requirements
- **NFR-01 (Safety & Ethical Containment):** Under no circumstances shall the framework generate actionable exploits, functional weaponized payloads, or target live third-party applications.
- **NFR-02 (Mathematical Rigor):** Every quantitative assertion must be mathematically justified from first principles without arbitrary heuristics.
- **NFR-03 (Documentation Integrity):** The repository must strictly adhere to the five canonical root files standard specified in Rule 11.
- **NFR-04 (Zero Inline Narrative Comments):** All illustrative scripts or code templates must follow Level 2.2 Docstrings-Only standards.

## 4. System Architecture
The research system models the interaction between three decoupled environments:
1. **The Attacker Surface:** Weaponized binaries, poisoned npm packages, and malicious GitHub forks.
2. **The Vulnerable Execution Layer:** The REA MCP daemon running with host user permissions, invoking local disassemblers and exposing loopback ports.
3. **The Compromised Reasoning Layer:** The AI coding agent ingesting untrusted binary data and issuing tool calls against the host OS.
4. **The Target Workstation:** Host filesystem (`~/.ssh`, `~/.aws`, `.env`), browser credential databases, and network adapters.

## 5. Data Model
The research framework formalizes data assets into four sensitivity tiers:
- **Tier 0 (Public Context):** Disassembled opcodes, instruction mnemonics, and open-source documentation.
- **Tier 1 (Intermediate Artifacts):** P-Code ASTs, decompiled C pseudocode, and symbol tables.
- **Tier 2 (High-Risk Tokens):** Per-session loopback capability tokens and MCP JSON-RPC messages.
- **Tier 3 (Host Secrets):** User SSH private keys, cloud access keys, database credentials, and session cookies.

## 6. Verification & Validation
- **VV-01:** CVSS v4.0 vector verification producing a base score of 9.3 (Critical).
- **VV-02:** Shannon entropy distribution verification across benign vs packed binary sections.
- **VV-03:** Validation of Manadhata-Wing metric indicating a 1005x attack surface expansion.
- **VV-04:** Legal cross-check against published legal precedents (Sega v. Accolade, Sony v. Connectix) demonstrating clean-room protocol failure.
