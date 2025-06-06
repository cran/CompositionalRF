comp.rf <- function(xnew = x, y, x, type = "alr", ntrees, nfeatures, minleaf,
                    ncores = 1) {
  
  if ( type == "alr" )  y <- .alrOptimized(y)
  est <- CompositionalRF::mrf(xnew = xnew, y = y, x = x, ntrees = ntrees,
         nfeatures = nfeatures, minleaf = minleaf, ncores = ncores)
  Compositional::alrinv(est)
}
