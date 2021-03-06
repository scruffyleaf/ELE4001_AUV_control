% MSS Vessel Models
%
% Standard ship, semisubmersible and underwater vehicle models.
%
%    Ships:
%    frigate     - Frigate, L = 100 m (nonlinear autopilot model)
%    mariner     - Mariner class vessel, L=160 m (nonlinear maneuvering model)
%    tanker      - Tanker, L=304 m (nonlinear course unstable maneuvering model)
%    container   - Container ship, L=175 m (nonlinear maneuvering model including the roll mode)
%    Lcontainer  - Container ship, L=175 m (LINEAR maneuvering model including the roll mode)
%    navalvessel - Multipurpose naval vessel, L = 51.5 m (nonlinear manneuvering model)
%    ROVzefakkel - Boat, L = 45 m (nonlinear autopilot model) 
%    supply      - Supply vessel, L = 76.2 m (linear DP model)
%
%    Underwater vehicles:
%    DSRV        - Deep submergence rescue vehicle (DSRV), L = 5.0 m
%    npsauv      - Naval Postgraduate School autnomous underwater vehicle (AUV), L = 5.3 m
%
%    Semisubmersibles:
%    rig         - Semisub MDG (mass-damper-spring) model, L = 84.6 m
%
%    USV models:
%    otter       - Small autonomous USV, L = 2.0 m
%
%    Time-series simulations:
%    SIMmariner     - Simulate mariner.m under PD control
%    SIMcontainer   - Simulate container.m and Lcontainer.m under PD control
%    SIMnavalvessel - Simulate navalvessel.m under PD control
%    SIMrig         - Simulate the 6-DOF semisub model under PID control
