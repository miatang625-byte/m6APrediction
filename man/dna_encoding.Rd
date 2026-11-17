\name{dna_encoding}
\alias{dna_encoding}
\title{Encode five-base contexts}
\description{Convert each nucleotide position into a categorical predictor.}
\usage{
dna_encoding(dna_strings)
}
\arguments{
\item{dna_strings}{Character vector of uppercase five-base DNA contexts.}
}
\value{A data frame of five factors named nt_pos1 through nt_pos5.}
