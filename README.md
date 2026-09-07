# AX Baterias — publicação

Arquivos:
- `index.html`: aplicativo.
- `config.js`: URL e Publishable Key do Supabase.
- `supabase.sql`: cria a tabela e as políticas de segurança.
- `manifest.webmanifest` + ícones: instalação na tela inicial do celular.

## Ordem recomendada

1. Crie o projeto no Supabase.
2. Abra **SQL Editor**, cole todo o conteúdo de `supabase.sql` e execute.
3. Em **Connect** / configurações do projeto, copie:
   - Project URL
   - Publishable Key (`sb_publishable_...`)
4. Cole esses dois valores em `config.js`.
5. No GitHub, crie um repositório, por exemplo `ax-baterias`.
6. Envie todos estes arquivos para a raiz do repositório.
7. Vá em **Settings > Pages**.
8. Em **Build and deployment > Source**, escolha **Deploy from a branch**.
9. Selecione `main` e `/(root)` e salve.
10. Abra a URL publicada.
11. Na primeira tela, crie o acesso do Alex com e-mail e senha.
12. Depois de confirmar o e-mail e testar, considere desabilitar novos cadastros públicos no Supabase Auth.

## Segurança

- `config.js` usa somente a **Publishable Key**, apropriada para frontend quando RLS está configurado.
- Nunca cole `sb_secret_...`, `service_role` ou senha do banco no GitHub ou no HTML.
- A tabela usa RLS: cada usuário autenticado só consegue acessar sua própria linha.

## Backup

O app mantém cache local e sincroniza o estado no Supabase. A opção **Exportar backup** continua disponível no app.
