# Requirements – Tic-Tac-Toe (Ruby on Rails + React)

## Descripción General

El aprendiz desarrollará el clásico juego de **Tic-Tac-Toe** como una aplicación web utilizando **Ruby on Rails** para el backend (API REST) y **React** para el frontend.  
El proyecto se gestionará utilizando la metodología **Scrum**, con **Trello** como herramienta de seguimiento y **GitHub** para el control de versiones.

El mentor asumirá el rol de **Product Owner (cliente)**, proporcionando retroalimentación continua y validando los entregables.

---

## Descripción del Juego

Tic-Tac-Toe es un juego de dos jugadores que se turnan para marcar una celda en una cuadrícula de 3x3.

- Jugador 1: **X**
- Jugador 2: **O**

Gana el primer jugador que alinee tres símbolos en una fila, columna o diagonal.  
Si todas las celdas están ocupadas y no hay ganador, la partida termina en **empate**.

---

## Arquitectura General

- **Backend**: Ruby on Rails (API REST)
- **Frontend**: React
- **Persistencia**: Base de datos relacional (ActiveRecord)
- **Comunicación**: JSON vía HTTP
- **Control de versiones**: GitHub

---

## Requisitos del Backend (Ruby on Rails)

### Lógica del Juego

- Implementar la cuadrícula de 3x3 como estructura de datos en el backend.
- Gestionar turnos entre jugadores.
- Validar movimientos:
  - Coordenadas válidas.
  - Celda no ocupada.
- Detectar:
  - Condición de victoria.
  - Condición de empate.
- Bloquear la partida una vez finalizada.

### Modelos Principales

- **Game**
  - Estado del juego (en progreso, ganado, empate).
  - Turno actual.
- **Board**
  - Representación del tablero.
  - Validación de movimientos.
  - Lógica de victoria y empate.
- **Player**
  - Identificador del jugador.
  - Símbolo asignado.

### API REST

Endpoints sugeridos:

- `POST /games` – Crear nueva partida.
- `GET /games/:id` – Obtener estado actual del juego.
- `POST /games/:id/moves` – Realizar una jugada.
- `POST /games/:id/reset` – Reiniciar partida.

---

## Requisitos del Frontend (React)

### Interfaz de Usuario

- Mostrar tablero 3x3 de forma visual.
- Permitir seleccionar una celda para jugar.
- Mostrar:
  - Turno actual.
  - Mensajes de victoria o empate.
  - Errores por movimientos inválidos.
- Actualizar el estado del tablero según la respuesta del backend.

### Componentes Sugeridos

- `Game`
- `Board`
- `Cell`
- `GameStatus`

### Comunicación con Backend

- Uso de `fetch` o `axios`.
- Manejo de estados con `useState` y `useEffect`.

---

## Persistencia de Datos

- Guardar partidas finalizadas.
- Permitir consultar historial de partidas (opcional).

---

## Pruebas Automatizadas

### Backend

- Pruebas unitarias con **RSpec o Minitest**:
  - Validación de movimientos.
  - Detección de ganador.
  - Empate.

### Frontend (Opcional)

- Pruebas básicas con Jest / React Testing Library.

---

## Extras Opcionales

- Modo jugador vs computadora.
- Historial de partidas.
- Sistema de rondas (mejor de 3 / 5).
- Estilos con CSS, Tailwind o Bootstrap.

---

## Gestión del Proyecto con GitHub

### Branches

- `main`
- `feature/[ticket#]_backend-game-logic`
- `feature/[ticket#]_react-board`
- `fix/[ticket#]_move-validation`

### Pull Requests

- Descripción clara del cambio.
- Relación con historia de usuario.
- Revisión por parte del mentor.

---

## Gestión del Proyecto con Scrum

### Roles

- Aprendiz:
  - Scrum Master
  - Desarrollador
- Mentor:
  - Product Owner

### Tablero de Trello

1. Backlog
2. To Do
3. In Progress
4. Review
5. Done

---

## Historias de Usuario (Ejemplos)

- Como jugador, quiero hacer una jugada desde la interfaz web para avanzar la partida.
- Como jugador, quiero recibir un mensaje cuando gane o empate.
- Como mentor, quiero revisar el estado del juego mediante una API clara.

---

## Sprints

- Duración: 1 semana
- Incluye:
  - Planificación
  - Desarrollo
  - Revisión
  - Retrospectiva

---

## Objetivos del Proyecto

### Técnicos

- Desarrollar una aplicación full-stack con Rails + React.
- Aplicar buenas prácticas de diseño y arquitectura.
- Implementar pruebas automatizadas.

### Gestión

- Aplicar Scrum de forma práctica.
- Gestionar tareas con Trello.
- Utilizar GitHub como en un entorno profesional.
