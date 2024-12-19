
---

# README: Git Workflow und Befehle

## Einführung
Dieses Projekt verwendet **Git** zur Versionskontrolle. Nachfolgend findest du eine Anleitung zur Einrichtung von Git, einer Liste der wichtigsten Befehle sowie empfohlene Workflows für die Zusammenarbeit im Team.

---

## Git einrichten

1. **Git installieren:**  
   - **Windows:** Git von der offiziellen Seite [https://git-scm.com/download/win](https://git-scm.com/download/win) herunterladen und installieren.  
   - **Linux:** Mit dem Paketmanager installieren (z. B. `sudo apt-get install git`).  
   - **macOS:** Mit Homebrew installieren (`brew install git`) oder die vorinstallierte Version nutzen.

2. **Git konfigurieren:**  
   Nach der Installation muss Git mit deinem Namen und deiner E-Mail-Adresse eingerichtet werden. Diese Daten erscheinen in den Commits:
   - git config --global user.name "Dein Name"
   - git config --global user.email "deine.email@example.com"

3. **Repository klonen:**  
   Um mit dem gemeinsamen Repository zu arbeiten, klone es in einen lokalen Ordner:  
   - git clone URL_des_Repositories  
   - Danach in den Projektordner wechseln: cd projektname

---

## Wichtige Git-Befehle

### Repository und Änderungen

- **Status anzeigen:**  
  git status  
  Zeigt den aktuellen Zustand deines Arbeitsverzeichnisses und ob es Änderungen gibt, die noch nicht committet wurden.

- **Dateien hinzufügen:**  
  git add .  
  Fügt alle Änderungen in der Arbeitskopie zur Staging-Area hinzu (bereit zum Commit).

- **Änderungen committen:**  
  git commit -m "Beschreibung der Änderungen"  
  Speichert die Änderungen in der lokalen Versionshistorie mit einer Beschreibung.

---

### Synchronisierung mit Remote

- **Änderungen hochladen (Push):**  
  git push origin main  
  Lädt die lokalen Commits ins zentrale Remote-Repository hoch.

- **Änderungen herunterladen (Pull):**  
  git pull  
  Holt die neuesten Änderungen vom Remote-Repository und integriert sie in deinen aktuellen Branch.

- **Nur Änderungen herunterladen (Fetch):**  
  git fetch  
  Holt die neuesten Änderungen vom Remote-Repository, ohne sie zu integrieren. Diese können manuell geprüft werden.

---

### Branching und Konflikte

#### Branch erstellen und nutzen
- **Branch erstellen und wechseln:**  
  git checkout -b branch-name  
  Erstellt einen neuen Branch mit dem Namen `branch-name` und wechselt direkt dorthin.

- **Branch wechseln:**  
  git checkout branch-name  
  Wechselt zu einem bestehenden Branch.

- **Branch mit Hauptbranch mergen:**  
  git checkout main  
  git merge branch-name  
  Wechselt zum Hauptbranch (`main`) und integriert die Änderungen aus `branch-name`.

#### Konflikte lösen
Wenn beim Mergen Konflikte auftreten, bearbeite die betroffenen Dateien manuell, um die Konflikte zu beheben. Danach:  
- git add .  
- git commit -m "Konflikte gelöst"

---

### Historie und Änderungen

- **Historie anzeigen:**  
  git log  
  Zeigt die Liste der bisherigen Commits.

- **Änderungen anzeigen:**  
  git diff  
  Zeigt, was in den Dateien seit dem letzten Commit geändert wurde.

- **Dateien aus älterem Commit wiederherstellen:**  
  git checkout commit-hash -- dateiname  
  Holt eine bestimmte Datei aus einem älteren Commit zurück.

---

## Empfohlener Workflow im Team

1. **Repository aktualisieren:**  
   - Bevor du mit der Arbeit beginnst, immer die neuesten Änderungen herunterladen:  
     git pull

2. **Neuen Branch erstellen:**  
   - Für größere Änderungen oder neue Features einen eigenen Branch anlegen:  
     git checkout -b feature-name

3. **Änderungen committen:**  
   - Nach jeder abgeschlossenen Änderung:  
     git add .  
     git commit -m "Beschreibung der Änderungen"

4. **Änderungen hochladen:**  
   - Änderungen in den Branch pushen:  
     git push origin feature-name

5. **Merge-Request oder Pull-Request stellen:**  
   - Auf GitHub oder GitLab einen Merge-Request stellen, um Änderungen in den Hauptbranch zu übernehmen.

---

Mit diesen Befehlen und Workflows könnt ihr effizient im Team arbeiten. Nutzt Branches, um parallele Entwicklungen zu ermöglichen, und synchronisiert regelmäßig eure Änderungen mit dem Remote-Repository.

---