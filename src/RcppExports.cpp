// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// mrf
NumericMatrix mrf(NumericMatrix xnew, NumericMatrix y, NumericMatrix x, int ntrees, int nfeatures, int minleaf, int ncores);
RcppExport SEXP _CompositionalRF_mrf(SEXP xnewSEXP, SEXP ySEXP, SEXP xSEXP, SEXP ntreesSEXP, SEXP nfeaturesSEXP, SEXP minleafSEXP, SEXP ncoresSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericMatrix >::type xnew(xnewSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type y(ySEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type x(xSEXP);
    Rcpp::traits::input_parameter< int >::type ntrees(ntreesSEXP);
    Rcpp::traits::input_parameter< int >::type nfeatures(nfeaturesSEXP);
    Rcpp::traits::input_parameter< int >::type minleaf(minleafSEXP);
    Rcpp::traits::input_parameter< int >::type ncores(ncoresSEXP);
    rcpp_result_gen = Rcpp::wrap(mrf(xnew, y, x, ntrees, nfeatures, minleaf, ncores));
    return rcpp_result_gen;
END_RCPP
}
// alrOptimized
SEXP alrOptimized(SEXP x);
RcppExport SEXP _CompositionalRF_alrOptimized(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(alrOptimized(x));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_CompositionalRF_mrf", (DL_FUNC) &_CompositionalRF_mrf, 7},
    {"_CompositionalRF_alrOptimized", (DL_FUNC) &_CompositionalRF_alrOptimized, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_CompositionalRF(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
