# FiliP
Tool zur Simulation der Pflegepersonaleinsatzplanung aus dem Projekt FiliP (Flexible und intelligente Pflegepersonalplanung für ein demografiefestes Krankenhaus)

## Projekt-Beschreibung
Die Pflege im Krankenhaus ist in doppelter Hinsicht vom demografischen Wandel betroffen. Einerseits führt die Zunahme älterer und multimorbider Patientinnen und Patienten zu komplexeren und verdichteteren Arbeitsanforderungen, andererseits fällt es zunehmend schwerer, den benötigten Nachwuchs an Berufsanfängerinnen und Berufsanfängern sicherzustellen. Eine besondere Notwendigkeit besteht somit auch darin, die Gesundheit und Beschäftigungsfähigkeit der alternden Belegschaften langfristig zu erhalten.

Als ein wichtiger Baustein der betrieblichen Gesundheitsförderung sind alternative Arbeitsmodelle anerkannt. Bisher wurde allerdings kaum untersucht, wie solche Modelle gestaltet sein könnten, damit sie den Bedürfnissen der Pflegenden und denen der Patientinnen und Patienten gerecht werden.

Das Projekt leistet hier einen konkreten Beitrag, in dem darin ein neuartiges Software-Tool entwickelt wird, das Kliniken bei einer effektiven und ressourcenschonenden Pflegepersonalplanung unterstützt. Die Entwicklung erfolgt durch Pflegewissenschaftler bzw. Pflegewissenschaftlerinnen und Mathematiker bzw. Mathematikerinnen, in Zusammenarbeit mit drei Kliniken. Grundlegend für das Tool ist eine Analyse der Bedarfe seitens der Kliniken, der Bedürfnisse der Pflegenden sowie des Pflegeaufwands. Aus den gewonnenen Erkenntnissen werden Mitarbeiter- bzw. Mitarbeiterinnen- und Patiententypen modelliert, die in ein mathematisches Modell übertragen werden, mit dem Simulationen möglich sind. Eine Klinik kann so z.B. eine Umstellung des Schichtsystems simulieren und das Ergebnis zur Entscheidungsfindung nutzen.


## Tool-Beschreibung
Das FiliP-Tool besteht aus folgenden Komponenten:

 * FiliP: Ordner, in dem alle Dateien des Simulationstools enthalten sind.
   * Bibliothek: Modelica-Bibliotheken für das Tool.
   * Config: Konfigurationsdateien
   * Simulationsdiagramme: Ordner, in dem Ergebnisdiagramme abgespeichert werden.
   * Simulationsergebnisse: Ordner, in dem Ergebnisdateien abgespeichert werden.
   * FiliP-Excel: Excel-GUI zur Nutzung der Modelica-Modelle.
 * Handbuch: Wichtige Infos zur Benutzung und Einrichtung des Tools.
 * Schulungsaufgabe FiliP: Eine Aufgabenstellung, um die wichtigsten Funktionen des Tools an einem "Mini"-Beispiel zu testen.



## Kompatibilität
Damit das FiliP-Tool funktioniert, muss auf dem Rechner eine funktionsfähige Version von OpenModelica installiert sein (https://www.openmodelica.org/download/download-windows). Das FiliP-Modell wird bis Version 1.13.0 unterstützt. Bei neueren Versionen kann keine Garantie für die Funktionsfähigkeit gegeben werden.

## Lizenz
Dieses Tool und die Modelica-Bibliotheken sind freie Software und die Verwendung erfolgt vollständig auf eigenes Risiko.
Es kann unter den Bedingungen [3-clause BSD](https://www.modelica.org/licenses/modelica-3-clause-bsd) weitergegeben und/oder modifiziert werden.


## Entwickler
    Fachhochschule Bielefeld
    Interaktion 1
    33619 Bielefeld
    Deutschland
	Email: mathematik@fh-bielefeld.de
* Prof. Dr. med. Annette Nauerth
* Prof. Dr. phil. Bernhard Bachmann
* Prof. Dr. rer. pol. Hermann-Josef Kruse
* Christian Grebe, MScN
* Timo Lask, M.Sc.
* Eva Trompetter, M.Sc.
* Paul Hammerschmidt, B.Sc.
* Marleen Schneider

## Gefördert von Bundesministerium für Bildung und Forschung (BMBF) in der Förderlinie SILQUA-FH 2015


