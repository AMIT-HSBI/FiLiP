# FiliP
Tool zur Simulation der Pflegepersonaleinsatzplannung aus dem Projekt FiliP (Flexible und intelligente Pflegepersonalplanung für ein
demografiefestes Krankenhaus)

## Projekt Beschreibung
Die Pflege im Krankenhaus ist in doppelter Hinsicht vom demografischen Wandel betroffen. Einerseits führt die Zunahme älterer und multimorbider Patientinnen und Patienten zu komplexeren und verdichteteren Arbeitsanforderungen, andererseits fällt es zunehmend schwerer, den benötigten Nachwuchs an Berufsanfängerinnen und Berufsanfängern sicherzustellen. Eine besondere Notwendigkeit besteht somit auch darin, die Gesundheit und Beschäftigungsfähigkeit der alternden Belegschaften langfristig zu erhalten.

Als ein wichtiger Baustein der betrieblichen Gesundheitsförderung sind alternative Arbeitsmodelle anerkannt. Bisher wurde allerdings kaum untersucht, wie solche Modelle gestaltet sein könnten, damit sie den Bedürfnissen der Pflegenden und denen der Patientinnen und Patienten entsprechen.

Das Projekt leistet hier einen konkreten Beitrag, in dem darin ein neuartiges Software-Tool entwickelt wird, das Kliniken bei einer effektiven und ressourcenschonenden Pflegepersonalplanung unterstützt. Die Entwicklung erfolgt durch Pflegewissenschaftler und Mathematiker, in Zusammenarbeit mit drei Kliniken. Grundlegend für das Tool ist eine Analyse der Bedarfe seitens der Kliniken, der Bedürfnisse der Pflegenden sowie des Pflegeaufwands. Aus den gewonnenen Erkenntnissen werden Mitarbeiter- und Patiententypen modelliert, die in ein mathematisches Modell übertragen werden, mit dem Simulationen möglich sind. Eine Klinik kann so z.B. eine Umstellung des Schichtsystems simulieren und das Ergebnis zur Entscheidungsfindung nutzen.


## Tool Beschreibung
Das FiliP-Tool besteht aus folgenden Komponenten:

 * FiliP: Ordner wo alle Dateien des Simulationstools enthalten sind
   * Bibliothek: Modelica Biblitheken für das Tool.
   * Simulationsdiagramme: Ordner wo Ergebnisdiagramme abgespeichert werden.
   * Simulationsergebnisse: Ordner wo Ergebnisdateine abgespeichert werden.
   * FiliP-Excel: Excel-GUI zur nutzung der Modelica Modelle.
 * Handbuch: Wichtige Infos zur Benutzung und einrichtung des Tools
 * Schulungsaufgabe FiliP: Eine aufgabe um die wichtigsten Funktionen des Tools an einem "Mini"-Beispiel zu testen.


## Kompatibilität
Damit das FiliP-Tool funktioniert, muss auf dem Rechner eine funktionsfähige Version von OpenModelicainstalliert sein. (https://www.openmodelica.org/download/download-windows) Das FiliP-Modell wird bis Version 1.13.0 unterstützt. Bei neueren Versionen kann keine Garantie für die Funktionsfähigkeit gegeben werden.

## License
Dieses Tool und die Modelica-Bibliotheken sind freie Software und die Verwendung erfolgt vollständig auf eigenes Risiko.
Es kann unter den Bedingungen ded. [3-clause BSD](https://www.modelica.org/licenses/modelica-3-clause-bsd) weitergegeben und/oder modifiziert werden.

## Entwickler
    Fachhochschule Bielefeld
    Interaktion 1
    33619 Bielefeld
    Deutschland
* Annette Nauerth
* Bernhard Bachmann
* Hermann-Josef Kruse
* Christian Grebe
* Timo Lask
* Eva Trompetter

## Gefördert von
Bundesministerium für Bildung und Forschung (BMBF) in der Förderlinie SILQUA-FH 2015


