-- ./db/init.sql
CREATE TABLE public.usuarios (
  id_usuario SERIAL PRIMARY KEY,
  is_admin BOOLEAN NOT NULL DEFAULT FALSE,
  nome TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
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
  hash_confirmacao TEXT UNIQUE NOT NULL
  -- caminho_arquivo TEXT
);

-- Eventos
INSERT INTO public.eventos (titulo, data_inicio, data_fim, local)
VALUES
  ('Dev Summit Primavera', '2025-11-05', '2025-11-08', 'São Paulo - Auditório Tech'),
  ('Workshop de UX para Devs', '2025-10-15', '2025-10-15', 'Porto Alegre - Laboratório');

INSERT INTO public.eventos (titulo, data_inicio, data_fim, local)
VALUES
  ('Semana de IA Aplicada', '2025-11-24', '2025-11-28', 'Curitiba - Centro Digital'),
  ('Bootcamp Kotlin Intensivo', '2025-11-23', '2025-11-27', 'Florianópolis - Hub Tech');

INSERT INTO public.eventos (titulo, data_inicio, data_fim, local)
VALUES
  ('Encontro Nacional de Startups', '2025-12-10', '2025-12-12', 'Rio de Janeiro - Expo Center'),
  ('Game Dev Festival', '2026-01-20', '2026-01-22', 'Belo Horizonte - Campus Expo');
