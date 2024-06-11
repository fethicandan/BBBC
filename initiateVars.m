clear;close all;clc
clearvars  xangle xbias Pp
%% Model parameters of the crazyflie 2.0
% Parameters
g = 9.81;       % m/s^2
m = 0.027;      % kg
l = 0.046;      % m
k = 2.2e-8;  % N m s^2
b = 2e-9;       % N s^2
Im = 3e-6;    % kg*m^2
I = [1.66e-5;    % kg*m^2
     1.66e-5;    % kg*m^2
     2.93e-5];   % kg*m^2
A = [0.92e-6;      % kg/s
	 0.91e-6;      % kg/s
	 1.03e-6];     % kg/s

% Thrust per rotor required to hover steadily
hover_omega = sqrt(g*m/(4*k));

%% Inner loop parameters for the crazyflie
% Loop rate at 500 Hz
inner_h = 0.1; 
% Sampling Rate
Ts=0.1;

% Omega saturation
inner_maxlim = 2500;
inner_minlim = 0;%500;

%% Crazyflie controller parameters
% % Parameters for PD-control (?nner Attitude-Altitude)
KzP = 15; KetaP = 16*[1 1 1];
KzD = KzP*1/2; KetaD = 9*[1 1 1];

Ke = 1;
Kd = 2;
K0 =  0.0001;
K1 = 0.1;

%% Initial states fo the system
initial_xi = [0; 0; 0];
initial_xidot = [0; 0; 0];
initial_eta = [0; 0; 0];
initial_etadot = [0; 0; 0];
max_ang_ref = pi/8;

% Computes the saturation bounds for the thrust PD controller
sat_lim = 0.1;        % difference between thrust and omega saturation
omega_min_lim = 0;    % rad/s
omega_max_lim = 2500; % rad/s
Tm = 4.*k.^2.*omega_min_lim;
Tp = 4.*k.*omega_max_lim.^2;
T_min_lim = Tm + (Tp - Tm) * sat_lim;
T_max_lim = Tp - (Tp - Tm) * sat_lim;
tau_max_lim = 1e-5;
tau_min_lim = -1e-5;

%% Initial Values of starting point and angle
xfinit = 0;
yfinit = 0;
xlinit = 0;
ylinit = 0;
yawl_init = 0;
yawf_init = 0;

v = [0 0 0]';
v_Abest = [0,0];
ang_A = 0;

Kc = 0.02;
Ti = 1;
Td = 8;

r_A = 0.32;
r_B = 0.12;
ref_X = 0;
ref_Y = 0;
desX = 0;
desY = 0;

tol=0.0001;
Alpha = 0;
Beta  = 0;
Gamma = 0;

V_des = [];
theta_right = 0;
theta_left = 0;
dif = [0,0];
suit = 1;
suitable_V = [];
unsuitable_V = [];
new_V = [];