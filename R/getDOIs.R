
# Export list of records matching 'Environmental Evidence' as a source title from the Lens.org API
token <- 'WCFlpCtuJXYI1sDhZcZ8y7hHpri0SEmTnLNkeU4OEM5JTQRNXB9w'
query <- paste0('{
	"query": {
		"match_phrase": {
			"source.title": "Environmental Evidence"
		}
	},
	"size": 500
}')

url <- 'https://api.lens.org/scholarly/search'
headers <- c('Authorization' = token, 'Content-Type' = 'application/json')
data <- httr::POST(url = url, httr::add_headers(.headers=headers), body = query)
record_json <- httr::content(data, "text")

# convert json output from article search to list
record_list <- jsonlite::fromJSON(record_json)
df <- as.data.frame(record_list)

# list of dois
EEJdois <- unlist(lapply(df$data.external_ids, function(ch) expss::vlookup('doi', ch, result_column = 'value', lookup_column = 'type')))
write.csv(EEJdois, 'data/EEJdois.csv')


# Export list of records matching 'Campbell Systematic Reviews' as a source title from the Lens.org API
token <- 'WCFlpCtuJXYI1sDhZcZ8y7hHpri0SEmTnLNkeU4OEM5JTQRNXB9w'
query <- paste0('{
	"query": {
		"match_phrase": {
			"source.title": "Campbell Systematic Reviews"
		}
	},
	"size": 500
}')

url <- 'https://api.lens.org/scholarly/search'
headers <- c('Authorization' = token, 'Content-Type' = 'application/json')
data <- httr::POST(url = url, httr::add_headers(.headers=headers), body = query)
record_json <- httr::content(data, "text")

# convert json output from article search to list
record_list <- jsonlite::fromJSON(record_json)
df <- as.data.frame(record_list)

# list of dois
CSRdois <- unlist(lapply(df$data.external_ids, function(ch) expss::vlookup('doi', ch, result_column = 'value', lookup_column = 'type')))
write.csv(CSRdois, 'data/CSRdois.csv')
