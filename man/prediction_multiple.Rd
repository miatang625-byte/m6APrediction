\name{prediction_multiple}
\alias{prediction_multiple}
\title{Predict m6A status for multiple observations}
\description{Apply the classifier to a table of genomic features.}
\usage{
prediction_multiple(ml_fit, feature_df, positive_threshold = 0.5)
}
\arguments{
\item{ml_fit}{A fitted randomForest classification model compatible with the package features.}
\item{feature_df}{Data frame containing the seven genomic feature columns described in \code{\link{prediction_single}}. Length and distance columns are already log2-transformed.}
\item{positive_threshold}{A numeric cutoff between zero and one. Scores strictly above it are Positive.}
}
\value{The input data frame with numeric predicted_m6A_prob and character predicted_m6A_status columns.}
\examples{
ml_fit <- readRDS(system.file("extdata", "rf_fit.rds",
    package = "m6APrediction", mustWork = TRUE))
example_df <- read.csv(system.file("extdata", "m6A_input_example.csv",
    package = "m6APrediction", mustWork = TRUE))
prediction_multiple(ml_fit, head(example_df, 3))
}
