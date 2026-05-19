% =====================================================================
%
% ROCAP meta-model.
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
%   ontoUMLLink      Tag{metaInstantiations:[OntoUMLInstanceDict...]}
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
class(attackPlan{super: [closedIntention], ontoUML: subKind}).

% --- Experience Risk Assessment ---
class(risk{super: [], ontoUML:quantity}).
class(untreatedRisk{super:[risk], ontoUML:historicalRole}).
class(agent{super: [], ontoUML:category}).
class(attacker{super:[agent], ontoUML:roleMixin}).
class(threatCapability{super:[], ontoUML:roleMixin}).
class(experienceRiskAssessment{super: [], ontoUML:subkind}).


% --- J. ATT&CK high-order types (powertypes) ---
class(eventType{super:[], ontoUML:type}).
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

% Attack -> Loss Event
role(causes{minCard: 0, maxCard: *, type: attack, endOf: lossEvent}).
role(causedBy{minCard: 0, maxCard: *, type: lossEvent, endOf: attack}).
assoc(causes{roles: [
  causes{minCard: 0, maxCard: *, type: attack, endOf: lossEvent},
  causedBy{minCard: 0, maxCard: *, type: lossEvent, endOf: attack}
], ontoUML: historicalDependence, super: []}).

% Attack -> Attack Plan 
role(causedBy{minCard: 0, maxCard: *, type: attackPlan, endOf: attack}).
role(causes{minCard: 0, maxCard: *, type: attack, endOf: basedOn}).
assoc(basedOn{roles: [
  causes{minCard: 0, maxCard: *, type: attack, endOf: basedOn},
  causedBy{minCard: 0, maxCard: *, type: attackPlan, endOf: basedOn}
], super: []}).

% Supporting Asset -> Attack 
role(offensivelyEngagedBy{minCard: 0, maxCard: *, type: supportingAsset, endOf: attack}).
role(offensivelyEngages{minCard: 0, maxCard: *, type: attack, endOf: supportingAsset}).
assoc(offensivelyEngagedBy{roles: [
  offensivelyEngagedBy{minCard: 0, maxCard: *, type: supportingAsset, endOf: attack},
  offensivelyEngages{minCard: 0, maxCard: *, type: attack, endOf: supportingAsset}
], ontoUML: participation, super: []}).

% Business Asset -> Supporting Asset
role(composes{minCard: 1, maxCard: *, type: supportingAsset, endOf: businessAsset}).
role(composedOf{minCard: 1, maxCard: *, type: businessAsset, endOf: supportingAsset}).
assoc(composes{roles: [
  composes{minCard: 1, maxCard: *, type: supportingAsset, endOf: businessAsset},
  composedOf{minCard: 1, maxCard: *, type: businessAsset, endOf: supportingAsset}
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

% CAPECC Pattern -> ATT&CK Tactic
role(partOf{minCard: 1, maxCard: *, type: capecPattern, endOf: attackTactic}).
role(composedOf{minCard: 0, maxCard: *, type: attackTactic, endOf: capecPattern}).
assoc(partOf{roles: [
  partOf{minCard: 1, maxCard: *, type: capecPattern, endOf: attackTactic},
  composedOf{minCard: 0, maxCard: *, type: attackTactic, endOf: capecPattern}
], super: []}).

% ATT&CK Technique -> ATT&CK Tactic
role(partOf{minCard: 1, maxCard: *, type: attackTechnique, endOf: attackTactic}).
role(composedOf{minCard: 0, maxCard: *, type: attackTactic, endOf: attackTechnique}).
assoc(partOf{roles: [
  partOf{minCard: 1, maxCard: *, type: attackTechnique, endOf: attackTactic},
  composedOf{minCard: 0, maxCard: *, type: attackTactic, endOf: attackTechnique}
], super: []}).

% =====================================================================
%  C. kill-chain ordering of ATT&CK tactics
% =====================================================================

% Reconnaissance -> Resource Development   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: reconnaissance, endOf: resourceDevelopment}).
role(dependsOn{minCard: 0, maxCard: *, type: resourceDevelopment, endOf: reconnaissance}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: reconnaissance, endOf: resourceDevelopment},
  dependsOn{minCard: 0, maxCard: *, type: resourceDevelopment, endOf: reconnaissance}
], ontoUML: historicalDependence, super: []}).

% Resource Development -> Initial Access   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: resourceDevelopment, endOf: initialAccess}).
role(dependsOn{minCard: 0, maxCard: *, type: initialAccess, endOf: resourceDevelopment}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: resourceDevelopment, endOf: initialAccess},
  dependsOn{minCard: 0, maxCard: *, type: initialAccess, endOf: resourceDevelopment}
], ontoUML: historicalDependence, super: []}).

% Initial Access -> Keep Informed   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: initialAccess, endOf: keepInformed}).
role(dependsOn{minCard: 0, maxCard: *, type: keepInformed, endOf: initialAccess}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: initialAccess, endOf: keepInformed},
  dependsOn{minCard: 0, maxCard: *, type: keepInformed, endOf: initialAccess}
], ontoUML: historicalDependence, super: []}).

