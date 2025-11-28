# Modèle de données — Liste des tables et champs

Ce fichier regroupe la liste des tables proposées pour l'application Planify et leurs champs (types pensés pour SQLite).

---

## projects
- id INTEGER PRIMARY KEY AUTOINCREMENT
- uuid TEXT UNIQUE NOT NULL
- title TEXT NOT NULL
- description TEXT
- color TEXT
- archived INTEGER NOT NULL DEFAULT 0
- order_index INTEGER DEFAULT 0
- created_at INTEGER NOT NULL    -- epoch ms
- updated_at INTEGER NOT NULL
- owner_id INTEGER               -- REFERENCES users(id)

## tasks
- id INTEGER PRIMARY KEY AUTOINCREMENT
- uuid TEXT UNIQUE NOT NULL
- title TEXT NOT NULL
- description TEXT
- project_id INTEGER             -- REFERENCES projects(id)
- parent_task_id INTEGER         -- REFERENCES tasks(id) (sous-tâches)
- due_date INTEGER               -- epoch ms
- start_date INTEGER             -- epoch ms
- completed INTEGER NOT NULL DEFAULT 0  -- 0/1
- completed_at INTEGER
- priority INTEGER DEFAULT 0
- status TEXT DEFAULT 'open'
- order_index INTEGER DEFAULT 0
- metadata TEXT                  -- JSON stocké en TEXT pour champs custom
- recurrence_id INTEGER          -- REFERENCES recurrences(id)
- created_at INTEGER NOT NULL
- updated_at INTEGER NOT NULL
- deleted_at INTEGER             -- soft-delete
- owner_id INTEGER               -- REFERENCES users(id)

## tags
- id INTEGER PRIMARY KEY AUTOINCREMENT
- name TEXT NOT NULL
- color TEXT
- owner_id INTEGER               -- REFERENCES users(id)
- created_at INTEGER
- UNIQUE(owner_id, name) (optionnel)

## task_tags (many-to-many)
- task_id INTEGER NOT NULL       -- REFERENCES tasks(id)
- tag_id INTEGER NOT NULL        -- REFERENCES tags(id)
- PRIMARY KEY (task_id, tag_id)

## attachments
- id INTEGER PRIMARY KEY AUTOINCREMENT
- task_id INTEGER                -- REFERENCES tasks(id)
- filename TEXT NOT NULL
- file_path TEXT NOT NULL        -- chemin local relatif (pas de BLOB volumineux)
- mime_type TEXT
- size INTEGER
- created_at INTEGER

## reminders
- id INTEGER PRIMARY KEY AUTOINCREMENT
- task_id INTEGER                -- REFERENCES tasks(id)
- remind_at INTEGER NOT NULL     -- epoch ms
- method TEXT DEFAULT 'local'    -- local, push, email
- repeat INTEGER DEFAULT 0       -- bool 0/1 (optionnel)
- created_at INTEGER

## recurrences
- id INTEGER PRIMARY KEY AUTOINCREMENT
- task_id INTEGER NOT NULL UNIQUE -- REFERENCES tasks(id)
- rrule TEXT NOT NULL            -- règle (RFC5545 / JSON)
- next_occurrence INTEGER        -- cache epoch ms
- timezone TEXT
- created_at INTEGER
- updated_at INTEGER

## users (optionnel)
- id INTEGER PRIMARY KEY AUTOINCREMENT
- uuid TEXT UNIQUE NOT NULL
- name TEXT
- email TEXT UNIQUE
- created_at INTEGER
- updated_at INTEGER

## activity_log
- id INTEGER PRIMARY KEY AUTOINCREMENT
- entity_type TEXT NOT NULL      -- 'task','project','tag', ...
- entity_id INTEGER NOT NULL
- action TEXT NOT NULL           -- 'create','update','delete','complete', ...
- actor_id INTEGER               -- REFERENCES users(id)
- payload TEXT                   -- JSON avec détails/changes
- created_at INTEGER NOT NULL

## settings (optionnel)
- id INTEGER PRIMARY KEY AUTOINCREMENT
- owner_id INTEGER               -- REFERENCES users(id)
- key TEXT
- value TEXT
- UNIQUE(owner_id, key)

---

## Indexation recommandée
- INDEX idx_tasks_project_due ON tasks(project_id, due_date)
- INDEX idx_tasks_due ON tasks(due_date)
- INDEX idx_tasks_owner ON tasks(owner_id)
- INDEX idx_tags_name ON tags(name)
- INDEX idx_reminders_time ON reminders(remind_at)
- Utiliser FTS5 pour recherche texte sur `tasks` (title + description)

## Notes rapides
- Stocker fichiers sur le système (file_path) plutôt que BLOB dans SQLite.
- Pour la récurrence, stocker la règle en `rrule` et générer les occurrences à la volée; si besoin, matérialiser plus tard une table `task_instances`.
- Prévoir champs de synchronisation (uuid, updated_at, sync_state) si vous ajoutez sync serveur.

---

Faites-moi savoir si vous voulez que je génère :
- un script SQL complet (migration v1) ;
- un schéma Drift (`tables.dart`) prêt à l'emploi ;
- ou un diagramme ER (PlantUML).
