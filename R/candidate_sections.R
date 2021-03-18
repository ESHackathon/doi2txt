#' Detect candidate section subheadings
#'
#' @description Detect potential candidate subheadings from a corpus
#' of line-separated full texts. The function detects any lines below
#' a given number of characters (default is 40) and deduplicates
#' across all texts.
#' @param text An input text stored as a character vector split by
#' lines.
#' @param length Maximum character length for potential candidate
#' subheadings. Default value is 40.
#' @return A character vector of candidate subheadings.
#' @export
#' @examples
#' dois <- c('10.1186/s13750-021-00219-x', '10.1186/s13750-018-0116-4', '10.1186/s13750-018-0144-0', '10.1186/s13750-017-0113-z')
#' text <- doi2html(doi = dois[1])
#' secs <- candidate_sections(text)
#' secs
#' texts <- lapply(dois, doi2html)
#' secs <- candidate_sections(texts)
candidate_sections <- function(text,
                               length = 40){

  #internal function to shorten texts to (abstract -> references)
  shorten <- function(text){
    start <- min(grep('Abstract', text)) #detect start of text
    end <- max(grep('Reference', text)) #detect end of text
    short <- text[start:end] #create short text from abstract to references
    return(short)
  }

  #apply shorten to text(s)
  if (is.list(text) == FALSE){
    short <- shorten(text)
    output <- short[nchar(short) < length] #extract all lines less than 'length' characters long
    output <- unique(output) #deduplicate across multiple texts

  } else {
    short <- lapply(text, shorten)
    output <- lapply(short, function(x, y = length){x[nchar(x) < y]}) #extract all lines less than 'length' characters long
    output <- unique(unlist(output)) #deduplicate across multiple texts
  }

  # tidy output (remove non alphanumerics and empty values)
  output <- trimws(gsub("[^[:alnum:] ]", "", output))
  output <- output[output != ""]
  return(output)

}


candidate_sections(text)
