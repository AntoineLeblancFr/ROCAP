% =====================================================================
% ROCAP meta-model (revised to match the redrawn Figs. 1-3).
%
%
% Dict shapes
%   class dict       Tag{super:[ClassDict...], ontoUML:Stereotype}
%   role dict        Tag{minCard:Int, maxCard:Int, type:ClassDict|atom
%                        [, endOf:AssocDict]}
%   slot dict        RoleTag{value:ObjectDict}
%   assoc dict       Tag{roles:[RoleDict...], ontoUML:Stereotype, super:[AssocDict...]}
%   object dict      Tag{classes:[ClassDict...], name:String}
%   link dict        Tag{slots:[SlotDict...]}
%   ontoUMLInstance  Tag{source:ClassDict, target:ClassDict, ontoUML:Stereotype}
%
% =====================================================================

:- discontiguous object/1.
:- discontiguous link/1.

% =====================================================================
% A. UML class dicts  --  class(ClassDict)
% =====================================================================

% --- I. Assets ---
class(riskEnabler{super: [], ontoUML:roleMixin}).
class(objectAtRisk{super: [], ontoUML:roleMixin}).
class(protectedSubject{super: [], ontoUML:roleMixin}).

% Supporting Asset is now a role played by an Endurant (physical or not).
class(supportingAsset{super: [riskEnabler], ontoUML:roleMixin}).
class(businessAsset{super: [objectAtRisk], ontoUML:roleMixin}).
class(cybersecurityValueComponent{super:[], ontoUML:mode}).

class(supportingAssetType{super:[], ontoUML:type}).
class(humanResource{super: [supportingAssetType], ontoUML: type}).
class(d3fArtifact{super: [supportingAssetType], ontoUML: type}).

class(d3fClientComputer{super: [d3fArtifact], ontoUML: subKind}).
class(d3fFileServer{super: [d3fArtifact], ontoUML: subKind}).
class(d3fApplicationInstaller{super: [d3fArtifact], ontoUML: type}).


% --- I. Vulnerabilities ---
class(vulnerability{super: [], ontoUML:roleMixin}).
class(vulnerabilityType{super: [], ontoUML:type}).
class(humanVulnerability{super:[vulnerabilityType], ontoUML:type}).
class(cweWeakness{super:[vulnerabilityType], ontoUML:subtypeKind}).
class(cveVulnerability{super: [cweWeakness], ontoUML: type}).

% --- Attack Plan ---
class(action{super: [], ontoUML:event}).
class(attack{super:[action], ontoUML:event}).
class(lossEvent{super:[], ontoUML:event}).
class(lossSituation{super:[], ontoUML:situation}).
class(intention{super:[], ontoUML:category}).
class(closedIntention{super:[intention], ontoUML:category}).
% Attack Plan is a closed intention -- a UFO mode inhering in the Attacker.
class(attackPlan{super: [closedIntention], ontoUML: mode}).

% --- Experience Risk Assessment ---
class(risk{super: [], ontoUML:quality}).
class(untreatedRisk{super:[risk], ontoUML:phase}).
class(agent{super: [], ontoUML:category}).
class(attacker{super:[agent], ontoUML:roleMixin}).
class(threatCapability{super:[], ontoUML:roleMixin}).
class(experienceRiskAssessment{super: [], ontoUML:subkind}).


% --- J. ATT&CK high-order types (powertypes) ---
class(eventType{super:[], ontoUML:type}).
class(complexActionType{super:[eventType], ontoUML:type}).
class(attackType{super:[eventType], ontoUML:type}).
class(attackTactic{super:[attackType], ontoUML:type}).
class(attackTechnique{super:[attackType], ontoUML:type}).
class(attackSubTechnique{super:[attackType], ontoUML:type}).
class(capecPattern{super:[attackType], ontoUML:type}).

