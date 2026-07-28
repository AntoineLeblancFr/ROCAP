% =====================================================================
% example_blacksuit_V3.pl
%
% ROCAP instance model -- "Fake Zoom -> BlackSuit Ransomware",
% extended with a second, long-term espionage attack plan.
% Source scenario: thedfirreport.com/2025/03/31/fake-zoom-ends-in-blacksuit-ransomware
%
%
% Dict shapes (tag-reference style, matching meta-model.pl):
%   object dict   Tag{classes:[ClassTag...], name:String [, attr:Value...]}
%   slot  dict    RoleTag{value:ObjectTag}
%   link  dict    Tag{assoc:AssocTag, slots:[SlotDict,SlotDict]}
% =====================================================================

:- consult('meta-model.pl').

% =====================================================================
% 0. Instance-model auxiliary associations
%    (domain relations used only at the instance level, declared here
%     so no link references an undefined assoc).
% =====================================================================

% Closed Intention -<>  Attack Plan   (a plan, a complex mode, has as
% parts the subordinate closed intentions of its phases)
role(intentionPart{minCard: 1, maxCard: *, type: closedIntention, endOf: attackPlan}).
role(planWhole{minCard: 1, maxCard: 1, type: attackPlan, endOf: closedIntention}).
assoc(planComposition{roles: [
  intentionPart{minCard: 1, maxCard: *, type: closedIntention, endOf: attackPlan},
  planWhole{minCard: 1, maxCard: 1, type: attackPlan, endOf: closedIntention}
], super: []}).

% Closed Intention -> Attack   (the Attack manifests the Closed Intention
% whose content it realizes)
role(causingIntention{minCard: 0, maxCard: *, type: closedIntention, endOf: attack}).
role(intendedAttack{minCard: 0, maxCard: *, type: attack, endOf: closedIntention}).
assoc(intentionManifestation{roles: [
  causingIntention{minCard: 0, maxCard: *, type: closedIntention, endOf: attack},
  intendedAttack{minCard: 0, maxCard: *, type: attack, endOf: closedIntention}
], ontoUML: manifestation, super: []}).

% Vulnerability -> Supporting Asset   (the vulnerability characterizes
% the Risk Enabler that the Supporting Asset specializes)
role(weakeningVuln{minCard: 0, maxCard: *, type: vulnerability, endOf: supportingAsset}).
role(weakenedAsset{minCard: 1, maxCard: *, type: supportingAsset, endOf: vulnerability}).
assoc(weakens{roles: [
  weakeningVuln{minCard: 0, maxCard: *, type: vulnerability, endOf: supportingAsset},
  weakenedAsset{minCard: 1, maxCard: *, type: supportingAsset, endOf: vulnerability}
], ontoUML: characterization, super: []}).

% Attack -> Vulnerability   (the Attack exploits the Vulnerability)
role(exploitingAttack{minCard: 0, maxCard: *, type: attack, endOf: vulnerability}).
role(exploitedVuln{minCard: 0, maxCard: *, type: vulnerability, endOf: attack}).
assoc(exploits{roles: [
  exploitingAttack{minCard: 0, maxCard: *, type: attack, endOf: vulnerability},
  exploitedVuln{minCard: 0, maxCard: *, type: vulnerability, endOf: attack}
], super: []}).

% Attacker -> Threat Capability   (the Attacker bears the Capability)
role(capableAttacker{minCard: 1, maxCard: 1, type: attacker, endOf: threatCapability}).
role(attackerCapability{minCard: 0, maxCard: *, type: threatCapability, endOf: attacker}).
assoc(hasCapability{roles: [
  capableAttacker{minCard: 1, maxCard: 1, type: attacker, endOf: threatCapability},
  attackerCapability{minCard: 0, maxCard: *, type: threatCapability, endOf: attacker}
], ontoUML: characterization, super: []}).

% =====================================================================
% A. Objects
% =====================================================================

