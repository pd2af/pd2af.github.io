---
layout: hidden
title: Conversion rules (working draft)
permalink: /pd2af/rules/
hidden: true
sitemap: false
---

# Conversion rules, working draft

Our rules for converting SBGN Process Description maps to Activity Flow and then to Boolean models, each with its
options, compared with CaSQ, the PD2AF 1.0 specification and pd2af 0.1.0 (Rougny). A draft: no option is final.

Each rule: the PD pattern (or the AF statement, for B rules), the options with what each costs, the option in use,
the status, the cases that test it. Status: **open** (no option chosen), **proposed** (an
option in use, not yet decided by the user), **decided** (user, date). Names of other systems' rules in brackets:
spec = the pd2af specification (https://pd2af.github.io/specification/), CaSQ 1.4.4, pd2af 0.1.0 (Rougny).

All rules are proposed or open as of 2026-11-02; the first case is the PGE2 loop of the eicosanoid atlas. Our engine applies them and switches one option at a time.

## Layer 1: PD to Activity Flow

**P1. Which entities are activities.**
- a. Every molecule in the PD is an activity; a state gets its own activity only if it has its own role (user,
  2026-11-02, as in "AF, all molecules"). Keeps metabolic chains (PGE2) and their loops.
- b. Only an entity with an activity in the PD's context is one (spec, AE-* rules). Depends on the context (module or
  assembled network, spec question 2).
- c. Small molecules are not activities (pd2af 0.1.0 default). Loses every metabolite loop; credits a transporter with
  what the metabolite did (case 1, 2).
