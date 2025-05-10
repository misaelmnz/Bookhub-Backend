const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'db_bookhub',
  port: 3306
});

app.get('/test-connection', (req, res) => {
  db.connect(err => {
    if (err) {
      console.error('Erro ao conectar:', err);
      res.status(500).json({ success: false, message: 'Erro na conexão' });
    } else {
      res.json({ success: true, message: 'Conectado ao MySQL com sucesso!' });
    }
  });
});

app.get('/users', (req, res) => {
    db.query('SELECT * FROM tb_users', (err, results) => {
      if (err) {
        console.error('Erro ao buscar usuários:', err);
        res.status(500).json({ message: 'Erro ao buscar usuários' });
      } else {
        res.json(results);
      }
    });
  });

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});