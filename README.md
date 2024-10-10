# Fair Management

Fair Management est une plateforme de gestion de kermesse qui permet aux utilisateurs d'organiser et de participer à des événements. Ce projet est divisé en deux parties principales : le frontend (client Flutter) et le backend (API Go).

## Table des matières

- [Installation](#installation)
- [Configuration](#configuration)
- [Utilisation](#utilisation)
- [Déploiement](#déploiement)
- [Contribuer](#contribuer)
- [Licence](#licence)

## Installation

### Frontend

1. Clonez le dépôt :

    ```bash
    git clone https://github.com/YourUsername/FairManagement.git
    cd FairManagement/client
    ```

2. Installez les dépendances Flutter :

    ```bash
    flutter pub get
    ```

3. Exécutez l'application :

    ```bash
    flutter run
    ```

### Backend

1. Clonez le dépôt (si ce n'est pas déjà fait) :

    ```bash
    git clone https://github.com/YourUsername/FairManagement.git
    cd FairManagement/backend
    ```

2. Installez les dépendances Go :

    ```bash
    go mod tidy
    ```

3. Lancer le serveur backend :

    ```bash
    go run main.go
    ```

## Configuration

### Fichiers de configuration

- `client/.env` : Variables d'environnement pour le frontend
- `backend/.env` : Variables d'environnement pour le backend

Assurez-vous de configurer ces fichiers avec les valeurs correctes pour votre environnement (ex: API base URL pour le client, base de données pour le backend).

Exemple `.env` pour le backend :

```env
DB_HOST=localhost
DB_PORT=5432
DB_USER=user
DB_PASS=password
DB_NAME=fair_management
```
## Utilisation

### Accéder à l'application

- **Frontend** : L'application Flutter est accessible sur l'émulateur, l'appareil ou le navigateur spécifié.
- **Backend** : API disponible à `http://localhost:8000/swagger/ui`.

### API Endpoints

#### Authentification

- `POST /register` : Inscription d'un utilisateur.
    - Body : `{ "name": "John", "email": "john@example.com", "password": "123456", "role": "parent" }`
  
- `POST /login` : Connexion de l'utilisateur.
    - Body : `{ "email": "john@example.com", "password": "123456" }`

- `POST /registerAdmin` : Inscription d'un administrateur.
    - Body : `{ "name": "Admin", "email": "admin@example.com", "password": "admin123" }`
  
- `GET /users` : Récupération de la liste des utilisateurs.

#### Gestion des Parents et Enfants

- `POST /get-children` : Récupération des enfants d'un parent.
    - Body : `{ "parent_id": 1 }`

#### Gestion des Stands

- `POST /add-stand` : Ajouter un nouveau stand.
    - Body : `{ "name": "Food Stand", "stock": 100 }`
  
- `PATCH /update-stand` : Mettre à jour les informations d'un stand.
    - Body : `{ "stand_id": 1, "name": "Updated Food Stand", "stock": 150 }`

- `POST /consume-tokens` : Consommer des jetons sur un stand.
    - Body : `{ "user_id": 1, "stand_id": 1, "tokens": 10 }`

#### Gestion des Tokens

- `POST /buy-tokens` : Acheter des jetons pour un parent.
    - Body : `{ "parent_id": 1, "amount": 50 }`
  
- `POST /distribute-tokens` : Distribuer des jetons à un enfant.
    - Body : `{ "parent_id": 1, "student_id": 2, "token_count": 20 }`

#### Gestion de la Tombola

- `POST /enter-tombola` : Inscrire un élève à la tombola.
    - Body : `{ "student_id": 1, "tickets": 5 }`

- `POST /draw-tombola` : Tirer au sort un gagnant de la tombola.
    - Aucun paramètre requis.


