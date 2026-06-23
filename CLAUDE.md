# CLAUDE.md — SPF (Second Principles Framework)

> **General instructions:** see the workspace-root `CLAUDE.md` (`~/IWE/CLAUDE.md`)
>
> This file contains only specifics of this repository.

---

## 1. Repository type

**Framework** — second principles framework (form + process for Packs).

**Source-of-truth:** Yes (for the SPF specification).

---

## 2. What is SPF

**SPF (Second Principles Framework)** defines:
- **Form** — canonical Pack structure
- **Process** — how to create and evolve a Pack
- **Contracts** — link between source-of-truth and downstream

SPF **does NOT define** domain content — only form and process.

---

## 3. Hierarchy

```
FPF (Level 1)   →  First Principles Framework (meta-ontology)
       ↓                   ↑ upstream
SPF (Level 2)   →  YOU ARE HERE (form + process)
       ↓                   ↓ downstream
Pack            →  (downstream pack repositories)
```

---

## 3.1. Working with FPF

**Local path:** `~/IWE/FPF/FPF-Spec.md` (4.6 MB, ~50000 lines)

**When to read FPF while working with SPF:**
- When clarifying base distinctions (A.7: Role ≠ Method ≠ Work)
- When working with Bounded Context (A.1.1)
- When verifying process correctness (B.4: Evolution Loop, B.5: Reasoning Cycle)
- When working with SoTA (FPF Part G: SoTA Kit)
- When terminology is unclear (FPF Part F: UTS, Bridges)

**How to read the large FPF file:**
1. Do NOT read it in full — the file is too large
2. First read the table of contents (first 200 lines) — understand the structure
3. Search for specific patterns via Grep: `A.7`, `B.5`, `Part G`
4. Read only the needed section

**FPF structure (for navigation):**

| Part | Content | When needed |
|------|---------|-------------|
| **A** | Kernel: Holon, BoundedContext, Role-Method-Work | Base distinctions |
| **B** | Aggregation (Γ), Trust (F-G-R), Evolution Loop | Processes, trust |
| **C** | Domain extensions: Sys-CAL, KD-CAL, NQD-CAL | Extensions |
| **D** | Ethics & Conflict | Ethics |
| **E** | Constitution & Authoring | Authoring rules |
| **F** | Terminology: UTS, Bridges | Terminology |
| **G** | SoTA Kit | Working with SoTA |

**Updating FPF:** `cd ~/IWE/FPF && git pull`

---

## 4. Repository structure

```
SPF/
├── docs/               # Conceptual documentation
│   ├── conceptual-model.md
│   └── fpf-spf-pack.md   # Full conceptual model
├── process/            # Pack creation process
│   ├── 00-process-overview.md
│   ├── 01-domain-selection.md
│   ├── 02-bounded-context.md
│   ├── 03-distinctions-work.md
│   ├── ...
│   ├── process-lint.md
│   └── material-ingestion-protocol.md
├── spec/               # Specifications
│   ├── ai-view.md
│   ├── downstream-contract.md
│   ├── human-guides.md
│   ├── SPF.SPEC.001-entity-coding.md
│   ├── SPF.SPEC.003-pack-scalability.md
│   └── SPF.SPEC.004-service-clauses.md  # SC vs UC distinction
└── pack-template/      # Pack structure template
    ├── 00-pack-manifest.md
    ├── 01-domain-contract/
    ├── 02-domain-entities/
    ├── 03-methods/
    ├── 04-work-products/
    ├── 05-failure-modes/
    ├── 06-sota/
    ├── 07-map/
    └── 08-service-clauses/  # User-facing promises (SC)
```

---

## 5. Hard Bans

### 5.1 Didactics ban
**BANNED in SPF and Pack:** "step", "lesson", "in N days", "implement", "first/then", "exercise", "module", "week 1"

**REASON:** Didactics is downstream. Pack captures **what exists**, not **how to teach**.

### 5.2 Domain content ban in SPF
**SPF defines form**, not content. Content belongs in Packs.

### 5.3 Entity type confusion ban (FPF A.7: Strict Distinction)

| ❌ Confusion | ✅ Distinction | FPF code |
|-------------|---------------|----------|
| Method = Tool | Method — way of acting, tool — means | A.3.1, A.3.2 |
| Method = Scenario | Method — what, scenario — step-by-step how | A.3.1 |
| Work Product = Description | WP — artifact, description — narrative | A.7 |
| System = Episteme | System — physical entity, episteme — knowledge domain | A.1 |
| Role = Actor | Role — function, actor — performer | A.2 |
| Object = Description = Carrier | Object ≠ description ≠ carrier | A.7 |

---

## 6. Claude's role in SPF

### 6.1. What Claude DOES

| Role | Description |
|------|-------------|
| **Spec Guardian** | Ensures compliance with SPF specifications |
| **Process Guide** | Helps follow the Pack creation process |
| **Template Maintainer** | Keeps templates up to date |
| **Lint Runner** | Checks correctness of changes |

### 6.2. What Claude does NOT do

- ~~Domain Expert~~ — does not determine what is true in a domain
- ~~Content Creator~~ — does not generate knowledge from nothing
- ~~Downstream Builder~~ — courses/code belong to other repos

---

## 7. Key documents

| Document | Path | Description |
|----------|------|-------------|
| Conceptual model (brief) | `docs/conceptual-model.md` | FPF → SPF → Pack → Downstream |
| Conceptual model (full) | `docs/fpf-spf-pack.md` | Detailed description of the full architecture |
| Process overview | `process/00-process-overview.md` | Process overview |
| Process lint | `process/process-lint.md` | Validation rules |
| Downstream contract | `spec/downstream-contract.md` | Contract with downstream |
| F-G-R Trust (opt.) | `spec/f-g-r-trust.md` | FPF B.3 — trust pattern |
| Pack template | `pack-template/` | Canonical Pack structure |

---

## 8. Procedures

### 8.1 Changing an SPF specification

1. Identify which spec is affected (`spec/`, `process/`, `pack-template/`)
2. Check whether the change will break existing Packs
3. Update the specification
4. Update `process-lint.md` if needed
5. Notify downstream (Pack repositories)

### 8.2 Changing pack-template

1. Changes must be backwards-compatible
2. If breaking change — Pack migration is required
3. Update `spec/SPF.SPEC.001-entity-coding.md` if IDs are affected

---

## 9. Pre-Commit Checklist

- [ ] Changes do not add domain content
- [ ] Changes do not add didactics
- [ ] Changes are backwards-compatible (or breaking change is documented)
- [ ] `process-lint.md` is updated if needed
- [ ] References are valid

---

## 10. Relationships with other repositories

| Repository | Relationship |
|------------|-------------|
| ailev/FPF | Upstream — SPF follows FPF |
| Pack repositories | Downstream — Pack follows SPF |
