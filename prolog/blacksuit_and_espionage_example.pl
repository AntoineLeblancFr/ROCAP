% =====================================================================
%
% ROCA instance model -- "Fake Zoom -> BlackSuit Ransomware",
% extended with a second, long-term espionage attack plan.
% Source scenario: thedfirreport.com/2025/03/31/fake-zoom-ends-in-blacksuit-ransomware
%
% Dict shapes (tag-reference style, matching meta-model.pl):
%   object dict   Tag{classes:[ClassTag...], name:String [, attr:Value...]}
%   slot  dict    RoleTag{value:ObjectTag}
%   link  dict    Tag{assoc:AssocTag, slots:[SlotDict,SlotDict]}

% =====================================================================

:- consult('meta-model.pl').

% =====================================================================
% A. Objects
% =====================================================================

% --- Supporting assets / business asset ---
object(employee{classes: [supportingAsset, humanResource], name: "Help-desk Employee"}).
object(workstation{classes: [supportingAsset, d3fClientComputer], name: "Employee Workstation"}).
object(fileServer{classes: [supportingAsset, d3fFileServer], name: "Corporate File Server"}).
object(applicationInstaller{classes: [supportingAsset, d3fApplicationInstaller], name: "Fake Zoom Installer (SectopRAT dropper)"}).
object(itDepartment{classes: [businessAsset], name: "Corporate Data"}).
% --- Cybersecurity value components & protected subject ---
object(confidentiality{classes: [cybersecurityValueComponent], name: "Confidentiality of Corporate Data"}).
object(integrity{classes: [cybersecurityValueComponent], name: "Integrity of Corporate Data"}).
object(availability{classes: [cybersecurityValueComponent], name: "Availability of Corporate Data"}).
object(organization{classes: [protectedSubject], name: "The Organization"}).
% --- Vulnerabilities ---
object(vuln_socEng{classes: [vulnerability, humanVulnerability], name: "Employee Susceptibility to Social Engineering"}).
object(vuln_autorun{classes: [vulnerability, cweWeakness], name: "Unrestricted Autostart Execution Weakness"}).
% --- Attacks (ATT&CK techniques) ---
object(atk_driveby{classes: [attack, driveByCompromiseT1189], name: "Drive-by Compromise via Fake Zoom site"}).
object(atk_c2{classes: [attack, applicationLayerProtocolT1071], name: "C2 Channel via SectopRAT"}).
object(atk_autostart{classes: [attack, bootOrLogonAutostartExecutionT1547], name: "Persistence via Autostart Execution"}).
object(atk_procinj{classes: [attack, processInjectionT1055], name: "Process Injection into MSBuild"}).
object(atk_hidefiles{classes: [attack, hiddenFilesAndDirectoriesT1564_001], name: "Hidden Files and Directories"}).
object(atk_exclusions{classes: [attack, filePathExclusionsT1564_012], name: "Defender File/Path Exclusions"}).
object(atk_filediscovery{classes: [attack, fileAndDirectoryDiscoveryT1083], name: "File and Directory Discovery (to locate data)"}).
object(atk_filediscovery2{classes: [attack, fileAndDirectoryDiscoveryT1083], name: "File and Directory Discovery (to scope encryption)"}).
object(atk_collect{classes: [attack, dataFromLocalSystemT1005], name: "Data from Local System (ransomware staging)"}).
object(atk_archive{classes: [attack, archiveCollectedDataT1560], name: "Archive Collected Data with WinRAR"}).
object(atk_encrypt{classes: [attack, dataEncryptedForImpactT1486], name: "Data Encrypted for Impact (BlackSuit)"}).
object(atk_exfil{classes: [attack, exfiltrationOverWebServiceT1567], name: "Exfiltration to Bublup Cloud Storage"}).
object(atk_espcollect{classes: [attack, dataFromLocalSystemT1005], name: "Recurring Intelligence Collection"}).
% --- Threat actors, capabilities, attack plans ---
object(blacksuitAttacker{classes: [attacker], name: "BlackSuit Ransomware Operator"}).
object(cap01{classes: [threatCapability], name: "Ransomware Deployment and Extortion Capability"}).
object(blacksuitPlan{classes: [attackPlan], name: "BlackSuit Ransomware Campaign (Fake Zoom Vector)", likelihood: likely, steps: [atk_driveby, atk_c2, atk_autostart, atk_filediscovery, atk_collect, atk_archive, atk_encrypt]}).
object(espionageAttacker{classes: [attacker], name: "Espionage Threat Actor"}).
object(cap02{classes: [threatCapability], name: "Stealthy Long-Term Access Capability"}).
object(espionagePlan{classes: [attackPlan], name: "Long-Term Espionage Campaign", likelihood: possible, steps: [atk_driveby, atk_c2, atk_autostart, atk_espcollect]}).
% --- Closed intentions composing the BlackSuit plan ---
object(ci_foothold{classes: [closedIntention], name: "Intention: Gain Initial Foothold"}).
object(ci_persist{classes: [closedIntention], name: "Intention: Maintain Persistent Access"}).
object(ci_discover{classes: [closedIntention], name: "Intention: Locate Valuable Data"}).
object(ci_steal{classes: [closedIntention], name: "Intention: Exfiltrate Corporate Data"}).
object(ci_extort{classes: [closedIntention], name: "Intention: Extort Victim via Encryption"}).
% --- Closed intentions composing the espionage plan ---
object(ci_espFoothold{classes: [closedIntention], name: "Intention: Establish Covert Foothold"}).
object(ci_espPersist{classes: [closedIntention], name: "Intention: Maintain Covert Long-Term Access"}).
object(ci_espCollect{classes: [closedIntention], name: "Intention: Continuously Collect Intelligence"}).
% --- Loss events / loss situations ---
object(le_encrypt{classes: [lossEvent], name: "Encryption of Corporate Files"}).
object(le_exfil{classes: [lossEvent], name: "Exfiltration of Corporate Data"}).
object(ls_unavail{classes: [lossSituation], name: "Corporate Data Unavailable"}).
object(ls_disclosed{classes: [lossSituation], name: "Corporate Data Disclosed to Adversary"}).
% --- Risk & risk assessment ---
object(risk01{classes: [untreatedRisk], name: "Untreated BlackSuit Ransomware Risk", level: high}).
object(era01{classes: [experienceRiskAssessment], name: "BlackSuit Ransomware Risk Assessment", level: high}).

