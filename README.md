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
├── ROCAP_Figures/
│   ├── BlackSuit Ransomware Campaign simplified.jpg
│   ├── Long-Term Espionage Scenario.jpg
│   ├── ROCAP Attack Planning Attack Dependency Sub-Ontology.jpg
│   ├── ROCAP Attack Planning Sub-Ontology.jpg
│   └── ROCAP Cybersecurity Risk Asessment Sub-Ontology.jpg
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

## `ROCAP_Figures/`

Contains the images of the ROCAP models.

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

The OWL ontology can be opened using ontology engineering tools such as Protégé

---

## Prolog Reasoning

To execute the Prolog queries, ensure that both files are located in the same directory.
Open a terminal, launch SWI-Prolog, and load the ontology with:

```prolog
?- [rocap].
```

Once loaded, the queries can be executed directly. Example queries are provided at the end of the blacksuit_and_espionage_example.pl file.
