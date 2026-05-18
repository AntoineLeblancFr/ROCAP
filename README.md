# ROCAP — Reference Ontology for Cybersecurity Attack Planning

## Overview

ROCAP is a theoretically-grounded and operationally-aligned Reference Ontology of Cybersecurity Attack Planning designed to bridge the structural gap in existing security ontologies. While current frameworks represent the traces or execution graphs of an intrusion (what could happen or what did happen), ROCAP formally models the attack plan as an independent intentional entity. It explicitly captures an attacker’s subjective commitment to a sequence of ordered steps before or independent of execution.

---

# Repository Structure

```text
.
├── owl/
│   └── rocap.owl
│
├── prolog/
│   ├── rocap.pl
│   └── blacksuit_and_espionage_example.pl
│
├── ROCAP.vpp
│
├── ROCAP_CQs_Traceability.xlsx
│
└── ROCAP_X_PAPO.xlsx
```

---

# Contents

## `owl/`

Contains the OWL implementation of ROCAP.

---

## `prolog/`

Contains the Prolog formalization of ROCAP and an executable example.

### Files

* `rocap.pl`
  Prolog representation of the ontology and associated reasoning rules.

* `blacksuit_and_espionage_example.pl`
  Example demonstrating how ROCAP can be instantiated and queried using Prolog.

---

## `ROCAP.vpp`

  Visual Paradigm project file representing the conceptual and modeling structure of ROCAP.

---

## `ROCAP_CQs_Traceability.xlsx`

Traceability matrix linking:

* standards extraction,
* ontology requirements,
* competency questions (CQs).

---

## `ROCAP_X_PAPO.xlsx`

Document describing the enrichment of ROCAP with PAPO.

---

# Usage

## OWL Ontology

The OWL ontology can be opened using ontology engineering tools such as:

* Protégé
* TopBraid Composer
* Any OWL-compatible semantic web framework

---

## Prolog Reasoning

To run the prolog queries, be sure to have both files next to each other.Open A terminal and launch SWI-Prolog and run: 

```prolog
?- [rocap].
```

Queries can then be executed, they can be found at then end of the blacksuit_and_espionage_example.pl file.
