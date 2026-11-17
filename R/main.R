features <- c("gc_content", "RNA_type", "RNA_region", "exon_length", 
    "distance_to_junction", "evolutionary_conservation", "DNA_5mer")

types <- c("mRNA", "lincRNA", "lncRNA", "pseudogene")

regions <- c("CDS", "intron", "3'UTR", "5'UTR")

dna_encoding <- function(dna_strings) {
    if (anyNA(dna_strings) || any(!grepl("^[ATCG]{5}$", dna_strings))) 
        stop("DNA_5mer must contain exactly five uppercase A, T, C or G characters.")
    ans <- as.data.frame(do.call(rbind, strsplit(dna_strings, 
        "")), stringsAsFactors = FALSE)
    names(ans) <- paste0("nt_pos", 1:5)
    ans[] <- lapply(ans, factor, levels = c("A", "T", "C", "G"))
    ans
}

prepare_features <- function(d) {
    missing <- setdiff(features, names(d))
    if (length(missing)) 
        stop(paste("Missing columns:", paste(missing, collapse = ", ")))
    if (!nrow(d)) 
        stop("The input table is empty.")
    x <- d[, features, drop = FALSE]
    if (anyNA(x)) 
        stop("Input features must not contain missing values.")
    if (any(!x$RNA_type %in% types) || any(!x$RNA_region %in% 
        regions)) 
        stop("RNA_type or RNA_region contains an unsupported value. See the prediction_single help page.")
    numeric_features <- setdiff(features, c("RNA_type", "RNA_region", 
        "DNA_5mer"))
    for (nm in numeric_features) {
        if (!is.numeric(x[[nm]]) || any(!is.finite(x[[nm]]))) 
            stop(paste(nm, "must contain finite numeric values."))
    }
    x$RNA_type <- factor(x$RNA_type, levels = types)
    x$RNA_region <- factor(x$RNA_region, levels = regions)
    cbind(x[, setdiff(features, "DNA_5mer"), drop = FALSE], dna_encoding(x$DNA_5mer))
}

prediction_multiple <- function(ml_fit, feature_df, positive_threshold = 0.5) {
    p <- predict(ml_fit, prepare_features(feature_df), type = "prob")[, 
        "Positive"]
    feature_df$predicted_m6A_prob <- as.numeric(p)
    feature_df$predicted_m6A_status <- ifelse(p > positive_threshold, 
        "Positive", "Negative")
    feature_df
}

prediction_single <- function(ml_fit, gc_content, RNA_type, RNA_region, 
    exon_length, distance_to_junction, evolutionary_conservation, 
    DNA_5mer, positive_threshold = 0.5) {
    d <- data.frame(gc_content, RNA_type, RNA_region, exon_length, 
        distance_to_junction, evolutionary_conservation, DNA_5mer)
    r <- prediction_multiple(ml_fit, d, positive_threshold)
    c(predicted_m6A_prob = r$predicted_m6A_prob, predicted_m6A_status = r$predicted_m6A_status)
}