- In use: a. Status: proposed (user's principle, 2026-11-02). Cases: 1, 2, 5, 12.

**P2. Catalysed conversion, A to B by C.**
- a. AND(A, C) to B (spec M-CAT-M).
- In use: a. Status: proposed. Case: 1.

**P3. Transport of one molecule between two compartments.**
- a. AND(source, transporter) to target (spec TRANS-STI). With export and uptake of one pool this is a two-node cycle,
  so the molecule never falls (criterion 1).
- b. Uptake into a pool its product leaves is removal: the uptake goes into the product only (AND(PGE2 outside,
  SLCO2A1, HPGD) to 15-keto-PGE2), not back to the source pool.
- c. Split the pool into two glyphs. Set aside (2026-11-02): one molecule in one compartment is one entity for the
  converter (identity, state, compartment, class), so the split would not survive the reading.
- In use: b. Status: open (b needs a test that tells "a pool its product leaves" from an ordinary transport). Case: 2.
- Tried (PGE2 loop): a keeps PGE2 on for good once made, even with COX-2 blocked (the cycle); b gives the hand behaviour.

**P4. Regulated removal (degradation, hydrolysis, catalysed inactivation).**
- a. Negative influence from the remover to what it removes (spec A-CAT-SS, A-CAT-I).
- b. Lost (CaSQ never reads consumption; pd2af 0.1.0 loses it when the target is a small molecule).
- In use: a. Status: proposed. Case: 3.
- Tried (PGE2 loop): b leaves cAMP on during LPS although LPS induces PDE4B, so the loop runs when it should not. A removal is a conversion whose product has no further role (AMP, 15-keto-PGE2); a conversion along a chain (PGH2 to PGE2) is not one.

**P5. Modification cycle, A to A-P by a kinase, back by a phosphatase.**
- a. One activity A; kinase positive, phosphatase negative (spec, pd2af 0.1.0).
- b. Two activities A and A-P (CaSQ; the spec's MR003 example, RAF1 and RAF1-P; the spec's AE-CONS read literally,
  spec question 1). Breaks the cycle in CaSQ: resting form off at the first update, never phosphorylated.
- In use: a. Status: proposed. Case: 5.
- Tried (PGE2 loop): b (two activities, as CaSQ) never phosphorylates CREB: the loop cannot close after LPS.

**P6. Logic of what makes one entity.**
- a. Separate processes making one entity: OR. One process with an AND gate or a complex formed: AND.
- In use: a. Status: proposed. Case: 6.

**P7. Two logic gates on one process.**
- a. Not allowed in a map: drawn as two processes (map side, a model-ready rule to propose).
- b. Read as OR of the two gates.
- c. ANDed (CaSQ, its own FIXME). Wrong.
- In use: a. Status: open. Case: 7.

**P8. Several catalysts on one process.**
- a. OR (CaSQ, any catalyst suffices).
- b. AND.
- c. OR by default, AND only where drawn as a complex (model-ready R4).
- In use: c. Status: open (spec question 3). Case: 8.

**P9. Association, ligand binds receptor.**
- a. The complex is the activity, AND(ligand, receptor) to complex (spec COMPL-AS).
- b. The receptor's activity, positively influenced by the ligand; the receptor taken as present.
- In use: b. Status: open (a and b give the same Boolean result when the receptor is constant). Case: 9.
- Tried (PGE2 loop): a and b behave the same; b drops the receptor as a constant, which C2 then counts as carried by the complex.

**P10. Dissociation releasing an active subunit from an inhibitory one (PKA: cAMP frees the catalytic subunit).**
- a. AND, then dissociation to both parts (spec). Loses the inhibitory role of the regulatory subunit.
- b. The inhibitory subunit inhibits the active one; the ligand inhibits the inhibitory subunit (ours, Activity Flow with all molecules).
- c. Skip to the released subunit (pd2af 0.1.0: cAMP to PRKACA).
- In use: b. Status: proposed. Case: 10.
- Tried (PGE2 loop): a and b behave the same in the scenarios; b keeps PRKAR1A as an activity, so a knockout of the regulatory subunit can be expressed.

**P11. Uncatalysed inactivation (an active receptor complex becomes desensitised).**
- a. Negative influence of the entity on itself through a delay (ours: EP4 inhibits itself after a delay).
- b. Not converted (CaSQ, spec: no case).
- In use: a. Status: open (Boolean oscillation to note, model-ready R10). Case: 11.
- Tried (PGE2 loop): b leaves EP4 on throughout LPS (no desensitisation).

**P12. Currency metabolites (ATP, NAD+, H2O, CO2).**
- a. Dropped by a fixed list (spec CURM).
- b. Currency is a role in a reaction, not a molecule: dropped where it is a cofactor, kept where it is the substrate
  (ATP in adenylate cyclase).
- In use: b. Status: proposed (needs the list of roles, spec question 4). Case: 12.
- Tried (PGE2 loop): no difference (ATP is the only reactant of adenylate cyclase, kept under both).

**P13. Competition for a substrate (AA taken by COX and by 5-LOX).**
- a. Hidden inhibition: negative influence between the competing branches (spec HIDINH).
- b. Not expressed.
- c. a only where the precursor is scarce, b where it is abundant (needs a criterion and a field in the map).
- In use: b. Status: open. Case: 13.

**P14. Transcription and translation.**
- a. Gene to mRNA to protein, mRNA kept as its node (spec SS-TRSCR, SS-TRSL; model-ready R7). Factors through the
  AND gate with the gene.
- In use: a. Status: proposed (spec question 6: the factor case). Cases: 6, 9 (criteria).

**P15. Identity of an entity.**
- a. By annotation and compartment, not by name (criterion 8).
- In use: a. Status: proposed.

**P16. Reversible process.**
- a. AND of both sides to both (spec M-CATR-M).
- In use: none. Status: open. Case: 14.

## Checks on every conversion (user, 2026-11-02)

Not rules that make influences: tests the output must pass, reported by the engine after every run.

**C1. Nothing kept without its reason.** An entity kept as an activity because it regulates something keeps that
regulation, and the product of what it regulates stays in the output, connected. An activity left with no influence
(kept as active, its regulation dropped) is reported. Keeps a pathway's end points (the genes a pathway switches on).
Status: proposed (user). PGE2 loop: no isolated activity.

**C2. No molecule lost.** Every molecule of the PD map is carried by an activity of the output, on its own or as a
member of a complex activity (the receptor in PGE2:PTGER2). Also needed for omics data on the output. Open: a currency
molecule dropped as a cofactor (P12) would fail it, unless C2 counts it as carried by its reaction's influence.
Status: proposed (user). PGE2 loop: none lost.

## Layer 2: Activity Flow to Boolean

**B1. Combining influences on one node.**
- a. On when any positive influence is on and no negative one is (our script reading rules off an Activity Flow map); a node with negative influences only
  is on unless one of them is; gates as drawn.
- In use: a. Status: proposed.

**B2. A negative influence from a remover that is always present (HPGD, PP1).**
- a. AND NOT: keeps the target off for good (criterion 3). Wrong as a default.
- b. The remover goes into the product (15-keto-PGE2 = PGE2 and SLCO2A1 and HPGD), not into the target.
- c. Persistence: the target stays on unless the remover is absent (CREB = PRKACA or (CREB and not PP1)).
- d. Left out: the target falls when its making stops (hand rules).
- In use: b where the product is a node, c otherwise. Status: open (c against d decides whether the loop latches).
  Cases: 4, 5.
- Tried (PGE2 loop): c and d behave the same in the four scenarios (the latch after LPS comes from the loop, not from persistence of CREB); they differ only once PKA is removed with CREB on.

**B3. A negative influence from a regulated remover (PDE4B, induced with LPS).**
- a. AND NOT (hand rules, our Activity Flow version).
- In use: a. Status: proposed. Case: 3.

**B4. Always present.**
- a. Enzymes, transporters and receptors not regulated in the module are constants (1), not inputs to set.
- In use: a. Status: proposed (hand rules).

**B5. Inputs.**
- a. A node with no influence in is an input, set per scenario.
- In use: a. Status: proposed.

**B6. Delay.**
- a. A delay gate becomes a variable of its own that copies its input one step late (our script, delay gate).
- In use: a. Status: proposed. Case: 11.

## Questions on the PD2AF 1.0 specification

For the user (and for Adrien Rougny, if the user talks to him). Each answer goes to the rule named in brackets, on this page.


1. AE-CONS: an entity with a consumption arc is active. In A[S1] to A[S2], A[S1] is consumed, so is it always active,
   which splits every modified protein into two activities (as in the MR003 example, RAF1 and RAF1-P)? Or does only
   consumption in another process count? (P5, P1)
2. Active is read from the map at hand: an entity whose next step is in another module is inactive here. Is the
   context the module or the assembled network? (P1)
3. Several catalysts on one process: AND or OR? (P8)
4. The currency metabolite list (CURM): where is it, and is a role-dependent exception planned (ATP in adenylate
   cyclase, NAD+ in 15-PGDH)? (P12)
5. `hidden_inhibition_1`: the AF file has an activity C that the PD file does not (R1 in the PD). A slip in the file? (none, a file to check)
6. Transcription with a factor (gene and factor through an AND gate): the spec shows gene to mRNA only. What happens to
   the factor? (P14)
