function [ params ] = SetQuest3DParams(row_eigs_num, col_eigs_num, trial_eigs_num, row_alpha, row_beta, col_alpha, col_beta, trial_alpha, trial_beta )
% Sets parameters for the questionnaire algirithm (user accesible).
% 
% to_normalize:                boolean variable. if true, data should be normalized.
% normalize_over_rows:         boolean variable. if true, normalization is applied on the rows 
%                              (relavent iff to_normalize is true).
% normalization_type:          choices are: 'by_std' (default)| 'scaling_between_0_and_1'| 'summing_to_unity'
%                              (relavent iff to_normalize is true).
% 
% init_aff_on_rows:            boolean variable. if true, the initial affinity is on the rows. 
% init_aff_metric:             choices are: 'cosine_similarity' (default)| 'gaussian'.
% init_aff_thresh:             conatrains the minimal affinities. positive number, default is 0  
%                              (relavent iff init_aff_type is 'cosine_similarity'). 
% init_aff_eps:                defines locality. positive number, default is 1 
%                              (relavent iff init_aff_type is 'gaussian').
% init_aff_knn:                number of nearest neighbors to consider. positive integer, 
%                              default is 5 (relavent iff init_aff_type is 'gaussian').
% 
% n_iters:                     number of iterations to carry out. positive integer, default is 1. 
% 
% row_constant:                conatrains the size of clusters. positive number, default is 1.
% row_min_joins_percentage:    conatrains the minimal number of joins per level. ranges between 0 and 1. 
% row_alpha:                   real number, default is 1. 
%                              alpha=0: all tree levels are equally weighted.
%                              alpha>0: puts higher weights on levels closer to the root.
%                              alpha<0: puts higher weights on levels closer to the leaves.
% row_beta:                    real number, default is 0. 
%                              beta=0: all tree folders are equally weighted.
%                              beta>0: puts higher weights on larger folders.
%                              beta<0: puts higher weights on smaller folders.
% row_eps:                     defines locality. positive number, default is 1.
% 
% col_constant:                conatrains the size of clusters. positive number, default is 1.
% col_min_joins_percentage:    conatrains the minimal number of joins per level. ranges between 0 and 1. 
% col_alpha:                   real number, default is 1. 
%                              alpha=0: all tree levels are equally weighted.
%                              alpha>0: puts higher weights on levels closer to the root.
%                              alpha<0: puts higher weights on levels closer to the leaves.
% col_beta:                    real number, default is 0. 
%                              beta=0: all tree folders are equally weighted.
%                              beta>0: puts higher weights on larger folders.
%                              beta<0: puts higher weights on smaller folders.
% col_eps:                     defines locality. positive number, default is 1.
% 
% Output: 
%     params - struct array with all user parameters 
%--------------------------------------------------------------------------
verbose = 2;
to_normalize = false;
normalize_over_rows = true;
normalization_type = 'by_std';

init_aff_row_on_rows = false;
init_aff_row_metric = 'cosine_similarity';
init_aff_row_thresh = 0.0;
init_aff_row_eps = 1;
init_aff_row_knn = 5;

init_aff_col_on_rows = false;
init_aff_col_metric = 'cosine_similarity';
init_aff_col_thresh = 0.0;
init_aff_col_eps = 1;
init_aff_col_knn = 5;

init_aff_trial_on_rows = false;
init_aff_trial_metric = 'cosine_similarity';
init_aff_trial_thresh = 0.0;
init_aff_trial_eps = 1;
init_aff_trial_knn = 5;

n_iters = 2;

row_constant = 0.5;
row_min_joins_percentage = 0.1;
row_eps = 1;

col_constant = 0.5;
col_min_joins_percentage = 0.1;
col_eps = 1;

trial_constant = 0.5;
trial_min_joins_percentage = 0.1;
trial_eps = 1;
%--------------------------------------------------------------------------

params.data.to_normalize = to_normalize;
params.data.over_rows = normalize_over_rows;
params.data.normalization_type = normalization_type;

% init affine
params.init_aff_col.on_rows = init_aff_col_on_rows;
params.init_aff_col.metric = init_aff_col_metric;
params.init_aff_col.thresh = init_aff_col_thresh;
params.init_aff_col.eps = init_aff_col_eps;
params.init_aff_col.knn = init_aff_col_knn;

params.init_aff_row.on_rows = init_aff_row_on_rows;
params.init_aff_row.metric = init_aff_row_metric;
params.init_aff_row.thresh = init_aff_row_thresh;
params.init_aff_row.eps = init_aff_row_eps;
params.init_aff_row.knn = init_aff_row_knn;

params.init_aff_trials.on_rows = init_aff_trial_on_rows;
params.init_aff_trials.metric = init_aff_trial_metric;
params.init_aff_trials.thresh = init_aff_trial_thresh;
params.init_aff_trials.eps = init_aff_trial_eps;
params.init_aff_trials.knn = init_aff_trial_knn;

params.n_iters = n_iters;
% trees and EMD
params.row_tree.eigs_num = row_eigs_num;
params.row_tree.constant = row_constant;
params.row_tree.min_joins_percentage = row_min_joins_percentage;
params.row_emd.alpha = row_alpha;
params.row_emd.beta = row_beta;
params.row_emd.eps = row_eps;

params.col_tree.eigs_num = col_eigs_num;
params.col_tree.constant = col_constant;
params.col_tree.min_joins_percentage = col_min_joins_percentage;
params.col_emd.alpha = col_alpha;
params.col_emd.beta = col_beta;
params.col_emd.eps = col_eps;

params.trials_tree.eigs_num = trial_eigs_num;
params.trials_tree.constant = trial_constant;
params.trials_tree.min_joins_percentage = trial_min_joins_percentage;
params.trials_emd.alpha = trial_alpha;
params.trials_emd.beta = trial_beta;
params.trials_emd.eps = trial_eps;
params.verbose = verbose;
params.col_tree.verbose = verbose;
params.row_tree.verbose = verbose;
params.trials_tree.verbose = verbose;
end


function [ res ] = is_natural( a )
% Determines whether a given number is a natural number.
%--------------------------------------------------------------------------

if (a > 0) && (a == round(a)),
    res = true;
else
    res = false;
end

end