class(getIn{super: [attackTactic],ontoUML: type}).
class(getThrough{super: [attackTactic],ontoUML: type}).
class(getOut{super: [attackTactic],ontoUML: type}).
class(keepInformed{super: [attackTactic],ontoUML: type}).
class(defenseEvasion{super: [attackTactic],ontoUML: type}).
class(reconnaissance{super: [getIn],ontoUML: type}).
class(resourceDevelopment{super: [getIn],ontoUML: type}).
class(initialAccess{super: [getIn],ontoUML: type}).
class(persistence{super: [keepInformed],ontoUML: type}).
class(commandAndControl{super: [keepInformed],ontoUML: type}).
class(credentialAccess{super: [getThrough],ontoUML: type}).
class(privilegeEscalation{super: [getThrough],ontoUML: type}).
class(lateralMovement{super: [getThrough],ontoUML: type}).
class(discovery{super: [getThrough],ontoUML: type}).
class(localDiscovery{super: [discovery],ontoUML: type}).
class(remoteDiscovery{super: [discovery],ontoUML: type}).
class(impact{super: [getOut],ontoUML: type}).
class(exfiltration{super: [getOut],ontoUML: type}).
class(collection{super: [getOut],ontoUML: type}).

% First-order base event type for the Keep In+formed meta-tactic, so that
% a dependency targeting the meta-tactic relates first-order types only.
class(keepInformedAction{super: [action], ontoUML: event}).

class(driveByCompromiseT1189{super: [initialAccess], ontoUML: type}).
class(applicationLayerProtocolT1071{super: [commandAndControl], ontoUML: type}).
class(bootOrLogonAutostartExecutionT1547{super: [persistence], ontoUML: type}).
class(processInjectionT1055{super: [defenseEvasion], ontoUML: type}).
class(hideArtifactsT1564{super: [defenseEvasion], ontoUML: type}).
class(hiddenFilesAndDirectoriesT1564_001{super: [hideArtifactsT1564], ontoUML: type}).
class(filePathExclusionsT1564_012{super: [hideArtifactsT1564], ontoUML: type}).
class(fileAndDirectoryDiscoveryT1083{super: [localDiscovery], ontoUML: type}).
class(dataFromLocalSystemT1005{super: [collection], ontoUML: type}).
class(archiveCollectedDataT1560{super: [collection], ontoUML: type}).
class(dataEncryptedForImpactT1486{super: [impact], ontoUML: type}).
class(exfiltrationOverWebServiceT1567{super: [exfiltration], ontoUML: type}).

% =====================================================================
% B. UML role dicts  --  role(RoleDict)
% =====================================================================

% Loss Situation -> Cybersecurity Value Component
role(hurtBy{minCard: 0, maxCard: *, type: cybersecurityValueComponent, endOf: lossSituation}).
role(hurts{minCard: 0, maxCard: *, type: lossSituation, endOf: cybersecurityValueComponent}).
assoc(hurts{roles: [
  hurtBy{minCard: 0, maxCard: *, type: cybersecurityValueComponent, endOf: lossSituation}, 
  hurts{minCard: 0, maxCard: *, type: lossSituation, endOf: cybersecurityValueComponent}
], super: []}).

% Loss Event -> Loss Situation
role(bringsAbout{minCard: 1, maxCard: *, type: lossEvent, endOf: lossSituation}).
role(broughtAboutBy{minCard: 0, maxCard: *, type: lossSituation, endOf: lossEvent}).
assoc(bringsAbout{roles: [
  bringsAbout{minCard: 1, maxCard: *, type: lossEvent, endOf: lossSituation},
  broughtAboutBy{minCard: 0, maxCard: *, type: lossSituation, endOf: lossEvent}
], ontoUML: bringsAbout, super: []}).

% Object At Risk -> Loss Event
role(participatesIn{minCard: 1, maxCard: *, type: objectAtRisk, endOf: lossEvent}).
role(hasParticipant{minCard: 1, maxCard: *, type: lossEvent, endOf: objectAtRisk}).
assoc(participatesIn{roles: [
  participatesIn{minCard: 1, maxCard: *, type: objectAtRisk, endOf: lossEvent},
  hasParticipant{minCard: 1, maxCard: *, type: lossEvent, endOf: objectAtRisk}
], ontoUML: participation, super: []}).

% Attack -> Loss Event  (Attack CAUSES Loss Event)
role(causes{minCard: 0, maxCard: *, type: attack, endOf: lossEvent}).
role(causedBy{minCard: 0, maxCard: *, type: lossEvent, endOf: attack}).
assoc(causes{roles: [
  causes{minCard: 0, maxCard: *, type: attack, endOf: lossEvent},
  causedBy{minCard: 0, maxCard: *, type: lossEvent, endOf: attack}
], ontoUML: historicalDependence, super: []}).

