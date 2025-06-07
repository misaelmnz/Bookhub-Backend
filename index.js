const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const { faker } = require('@faker-js/faker');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser')

const SECRET_KEY = 'SECRET_KEY';

const app = express();
app.use(cors());
app.use(express.json());
app.use(bodyParser.json())

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

app.post('/pesquisar', (req, res) => {
  const { pesquisa } = req.body;

  if (!pesquisa) {
    return res.status(400).json({ success: false, message: 'Pesquisa não fornecida.' });
  }

  if (typeof pesquisa !== 'object' || pesquisa === null) {
    return res.status(400).json({ success: false, message: 'Pesquisa inválida.' });
  }

  const itemTipoMap = { 'Venda': 1, 'Doação': 0, 'Troca': 2 };
  const pubTipoMap = { 'Coleção': 0, 'Unidade': 1 };

  let { titulo, tipo, itemTipo, generos } = pesquisa;

  let itemTipoValue = itemTipoMap[itemTipo];
  if (itemTipo === 'Todos' || !itemTipo) itemTipoValue = null;

  let pubTipoValue = pubTipoMap[tipo];
  if (tipo === 'Todos' || !tipo) pubTipoValue = null;

  let sql = `
    SELECT DISTINCT 
      p.pub_id,
      p.pub_titulo,
      p.pub_valor,
      p.pub_tipo,
      i.item_tipo,
      u.user_nome,
      img.imagem_caminho AS imagem
    FROM tb_publicacoes p
    JOIN tb_item i ON p.item_id = i.item_id
    LEFT JOIN tb_publicacao_genero pg ON p.pub_id = pg.pub_id
    JOIN tb_users u ON p.user_id = u.user_id
    LEFT JOIN tb_imagens img ON img.pub_id = p.pub_id
    WHERE 1=1
  `;
  
  const params = [];

  if (titulo) {
    sql += ' AND p.pub_titulo LIKE ?';
    params.push(`%${titulo}%`);
  }
  if (pubTipoValue !== null && pubTipoValue !== undefined) {
    sql += ' AND p.pub_tipo = ?';
    params.push(pubTipoValue);
  }
  if (itemTipoValue !== null && itemTipoValue !== undefined) {
    sql += ' AND i.item_tipo = ?';
    params.push(itemTipoValue);
  }
  if (Array.isArray(generos) && generos.length > 0) {
    sql += ` AND pg.genero_id IN (${generos.map(() => '?').join(', ')})`;
    params.push(...generos);
  }

  sql += ' GROUP BY p.pub_id';

  db.query(sql, params, (err, results) => {
    if (err) {
      console.error('Erro ao pesquisar:', err);
      return res.status(500).json({ success: false, message: 'Erro ao pesquisar', error: err });
    }
    res.json({ success: true, data: results });
  });
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
      const user = results[0];
      const token = jwt.sign(
        { id: user.user_id, nome: user.user_nome, email: user.user_email },
        SECRET_KEY,
        { expiresIn: '1h' }
      );
      res.json({ success: true, message: 'Login realizado com sucesso', token, user });
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

app.get('/receberPUBS', (req, res) => {

  const sql = `
    SELECT 
      p.pub_id,
      p.pub_titulo,
      p.pub_tipo,
      p.pub_valor,
      p.pub_valor,
      i.item_tipo,
      img.imagem_caminho AS imagem
    FROM tb_publicacoes p
    JOIN tb_item i ON p.item_id = i.item_id
    LEFT JOIN tb_imagens img ON img.pub_id = p.pub_id
    GROUP BY p.pub_id
  `;

  db.query(sql, (err, results) => {
    if (err) {
      console.error('Erro ao buscar publicações:');
      return res.status(500).json({ success: false, message: 'Erro ao buscar publicações', error: err });
    }
    res.json({ success: true, data: results });
  });
});

app.get('/receberGeneros', (req, res) => {
  const sql = `
    SELECT 
      g.genero_id,
      g.genero_nome
    FROM tb_genero g
    ORDER BY g.genero_nome
  `;

  db.query(sql, (err, results) => {
    if (err) {
      console.error('Erro ao buscar gêneros:', err);
      return res.status(500).json({ success: false, message: 'Erro ao buscar gêneros', error: err });
    } else {
      res.json({ success: true, data: results });
    }
  })


});

app.post('/popularAleatorio', (req, res) => {
  const numRegistros = req.body.qtd || 10;

  function inserirProximo(i) {
    if (i >= numRegistros) {
      return res.json({ success: true, message: `${numRegistros} registros inseridos com sucesso!` });
    }
    const item = {
      isbn: faker.string.numeric(13),
      titulo: faker.commerce.productName(),
      autor: faker.person.fullName(),
      editora: faker.company.name(),
      dataPublicacao: faker.date.past(10).toISOString().split('T')[0],
      status: faker.helpers.arrayElement(['Disponível', 'Reservado', 'Indisponível']),
      tipo: faker.helpers.arrayElement(['Livro', 'Revista', 'HQ', 'Mangá', 'Outro'])
    };

    db.query(
      'INSERT INTO tb_item (item_isbnCode, item_titulo, item_autor, item_editora, item_datadepublicacao, item_status, item_tipo) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [item.isbn, item.titulo, item.autor, item.editora, item.dataPublicacao, item.status, item.tipo],
      (err, itemResult) => {
        if (err) {
          console.error('Erro ao inserir it em:', err);
          return res.status(500).json({ success: false, error: err.message });
        }
        const itemId = itemResult.insertId;

        db.query('SELECT user_id FROM tb_users ORDER BY RAND() LIMIT 1', (err, userResults) => {
          if (err) {
            console.error('Erro ao buscar usuário aleatório:', err);
            return res.status(500).json({ success: false, error: err.message });
          }
          if (userResults.length === 0) {
            return res.status(404).json({ success: false, message: 'Nenhum usuário encontrado' });
          }
          const userId = userResults[0].user_id;

          const pub = {
            titulo: faker.commerce.productName(),
            tipoVenda: faker.helpers.arrayElement([1, 2, 3]),
            idItem: itemId,
            userId: userId
          };

          db.query(
            'INSERT INTO tb_publicacoes (pub_titulo, pub_tipo, item_id, user_id) VALUES (?, ?, ?, ?)',
            [pub.titulo, pub.tipoVenda, pub.idItem, pub.userId],
            (err, pubResult) => {
              if (err) {
                console.error('Erro ao inserir publicação:', err);
                return res.status(500).json({ success: false, error: err.message });
              }
              const pubId = pubResult.insertId;

              // Inserir imagem
              const imagemUrl = faker.image.url();
              db.query(
                'INSERT INTO tb_imagens (id_pub, imagem_caminho) VALUES (?, ?)',
                [pubId, imagemUrl],
                (err) => {
                  if (err) {
                    console.error('Erro ao inserir imagem:', err);
                    return res.status(500).json({ success: false, error: err.message });
                  }
                  inserirProximo(i + 1);

                });
            });
        });
      });
  }

  inserirProximo(0);
});

app.get('/detalhesPUB/:pubId', (req, res) => {
  const { pubId } = req.params;

  const sql = `
    SELECT 
      p.pub_id,
      p.pub_titulo,
      p.pub_tipo,
      p.pub_valor,
      p.pub_descricao,
      i.item_titulo,
      i.item_status,
      i.item_autor,
      i.item_editora,
      i.item_datadepublicacao,
      i.item_isbnCode,
      i.item_tipo,
      img.imagem_caminho AS imagem,
      u.user_nome,
      u.user_sobrenome,
      u.user_celular
    FROM tb_publicacoes p
    JOIN tb_item i ON p.item_id = i.item_id
    LEFT JOIN tb_imagens img ON img.pub_id = p.pub_id
    JOIN tb_users u ON p.user_id = u.user_id
    WHERE p.pub_id = ?
  `;

  db.query(sql, [pubId], (err, results) => {
    if (err) {
      console.error('Erro ao buscar detalhes da publicação:', err);
      return res.status(500).json({ success: false, message: 'Erro ao buscar detalhes da publicação', error: err });
    }
    if (results.length === 0) {
      return res.status(404).json({ success: false, message: 'Publicação não encontrada' });
    }

    // Extrair informações comuns do primeiro registro
    const {
      pub_id, pub_titulo, pub_tipo, pub_valor, pub_descricao,
      item_titulo, item_status, item_autor, item_editora,
      item_datadepublicacao, item_isbnCode, item_tipo,
      user_nome, user_sobrenome, user_celular
    } = results[0];

    // Extrair todas as imagens
    const imagens = results.map(row => row.imagem).filter(img => img);

    res.json({
      success: true,
      data: {
        pub_id,
        pub_titulo,
        pub_tipo,
        pub_valor,
        pub_descricao,
        item_titulo,
        item_status,
        item_autor,
        item_editora,
        item_datadepublicacao,
        item_isbnCode,
        item_tipo,
        user_nome,
        user_sobrenome,
        user_celular,
        imagens
      }
    });
  });
});

const PORT = 3000;

const server = app.listen(PORT, () => {
  const address = server.address();
  const host = address.address === '::' ? 'localhost' : address.address;
  const port = address.port;

  console.log('Servidor rodando!');
  console.log(`→ Acesse: http://${host}:${port}/`);
});