


%% update
function [x_est, p_est] = MCKF(x_est, p_est, Y)

H = eye(12);
R = 0.01 * eye(12);
Q = 0.01 * eye(12);
F = eye(12);

[x_pred, p_pred] = prediction(F, x_est, p_est, Q);

iter = 100;
epsilon = 1e-3;

I = eye(length(x_pred));

x_est_prev = x_pred;

                 
for i = 1: iter
    if length(R) > 1
        Br = chol(R);
    else
        Br = sqrt(R);
    end
    
Bp = chol(p_pred);                % Cholesky Decomposition 
B =  blkdiag(Bp, Br);             % Define Diagonal
D = inv(B) * cat(1, x_pred, Y);
W = inv(B) * cat(1, I, H);
E = D - (W * x_est_prev);
            
Cx_diag = [];
Cy_diag = [];
            
    for i = 1:length(x_pred')
        Cx_diag = [Cx_diag, gaussian_kernel(E(i))];
    end

    for i = length(x_pred')+1:length(E')
        Cy_diag = [Cy_diag, gaussian_kernel(E(i))];
    end

Cx = diag(Cx_diag);
Cy = diag(Cy_diag);
% Cx = Cx_diag;
% Cy = Cy_diag;
        
p_pred = (Bp * Cx^-1 * Bp');
R = ((Br * Cy^-1) * Br');
K = (p_pred * H') * inv((H * p_pred) * H' + R );
x_est = x_pred + (K * (Y - (H * x_pred)));



res = norm(x_est - x_est_prev) / norm(x_est_prev);
x_est_prev = x_est;            
    if res <= epsilon
        p_est =((I - (K * H)) * p_pred) * (I - (K * H)');
        break
    else
        continue
    end

end
end


%% gaussian kernel
function g_sigma = gaussian_kernel(error)
sigma = 10;
g_sigma = exp(- (error^2/(2*sigma^2)));
end


%% prediction
function [x_pred, p_pred] = prediction(F, x_est, p_est, Q)
x_pred = F * x_est;
p_pred = (F * p_est) * F' + Q;
end
  
        

        