% Attack Plan -> Attack  (the Attack MANIFESTS the Attack Plan, Fig. 3)
role(manifestedBy{minCard: 0, maxCard: *, type: attackPlan, endOf: attack}).
role(manifests{minCard: 0, maxCard: *, type: attack, endOf: attackPlan}).
assoc(manifestation{roles: [
  manifests{minCard: 0, maxCard: *, type: attack, endOf: attackPlan},
  manifestedBy{minCard: 0, maxCard: *, type: attackPlan, endOf: attack}
], ontoUML: manifestation, super: []}).

% Attack Plan -> Attacker  (Attack Plan, a mode, INHERES IN the Attacker, Fig. 1)
role(inheresIn{minCard: 1, maxCard: 1, type: attackPlan, endOf: attacker}).
role(bearerOf{minCard: 0, maxCard: *, type: attacker, endOf: attackPlan}).
assoc(planInherence{roles: [
  inheresIn{minCard: 1, maxCard: 1, type: attackPlan, endOf: attacker},
  bearerOf{minCard: 0, maxCard: *, type: attacker, endOf: attackPlan}
], ontoUML: characterization, super: []}).

% Attacker -> Attack  (the Attacker PARTICIPATES IN the Attack, Figs. 1 & 3)
role(participatesInAttack{minCard: 0, maxCard: *, type: attacker, endOf: attack}).
role(engagesAttacker{minCard: 1, maxCard: *, type: attack, endOf: attacker}).
assoc(attackerParticipation{roles: [
  participatesInAttack{minCard: 0, maxCard: *, type: attacker, endOf: attack},
  engagesAttacker{minCard: 1, maxCard: *, type: attack, endOf: attacker}
], ontoUML: participation, super: []}).

% Supporting Asset -> Attack 
role(offensivelyEngagedBy{minCard: 0, maxCard: *, type: supportingAsset, endOf: attack}).
role(offensivelyEngages{minCard: 0, maxCard: *, type: attack, endOf: supportingAsset}).
assoc(offensivelyEngagedBy{roles: [
  offensivelyEngagedBy{minCard: 0, maxCard: *, type: supportingAsset, endOf: attack},
  offensivelyEngages{minCard: 0, maxCard: *, type: attack, endOf: supportingAsset}
], ontoUML: participation, super: []}).

% Business Asset -> Supporting Asset   (FUNCTIONAL DEPENDENCE, Fig. 1 "supported by")
% Contingent: a Business Asset can exist without supporting assets
% (min 0 on the Supporting Asset end) but cannot realize its value without them.
role(supportedBy{minCard: 0, maxCard: *, type: supportingAsset, endOf: businessAsset}).
role(supports{minCard: 1, maxCard: *, type: businessAsset, endOf: supportingAsset}).
assoc(supportedBy{roles: [
  supportedBy{minCard: 0, maxCard: *, type: supportingAsset, endOf: businessAsset},
  supports{minCard: 1, maxCard: *, type: businessAsset, endOf: supportingAsset}
], super: []}).

% Supporting Asset Type -> Attack Type
role(offensivelyEngagedBy{minCard: 1, maxCard: *, type: supportingAssetType, endOf: attackType}).
role(offensivelyEngages{minCard: 0, maxCard: *, type: attackType, endOf: supportingAssetType}).
assoc(offensivelyEngagedBy{roles: [
  offensivelyEngagedBy{minCard: 1, maxCard: *, type: supportingAssetType, endOf: attackType},
  offensivelyEngages{minCard: 0, maxCard: *, type: attackType, endOf: supportingAssetType}
], ontoUML: participation, super: []}).

% Cybersecurity Value Component -> Business Asset
role(characterizedBy{minCard: 0, maxCard: *, type: businessAsset, endOf: cybersecurityValueComponent}).
role(characterizes{minCard: 0, maxCard: *, type: cybersecurityValueComponent, endOf: businessAsset}).
assoc(characterizedBy{roles: [
  characterizedBy{minCard: 0, maxCard: *, type: businessAsset, endOf: cybersecurityValueComponent},
  characterizes{minCard: 0, maxCard: *, type: cybersecurityValueComponent, endOf: businessAsset}
], ontoUML: characterization, super: []}).

