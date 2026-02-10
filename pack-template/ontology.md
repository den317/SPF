# Ontology: [Domain Name]

> Domain ontology per SPF.SPEC.002.
> Complete registry of entity types, key terms, and relationships for this Pack.
> Each concept MUST link to a parent concept from SPF base ontology (SPF.SPEC.002, Section 2).

---

## 1. Entity Types

> All entity types used in this Pack: base (from SPF) + extended (defined by this Pack).
> **Mandatory column "FPF/SPF Concept"** — parent concept from SPF base ontology.

| Code | Type | FPF/SPF Concept | Definition | ≠ (what it is NOT) | Source |
|------|------|-----------------|------------|---------------------|--------|
| `M` | Method | U.Method | _TBD_ | ≠ scenario, ≠ tool | SPF (base) |
| `WP` | Work Product | U.Work + U.Episteme | _TBD_ | ≠ method description | SPF (base) |
| `FM` | Failure Mode | — (SPF-specific) | _TBD_ | ≠ code bug | SPF (base) |
| `D` | Distinction | A.7 Strict Distinction | _TBD_ | ≠ fact, ≠ definition | SPF (base) |
| `R` | Role | U.RoleAssignment | _TBD_ | ≠ person, ≠ job title | SPF (base) |
| `CHR` | Characteristic | U.Characteristic | _TBD_ | ≠ metric, ≠ indicator | SPF (base) |
| `SOTA` | SoTA Annotation | — (SPF-specific) | _TBD_ | ≠ literature review | SPF (base) |
| `MAP` | Map | U.Episteme | _TBD_ | ≠ content | SPF (base) |
| _`EXT`_ | _Extended Type_ | _{U.* concept}_ | _TBD_ | _TBD_ | Pack (extended) |

---

## 2. Domain Glossary

> Key domain terms with definitions. Only terms essential for understanding this domain.
> **Mandatory column "Parent Concept (SPF)"** — which universal concept from SPF base ontology this term belongs to.

| Term | Definition | Parent Concept (SPF) | Related entity |
|------|-----------|---------------------|----------------|
| _Term 1_ | _Definition (1-2 sentences)_ | _U.System / U.Method / ..._ | _DOMAIN.XXX.NNN_ |
| _Term 2_ | _Definition_ | _U.*_ | — |

---

## 3. Relationships Between Types

> How entity types relate to each other in this domain.

| Subject | Relationship | Object | Example |
|---------|-------------|--------|---------|
| Method | produces → | Work Product | _DOMAIN.M.001 → DOMAIN.WP.001_ |
| Failure Mode | violates ← | Method | _DOMAIN.FM.001 ← DOMAIN.M.001_ |
| _Extended type_ | _relationship_ | _type_ | _example_ |

---

## 4. Type Hierarchy (optional)

> If types have subtypes or specializations, document here.

```
Base Type
├── Subtype A
└── Subtype B
```

---

## 5. Cross-Pack Terms (optional)

> Terms shared with or borrowed from other Packs.

| This Pack's term | Related Pack | Term there |
|-----------------|-------------|------------|
| _Term_ | _Pack ID_ | _Term/entity_ |

---

_Ontology per SPF.SPEC.002. Pack ID: [ID]_