% --- Supporting assets / business asset ---
object(johnDoe{classes: [supportingAsset, humanResource], name: "Help-desk Employee"}).
object(workstation01{classes: [supportingAsset, d3fClientComputer], name: "Employee Workstation"}).
object(fileserver01{classes: [supportingAsset, d3fFileServer], name: "Corporate File Server"}).
object(zoomInstaller{classes: [supportingAsset, d3fApplicationInstaller], name: "Fake Zoom Installer (SectopRAT dropper)"}).
object(victimCorpITDepartment{classes: [businessAsset], name: "Corporate Data"}).
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
object(blacksuitOperator{classes: [attacker], name: "BlackSuit Ransomware Operator"}).
object(blacksuitCapability{classes: [threatCapability], name: "Ransomware Deployment and Extortion Capability"}).
object(blacksuitPlan_bs{classes: [attackPlan], name: "BlackSuit Ransomware Campaign (Fake Zoom Vector)", likelihood: likely, steps: [atk_driveby, atk_c2, atk_autostart, atk_filediscovery, atk_collect, atk_archive, atk_encrypt, atk_exfil]}).
object(espionageOperator{classes: [attacker], name: "Espionage Threat Actor"}).
object(espionageCapability{classes: [threatCapability], name: "Stealthy Long-Term Access Capability"}).
object(longTermEspionagePlan{classes: [attackPlan], name: "Long-Term Espionage Campaign", likelihood: possible, steps: [atk_driveby, atk_c2, atk_autostart, atk_espcollect]}).
% --- Closed intentions composing the BlackSuit plan ---
object(gainInitialFoothold_bs{classes: [closedIntention], name: "Intention: Gain Initial Foothold"}).
object(maintainPersistence_bs{classes: [closedIntention], name: "Intention: Maintain Persistent Access"}).
object(locateValuableData_bs{classes: [closedIntention], name: "Intention: Locate Valuable Data"}).
object(exfiltrateData_bs{classes: [closedIntention], name: "Intention: Exfiltrate Corporate Data"}).
object(extortVictim_bs{classes: [closedIntention], name: "Intention: Extort Victim via Encryption"}).
% --- Closed intentions composing the espionage plan ---
object(gainInitialFoothold_es{classes: [closedIntention], name: "Intention: Establish Covert Foothold"}).
object(maintainPersistence_es{classes: [closedIntention], name: "Intention: Maintain Covert Long-Term Access"}).
object(continuouslyCollectIntelligence_es{classes: [closedIntention], name: "Intention: Continuously Collect Intelligence"}).
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
link(l_offensivelyEngagedBy_1{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: johnDoe}, offensivelyEngages{value: atk_driveby}]}).
link(l_offensivelyEngagedBy_2{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: zoomInstaller}, offensivelyEngages{value: atk_driveby}]}).
link(l_offensivelyEngagedBy_3{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation01}, offensivelyEngages{value: atk_driveby}]}).
link(l_offensivelyEngagedBy_4{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation01}, offensivelyEngages{value: atk_c2}]}).
link(l_offensivelyEngagedBy_5{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation01}, offensivelyEngages{value: atk_autostart}]}).
link(l_offensivelyEngagedBy_6{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation01}, offensivelyEngages{value: atk_procinj}]}).
link(l_offensivelyEngagedBy_7{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation01}, offensivelyEngages{value: atk_hidefiles}]}).
link(l_offensivelyEngagedBy_8{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: workstation01}, offensivelyEngages{value: atk_exclusions}]}).
link(l_offensivelyEngagedBy_9{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileserver01}, offensivelyEngages{value: atk_filediscovery}]}).
link(l_offensivelyEngagedBy_10{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileserver01}, offensivelyEngages{value: atk_filediscovery2}]}).
link(l_offensivelyEngagedBy_11{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileserver01}, offensivelyEngages{value: atk_collect}]}).
link(l_offensivelyEngagedBy_12{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileserver01}, offensivelyEngages{value: atk_archive}]}).
link(l_offensivelyEngagedBy_13{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileserver01}, offensivelyEngages{value: atk_encrypt}]}).
link(l_offensivelyEngagedBy_14{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileserver01}, offensivelyEngages{value: atk_exfil}]}).
link(l_offensivelyEngagedBy_15{assoc: offensivelyEngagedBy, slots: [offensivelyEngagedBy{value: fileserver01}, offensivelyEngages{value: atk_espcollect}]}).