% Protected Subject -> Cybersecurity Value Component
role(externallyDependentedOn{minCard: 0, maxCard: *, type: cybersecurityValueComponent, endOf: protectedSubject}).
role(externallyDepends{minCard: 1, maxCard: *, type: protectedSubject, endOf: cybersecurityValueComponent}).
assoc(externallyDependentedOn{roles: [
  externallyDependentedOn{minCard: 0, maxCard: *, type: cybersecurityValueComponent, endOf: protectedSubject},
  externallyDepends{minCard: 1, maxCard: *, type: protectedSubject, endOf: cybersecurityValueComponent}
], ontoUML: externalDependence, super: []}).

% CAPEC Pattern realizes ATT&CK Tactic  (Fig. 1)
role(realizesTactic{minCard: 1, maxCard: *, type: capecPattern, endOf: attackTactic}).
role(realizedByPattern{minCard: 1, maxCard: *, type: attackTactic, endOf: capecPattern}).
assoc(patternRealizes{roles: [
  realizesTactic{minCard: 1, maxCard: *, type: capecPattern, endOf: attackTactic},
  realizedByPattern{minCard: 1, maxCard: *, type: attackTactic, endOf: capecPattern}
], super: []}).

% ATT&CK Technique realizes ATT&CK Tactic  (Fig. 1)
role(realizesTactic{minCard: 1, maxCard: *, type: attackTechnique, endOf: attackTactic}).
role(realizedByTechnique{minCard: 1, maxCard: *, type: attackTactic, endOf: attackTechnique}).
assoc(techniqueRealizes{roles: [
  realizesTactic{minCard: 1, maxCard: *, type: attackTechnique, endOf: attackTactic},
  realizedByTechnique{minCard: 1, maxCard: *, type: attackTactic, endOf: attackTechnique}
], super: []}).

% =====================================================================
%  C. Tactic dependency (Fig. 2)  --  defined relation `enables`
%     between FIRST-ORDER event types.
%     enables(B, A): instances of A typically historically depend on
%                    some instance of B.
%     In each assoc below, role `enabler` is B and role `enabled` is A.
% =====================================================================

% Reconnaissance enables Resource Development
role(enabler{minCard: 0, maxCard: *, type: reconnaissance, endOf: resourceDevelopment}).
role(enabled{minCard: 0, maxCard: *, type: resourceDevelopment, endOf: reconnaissance}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: reconnaissance, endOf: resourceDevelopment},
  enabled{minCard: 0, maxCard: *, type: resourceDevelopment, endOf: reconnaissance}
], super: []}).

% Resource Development enables Initial Access
role(enabler{minCard: 0, maxCard: *, type: resourceDevelopment, endOf: initialAccess}).
role(enabled{minCard: 0, maxCard: *, type: initialAccess, endOf: resourceDevelopment}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: resourceDevelopment, endOf: initialAccess},
  enabled{minCard: 0, maxCard: *, type: initialAccess, endOf: resourceDevelopment}
], super: []}).

% Initial Access enables Keep In+formed Action  (via first-order base type)
role(enabler{minCard: 0, maxCard: *, type: initialAccess, endOf: keepInformedAction}).
role(enabled{minCard: 0, maxCard: *, type: keepInformedAction, endOf: initialAccess}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: initialAccess, endOf: keepInformedAction},
  enabled{minCard: 0, maxCard: *, type: keepInformedAction, endOf: initialAccess}
], super: []}).

% Initial Access enables Discovery
role(enabler{minCard: 0, maxCard: *, type: initialAccess, endOf: discovery}).
role(enabled{minCard: 0, maxCard: *, type: discovery, endOf: initialAccess}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: initialAccess, endOf: discovery},
  enabled{minCard: 0, maxCard: *, type: discovery, endOf: initialAccess}
], super: []}).

% Discovery enables Keep In+formed Action
role(enabler{minCard: 0, maxCard: *, type: discovery, endOf: keepInformedAction}).
role(enabled{minCard: 0, maxCard: *, type: keepInformedAction, endOf: discovery}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: discovery, endOf: keepInformedAction},
  enabled{minCard: 0, maxCard: *, type: keepInformedAction, endOf: discovery}
], super: []}).

