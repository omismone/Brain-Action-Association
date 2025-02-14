% hrf_function: Calculates the hemodynamic response function (HRF)
%
% t: Time vector (seconds)
% a1: Shape parameter for the first peak
% a2: Shape parameter for the undershoot
% b1: Scale parameter for the first peak
% b2: Scale parameter for the undershoot
% c: Scaling factor for the undershoot
function h = hrf(t, a1, a2, b1, b2, c)
    % amplitudes
    d1 = a1 * b1;
    d2 = a2 * b2;

    % first peak component
    h1 = (t / d1).^a1 .* exp(-(t - d1) / b1);
    % undershoot component
    h2 = (t / d2).^a2 .* exp(-(t - d2) / b2);

    h = h1 - c * h2;
    h(t < 0) = 0;

    % normalize
    h = h / max(h);
end
