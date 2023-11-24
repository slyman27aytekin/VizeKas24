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
# Test 1.4
Test_1_4 <- length(output) == 2

# Test 1.5
Test_1_5 <- names(output)[1] == "status_code"

# Test 1.6
Test_1_6 <- class(output$status_code) == "numeric"

# Test 1.7
Test_1_7 <- output$status_code == 200

paste("Test 1.4:", Test_1_4)
paste("Test 1.5:", Test_1_5)
paste("Test 1.6:", Test_1_6)
paste("Test 1.7:", Test_1_7)

# Test 1.8
Test_1_8 <- names(output)[2] == "token"

# Test 1.9
Test_1_9 <- class(output$token) == "character"

# Test 1.10
Test_1_10 <- substr(output$token, 1, 7) == "Bearer "

# Test 1.11
Test_1_11 <- nchar(output$token) == 122

# Test sonuçlarını yazdırma

paste("Test 1.8:", Test_1_8)
paste("Test 1.9:", Test_1_9)
paste("Test 1.10:", Test_1_10)
paste("Test 1.11:", Test_1_11)



