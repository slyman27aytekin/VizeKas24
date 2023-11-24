sevilen_sanatci_id <- sapply(sevilen_sanatcilar, function(artist) {
  result <- spotify_search_artist(artist)
  result$search_results$id[1]  # İlk sonucun ID'sini al
})

sevilmeyen_sanatci_id <- sapply(sevilmeyen_sanatcilar, function(artist) {
  result <- spotify_search_artist(artist)
  result$search_results$id[1]  # İlk sonucun ID'sini al
})

my_artists <- data.frame(artist = c(sevilen_sanatcilar, sevilmeyen_sanatcilar),
                         id = c(sevilen_sanatci_id, sevilmeyen_sanatci_id))

my_artists_combined <- cbind(sevilen = sevilen_sanatci_id, sevilmeyen = sevilmeyen_sanatci_id)

#
matching_ids <- apply(my_artists_combined, 1, function(row) {
  identical(row["sevilen"], row["sevilmeyen"])
})

matching_artists <- my_artists[matching_ids, ]
non_matching_artists <- my_artists[!matching_ids, ]

# Eşleşen ve eşleşmeyen sanatçıları görüntüleme
print("Eşleşen Sanatçılar:")
print(matching_artists)
print("Eşleşmeyen Sanatçılar:")
print(non_matching_artists)

# Test 3.1
Test_3_1 <- exists("my_artists", envir = .GlobalEnv)
paste("Test 3.1:", Test_3_1)

# Test 3.2
Test_3_2 <- class(my_artists) == "data.frame"
paste("Test 3.2:", Test_3_2)