% =====================================================================
% B. Links
% =====================================================================


% --- Supporting assets offensively engaged by attacks ---
link(l_offensivelyEngagedBy_1{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: employee}, offensivelyEngages{value: atk_driveby}]}).
link(l_offensivelyEngagedBy_2{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: applicationInstaller}, offensivelyEngages{value: atk_driveby}]}).
link(l_offensivelyEngagedBy_3{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation}, offensivelyEngages{value: atk_driveby}]}).
link(l_offensivelyEngagedBy_4{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation}, offensivelyEngages{value: atk_c2}]}).
link(l_offensivelyEngagedBy_5{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation}, offensivelyEngages{value: atk_autostart}]}).
link(l_offensivelyEngagedBy_6{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation}, offensivelyEngages{value: atk_procinj}]}).
link(l_offensivelyEngagedBy_7{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation}, offensivelyEngages{value: atk_hidefiles}]}).
link(l_offensivelyEngagedBy_8{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation}, offensivelyEngages{value: atk_exclusions}]}).
link(l_offensivelyEngagedBy_9{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileServer}, offensivelyEngages{value: atk_filediscovery}]}).
link(l_offensivelyEngagedBy_10{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileServer}, offensivelyEngages{value: atk_filediscovery2}]}).
link(l_offensivelyEngagedBy_11{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileServer}, offensivelyEngages{value: atk_collect}]}).
link(l_offensivelyEngagedBy_12{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileServer}, offensivelyEngages{value: atk_archive}]}).
link(l_offensivelyEngagedBy_13{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileServer}, offensivelyEngages{value: atk_encrypt}]}).
link(l_offensivelyEngagedBy_14{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileServer}, offensivelyEngages{value: atk_exfil}]}).
link(l_offensivelyEngagedBy_15{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileServer}, offensivelyEngages{value: atk_espcollect}]}).

% --- Supporting assets compose the business asset ---
link(l_composes_1{assoc: composes, slots: [composes{value: employee}, composedOf{value: itDepartment}]}).
link(l_composes_2{assoc: composes, slots: [composes{value: workstation}, composedOf{value: itDepartment}]}).
link(l_composes_3{assoc: composes, slots: [composes{value: fileServer}, composedOf{value: itDepartment}]}).

