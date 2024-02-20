# hacking_machine

## Objectifs :

L'objectif c'est de m'entrainer sur Ansible (la même chose sera faite avec SaltStack). Actuellement pour faire des box HTB / THM, j'utilise une Kali Linux. Je veux faire en sorte d'avoir le choix d'avoir tous les outils dont j'ai besoin sur n'importe quelle distro et assez de notes, d'exploitation tools et d'exploits liés à des CVE directement installés localement (et avec l'objectif d'enrichir le tout).
Actuellement tout est en français mais ça sera traduit je ne sais quand.

1) Répertorier tous les outils que j'utilise (et la possibilité d'en ajouter) et les installer
2) Créer une arborescence de dossiers pour des exploits CVE (triés par techno)
4) Créer un répertoire pour les "exploitation tools" (linpeas...)
5) Créer un répertoire "notes" pour stocker des notes liées à tel ou tel sujet
....

Notes :

- ```wget -O /tmp/bootstrap_node_manager.sh https://raw.githubusercontent.com/khaddict/hacking_machine/main/bootstrap_node_manager.sh && chmod +x /tmp/bootstrap_node_manager.sh && cd /tmp && ./bootstrap_node_manager.sh```