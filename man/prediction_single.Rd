\name{prediction_single}
\alias{prediction_single}
\title{Predict m6A status for one observation}
\description{Apply the classifier to one site.}
\usage{
prediction_single(ml_fit, gc_content, RNA_type, RNA_region, exon_length,
  distance_to_junction, evolutionary_conservation, DNA_5mer, positive_threshold = 0.5)
}
\arguments{
\item{ml_fit}{A fitted randomForest classification model compatible with the package features.}
\item{gc_content}{Numeric GC fraction.}
\item{RNA_type}{One of mRNA, lincRNA, lncRNA, or pseudogene.}
\item{RNA_region}{One of CDS, intron, 3'UTR, or 5'UTR.}
\item{exon_length}{Numeric exon length on the log2 scale.}
\item{distance_to_junction}{Numeric distance to the splice junction on the log2 scale.}
\item{evolutionary_conservation}{Numeric conservation score.}
\item{DNA_5mer}{Uppercase five-base DNA context. The training contexts have A at the center.}
\item{positive_threshold}{A numeric cutoff between zero and one. Scores strictly above it are Positive.}
}
\value{A named character vector with predicted_m6A_prob and predicted_m6A_status.}
\examples{
ml_fit <- readRDS(system.file("extdata", "rf_fit.rds",
    package = "m6APrediction", mustWork = TRUE))
prediction_single(ml_fit, gc_content = 0.6, RNA_type = "mRNA", RNA_region = "CDS",
    exon_length = 12, distance_to_junction = 5, evolutionary_conservation = 0.8,
    DNA_5mer = "GGACA")
}
