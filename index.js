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

db.connect(err => {
  if (err) {
    console.error('Erro ao conectar ao MySQL:', err);
  } else {
    console.log('Conectado ao MySQL com sucesso!');
  }
});

app.post('/login', (req, res) => {
  const { usuario, senha } = req.body;

  const sql = `
    SELECT * FROM tb_users 
    WHERE (user_email = ? OR user_celular = ?) 
      AND user_senha = ?
  `;

  db.query(sql, [usuario, usuario, senha], (err, results) => {
    if (err) {
      console.error('Erro ao buscar usuário:', err);
      return res.status(500).json({ success: false, message: 'Erro interno no servidor' });
    }

    if (results.length > 0) {
      res.json({ success: true, message: 'Login realizado com sucesso' });
    } else {
      res.status(401).json({ success: false, message: 'Usuário não localizado ou dados incorretos.' });
    }
  });
});

app.post('/cadastro', (req, res) => {
  const {
    user_nome,
    user_sobrenome,
    user_data_nascimento,
    user_email,
    user_celular,
    user_senha,
  } = req.body;

  const verificarDuplicidade = `
    SELECT * FROM tb_users 
    WHERE user_email = ? OR user_celular = ?
  `;

  db.query(verificarDuplicidade, [user_email, user_celular], (err, resultados) => {
    if (err) {
      console.error('Erro ao verificar duplicidade:', err);
      return res.status(500).json({ success: false, message: 'Erro no servidor' });
    }

    if (resultados.length > 0) {
      const usuarioExistente = resultados[0];
      if (usuarioExistente.user_email === user_email) {
        return res.status(400).json({ success: false, message: 'E-mail já registrado.' });
      }
      if (usuarioExistente.user_celular === user_celular) {
        return res.status(400).json({ success: false, message: 'Celular já registrado.' });
      }
    }

    const sql = `
      INSERT INTO tb_users (
        user_nome, user_sobrenome, user_data_nascimento,
        user_email, user_celular, user_senha
      ) VALUES (?, ?, ?, ?, ?, ?)
    `;

    db.query(sql, [
      user_nome,
      user_sobrenome,
      user_data_nascimento,
      user_email,
      user_celular,
      user_senha
    ], (err, result) => {
      if (err) {
        console.error('Erro ao inserir usuário:', err);
        return res.status(500).json({ success: false, message: 'Erro ao criar conta' });
      }

      res.json({ success: true, message: 'Conta criada com sucesso' });
    });
  });
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});