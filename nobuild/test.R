require(tidyverse)

load('~/Downloads/Archive/data/Mutect_Set07_Diploid.RData', verbose = T)

mutations = readxl::read_excel('~/Downloads/Archive/SM_tables/Supplementary_Table_S1_MSeq_calls.xlsx', sheet = 2)

cna = readxl::read_excel('~/Downloads/Archive/SM_tables/Supplementary_Table_S1_MSeq_calls.xlsx', sheet = 3)
colnames(cna)[c(2,4)] = c('from', 'to')
colnames(cna) = gsub('_Minor', '\\.minor', colnames(cna))
colnames(cna) = gsub('_Major', '\\.Major', colnames(cna))
cna$chr = paste0('chr', cna$chr)

clean_mutations = mutations %>%
  select(-ends_with('projected'), -ends_with('cluster'),-starts_with('MOBSTER')) %>%
  mutate(from = as.numeric(from), to = as.numeric(to))
colnames(clean_mutations) = gsub('_original', '', colnames(clean_mutations))

mutations_list = cna_list = NULL

for(s in dataset$samples)
{
  nw = clean_mutations %>% select(chr,
                           from,
                           to,
                           ref,
                           alt,
                           gene,
                           starts_with(!!s),
                           cosmic,
                           `function.`,
                           mutlocation,
                           region)

  colnames(nw) = gsub(paste0(s, '\\.'), '', colnames(nw))
  colnames(nw)[7] = 'vaf_normal'

  mutations_list = append(mutations_list, list(nw))

  #
  nw = cna %>% select(chr,
                      from,
                      to,
                      nloci,
                      starts_with(!!s))

  colnames(nw) = gsub(paste0(s, '\\.'), '', colnames(nw))

  cna_list = append(cna_list, list(nw))
}

names(cna_list) = names(mutations_list) = dataset$samples

save(clean_mutations, file = '../Set7.RData')

require(mobster)
require(mvmobster)

x = mvmobster::dataset(
  mutations = mutations_list,
  segments = cna_list,
  samples = dataset$samples,
  purity = dataset$purity
)

x = mvmobster::analyze_mobster(x, epsilon = 1e-4, K = 1, parallel = FALSE, maxIter = 100)

library(CNAqc)

f = plot(x)
f[[3]]

require(ggpubr)
fg = ggarrange(plotlist = f, ncol = 2, nrow = 3)

plot_sample(x, sample = 'Set7_55')

qc = CNAqc::analyze_peaks(x$CNAqc$Set7_62)
plot_peaks_analysis(qc)

qc$peaks_analysis$plots$`1:1` + ylim(0, 5)

x = analyze_mobster(x, parallel = F, epsilon = 1e-5, K = c(1, 2))
save(y, file = '../y_Set7.RData')

load(file = '../y_Set7.RData')

f = mvmobster::plot.mbst_data(y, clusters = 'MOBSTER', N = 2000)
f[[3]]

f = mvmobster::plot.mbst_data(y, N = 2000)
f[[3]]

plot(y$fit_MOBSTER$Set7_62$best)
plot_model_selection(y$fit_MOBSTER$Set7_62)
plot_latent_variables(y$fit_MOBSTER$Set7_62$best)

data('example_input_formats')

data('example_input_formats')

example_dummy =
  dataset(
    mutations = example_input_formats$wide_mutations,
    segments = example_input_formats$wide_segments,
    purity = example_input_formats$purity,
    samples = example_input_formats$samples
)
