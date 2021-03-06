
clear all; clc;

% Input
K                       = 11;                                     
rho                     = 0.25;                                 
CARE_RB_Th2_005         = load('CARE_RB_Th2_005'); 
T_k_Th2_005             = load('T_k_Th2_005');          
y_t_005_Th2             = load('y_t_005_Th2');
V                       = size(y_t_005_Th2, 2);
CARE_risk_bound_Th2_005 = load('CARE_risk_bound_Th2_005.mat');
CARE_LR_c_Th2_005       = CARE_risk_bound_Th2_005.CARE_LR_c_Th2_005;
CARE_LR_d_Th2_005       = CARE_risk_bound_Th2_005.CARE_LR_d_Th2_005;

% Programme Code
z_k_c_Th2_005 = zeros(K - 1, K - 1); 
z_k_d_Th2_005 = zeros(K - 1, K - 1);
for s = 1 : 1 : (K - 1)
  for s_step = 1 : 1 : K - 1
      
      z_k_c_Th2_005(s, s_step) = LCARE_Propagation_Condition(s, s_step, ...
                                  V, T_k_Th2_005, CARE_LR_c_Th2_005, 1)...
                                 + CARE_RB_Th2_005(1);
      z_k_d_Th2_005(s, s_step) = LCARE_Propagation_Condition(s, s_step, ...
                                  V, T_k_Th2_005, CARE_LR_d_Th2_005, 2)...
                                 + CARE_RB_Th2_005(2);
                             
  end
end
z_k_c_Th2_005 = diag(z_k_c_Th2_005); 
z_k_d_Th2_005 = diag(z_k_d_Th2_005);
z_k_Th2_005   = [z_k_c_Th2_005, z_k_d_Th2_005];

for i = 1 : 1 : 2
  for s = 2 : 1 : length(z_k_Th2_005)
      
    if z_k_Th2_005(s, i) > z_k_Th2_005(s - 1, i)
        z_k_Th2_005(s, i) = z_k_Th2_005(s - 1, i);
    else
        z_k_Th2_005(s, i) = z_k_Th2_005(s, i);
    end
    
  end
end

% Output
Out.z_k_Th2_005 = z_k_Th2_005;
save('z_k_Th2_005', 'z_k_Th2_005', '-ascii');

