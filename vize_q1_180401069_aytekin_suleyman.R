
spotify_token <- function() {
  client_id <- Sys.getenv("SPOTIFY_CLIENT_ID")
  client_secret <- Sys.getenv("SPOTIFY_CLIENT_SECRET")
  
  # Base64 encode edilmiş client ID ve client secret
  client_credentials <- base64enc::base64encode(paste0(client_id, ":", client_secret))
  
  # HTTP POST isteği için gerekli header bilgileri
  headers <- c(
    `Content-Type` = "application/x-www-form-urlencoded",
    Authorization = paste("Basic", client_credentials)
  )
  
  # POST isteği gönderme
  response <- httr::POST(
    url = token_url,
    add_headers(.headers = headers),
    body = list(grant_type = "client_credentials")
  )
  
  # HTTP status kodunu alma
  status_code <- httr::status_code(response)
  
  # JSON formatındaki cevabı alma ve içinden token'ı çıkarma
  token <- httr::content(response)$access_token
  
  # Döndürülecek liste
  result <- list(
    status_code = status_code,
    token = paste("Bearer", token)
  )
  
  return(result)
}
