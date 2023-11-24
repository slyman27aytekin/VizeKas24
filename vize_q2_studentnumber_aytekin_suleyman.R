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