% --- Supporting assets support the business asset (functional dependence) ---
link(l_supportedBy_1{assoc: supportedBy, slots: [supports{value: johnDoe}, supportedBy{value: victimCorpITDepartment}]}).
link(l_supportedBy_2{assoc: supportedBy, slots: [supports{value: workstation01}, supportedBy{value: victimCorpITDepartment}]}).
link(l_supportedBy_3{assoc: supportedBy, slots: [supports{value: fileserver01}, supportedBy{value: victimCorpITDepartment}]}).

% --- Value components characterize the business asset ---
link(l_characterizedBy_1{assoc: characterizedBy, slots: [characterizedBy{value: victimCorpITDepartment}, characterizes{value: confidentiality}]}).
link(l_characterizedBy_2{assoc: characterizedBy, slots: [characterizedBy{value: victimCorpITDepartment}, characterizes{value: integrity}]}).
link(l_characterizedBy_3{assoc: characterizedBy, slots: [characterizedBy{value: victimCorpITDepartment}, characterizes{value: availability}]}).

% --- Protected subject externally depends on the value components ---
link(l_externallyDependentedOn_1{assoc: externallyDependentedOn, slots: [externallyDependentedOn{value: confidentiality}, externallyDepends{value: organization}]}).
link(l_externallyDependentedOn_2{assoc: externallyDependentedOn, slots: [externallyDependentedOn{value: integrity}, externallyDepends{value: organization}]}).
link(l_externallyDependentedOn_3{assoc: externallyDependentedOn, slots: [externallyDependentedOn{value: availability}, externallyDepends{value: organization}]}).