% --- Value components characterize the business asset ---
link(l_characterizedBy_1{assoc: characterizedBy, slots: [characterizedBy{value: itDepartment}, characterizes{value: confidentiality}]}).
link(l_characterizedBy_2{assoc: characterizedBy, slots: [characterizedBy{value: itDepartment}, characterizes{value: integrity}]}).
link(l_characterizedBy_3{assoc: characterizedBy, slots: [characterizedBy{value: itDepartment}, characterizes{value: availability}]}).

% --- Protected subject externally depends on the value components ---
link(l_externallyDependentedOn_1{assoc: externallyDependentedOn, slots: [externallyDependentedOn{value: confidentiality}, externallyDepends{value: organization}]}).
link(l_externallyDependentedOn_2{assoc: externallyDependentedOn, slots: [externallyDependentedOn{value: integrity}, externallyDepends{value: organization}]}).
link(l_externallyDependentedOn_3{assoc: externallyDependentedOn, slots: [externallyDependentedOn{value: availability}, externallyDepends{value: organization}]}).

% --- BlackSuit attacks are based on the BlackSuit plan ---
link(l_basedOn_1{assoc: basedOn, slots: [causes{value: atk_driveby}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_2{assoc: basedOn, slots: [causes{value: atk_c2}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_3{assoc: basedOn, slots: [causes{value: atk_autostart}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_4{assoc: basedOn, slots: [causes{value: atk_procinj}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_5{assoc: basedOn, slots: [causes{value: atk_hidefiles}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_6{assoc: basedOn, slots: [causes{value: atk_exclusions}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_7{assoc: basedOn, slots: [causes{value: atk_filediscovery}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_8{assoc: basedOn, slots: [causes{value: atk_filediscovery2}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_9{assoc: basedOn, slots: [causes{value: atk_collect}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_10{assoc: basedOn, slots: [causes{value: atk_archive}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_11{assoc: basedOn, slots: [causes{value: atk_encrypt}, causedBy{value: blacksuitPlan}]}).
link(l_basedOn_12{assoc: basedOn, slots: [causes{value: atk_exfil}, causedBy{value: blacksuitPlan}]}).

% --- Espionage attacks are based on the espionage plan (first 3 shared) ---
link(l_basedOn_13{assoc: basedOn, slots: [causes{value: atk_driveby}, causedBy{value: espionagePlan}]}).
link(l_basedOn_14{assoc: basedOn, slots: [causes{value: atk_c2}, causedBy{value: espionagePlan}]}).
link(l_basedOn_15{assoc: basedOn, slots: [causes{value: atk_autostart}, causedBy{value: espionagePlan}]}).
link(l_basedOn_16{assoc: basedOn, slots: [causes{value: atk_espcollect}, causedBy{value: espionagePlan}]}).

% --- Attacks cause loss events ---
link(l_causes_1{assoc: causes, slots: [causes{value: atk_encrypt}, causedBy{value: le_encrypt}]}).
link(l_causes_2{assoc: causes, slots: [causes{value: atk_exfil}, causedBy{value: le_exfil}]}).

% --- Loss events bring about loss situations ---
link(l_bringsAbout_1{assoc: bringsAbout, slots: [bringsAbout{value: le_encrypt}, broughtAboutBy{value: ls_unavail}]}).
link(l_bringsAbout_2{assoc: bringsAbout, slots: [bringsAbout{value: le_exfil}, broughtAboutBy{value: ls_disclosed}]}).

% --- Loss situations hurt value components ---
link(l_hurts_1{assoc: hurts, slots: [hurts{value: ls_unavail}, hurtBy{value: availability}]}).
link(l_hurts_2{assoc: hurts, slots: [hurts{value: ls_disclosed}, hurtBy{value: confidentiality}]}).

% --- Business asset participates in the loss events ---
link(l_participatesIn_1{assoc: participatesIn, slots: [participatesIn{value: itDepartment}, hasParticipant{value: le_encrypt}]}).
link(l_participatesIn_2{assoc: participatesIn, slots: [participatesIn{value: itDepartment}, hasParticipant{value: le_exfil}]}).

% --- Closed intentions compose the BlackSuit plan ---
link(l_planComposition_1{assoc: planComposition, slots: [intentionPart{value: ci_foothold}, planWhole{value: blacksuitPlan}]}).
link(l_planComposition_2{assoc: planComposition, slots: [intentionPart{value: ci_persist}, planWhole{value: blacksuitPlan}]}).
link(l_planComposition_3{assoc: planComposition, slots: [intentionPart{value: ci_discover}, planWhole{value: blacksuitPlan}]}).
link(l_planComposition_4{assoc: planComposition, slots: [intentionPart{value: ci_steal}, planWhole{value: blacksuitPlan}]}).
link(l_planComposition_5{assoc: planComposition, slots: [intentionPart{value: ci_extort}, planWhole{value: blacksuitPlan}]}).

% --- Closed intentions compose the espionage plan ---
link(l_planComposition_6{assoc: planComposition, slots: [intentionPart{value: ci_espFoothold}, planWhole{value: espionagePlan}]}).
link(l_planComposition_7{assoc: planComposition, slots: [intentionPart{value: ci_espPersist}, planWhole{value: espionagePlan}]}).
link(l_planComposition_8{assoc: planComposition, slots: [intentionPart{value: ci_espCollect}, planWhole{value: espionagePlan}]}).

% --- BlackSuit closed intentions cause the attacks ---
link(l_intentionCausation_1{assoc: intentionCausation, slots: [causingIntention{value: ci_foothold}, intendedAttack{value: atk_driveby}]}).
link(l_intentionCausation_2{assoc: intentionCausation, slots: [causingIntention{value: ci_foothold}, intendedAttack{value: atk_c2}]}).
link(l_intentionCausation_3{assoc: intentionCausation, slots: [causingIntention{value: ci_persist}, intendedAttack{value: atk_autostart}]}).
link(l_intentionCausation_4{assoc: intentionCausation, slots: [causingIntention{value: ci_persist}, intendedAttack{value: atk_procinj}]}).
link(l_intentionCausation_5{assoc: intentionCausation, slots: [causingIntention{value: ci_persist}, intendedAttack{value: atk_hidefiles}]}).
link(l_intentionCausation_6{assoc: intentionCausation, slots: [causingIntention{value: ci_persist}, intendedAttack{value: atk_exclusions}]}).
link(l_intentionCausation_7{assoc: intentionCausation, slots: [causingIntention{value: ci_discover}, intendedAttack{value: atk_filediscovery}]}).
link(l_intentionCausation_8{assoc: intentionCausation, slots: [causingIntention{value: ci_steal}, intendedAttack{value: atk_collect}]}).
link(l_intentionCausation_9{assoc: intentionCausation, slots: [causingIntention{value: ci_steal}, intendedAttack{value: atk_archive}]}).
link(l_intentionCausation_10{assoc: intentionCausation, slots: [causingIntention{value: ci_steal}, intendedAttack{value: atk_exfil}]}).
link(l_intentionCausation_11{assoc: intentionCausation, slots: [causingIntention{value: ci_extort}, intendedAttack{value: atk_encrypt}]}).
link(l_intentionCausation_12{assoc: intentionCausation, slots: [causingIntention{value: ci_extort}, intendedAttack{value: atk_filediscovery2}]}).

% --- Espionage closed intentions cause the attacks ---
link(l_intentionCausation_13{assoc: intentionCausation, slots: [causingIntention{value: ci_espFoothold}, intendedAttack{value: atk_driveby}]}).
link(l_intentionCausation_14{assoc: intentionCausation, slots: [causingIntention{value: ci_espFoothold}, intendedAttack{value: atk_c2}]}).
link(l_intentionCausation_15{assoc: intentionCausation, slots: [causingIntention{value: ci_espPersist}, intendedAttack{value: atk_autostart}]}).
link(l_intentionCausation_16{assoc: intentionCausation, slots: [causingIntention{value: ci_espCollect}, intendedAttack{value: atk_espcollect}]}).

% --- Vulnerabilities weaken supporting assets ---
link(l_weakens_1{assoc: weakens, slots: [weakeningVuln{value: vuln_socEng}, weakenedAsset{value: employee}]}).

% --- Attacks exploit vulnerabilities ---
link(l_exploits_1{assoc: exploits, slots: [exploitingAttack{value: atk_driveby}, exploitedVuln{value: vuln_socEng}]}).

% --- Attackers perform their plans / hold their capabilities ---
link(l_performsPlan_1{assoc: performsPlan, slots: [performingAttacker{value: blacksuitAttacker}, performedPlan{value: blacksuitPlan}]}).
link(l_performsPlan_2{assoc: performsPlan, slots: [performingAttacker{value: espionageAttacker}, performedPlan{value: espionagePlan}]}).
link(l_hasCapability_1{assoc: hasCapability, slots: [capableAttacker{value: blacksuitAttacker}, attackerCapability{value: cap01}]}).
link(l_hasCapability_2{assoc: hasCapability, slots: [capableAttacker{value: espionageAttacker}, attackerCapability{value: cap02}]}).


% =====================================================================
% C. Helper predicates  --  shared by the CQ queries
%    Pure and declarative: no cut, no if-then-else.
% =====================================================================

% direct classes of an object
objClasses(Obj, Classes) :-
    object(D), is_dict(D, Obj), get_dict(classes, D, Classes).

% human-readable name of an object
objName(Obj, Name) :-
    object(D), is_dict(D, Obj), get_dict(name, D, Name).

% an attribute value slot of an object (e.g. likelihood, level, steps)
attr(Obj, Key, Value) :-
    object(D), is_dict(D, Obj), get_dict(Key, D, Value).

% class subsumption: Class is Super, or Class specialises Super
% (reflexive-transitive closure over the meta-model `super` lists)
isa(Class, Class) :-
    class(D), is_dict(D, Class).
isa(Class, Super) :-
    class(D), is_dict(D, Class), get_dict(super, D, Sups),
    member(Mid, Sups), isa(Mid, Super).

% object is a direct or inherited instance of a class
instanceOf(Obj, Class) :-
    objClasses(Obj, Classes), member(C, Classes), isa(C, Class).

% one link of association Assoc in which ObjA fills RoleA and ObjB fills RoleB
biLink(Assoc, RoleA, ObjA, RoleB, ObjB) :-
    link(L), get_dict(assoc, L, Assoc), get_dict(slots, L, Slots),
    member(SA, Slots), is_dict(SA, RoleA), get_dict(value, SA, ObjA),
    member(SB, Slots), is_dict(SB, RoleB), get_dict(value, SB, ObjB).

% pretty-print a CQ answer term
show(Answer) :-
    print_term(Answer, [indent_arguments(2), nl(true)]), nl.

% =====================================================================
% D. Competency-question queries  --  one predicate per CQ
% =====================================================================

% --- Asset identification (CQ1-CQ3) -- bare-tag answers ---

% CQ1  What are the organization's assets, and what types
%      do they belong to?
cq1(Asset, Type) :-
    object(D), is_dict(D, Asset),
    ( instanceOf(Asset, riskEnabler) ; instanceOf(Asset, objectAtRisk) ),
    objClasses(Asset, Classes), member(Type, Classes).

% CQ2  What cybersecurity value characterizes a given asset?
cq2(Asset, ValueComponent) :-
    biLink(characterizedBy, characterizedBy, Asset, characterizes, ValueComponent).

% CQ3  What dependency relationships exist between assets?
cq3(SupportingAsset, BusinessAsset) :-
    biLink(composes, composes, SupportingAsset, composedOf, BusinessAsset).

% --- Threat source & attack plan (CQ4-CQ8) -- compact answer dicts ---

% CQ4  What threat sources and actors are identified
%      and associated?  One answer per actor: plan performed, capability held.
cq4(Actor, cq4{actor:Actor, performs:Plan, capability:Capability}) :-
    biLink(performsPlan, performingAttacker, Actor, performedPlan, Plan),
    biLink(hasCapability, capableAttacker, Actor, attackerCapability, Capability).

% CQ5  What capabilities, intentions and objectives
%      characterize an attacker?
cq5(Attacker, cq5{attacker:Attacker, capabilities:Capabilities,
                  intentions:Intentions}) :-
    instanceOf(Attacker, attacker),
    findall(C,
            biLink(hasCapability, capableAttacker, Attacker, attackerCapability, C),
            Capabilities),
    findall(I,
            ( biLink(performsPlan, performingAttacker, Attacker, performedPlan, Plan),
              biLink(planComposition, planWhole, Plan, intentionPart, I) ),
            Intentions).

% CQ6  What attack types, techniques and patterns
%      compose a given plan?  
cq6(Plan, cq6{plan:Plan, steps:Steps}) :-
    instanceOf(Plan, attackPlan),
    findall(Attack-Technique,
            ( biLink(basedOn, causedBy, Plan, causes, Attack),
              objClasses(Attack, Classes),
              member(Technique, Classes), Technique \== attack ),
            Steps).

% CQ7  Given a partial trace which attack 
%      plans is the adversary carrying out?  A plan matches when 
%      the trace is an ordered PREFIX of its `steps` sequence; the 
%      steps still to come are returned as `anticipated`.
cq7(Trace, cq7{plan:Plan, observed:Trace, anticipated:Anticipated}) :-
    object(P), is_dict(P, Plan), instanceOf(Plan, attackPlan),
    get_dict(steps, P, Steps),
    append(Trace, Anticipated, Steps).

% CQ8  Can identically looking attacks be told apart
%      by the adversary's goal?  Two distinct attacks of the SAME technique
%      driven by DIFFERENT closed intentions.
cq8(cq8{technique:Technique, attack1:A1, goal1:Goal1,
        attack2:A2, goal2:Goal2}) :-
    objClasses(A1, C1), member(Technique, C1), Technique \== attack,
    objClasses(A2, C2), member(Technique, C2),
    A1 @< A2,
    biLink(intentionCausation, intendedAttack, A1, causingIntention, Goal1),
    biLink(intentionCausation, intendedAttack, A2, causingIntention, Goal2),
    Goal1 \== Goal2.

% --- Vulnerability, impact, risk (CQ9-CQ15) -- bare-tag answers ---

% CQ9  What vulnerabilities are associated with an asset?
cq9(Asset, Vulnerability) :-
    biLink(weakens, weakenedAsset, Asset, weakeningVuln, Vulnerability).

% CQ10  What vulnerabilities are exploitable by attack plans?
cq10(AttackPlan, Vulnerability) :-
    biLink(basedOn, causedBy, AttackPlan, causes, Attack),
    biLink(exploits, exploitingAttack, Attack, exploitedVuln, Vulnerability).

% CQ11  What attack path could negatively influence security
%      objectives? 
cq11(Attack, LossEvent, LossSituation, SecurityObjective) :-
    biLink(causes, causes, Attack, causedBy, LossEvent),
    biLink(bringsAbout, bringsAbout, LossEvent, broughtAboutBy, LossSituation),
    biLink(hurts, hurts, LossSituation, hurtBy, SecurityObjective).

% CQ12  What vulnerability or threat source originates a given
%      adverse (loss) event?  Origin is `vulnerability` or `threatActor`.
cq12(LossEvent, vulnerability, Vulnerability) :-
    biLink(causes, causes, Attack, causedBy, LossEvent),
    biLink(exploits, exploitingAttack, Attack, exploitedVuln, Vulnerability).
cq12(LossEvent, threatActor, ThreatActor) :-
    biLink(causes, causes, Attack, causedBy, LossEvent),
    biLink(basedOn, causes, Attack, causedBy, Plan),
    biLink(performsPlan, performedPlan, Plan, performingAttacker, ThreatActor).

% CQ13 What value components of which assets are harmed by an attack?
cq13(Attack, ValueComponent, Asset) :-
    biLink(causes, causes, Attack, causedBy, LossEvent),
    biLink(bringsAbout, bringsAbout, LossEvent, broughtAboutBy, LossSituation),
    biLink(hurts, hurts, LossSituation, hurtBy, ValueComponent),
    biLink(characterizedBy, characterizes, ValueComponent, characterizedBy, Asset).

% CQ14  What is the estimated likelihood of a specific
%      attack scenario (attack plan)?
cq14(AttackPlan, Likelihood) :-
    instanceOf(AttackPlan, attackPlan),
    attr(AttackPlan, likelihood, Likelihood).

% CQ15  What is the level of risk for a given risk
%      experience (risk assessment)?
cq15(RiskExperience, Level) :-
    instanceOf(RiskExperience, experienceRiskAssessment),
    attr(RiskExperience, level, Level).

% =====================================================================
% E. Queries to run  --  copy-paste into the Prolog console
% =====================================================================
%   ?- cq1(Asset, Type).
%   ?- cq2(itDepartment, Value).
%   ?- cq3(Sa, Ba).
%   ?- cq4(Actor, Answer).
%   ?- cq5(blacksuitAttacker, Answer).
%   ?- cq6(blacksuitPlan, Answer).
%   % CQ7 -- shared 3-step prefix is ambiguous: two candidate plans
%   ?- cq7([atk_driveby, atk_c2, atk_autostart], Answer).
%   % CQ7 -- one more step disambiguates: only the BlackSuit plan remains
%   ?- cq7([atk_driveby, atk_c2, atk_autostart, atk_filediscovery], Answer).
%   ?- cq8(Answer).
%   ?- cq9(employee, Vuln).
%   ?- cq10(blacksuitPlan, Vuln).
%   ?- cq11(Attack, Le, Ls, Objective).
%   ?- cq12(le_encrypt, Origin, Source).
%   ?- cq13(atk_encrypt, Value, Asset).
%   ?- cq14(Plan, Likelihood).
%   ?- cq15(era01, Level).
