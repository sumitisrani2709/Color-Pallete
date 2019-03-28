# Color Palette

Generate perfect color combinations for your designs. The super fast color schemes generator! Create, save perfect palettes in seconds! 

## Visit the hosted version
* Visit https://color-palete.herokuapp.com

## Setup development environment

### Prerequisites

1. Install ruby v2.6.2 
2. Install Postgres

### Download app and dependencies

```
$ git clone https://github.com/sumitisrani88/color_palette.git
$ cd color_palette
$ gem install bundler
$ bundle install
```

### Setup database.

Update config/database.yml

```
$ rake db:create db:migrate
$ rake color:create_records
```

### Now launch
```
$ rails s
```

### Run test suits
```
$ rspec
```
