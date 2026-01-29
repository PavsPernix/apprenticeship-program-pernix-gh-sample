import axios from 'axios';

const API_BASE_URL = 'http://localhost:3000/api/v1';

const gameApi = {
  createGame: () => axios.post(`${API_BASE_URL}/games`),

  getGame: (id) => axios.get(`${API_BASE_URL}/games/${id}`),

  makeMove: (id, position) =>
    axios.post(`${API_BASE_URL}/games/${id}/move`, { move: { position } }),

  resetGame: (id) => axios.post(`${API_BASE_URL}/games/${id}/reset`)
};

export default gameApi;
