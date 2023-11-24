spotify_search_artist <- function(artist_name) {
  # Artist ismini URL uygun hale getirme
  artist_name <- "Drake"
  encoded_artist_name <- URLencode(artist_name)
  artist_name
  # Arama yapılacak URL
  search_url <- paste0("https://api.spotify.com/v1/search?q=", encoded_artist_name, "&type=artist")
  
  # Token alma fonksiyonunu kullanarak token al
  token <- spotify_token()$token
  
  # HTTP GET isteği için gerekli header bilgileri
  headers <- c(
    Authorization = token
  )
  
  # GET isteği gönderme
  response <- httr::GET(
    url = search_url,
    add_headers(.headers = headers)
  )
  
  # HTTP status kodunu alma
  status_code <- httr::status_code(response)
  
  # JSON formatındaki cevabı alma
  search_results <- httr::content(response)$artists
  
  # İlgili bilgileri çıkarma
  artist_names <- search_results$items$name
  artist_ids <- search_results$items$id
  
  # Data frame oluşturma
  artist_data <- data.frame(artist = artist_names, id = artist_ids)
  
  # Döndürülecek liste
  result <- list(
    status_code = status_code,
    search_results = artist_data
  )
  
  return(result)
}
# Test 2.1
Test_2_1 <- exists("spotify_search_artist", envir = .GlobalEnv)
paste("Test 2.1:", Test_2_1)

# Test 2.2
Test_2_2 <- is.function(spotify_search_artist)
paste("Test 2.2:", Test_2_2)

output <- spotify_search_artist("Any Artist Name")
Test_2_3 <- is.list(output)
paste("Test 2.3:", Test_2_3)


# Test 2.4
Test_2_4 <- length(output) == 2
paste("Test 2.4:", Test_2_4)

# Test 2.5
Test_2_5 <- names(output)[1] == "status_code"
paste("Test 2.5:", Test_2_5)

# Test 2.6
Test_2_6 <- class(output$status_code) == "numeric"
paste("Test 2.6:", Test_2_6)

# Test 2.7"
Test_2_7 <- output$status_code == 200
paste("Test 2.7:", Test_2_7)

# Test 2.8
Test_2_8 <- names(output)[2] == "search_results"
paste("Test 2.8:", Test_2_8)


# Test 2.9
Test_2_9 <- class(output$search_results) == "data.frame"
paste("Test 2.9:", Test_2_9)

# Test 2.10
Test_2_10 <- ncol(output$search_results) == 2
paste("Test 2.10:", Test_2_10)


# Test 2.11
Test_2_11 <- all(colnames(output$search_results) %in% c("artist", "id"))
paste("Test 2.11:", Test_2_11)
