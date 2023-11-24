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


# Test 1.2
Test_1_2 <- is.function(spotify_token)
paste("Test 1.2:", Test_1_2)


# Test 1.3
output <- spotify_token()
Test_1_3 <- is.list(output)
paste("Test 1.3:", Test_1_3)

