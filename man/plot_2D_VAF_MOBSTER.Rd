% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_2D_VAF_MOBSTER.R
\name{plot_2D_VAF_MOBSTER}
\alias{plot_2D_VAF_MOBSTER}
\title{Plot a 2-dimensional VAF scatterplot, augmented with `MOBSTER` cluster.}
\usage{
plot_2D_VAF_MOBSTER(x, s1 = x$samples[1], s2 = x$samples[2], N = 10000, ...)
}
\arguments{
\item{x}{An `evoverse` object.}

\item{s1}{The second sample name, by default `x$samples[1]` the second sample in the data.}

\item{N}{Maximum number of points to plot, the overall percentage is reported.}

\item{...}{Extra parameters, not used.}
}
\value{
A `ggplot` object plot.
}
\description{
This function plots a 2D scatterplot
of the input VAF values in sample`s1` versus `s2`.
Compared to function \code{plot_2D_VAF}, this
function colours the points according to `MOBSTER`
clusters (with a double label mechanism `A ~ B`
meaning that the point is in cluster `A` in one sample
and `B` in the other). Similarly to \code{plot_2D_VAF},
this function can also subsample the number of plot
points, which helps to allow for a faster rendering
of the returned plot. The number of mutations shown
is always reported, as well as the proportion with
respect to the total number of mutations.
}
\note{
This function throws an error if the object `x` does
not contain `MOBSTER` clusters.
}
\examples{
data('example_evoverse')

# Plot the 1st vs the 2nd sample (default parameters)
plot_2D_VAF_MOBSTER(example_evoverse)
}
\seealso{
Function \link{\code{plot_2D_VAF}} is a simpler version of this plot
which does not visualize `MOBSTER` clusters.
}
