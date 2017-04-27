# README

### Clone the project

`git clone https://github.com/brunocascio/AR-MTB.git && cd AR-MTB`

### Replace variables into .env

`cp .env.example .env`

### For developers

#### Run the application

`docker-compose -f docker-compose.dev.yml up -d`

#### Run the migrations and seeds

`docker-compose -f docker-compose.dev.yml exec web rake db:create db:migrate db:seed`

#### That's all

Open your browser at `http://localhost:3001`
