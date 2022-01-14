%% 648, 1/2
clear all;
clc
ldpc_code = LDPCCode(0, 0);

block_length = 648; % Should be one of 648, 1296, and 1944
rate = 1/2; % Should be one of 1/2, 2/3, 3/4, 5/6


ldpc_code.load_wifi_ldpc(block_length, rate);
info_length = ldpc_code.K;
disp(['Running LDPC with N = ', num2str(block_length), ' and rate = ' , num2str(rate)]);

info_bits = rand(info_length * 300, 1) < 0.5;  % genrate bits to encode 150 frames.
p = [sum(info_bits)/length(info_bits), sum(info_bits==0)/length(info_bits)];
ent = - sum(p.*log2(p));

% encode
encoded = [];
for idx = 1:300
    frame_bits = info_bits((idx-1)*info_length+1 : idx*info_length);
    encoded = [encoded; ldpc_code.encode_bits(frame_bits)];
end


% writematrix(info_bits.', ['../encoding/info_bits_N', num2str(block_length), '_R12.csv']);
% writematrix(encoded.', ['../encoding/encoded_N', num2str(block_length), '_R12.csv']);

%% 1296, 2/3
clear all;
clc
ldpc_code = LDPCCode(0, 0);

block_length = 1296; % Should be one of 648, 1296, and 1944
rate = 2/3; % Should be one of 1/2, 2/3, 3/4, 5/6


ldpc_code.load_wifi_ldpc(block_length, rate);
info_length = ldpc_code.K;
disp(['Running LDPC with N = ', num2str(block_length), ' and rate = ' , num2str(rate)]);

info_bits = rand(info_length * 300, 1) < 0.5;  % genrate bits to encode 150 frames.
p = [sum(info_bits)/length(info_bits), sum(info_bits==0)/length(info_bits)];
ent = - sum(p.*log2(p));

% encode
encoded = [];
for idx = 1:300
    frame_bits = info_bits((idx-1)*info_length+1 : idx*info_length);
    encoded = [encoded; ldpc_code.encode_bits(frame_bits)];
end


writematrix(info_bits.', ['../encoding/info_bits_N', num2str(block_length), '_R23.csv']);
writematrix(encoded.', ['../encoding/encoded_N', num2str(block_length), '_R23.csv']);

%% 1944, 3/4
clear all;
clc
ldpc_code = LDPCCode(0, 0);

block_length = 1944; % Should be one of 648, 1296, and 1944
rate = 3/4; % Should be one of 1/2, 2/3, 3/4, 5/6


ldpc_code.load_wifi_ldpc(block_length, rate);
info_length = ldpc_code.K;
disp(['Running LDPC with N = ', num2str(block_length), ' and rate = ' , num2str(rate)]);

info_bits = rand(info_length * 300, 1) < 0.5;  % genrate bits to encode 150 frames.
p = [sum(info_bits)/length(info_bits), sum(info_bits==0)/length(info_bits)];
ent = - sum(p.*log2(p));

% encode
encoded = [];
for idx = 1:300
    frame_bits = info_bits((idx-1)*info_length+1 : idx*info_length);
    encoded = [encoded; ldpc_code.encode_bits(frame_bits)];
end


writematrix(info_bits.', ['../encoding/info_bits_N', num2str(block_length), '_R34.csv']);
writematrix(encoded.', ['../encoding/encoded_N', num2str(block_length), '_R34.csv']);

%% 648, 5/6
clear all;
clc
ldpc_code = LDPCCode(0, 0);

block_length = 648; % Should be one of 648, 1296, and 1944
rate = 5/6; % Should be one of 1/2, 2/3, 3/4, 5/6


ldpc_code.load_wifi_ldpc(block_length, rate);
info_length = ldpc_code.K;
disp(['Running LDPC with N = ', num2str(block_length), ' and rate = ' , num2str(rate)]);

info_bits = rand(info_length * 300, 1) < 0.5;  % genrate bits to encode 150 frames.
p = [sum(info_bits)/length(info_bits), sum(info_bits==0)/length(info_bits)];
ent = - sum(p.*log2(p));

% encode
encoded = [];
for idx = 1:300
    frame_bits = info_bits((idx-1)*info_length+1 : idx*info_length);
    encoded = [encoded; ldpc_code.encode_bits(frame_bits)];
end


writematrix(info_bits.', ['../encoding/info_bits_N', num2str(block_length), '_R56.csv']);
writematrix(encoded.', ['../encoding/encoded_N', num2str(block_length), '_R56.csv']);

