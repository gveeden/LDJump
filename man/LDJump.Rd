\name{LDJump}
\alias{LDJump}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Estimate Variable Recomination Rates from Population Genetic Data
%%  ~~function to do ... ~~
}
\description{This function estimates variable recombination rates from population genetic data.
    Therefore, a segmentation algorithm with specific segment lengths (\code{segLength}) and type-I error probability (\code{alpha}, \eqn{\alpha}) is applied. The returned object can be plotted with the plot-function of the package \code{stepR}.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
LDJump(seqName, alpha = 0.05, segLength = 1000, pathLDhat = "",
       format = "fasta", refName = NULL, start = NULL, thth = 0.005,
       constant = F, rescale = F, status = T, polyThres = 0,
       cores = 1, accept = F)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{seqName}{
%%     ~~Describe \code{seqName} here~~
   A character string containing the path and the name of the sequence file in \code{fasta} of \code{vcf} format.
}
  \item{alpha}{
  A value from the interval (0,1) for the type-I error probability \eqn{\alpha} used in the segmentation algorithm. We recommend to use 0.05. We enabled to estimate the recombination map efficiently (without recalculating all summary statistics) under several type-I errors when \code{LDJump} is applied with a vector of type-I error probabilities.
}
  \item{segLength}{
%%     ~~Describe \code{segLength} here~~
   An integer value for the length of the segments, provided by the user. The default value of 1000 is our recommended value (1kb). The number of resulting segments, based on the sequence length is calculated within the funtion.
}
  \item{pathLDhat}{
  A character string containing the path to LDhat. This path and the installation of \href{https://github.com/auton1/LDhat}{LDhat} is necessary for the computation of the package.
  }

  \item{format}{
  A character string which can be either \code{fasta} or \code{vcf}. If \code{fasta} is used, the package will proceed with the computation of the recombination map. If \code{vcf}, the package will convert the data in \code{vcf} format to \code{fasta} format with the function \code{vcfR_to_fasta} and then proceed as in case \code{fasta}.
  }

  \item{refName}{
  An (optional) path to the reference sequence for the region of interest downloaded from e.g. http://phase3browser.1000genomes.org/index.html. Only to be used in case that \code{format == "vcf"}.
  }
  \item{start}{
  An (optional) integer value which reflects the starting position of the sequences in bp. Only to be used in case that \code{format == "vcf"}.
  }
    \item{thth}{
  A numeric value for \eqn{\theta} used in the lookup tables of \href{https://github.com/auton1/LDhat}{LDhat}.
}
    \item{constant}{
  an optional logical value: by default \code{FALSE} estimating variable recombination rates. If \code{TRUE}, the constant recombination rate for the full sequence is estimated.
  }
  \item{rescale}{
  an optional logical value: by default \code{FALSE} the sequence length is not rescaled to 0 and 1. If \code{TRUE} this rescaling is performed.
  }
  \item{status}{
  an optional logical value: by default \code{TRUE} such that the current processing status of the segments is printed.
  }
  \item{polyThres}{
  a numeric value between 0 and 1. Used in data manipulation function \code{DNAbin2genind}: the minimum frequency of a minor allele for a locus to be considered as polymorphic (default to 0).
  }
   \item{cores}{
  a positive integer value which is by default 1. This integer reflects the number of cores to be used. Hence, when setting to an integer larger then one the same number of cores are used to compute the recombination map.
  }
  \item{accept}{
  an optional logical value: by default \code{FALSE} and \code{LDJump} checks for segments with less than 2 SNPs and requires user input to proceed. If set to \code{TRUE}, it is accepted that the rates for these segments are estimated via imputation.
  }
}
%%\details{
%%  ~~ If necessary, more details than the description above ~~

%%}
\value{
The following list is returned in the case of estimating variable recombination rates (\code{constant == FALSE}).

  \item{seq.full.cor}{The final estimate of the recombination map. Depiction with plot-function of stepR package. }
  \item{pr.full.cor}{The (constant) estimates of the recombination rate per segment. }
  \item{help}{A helper matrix containing the summary statistics per segment used in the regression model. }
  \item{alpha}{The type-I error probability \eqn{\alpha}.}
  \item{nn}{The number of individuals (more precisely sequences) for which the recombination map was estimated.}
  \item{ll}{Total sequence length}
  \item{segs}{The number of segments by which the sequence is divided. Resulting from the user-defined segment length (segLength). }

For constant recombination rate estimation across the whole sequences (\code{constant == TRUE}), we provide the same list except for \code{seq.full.cor}.
%% ...
}
\references{
Auton, A. and McVean, G. (2007). Recombination rate estimation in the presence
of hotspots. Genome Research, 17(8), 1219–1227.

Frick, K., Munk, A., and Sieling, H. (2014). Multiscale change-point inference.
Journal of the Royal Statistical Society: Series B, 76(3), 495–580.

Futschik, A., Hotz, T., Munk, A., and Sieling, H. (2014). Multiscale DNA
partitioning: Statistical evidence for segments. Bioinformatics, 30(16), 2255–2262.

Jombart T. and Ahmed I. (2011) adegenet 1.3-1: new   tools for the analysis of
genome-wide SNP data. Bioinformatics. doi: 10.1093/bioinformatics/btr521

Knaus BJ and Grünwald NJ (2017). VCFR: a package to manipulate and visualize
variant call format data in R. Molecular Ecology Resources, 17(1), pp. 44-53.
ISSN 757, <URL:http://dx.doi.org/10.1111/1755-0998.12549>.

McVean, G. A. T., Myers, S. R., Hunt, S., Deloukas, P., Bentley, D. R., and Donnelly,
P. (2004). The fine-scale structure of recombination rate variation in the human
genome. Science, 304(5670), 581–584.

Paradis E., Claude J. & Strimmer K. 2004. APE:  analyses of phylogenetics and evolution
in R language. Bioinformatics 20: 289-290.

The 1000 Genomes Project Consortium (2015). Aglobal reference for human genetic
variation. Nature, 526(7571), 68–74.

Wood, S.N. (2011) Fast stable restricted maximum   likelihood and marginal
likelihood estimation of semiparametric generalized linear models.
Journal of the Royal Statistical Society (B) 73(1):3-36

}
\author{
Philipp Hermann \email{philipp.hermann@jku.at}, Andreas Futschik
}

\note{
  This function only works with unix and having \href{https://github.com/auton1/LDhat}{LDhat} (Auton and McVean (2007)) installed. Please properly check all paths to \href{https://github.com/auton1/LDhat}{LDhat} as well as the sequence files.
  The required lookup tables used by \href{https://github.com/auton1/LDhat}{LDhat} should be located in the path "pathToLDhat/LDhat-master/lk_files". Lookup tables are contained in LDhat, but we also provide several lookup tables \href{https://github.com/PhHermann/LDJump/tree/master/Lookups}{here}.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{summary_statistics}}, \code{\link{vcfR_to_fasta}}, \code{\link{fgt_rrate_dpr}}, \code{\link{get_smuce}}, \code{\link[stepR]{smuceR}}, \code{\link[quantreg]{rq}}, \code{\link[mgcv]{gam}}, \code{\link[vcfR]{vcfR2DNAbin}}, \code{\link[genetics]{diseq}}, \code{\link[genetics]{genotype}}, \code{\link[Biostrings]{readDNAStringSet}}
}

\examples{
##### Do not run these examples                                  #####
##### result = LDJump(fileName, alpha = 0.05, segLength = 1000,  #####
#####                 pathLDhat = getwd(), format = "fasta")          #####
##### plot(results)                                              #####
##### ab <- system(paste("locate LDhat-master |  head -n 1"), intern = T)   #####
##### map.tsi.40 = LDJump("S40example.fa", alpha = 0.05, segLength = 1000,  #####
#####                 pathLDhat = ab, format = "fasta")                          #####
##### plot(map.tsi.40)                                                      #####
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{methods}
\keyword{models, regression}
\keyword{datasets}
\keyword{list}
\keyword{htest}