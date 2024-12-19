## Einstieg ins Projekt

1. **Git installieren:**  
   - Windows: Git von [https://git-scm.com/download/win](https://git-scm.com/download/win) herunterladen und installieren  
   - Linux (z. B. Debian/Ubuntu): `sudo apt-get install git`  
   - macOS: `brew install git` oder Git ist oft bereits vorinstalliert

2. **Repository klonen:**  
   - Erhaltet die URL vom Projektverantwortlichen  
   - Dann im Terminal:  
     - `git clone https://github.com/benutzername/projektname.git`  
     - `cd projektname`

3. **Am Projekt arbeiten:**  
   - Bevor ihr neue Änderungen macht, immer zuerst den aktuellen Stand holen:  
     - `git pull`

   Anschließend Dateien wie gewohnt bearbeiten.

4. **Änderungen einchecken:**  
   - Dateien zur Staging-Area hinzufügen:  
     - `git add .`
   - Änderungen committen:  
     - `git commit -m "Kurze Beschreibung der Änderungen"`
   - Aktuelle Commits zum zentralen Repository hochladen:  
     - `git push`

## Wichtige Git-Befehle

- **Status anzeigen:**  
  `git status`  
  Zeigt, welche Dateien geändert wurden und ob noch etwas zum Committen bereitsteht.

- **Änderungen zur Stage hinzufügen:**  
  `git add .`  
  Fügt alle geänderten Dateien zum nächsten Commit hinzu.

- **Commit erstellen:**  
  `git commit -m "Beschreibung"`  
  Speichert den aktuellen Stand als neuen Versionspunkt.

- **Änderungen hochladen (Push):**  
  `git push origin main`  
  Überträgt lokale Commits ins zentrale Repository.

- **Aktuellen Stand holen (Pull):**  
  `git pull`  
  Holt neue Commits vom zentralen Repo und integriert sie lokal.

- **Historie ansehen:**  
  `git log`  
  Zeigt alle vergangenen Commits mit Beschreibung.

- **Branch erstellen und wechseln:**  
  `git checkout -b neuer-branch`  
  Erstellt einen neuen Entwicklungszweig und wechselt direkt darauf.

---

Mit diesen Schritten und Befehlen könnt ihr schnell und einfach am gemeinsamen Projekt mitarbeiten. Sobald ihr damit vertraut seid, könnt ihr auch komplexere Git-Funktionen wie Branch-Management, Merge-Konflikte lösen oder Pull Requests nutzen.