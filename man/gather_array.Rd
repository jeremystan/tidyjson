% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gather.R
\name{gather_array}
\alias{gather_array}
\title{Gather a JSON array into index-value pairs}
\usage{
gather_array(.x, column.name = default.column.name)
}
\arguments{
\item{.x}{a json string or tbl_json object whose JSON attribute should always
be an array}

\item{column.name}{the name to give to the array index column created}
}
\value{
a \code{\link{tbl_json}} object
}
\description{
\code{gather_array} collapses a JSON array into index-value pairs, creating
a new column \code{'array.index'} to store the index of the array, and
storing values in the \code{'JSON'} attribute for further tidyjson
manipulation. All other columns are duplicated as necessary. This allows you
to access the values of the array just like \code{\link{gather_object}} lets
you access the values of an object.
}
\details{
JSON arrays can be simple vectors (fixed or varying length number, string
or logical vectors with or without null values). But they also often contain
lists of other objects (like a list of purchases for a user). Thus, the
best analogy in R for a JSON array is an unnamed list.

\code{gather_array} is often preceded by \code{\link{enter_object}} when the
array is nested under a JSON object, and is often followed by
\code{\link{gather_object}} or \code{\link{enter_object}} if the array values
are objects, or by \code{\link{append_values}} to append all scalar values
as a new column or \code{\link{json_types}} to determine the types of the
array elements (JSON does not guarantee they are the same type).
}
\examples{

# A simple character array example
json <- '["a", "b", "c"]'

# Check that this is an array
json \%>\% json_types

# Gather array and check types
json \%>\% gather_array \%>\% json_types

# Extract string values
json \%>\% gather_array \%>\% append_values_string

# A more complex mixed type example
json <- '["a", 1, true, null, {"name": "value"}]'

# Then we can use the column.name argument to change the name column
json \%>\% gather_array \%>\% json_types

# A nested array
json <- '[["a", "b", "c"], ["a", "d"], ["b", "c"]]'

# Extract both levels
json \%>\% gather_array("index.1") \%>\% gather_array("index.2") \%>\%
  append_values_string

# Some JSON begins as an array
commits \%>\% gather_array

# We can use spread_all to capture all values
# (recursive = FALSE to limit to the top level object)
library(dplyr)
commits \%>\% gather_array \%>\% spread_all(recursive = FALSE) \%>\% glimpse
}
\seealso{
\code{\link{gather_object}} to gather a JSON object,
         \code{\link{enter_object}} to enter into an object,
         \code{\link[tidyr]{gather}} to gather name-value pairs in a data
         frame
}
