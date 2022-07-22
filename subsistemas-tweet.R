# Install the package from CRAN
#install.packages("rtweet")
#install.packages("devtools")
#devtools::install_github('brunomioto/reservatoriosBR')

reservatorios_token <- rtweet:: rtweet_bot(
  #app = "reservatoriosBR-bot",
  api_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  api_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

# Get data from reservatoriosBR package
perc_subsistemas <- reservatoriosBR::ONS_reservatorios(formato = "resumo")


# Build the status message
tweet_text <- paste0(
  "Nível dos subsistemas de reservatórios em ", format(perc_subsistemas[1,1]$data, "%d/%m/%y"), "\n\n",
  perc_subsistemas[2,2]$subsistema,": ", round(perc_subsistemas[2,3]$percentual,2),"%\n",
  perc_subsistemas[1,2]$subsistema,": ", round(perc_subsistemas[1,3]$percentual,2),"%\n",
  perc_subsistemas[3,2]$subsistema,": ", round(perc_subsistemas[3,3]$percentual,2),"%\n",
  perc_subsistemas[4,2]$subsistema,": ", round(perc_subsistemas[4,3]$percentual,2),"%\n\n",
  "Dados da ONS obtidos a partir do pacote reservatoriosBR"
)

# Post the status message to Twitter
rtweet::post_tweet(
  status = tweet_text,
  token = reservatorios_token
)