% Collection enables Exfiltration
role(enabler{minCard: 0, maxCard: *, type: collection, endOf: exfiltration}).
role(enabled{minCard: 0, maxCard: *, type: exfiltration, endOf: collection}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: collection, endOf: exfiltration},
  enabled{minCard: 0, maxCard: *, type: exfiltration, endOf: collection}
], super: []}).

% Collection enables Impact
role(enabler{minCard: 0, maxCard: *, type: collection, endOf: impact}).
role(enabled{minCard: 0, maxCard: *, type: impact, endOf: collection}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: collection, endOf: impact},
  enabled{minCard: 0, maxCard: *, type: impact, endOf: collection}
], super: []}).

% Discovery enables Collection
role(enabler{minCard: 0, maxCard: *, type: discovery, endOf: collection}).
role(enabled{minCard: 0, maxCard: *, type: collection, endOf: discovery}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: discovery, endOf: collection},
  enabled{minCard: 0, maxCard: *, type: collection, endOf: discovery}
], super: []}).

% Credential Access enables Privilege Escalation
role(enabler{minCard: 0, maxCard: *, type: credentialAccess, endOf: privilegeEscalation}).
role(enabled{minCard: 0, maxCard: *, type: privilegeEscalation, endOf: credentialAccess}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: credentialAccess, endOf: privilegeEscalation},
  enabled{minCard: 0, maxCard: *, type: privilegeEscalation, endOf: credentialAccess}
], super: []}).

% Privilege Escalation enables Lateral Movement
role(enabler{minCard: 0, maxCard: *, type: privilegeEscalation, endOf: lateralMovement}).
role(enabled{minCard: 0, maxCard: *, type: lateralMovement, endOf: privilegeEscalation}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: privilegeEscalation, endOf: lateralMovement},
  enabled{minCard: 0, maxCard: *, type: lateralMovement, endOf: privilegeEscalation}
], super: []}).

% Remote Discovery enables Lateral Movement
role(enabler{minCard: 0, maxCard: *, type: remoteDiscovery, endOf: lateralMovement}).
role(enabled{minCard: 0, maxCard: *, type: lateralMovement, endOf: remoteDiscovery}).
assoc(enables{roles: [
  enabler{minCard: 0, maxCard: *, type: remoteDiscovery, endOf: lateralMovement},
  enabled{minCard: 0, maxCard: *, type: lateralMovement, endOf: remoteDiscovery}
], super: []}).

% Attack Plan -> Complex Action Type   (based on, Fig. 2)
role(basedOn{minCard: 0, maxCard: *, type: attackPlan, endOf: complexActionType}).
role(basisOf{minCard: 0, maxCard: *, type: complexActionType, endOf: attackPlan}).
assoc(basedOn{roles: [
  basedOn{minCard: 0, maxCard: *, type: attackPlan, endOf: complexActionType},
  basisOf{minCard: 0, maxCard: *, type: complexActionType, endOf: attackPlan}
], super: []}).

% =====================================================================
% D. comp/1 and aggreg/1
% =====================================================================
comp(Assoc)   :- assoc(Assoc),   get_dict(ontoUML, Assoc, composition).
aggreg(Assoc) :- assoc(Assoc),   get_dict(ontoUML, Assoc, aggregation).

% =====================================================================
% E. OntoUML class-to-class meta-instantiations
% =====================================================================
ontoUMLInstance(
  instantiates{
    source: attack,
    target: attackType,
    ontoUML: instantiation
  }
).

ontoUMLInstance(
  instantiates{
    source: supportingAsset,
    target: supportingAssetType,
    ontoUML: instantiation
  }
).

ontoUMLInstance(
  instantiates{
    source: vulnerability,
    target: vulnerabilityType,
    ontoUML: instantiation
  }
).

% Keep In+formed Action is categorized by the Keep In+formed meta-tactic:
% every Tactic instantiating keepInformed specializes keepInformedAction.
ontoUMLInstance(
  categorizes{
    source: keepInformedAction,
    target: keepInformed,
    ontoUML: categorization
  }
).
