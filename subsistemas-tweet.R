devtools::install_github('brunomioto/reservatoriosBR')
library(reservatoriosBR)

# Create Twitter token
reservatorios_token <- rtweet::create_token(
  app = "reservatoriosBR-bot",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

# Get data from reservatoriosBR package
perc_subsistemas <- reservatoriosBR::ONS_reservatorios(formato = "resumo")


# Build the status message (text and URL)
tweet_text <- paste0(
  "Nível dos subsistemas de reservatórios hoje ", format(Sys.Date(), "%d/%m/%y"), ":\n ",
  perc_subsistemas[1,2],": ", round(perc_subsistemas[1,3],2),"%\n",
  perc_subsistemas[2,2],": ", round(perc_subsistemas[2,3],2),"%\n",
  perc_subsistemas[3,2],": ", round(perc_subsistemas[3,3],2),"%\n",
  perc_subsistemas[4,2],": ", round(perc_subsistemas[4,3],2),"%\n\n",
  "Dados obtidos a partir do pacote reservatoriosBR"
)

# Post the image to Twitter
rtweet::post_tweet(
  status = tweet_text,
  token = reservatorios_token
)
