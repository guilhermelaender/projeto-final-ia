# Trabalho Final 2ª Etapa - Criando Agente de IA para Engenharia de Software

## Integrantes do Grupo

- Guilherme Oliveira Laender
- Isabella Antunes
- Leonardo Miranda

## Visão Geral
Aplicação Streamlit que integra o Google Gemini. Este repositório inclui:
- IaC (Terraform) **simulado** de EC2 + S3
- Pipeline CI/CD (GitHub Actions)
- Testes automatizados (pytest)
- Container Docker
- Ambiente para GitHub Codespaces

## Como o agente funciona
- UI em Streamlit (`main.py`) exibe chat e histórico.
- Funções `init_gemini()` e `generate_response()` encapsulam a interação com o modelo.
- Em testes, substituímos o modelo por um **mock** (sem chamar a API real).

## Instalação e Execução (local ou Codespaces)
#### Crie o arquivo .env a partir do exemplo
```bash
make install
cp .env.example .env
```

#### Edite e adicione a sua chave do Google Gemini
GEMINI_API_KEY=coloque_sua_chave_aqui

#### Instale as dependências e rode a aplicação
```bash
make install
make run
```

#### Acesse
http://localhost:8501


## Docker

#### Build da imagem
```bash
make docker-build
```

#### Executar container
```bash
make docker-run
```

## Infraestrutura como Código (Terraform)
```bash
make tf-init
make tf-plan
```
Saída esperada: simulated_outputs.json com IDs fictícios.

## Pipeline CI/CD (GitHub Actions)
O workflow ci.yml executa:

1.	Instalação de dependências;
2.	Lint + testes (pytest);
3.	Build de imagem Docker;
4.	terraform init, validate e plan;
5.	Deploy simulado (LocalStack ou script simulate_deploy.sh);
6.	Upload de artefatos (logs, relatórios, planos).

## GitHub Codespaces
O diretório .devcontainer/ permite abrir o projeto no GitHub Codespaces com:
•	Python 3.11;
•	Terraform 1.6.x;
•	Extensões do VSCode (Python, Docker, Terraform).

No Codespaces, basta rodar:
```bash
make install
make run
```

## Segurança
•	O arquivo .env não deve ser commitado.
•	O container roda como usuário não-root.
•	Testes são offline → não expõem chaves de API.
•	Pipeline pode ser estendido com ferramentas de segurança:
  -	tfsec para Terraform;
  -	trivy para imagens Docker;
  -	semgrep para análise de código.
