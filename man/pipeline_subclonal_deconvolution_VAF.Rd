% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pipeline_subclonal_deconvolution_VAF.R
\name{pipeline_subclonal_deconvolution_VAF}
\alias{pipeline_subclonal_deconvolution_VAF}
\title{Pipeline to perform subclonal deconvolution with MOBSTER.}
\usage{
pipeline_subclonal_deconvolution_VAF(
  mutations,
  cna = NULL,
  purity = NULL,
  sample = "XXX_YYY_ZZZ",
  output = paste0(sample, "_evoverse_vaf_deconvolution.pdf"),
  min_VAF = 0.05,
  karyotypes = c("1:0", "1:1", "2:0", "2:1", "2:2"),
  min_muts = 50,
  N_max = 15000,
  matching_epsilon_peaks = 0.025,
  cex = 0.7,
  collate = FALSE,
  ...
)
}
\arguments{
\item{mutations}{Input mutations in the format for package \code{CNAqc}.}

\item{cna}{Absolute Copy Number Alterations in the format for package \code{CNAqc}.}

\item{purity}{Tumour purity, in [0, 1].}

\item{min_muts}{Skip analysing karyotypes with less than \code{min_muts} mutations.}

\item{cex}{}

\item{...}{Parameters passed \code{mobster_fit} in package \code{mobster}.}
}
\value{

}
\description{
For a list of input mutations, CNA and purity data from a tumour sample,
MOBSTER fits are computed to determine proportions of mutations in each
aneuploidy state (copy state). Assignments and plots are returned, and
an automatic QC pipeline (supervised logistic classifier) is used to
flag which fits pass quality check. The trained set for the classifier
consists in n = 377 colorectal whole genome samples.
}
\examples{
# We use data released with the CNAqc package

cna = CNAqc::example_dataset_CNAqc$cna
mutations = CNAqc::example_dataset_CNAqc$snvs
purity = CNAqc::example_dataset_CNAqc$purity

# We use auto_setup = 'FAST' to speed up the analysis
x = pipeline_subclonal_deconvolution_VAF(mutations, cna = cna, purity = purity,  N_max = 1000, auto_setup = 'FAST')
print(x)
}
