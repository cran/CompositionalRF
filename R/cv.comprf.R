cv.comprf <- function(y, x, ntrees = c(50, 100, 500, 1000), nfeatures, minleaf,
                      folds = NULL, nfolds = 10, seed = NULL, ncores = 1) {
  
  config <- as.matrix( expand.grid(ntrees = ntrees, nfeatures = nfeatures, minleaf = minleaf) )
  ly <- Compositional::alr(y)
  n <- dim(y)[1]
  
  if (ncores > 1) {
    cl <- parallel::makePSOCKcluster(ncores)
    doParallel::registerDoParallel(cl)
    on.exit(parallel::stopCluster(cl))
    if ( is.null(folds) )
      folds <- Compositional::makefolds(1:n, nfolds = nfolds, stratified = FALSE, seed = seed )
    nfolds <- length(folds)
    p <- dim(config)[1]
    kl <- js <- matrix(nrow = nfolds, ncol = p)
    
    per <- foreach( k=1:nfolds, .combine = rbind, .export = "comp.rf") %dopar% {
      ytrain <- ly[ -folds[[ k ]], ]
      ytest <- y[ folds[[ k ]],  ]
      xtrain <- x[-folds[[ k ]], ]
      xtest <- x[folds[[ k ]], ]
      for (j in 1:p) {
        est <- CompositionalRF::comp.rf(xtest, ytrain, xtrain, type = 0,
                                        ntrees = config[j, 1], nfeatures = config[j, 2], minleaf = config[j, 3])
        ela <- abs( ytest * log( ytest / est ) )
        ela[ is.infinite(ela) ] <- NA
        kl[k, j] <- 2 * mean(ela , na.rm = TRUE)
        ela2 <- ytest * log( 2 * ytest / (ytest + est) ) + est * log( 2 * est / (ytest + est) )
        ela2[ is.infinite(ela2) ] <- NA
        js[k, j] <- mean(ela2, na.rm = TRUE)
      }
      return( cbind(kl, js) )
    }
    # parallel::stopCluster(cl)
    kl <- Rfast::colmeans( per[, 1:(0.5 * p)] )
    js <- Rfast::colmeans( per[, (0.5 * p + 1):p] )
    kl <- cbind(config, kl )
    js <- cbind(config, js )
    
  } else {
    if ( is.null(folds) )
      folds <- Compositional::makefolds(1:n, nfolds = nfolds, stratified = FALSE, seed = seed)
    nfolds <- length(folds)
    p <- dim(config)[1]
    kl <- js <- matrix(nrow = nfolds, ncol = p)
    
    for ( k in 1:nfolds ) {
      ytrain <- ly[ -folds[[ k ]], ]
      ytest <- y[ folds[[ k ]],  ]
      xtrain <- x[-folds[[ k ]], ]
      xtest <- x[folds[[ k ]], ]
      for (j in 1:p) {
        est <- CompositionalRF::comp.rf(xtest, ytrain, xtrain, type = 0,
                                        ntrees = config[j, 1], nfeatures = config[j, 2], minleaf = config[j, 3])
        ela <- abs( ytest * log( ytest / est ) )
        ela[ is.infinite(ela) ] <- NA
        kl[k, j] <- 2 * mean(ela , na.rm = TRUE)
        ela2 <- ytest * log( 2 * ytest / (ytest + est) ) + est * log( 2 * est / (ytest + est) )
        ela2[ is.infinite(ela2) ] <- NA
        js[k, j] <- mean(ela2, na.rm = TRUE)
      }
    }
    kl <- cbind(config, Rfast::colmeans(kl) )
    js <- cbind(config, Rfast::colmeans(js) )
  }
  
  colnames(kl) <- c( colnames(config), "KL")
  colnames(js) <- c( colnames(config), "JS")
  list(kl = kl, js = js)
}