% --- BlackSuit attacks manifest the BlackSuit plan ---
link(l_manifests_1{assoc: manifestation, slots: [manifests{value: atk_driveby}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_2{assoc: manifestation, slots: [manifests{value: atk_c2}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_3{assoc: manifestation, slots: [manifests{value: atk_autostart}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_4{assoc: manifestation, slots: [manifests{value: atk_procinj}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_5{assoc: manifestation, slots: [manifests{value: atk_hidefiles}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_6{assoc: manifestation, slots: [manifests{value: atk_exclusions}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_7{assoc: manifestation, slots: [manifests{value: atk_filediscovery}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_8{assoc: manifestation, slots: [manifests{value: atk_filediscovery2}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_9{assoc: manifestation, slots: [manifests{value: atk_collect}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_10{assoc: manifestation, slots: [manifests{value: atk_archive}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_11{assoc: manifestation, slots: [manifests{value: atk_encrypt}, manifestedBy{value: blacksuitPlan_bs}]}).
link(l_manifests_12{assoc: manifestation, slots: [manifests{value: atk_exfil}, manifestedBy{value: blacksuitPlan_bs}]}).

% --- Espionage attacks manifest the espionage plan (first 3 shared) ---
link(l_manifests_13{assoc: manifestation, slots: [manifests{value: atk_driveby}, manifestedBy{value: longTermEspionagePlan}]}).
link(l_manifests_14{assoc: manifestation, slots: [manifests{value: atk_c2}, manifestedBy{value: longTermEspionagePlan}]}).
link(l_manifests_15{assoc: manifestation, slots: [manifests{value: atk_autostart}, manifestedBy{value: longTermEspionagePlan}]}).
link(l_manifests_16{assoc: manifestation, slots: [manifests{value: atk_espcollect}, manifestedBy{value: longTermEspionagePlan}]}).

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
link(l_participatesIn_1{assoc: participatesIn, slots: [participatesIn{value: victimCorpITDepartment}, hasParticipant{value: le_encrypt}]}).
link(l_participatesIn_2{assoc: participatesIn, slots: [participatesIn{value: victimCorpITDepartment}, hasParticipant{value: le_exfil}]}).

% --- Closed intentions compose the BlackSuit plan ---
link(l_planComposition_1{assoc: planComposition, slots: [intentionPart{value: gainInitialFoothold_bs}, planWhole{value: blacksuitPlan_bs}]}).
link(l_planComposition_2{assoc: planComposition, slots: [intentionPart{value: maintainPersistence_bs}, planWhole{value: blacksuitPlan_bs}]}).
link(l_planComposition_3{assoc: planComposition, slots: [intentionPart{value: locateValuableData_bs}, planWhole{value: blacksuitPlan_bs}]}).
link(l_planComposition_4{assoc: planComposition, slots: [intentionPart{value: exfiltrateData_bs}, planWhole{value: blacksuitPlan_bs}]}).
link(l_planComposition_5{assoc: planComposition, slots: [intentionPart{value: extortVictim_bs}, planWhole{value: blacksuitPlan_bs}]}).

% --- Closed intentions compose the espionage plan ---
link(l_planComposition_6{assoc: planComposition, slots: [intentionPart{value: gainInitialFoothold_es}, planWhole{value: longTermEspionagePlan}]}).
link(l_planComposition_7{assoc: planComposition, slots: [intentionPart{value: maintainPersistence_es}, planWhole{value: longTermEspionagePlan}]}).
link(l_planComposition_8{assoc: planComposition, slots: [intentionPart{value: continuouslyCollectIntelligence_es}, planWhole{value: longTermEspionagePlan}]}).

% --- BlackSuit closed intentions are manifested by the attacks ---
link(l_intentionManifestation_1{assoc: intentionManifestation, slots: [causingIntention{value: gainInitialFoothold_bs}, intendedAttack{value: atk_driveby}]}).
link(l_intentionManifestation_2{assoc: intentionManifestation, slots: [causingIntention{value: gainInitialFoothold_bs}, intendedAttack{value: atk_c2}]}).
link(l_intentionManifestation_3{assoc: intentionManifestation, slots: [causingIntention{value: maintainPersistence_bs}, intendedAttack{value: atk_autostart}]}).
link(l_intentionManifestation_4{assoc: intentionManifestation, slots: [causingIntention{value: maintainPersistence_bs}, intendedAttack{value: atk_procinj}]}).
link(l_intentionManifestation_5{assoc: intentionManifestation, slots: [causingIntention{value: maintainPersistence_bs}, intendedAttack{value: atk_hidefiles}]}).
link(l_intentionManifestation_6{assoc: intentionManifestation, slots: [causingIntention{value: maintainPersistence_bs}, intendedAttack{value: atk_exclusions}]}).
link(l_intentionManifestation_7{assoc: intentionManifestation, slots: [causingIntention{value: locateValuableData_bs}, intendedAttack{value: atk_filediscovery}]}).
link(l_intentionManifestation_8{assoc: intentionManifestation, slots: [causingIntention{value: exfiltrateData_bs}, intendedAttack{value: atk_collect}]}).
link(l_intentionManifestation_9{assoc: intentionManifestation, slots: [causingIntention{value: exfiltrateData_bs}, intendedAttack{value: atk_archive}]}).
link(l_intentionManifestation_10{assoc: intentionManifestation, slots: [causingIntention{value: exfiltrateData_bs}, intendedAttack{value: atk_exfil}]}).
link(l_intentionManifestation_11{assoc: intentionManifestation, slots: [causingIntention{value: extortVictim_bs}, intendedAttack{value: atk_encrypt}]}).
link(l_intentionManifestation_12{assoc: intentionManifestation, slots: [causingIntention{value: extortVictim_bs}, intendedAttack{value: atk_filediscovery2}]}).

% --- Espionage closed intentions are manifested by the attacks ---
link(l_intentionManifestation_13{assoc: intentionManifestation, slots: [causingIntention{value: gainInitialFoothold_es}, intendedAttack{value: atk_driveby}]}).
link(l_intentionManifestation_14{assoc: intentionManifestation, slots: [causingIntention{value: gainInitialFoothold_es}, intendedAttack{value: atk_c2}]}).
link(l_intentionManifestation_15{assoc: intentionManifestation, slots: [causingIntention{value: maintainPersistence_es}, intendedAttack{value: atk_autostart}]}).
link(l_intentionManifestation_16{assoc: intentionManifestation, slots: [causingIntention{value: continuouslyCollectIntelligence_es}, intendedAttack{value: atk_espcollect}]}).

% --- Vulnerabilities weaken supporting assets ---
link(l_weakens_1{assoc: weakens, slots: [weakeningVuln{value: vuln_socEng}, weakenedAsset{value: johnDoe}]}).
link(l_weakens_2{assoc: weakens, slots: [weakeningVuln{value: vuln_autorun}, weakenedAsset{value: workstation01}]}).

% --- Attacks exploit vulnerabilities ---
link(l_exploits_1{assoc: exploits, slots: [exploitingAttack{value: atk_driveby}, exploitedVuln{value: vuln_socEng}]}).
link(l_exploits_2{assoc: exploits, slots: [exploitingAttack{value: atk_autostart}, exploitedVuln{value: vuln_autorun}]}).

% --- Attackers participate in their attacks / hold their capabilities ---
% (the plan, a mode, inheres in the attacker: planInherence)
link(l_planInherence_1{assoc: planInherence, slots: [inheresIn{value: blacksuitPlan_bs}, bearerOf{value: blacksuitOperator}]}).
link(l_planInherence_2{assoc: planInherence, slots: [inheresIn{value: longTermEspionagePlan}, bearerOf{value: espionageOperator}]}).
link(l_hasCapability_1{assoc: hasCapability, slots: [capableAttacker{value: blacksuitOperator}, attackerCapability{value: blacksuitCapability}]}).
link(l_hasCapability_2{assoc: hasCapability, slots: [capableAttacker{value: espionageOperator}, attackerCapability{value: espionageCapability}]}).

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

% CQ1  What are the organization's assets, and what types do they belong to?
cq1(Asset, Type) :-
    object(D), is_dict(D, Asset),
    ( instanceOf(Asset, riskEnabler) ; instanceOf(Asset, objectAtRisk) ),
    objClasses(Asset, Classes), member(Type, Classes).

% CQ2  What cybersecurity value characterizes a given asset?
cq2(Asset, ValueComponent) :-
    biLink(characterizedBy, characterizedBy, Asset, characterizes, ValueComponent).

% CQ3  What functional-dependence relationships exist between assets?
%      (a Business Asset is supported by its Supporting Assets)
cq3(SupportingAsset, BusinessAsset) :-
    biLink(supportedBy, supports, SupportingAsset, supportedBy, BusinessAsset).

% --- Threat source & attack plan (CQ4-CQ8) -- compact answer dicts ---

% CQ4  What threat sources and actors are identified and associated?
%      One answer per actor: plan borne, capability held.
cq4(Actor, cq4{actor:Actor, plan:Plan, capability:Capability}) :-
    biLink(planInherence, bearerOf, Actor, inheresIn, Plan),
    biLink(hasCapability, capableAttacker, Actor, attackerCapability, Capability).

% CQ5  What capabilities, intentions and objectives characterize an attacker?
cq5(Attacker, cq5{attacker:Attacker, capabilities:Capabilities,
                  intentions:Intentions}) :-
    instanceOf(Attacker, attacker),
    findall(C,
            biLink(hasCapability, capableAttacker, Attacker, attackerCapability, C),
            Capabilities),
    findall(I,
            ( biLink(planInherence, bearerOf, Attacker, inheresIn, Plan),
              biLink(planComposition, planWhole, Plan, intentionPart, I) ),
            Intentions).

% CQ6  What attack types, techniques and patterns characterize a given plan?
cq6(Plan, cq6{plan:Plan, steps:Steps}) :-
    instanceOf(Plan, attackPlan),
    findall(Attack-Technique,
            ( biLink(manifestation, manifestedBy, Plan, manifests, Attack),
              objClasses(Attack, Classes),
              member(Technique, Classes), Technique \== attack ),
            Steps).

% CQ7  Given a partial trace which attack plans is the adversary
%      carrying out?  A plan matches when the trace is an ordered PREFIX
%      of its `steps` sequence; the steps still to come are returned as
%      `anticipated`.
cq7(Trace, cq7{plan:Plan, observed:Trace, anticipated:Anticipated}) :-
    object(P), is_dict(P, Plan), instanceOf(Plan, attackPlan),
    get_dict(steps, P, Steps),
    append(Trace, Anticipated, Steps).

% CQ8  Can identically looking attacks be told apart by the adversary's
%      goal?  Two distinct attacks of the SAME technique manifesting
%      DIFFERENT closed intentions.
cq8(cq8{technique:Technique, attack1:A1, goal1:Goal1,
        attack2:A2, goal2:Goal2}) :-
    objClasses(A1, C1), member(Technique, C1), Technique \== attack,
    objClasses(A2, C2), member(Technique, C2),
    A1 @< A2,
    biLink(intentionManifestation, intendedAttack, A1, causingIntention, Goal1),
    biLink(intentionManifestation, intendedAttack, A2, causingIntention, Goal2),
    Goal1 \== Goal2.

% --- Vulnerability, impact, risk (CQ9-CQ15) -- bare-tag answers ---

% CQ9  What vulnerabilities are associated with an asset?
cq9(Asset, Vulnerability) :-
    biLink(weakens, weakenedAsset, Asset, weakeningVuln, Vulnerability).

% CQ10  What vulnerabilities are exploitable by attack plans?
cq10(AttackPlan, Vulnerability) :-
    biLink(manifestation, manifestedBy, AttackPlan, manifests, Attack),
    biLink(exploits, exploitingAttack, Attack, exploitedVuln, Vulnerability).

% CQ11  What attack path could negatively influence security objectives?
cq11(Attack, LossEvent, LossSituation, SecurityObjective) :-
    biLink(causes, causes, Attack, causedBy, LossEvent),
    biLink(bringsAbout, bringsAbout, LossEvent, broughtAboutBy, LossSituation),
    biLink(hurts, hurts, LossSituation, hurtBy, SecurityObjective).

% CQ12  What vulnerability or threat source originates a given adverse
%      (loss) event?  Origin is `vulnerability` or `threatActor`.
cq12(LossEvent, vulnerability, Vulnerability) :-
    biLink(causes, causes, Attack, causedBy, LossEvent),
    biLink(exploits, exploitingAttack, Attack, exploitedVuln, Vulnerability).
cq12(LossEvent, threatActor, ThreatActor) :-
    biLink(causes, causes, Attack, causedBy, LossEvent),
    biLink(manifestation, manifests, Attack, manifestedBy, Plan),
    biLink(planInherence, inheresIn, Plan, bearerOf, ThreatActor).

% CQ13 What value components of which assets are harmed by an attack?
cq13(Attack, ValueComponent, Asset) :-
    biLink(causes, causes, Attack, causedBy, LossEvent),
    biLink(bringsAbout, bringsAbout, LossEvent, broughtAboutBy, LossSituation),
    biLink(hurts, hurts, LossSituation, hurtBy, ValueComponent),
    biLink(characterizedBy, characterizes, ValueComponent, characterizedBy, Asset).

% CQ14  What is the estimated likelihood of a specific attack scenario?
cq14(AttackPlan, Likelihood) :-
    instanceOf(AttackPlan, attackPlan),
    attr(AttackPlan, likelihood, Likelihood).

% CQ15  What is the level of risk for a given risk experience?
cq15(RiskExperience, Level) :-
    instanceOf(RiskExperience, experienceRiskAssessment),
    attr(RiskExperience, level, Level).

% =====================================================================
% E. Queries to run  --  copy-paste into the Prolog console
% =====================================================================
%   ?- cq1(Asset, Type).
%   ?- cq2(victimCorpITDepartment, Value).
%   ?- cq3(Sa, Ba).
%   ?- cq4(Actor, Answer).
%   ?- cq5(blacksuitOperator, Answer).
%   ?- cq6(blacksuitPlan_bs, Answer).
%   % CQ7 -- shared 3-step prefix is ambiguous: two candidate plans
%   ?- cq7([atk_driveby, atk_c2, atk_autostart], Answer).
%   % CQ7 -- one more step disambiguates: only the BlackSuit plan remains
%   ?- cq7([atk_driveby, atk_c2, atk_autostart, atk_filediscovery], Answer).
%   ?- cq8(Answer).
%   ?- cq9(johnDoe, Vuln).
%   ?- cq10(blacksuitPlan_bs, Vuln).
%   ?- cq11(Attack, Le, Ls, Objective).
%   ?- cq12(le_encrypt, Origin, Source).
%   ?- cq13(atk_encrypt, Value, Asset).
%   ?- cq14(Plan, Likelihood).
%   ?- cq15(era01, Level).
