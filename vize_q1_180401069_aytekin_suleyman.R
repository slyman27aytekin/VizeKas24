spotify_token <- function() {
  client_id <- Sys.getenv("SPOTIFY_CLIENT_ID")
  client_secret <- Sys.getenv("SPOTIFY_CLIENT_SECRET")
  
  token_url <- "https://accounts.spotify.com/api/token"
  
  client_credentials <- base64enc::base64encode(paste0(client_id, ":", client_secret))
  
  headers <- c(
    `Content-Type` = "application/x-www-form-urlencoded",
    Authorization = paste("Basic", client_credentials)
  )
  
  response <- httr::POST(
    url = token_url,
    add_headers(.headers = headers),
    body = list(grant_type = "client_credentials")
  )
  
  status_code <- httr::status_code(response)
  token <- httr::content(response)$access_token
  
  result <- list(
    status_code = status_code,
    token = paste("Bearer", token)
  )
  
  return(result)
}# Test 1.1
Test_1_1 <- exists("spotify_token", envir = .GlobalEnv)
paste("Test 1.1:", Test_1_1)

