
run_REFERENCE.SAMPLE.SET.SELECTOR <- function(num_clusters_max,
                                              input_cov_table){
  library(clusterCrit)
  Y <- data.matrix(read.csv(input_cov_table))
  sampname <- colnames(Y)
  metrics_dunn <- c()
  metrics_silhouette <- c()
  metrics_davies_bouldin <- c()
  for(num_clusters in 1:num_clusters_max) {
    print(paste("Clustering with number of groups equal to ", num_clusters, sep=""))
    reference_samples <- list()
    kmeans_results <- kmeans_select_groups(Y, num_clusters)
    kmeans_clusters <- kmeans_results$clusters
    d <- kmeans_results$d
    metrics_iter <- intCriteria(as.matrix(d),kmeans_clusters$cluster,c("dunn","silhouette","davies_bouldin"))
    metrics_dunn <- c(metrics_dunn, metrics_iter$dunn)
    metrics_silhouette <- c(metrics_silhouette, metrics_iter$silhouette)
    metrics_davies_bouldin <- c(metrics_davies_bouldin, metrics_iter$davies_bouldin)
    for(i in 1:length(sampname)) {
      investigated_sample <- as.character(sampname[i])
      reference_samples_for_investigated_sample <- kmeans_method(investigated_sample, Y, kmeans_clusters)$reference_samples
      reference_samples[[i]] <- c(investigated_sample, reference_samples_for_investigated_sample)
    }
    resultant_string <- ''
    for(i in 1:length(reference_samples)) {
      resultant_string <- paste(resultant_string, paste(reference_samples[[i]], collapse=","), '\n', sep="")
    }
    write(resultant_string, paste('reference_sample_set_kmeans_', num_clusters, '.csv', sep=""))
  }

  print(paste(c("Dunn index: ", metrics_dunn), collapse=" "))
  print(paste(c("Silhouette width: ", metrics_silhouette), collapse=" "))
  print(paste(c("Davies Bouldin index: ", metrics_davies_bouldin), collapse=" "))

  plot_diagram(metrics_dunn, metrics_silhouette, metrics_davies_bouldin)

}
