# Cinema App
Este repositório é dedicado aos testes funcionais de API e WEB do Cinema App, incluindo documentos da fase de planejamento até os scripts de testes automatizados.

🔗 [Planejamento dos Testes](https://github.com/liviavbarbosa/cinema-app-tests/tree/main/Planejamento%20dos%20Testes)

🔗 [Testes de API](https://github.com/liviavbarbosa/cinema-app-tests/tree/main/Testes/Testes%20API) 

🔗 [Testes WEB](https://github.com/liviavbarbosa/cinema-app-tests/tree/main/Testes/Testes%20WEB) 

🔗 [Relatório de Issues](https://github.com/liviavbarbosa/cinema-app-tests/blob/main/Mapeamento%20de%20Issues%20e%20Melhorias.pdf) 


## Mapa mental da aplicação
Para compreender melhor a aplicação, foram realizados dois mapas mentais: um para a API e outro para as páginas do front-end:

### Mapa mental da API
![Mapa Mental - Cinema App](https://github.com/user-attachments/assets/1f54b396-59ed-48a9-b3cb-e7a06239726c)

### Mapa mental da aplicação WEB
![Mapa Mental - Cinema App Front](https://github.com/user-attachments/assets/aeb7f91c-1d44-4c00-8e1b-665e4a84b6e3)


## Pré-requisitos
- Node.js (v14+)
- MongoDB (local)
- Robot Framework


## Como utilizar a aplicação
1. Clone o repositório back-end da aplicação: ```git clone https://github.com/juniorschmitz/cinema-challenge-back```
2. Clone o repositório front-end da aplicação: ```git clone https://github.com/juniorschmitz/cinema-challenge-front```
3. Abra dois terminais, cada um em uma pasta da aplicação (back e front)
4. Execute ```npm install``` em ambos os terminais
5. Crie um arquivo .env na raiz da pasta do back-end contendo as seguintes informações:

```
PORT=3000
MONGODB_URI=mongodb://localhost:27017/cinema-app
```

6. Execute ```npm start``` em ambos os terminais


## Configuração e Execução dos Testes
1. Clone o repositório
   
Abra o terminal e clone o repositório com o seguinte comando:

```
git clone https://github.com/liviavbarbosa/cinema-app-tests
```

2. Para executar, entre em uma das pastas (Testes API ou Testes WEB) e rode o seguinte comando:

```
robot -d results tests
```


## Sobre a Autora
Olá! Sou Lívia Viana Barbosa!

Tenho 20 anos e sou estudante do 6º semestre do curso de Engenharia de Software na Universidade Federal do Pampa, Campus Alegrete - RS.


## Agradecimentos
Agradeço a Amanda Cardoso de Almeida, Jacques de Jesus Figueredo e Rafael Túlio, pelo apoio no desenvolvimento das atividades e auxílio nas dúvidas.

Também agradeço aos SMs Lucas Alves Costa e Samantha Antunes de Resende Firmino, os quais estiveram sempre disponíveis para conversar e dar apoio ao time sempre que necessário.

E, por fim, agradeço aos meus colegas, os quais compartilharam conhecimentos valiosos e me acompanharam durante essa jornada:

Mario Glauko Cordeiro Queiroz, Wesley Lima Gomes Filho, Eric Lima Da Silva, Agemilson Pereira Abreu, Marcelo Ferreira De Souza, Carlos Eduardo Sarubi De Souza e Joao Vitor Moreira Lemos.