% Initial Access -> Discovery   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: initialAccess, endOf: discovery}).
role(dependsOn{minCard: 0, maxCard: *, type: discovery, endOf: initialAccess}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: initialAccess, endOf: discovery},
  dependsOn{minCard: 0, maxCard: *, type: discovery, endOf: initialAccess}
], ontoUML: historicalDependence, super: []}).

% Discovery -> Keep Informed   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: discovery, endOf: keepInformed}).
role(dependsOn{minCard: 0, maxCard: *, type: keepInformed, endOf: discovery}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: discovery, endOf: keepInformed},
  dependsOn{minCard: 0, maxCard: *, type: keepInformed, endOf: discovery}
], ontoUML: historicalDependence, super: []}).

% Collection -> Exfiltration   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: collection, endOf: exfiltration}).
role(dependsOn{minCard: 0, maxCard: *, type: exfiltration, endOf: collection}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: collection, endOf: exfiltration},
  dependsOn{minCard: 0, maxCard: *, type: exfiltration, endOf: collection}
], ontoUML: historicalDependence, super: []}).

% Exfiltration -> Impact   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: exfiltration, endOf: impact}).
role(dependsOn{minCard: 0, maxCard: *, type: impact, endOf: exfiltration}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: exfiltration, endOf: impact},
  dependsOn{minCard: 0, maxCard: *, type: impact, endOf: exfiltration}
], ontoUML: historicalDependence, super: []}).

% Collection -> Discovery   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: collection, endOf: discovery}).
role(dependsOn{minCard: 0, maxCard: *, type: discovery, endOf: collection}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: collection, endOf: discovery},
  dependsOn{minCard: 0, maxCard: *, type: discovery, endOf: collection}
], ontoUML: historicalDependence, super: []}).

% Credential Access -> Privilege Escalation   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: credentialAccess, endOf: privilegeEscalation}).
role(dependsOn{minCard: 0, maxCard: *, type: privilegeEscalation, endOf: credentialAccess}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: credentialAccess, endOf: privilegeEscalation},
  dependsOn{minCard: 0, maxCard: *, type: privilegeEscalation, endOf: credentialAccess}
], ontoUML: historicalDependence, super: []}).

% Privilege Escalation -> Lateral Movement   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: privilegeEscalation, endOf: lateralMovement}).
role(dependsOn{minCard: 0, maxCard: *, type: lateralMovement, endOf: privilegeEscalation}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: privilegeEscalation, endOf: lateralMovement},
  dependsOn{minCard: 0, maxCard: *, type: lateralMovement, endOf: privilegeEscalation}
], ontoUML: historicalDependence, super: []}).

% Remote Discovery -> Lateral Movement   (historicalDependence)
role(precedes{minCard: 0, maxCard: *, type: remoteDiscovery, endOf: lateralMovement}).
role(dependsOn{minCard: 0, maxCard: *, type: lateralMovement, endOf: remoteDiscovery}).
assoc(historicalDependence{roles: [
  precedes{minCard: 0, maxCard: *, type: remoteDiscovery, endOf: lateralMovement},
  dependsOn{minCard: 0, maxCard: *, type: lateralMovement, endOf: remoteDiscovery}
], ontoUML: historicalDependence, super: []}).

% Defense Evasion -> Tactic   (covers)
role(covers{minCard: 1, maxCard: *, type: defenseEvasion, endOf: attackTactic}).
role(coveredBy{minCard: 0, maxCard: *, type: attackTactic, endOf: defenseEvasion}).
assoc(covers{roles: [
  covers{minCard: 1, maxCard: *, type: defenseEvasion, endOf: attackTactic},
  coveredBy{minCard: 0, maxCard: *, type: attackTactic, endOf: defenseEvasion}
], super: []}).

% Attack Plan -> (complex) Event   (based on)
role(basedOn{minCard: 0, maxCard: *, type: attackPlan, endOf: complexEvent}).
role(basisOf{minCard: 0, maxCard: *, type: complexEvent, endOf: attackPlan}).
assoc(basedOn{roles: [
  basedOn{minCard: 0, maxCard: *, type: attackPlan, endOf: complexEvent},
  basisOf{minCard: 0, maxCard: *, type: complexEvent, endOf: attackPlan}
], super: []}).

% (complex) Event <>-- Tactic   (aggregation)
role(composes{minCard: 1, maxCard: *, type: attackTactic, endOf: complexEvent}).
role(composedOf{minCard: 1, maxCard: 1, type: complexEvent, endOf: attackTactic}).
assoc(composes{roles: [
  composes{minCard: 1, maxCard: *, type: attackTactic, endOf: complexEvent},
  composedOf{minCard: 1, maxCard: 1, type: complexEvent, endOf: attackTactic}
], super: []}).

% =====================================================================
% D. comp/1 and aggreg/1  --  
% =====================================================================
comp(Assoc)   :- assoc(Assoc),   get_dict(ontoUML, Assoc, composition).
aggreg(Assoc) :- assoc(Assoc),   get_dict(ontoUML, Assoc, aggregation).

% =====================================================================
% E. OntoUML class-to-class meta-instantiations
% =====================================================================
% ontoUMLInstance/1 : a single inter-class meta-instantiation dict.
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
