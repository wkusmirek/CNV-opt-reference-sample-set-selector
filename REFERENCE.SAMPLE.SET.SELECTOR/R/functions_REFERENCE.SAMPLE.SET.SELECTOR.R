
kmeans_select_groups <- function(Y, number_of_clusters){
  samples <- colnames(Y)
  cov <- cor(Y[, samples], Y[, samples])
  d <- cov
  for(i in 1:nrow(d)) {
    d[i,] <- cov[samples[i], samples]
  }
  d <- 1-d
  c <- c()
  for(i in 1:ncol(d)-1) {
    c <- c(c, d[(i+1):nrow(d),i])
  }
  d <- dist(d)
  for(i in 1:length(d)) {
    d[i] <- c[i]
  }
  km1 <- kmeans(d, number_of_clusters, nstart=100)
  return(list(clusters=km1, d=d))
}

kmeans_method <- function(investigated_sample, Y, kmeans_clusters){
  samples <- colnames(Y)
  cluster_id <- kmeans_clusters$cluster[investigated_sample]
  reference_samples <- c()
  list_index <- 1
  for(i in kmeans_clusters$cluster) {
    if(i == cluster_id) {
      reference_samples <- c(reference_samples, samples[list_index])
    }
    list_index <- list_index + 1
  }
  reference_samples <- setdiff(reference_samples, investigated_sample)
  return(list(reference_samples=reference_samples))
}

plot_diagram <- function(metrics_dunn, metrics_silhouette, metrics_davies_bouldin){
  library(ggplot2)
  svg('clustering_evaluation.svg')
  kmeans <- 2:length(metrics_dunn)
  df <- data.frame("kmeans" = c(kmeans,kmeans,kmeans), 
                   "metric_value" = c(metrics_dunn[-1],metrics_silhouette[-1],metrics_davies_bouldin[-1]), 
                   "metric" <- c(rep("Dunn index",length(kmeans)),rep("Silhouette width",length(kmeans)),rep("Davies Bouldin index",length(kmeans))))
  print({
    p <- ggplot(data=df, aes(kmeans, metric_value, group=metric, colour=metric)) 
    p + xlim(2,max(kmeans)) + labs(x = "Number of clusters", y = "Metric value", color = "Type of metric") + geom_line() + geom_point() + theme(legend.position="top")
  })
  dev.off()
}

