-- ./db/init.sql
CREATE TABLE public.usuarios (
  id_usuario SERIAL PRIMARY KEY,
  is_admin BOOLEAN NOT NULL DEFAULT FALSE,
  nome TEXT NOT NULL,
  email TEXT,
  cpf TEXT,
  telefone TEXT,
  created_at TIMESTAMP DEFAULT now(),
  senha TEXT NOT NULL
);

-- Usuário administrador de teste
INSERT INTO public.usuarios (is_admin, nome, email, cpf, telefone, senha)
VALUES (
  TRUE,
  'Administrador',
  'admin@gmail.com',
  '00000000000',
  '000000000',
  '$2a$10$F60YWnAAalksjZBqpPt2LuYegV3dRPFIvnDE2xk21H.voGk03zx0m'
)
ON CONFLICT DO NOTHING;

CREATE TABLE public.eventos (
  id_evento SERIAL PRIMARY KEY,
  titulo TEXT NOT NULL,
  data_inicio DATE NOT NULL,
  data_fim DATE NOT NULL,
  local TEXT
);

CREATE TABLE public.inscricoes (
  id_inscricao SERIAL PRIMARY KEY,
  id_usuario INTEGER NOT NULL REFERENCES usuarios(id_usuario),
  id_evento INTEGER NOT NULL REFERENCES eventos(id_evento),
  data_inscricao TIMESTAMP DEFAULT now(),
  data_cancelamento TIMESTAMP,
  status BOOLEAN DEFAULT TRUE
);

CREATE TABLE public.checkins (
  id_checkin SERIAL PRIMARY KEY,
  id_inscricao INTEGER NOT NULL REFERENCES inscricoes(id_inscricao),
  data_checkin TIMESTAMP DEFAULT now()
);

CREATE TABLE public.certificados (
  id_certificado SERIAL PRIMARY KEY,
  id_checkin INTEGER NOT NULL REFERENCES checkins(id_checkin),
  data_emissao TIMESTAMP DEFAULT now(),
  hash_confirmacao TEXT UNIQUE
);
