# Preparando o banco de desenvolvimento

Prefira utilizar `rake db:structure:load` para carregar a versão inicial do seu banco de
dados local. O comando `rake db:schema:load` irá utilizar o arquivo _schema.rb_ para
carregar o banco de dados, mas esse é incapaz de representar o banco fielmente, pois
não possui suporte a enumerações.

Para carregar dados no seu banco local, dê uma olhada em `/data/dumps/`:

- **base**: Possui dados para as tabelas *alternatives, areas, cities, exams questions, school_summary, schools, skills, states, subjects, summaries, taggings e tags*;

- **bh_frequencies**: Possui dados da tabela *frequencies* para as escolas de Belo Horizonte;

- **bh_candidates**: Possui os dados da tabela *candidates* das escolas de Belo Horizonte;

- **bh_scores**: Possui os dados da tabela *scores* dos alunos das escolas de Belo Horizonte;

- **bh_6304_answers**: Possui os dados da tabela *answers* dos alunos da escola Santo Antonio de Belo Horizonte.

Talvez seja necessário aumentar o tamanho máximo do pacote de inserção do MySQL:
```sql
-- Para 500MB de buffer
SET GLOBAL max_allowed_packet=524288000;
```
