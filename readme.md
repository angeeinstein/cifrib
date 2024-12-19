Einstieg ins Projekt:

Git installieren:
Windows: Auf git-scm.com herunterladen und installieren
Linux (z. B. Debian/Ubuntu): "sudo apt-get install git"
macOS: "brew install git" oder Git ist oft schon vorinstalliert

Repository klonen:
Ihr erhaltet eine URL. Gebt sie im Terminal ein:
git clone https://github.com/benutzername/projektname.git
cd projektname

Am Projekt arbeiten:
Bevor ihr Änderungen macht, holt den aktuellen Stand:
git pull

Danach könnt ihr Dateien bearbeiten und neue Funktionen hinzufügen.

Änderungen einchecken:
git add .
git commit -m "Beschreibe hier deine Änderungen"
git push

Damit werden eure Änderungen lokal festgehalten und ins zentrale Repository hochgeladen.

Wichtige Git-Befehle:

• Status anzeigen:
git status
Zeigt geänderte Dateien und ob noch etwas zum Committen bereitsteht.

• Änderungen zur Stage hinzufügen:
git add .
Fügt alle geänderten Dateien zum nächsten Commit hinzu.

• Commit erstellen:
git commit -m "Kurze Beschreibung der Änderung"
Speichert den aktuellen Stand als neuen Versionspunkt.

• Änderungen hochladen (Push):
git push origin main
Überträgt alle lokalen Commits ins zentrale Repository.

• Aktuellen Stand holen (Pull):
git pull
Holt neue Commits vom zentralen Repo und integriert diese lokal.

• Historie ansehen:
git log
Zeigt alle vergangenen Commits mit Beschreibung.

• Branch erstellen und wechseln:
git checkout -b neuer-branch
Erstellt einen neuen Entwicklungszweig und wechselt direkt dorthin.