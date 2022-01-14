clear;
load('binary_buffers.mat','five_sec_delay_binary')
addpath('../LdpcM')

five_sec_delay_binary = uint8(five_sec_delay_binary);
ldpc_code = LDPCCode(0, 0);

block_length = 1944; % Should be one of 648, 1296, and 1944
rate = 2/3; % Should be one of 1/2, 2/3, 3/4, 5/6


ldpc_code.load_wifi_ldpc(block_length, rate);
info_length = ldpc_code.K;
disp(['Running LDPC with N = ', num2str(block_length), ' and rate = ' , num2str(rate)]);

%% encode
encoded = [];
frames = [];
for idx = 1:size(five_sec_delay_binary,1)
    info_bits = reshape(de2bi(five_sec_delay_binary(1,:)).',[],1);
    %pad bits
    frame_bits = [info_bits; rand(ldpc_code.K- length(info_bits), 1) < 0.5];  % genrate bits to encode 150 frames.
    encoded = [encoded; ldpc_code.encode_bits(frame_bits)];
    frames = [frames; frame_bits];
end


writematrix(frames.', ['frames_N', num2str(block_length), '_R23.csv']);
writematrix(encoded.', ['encoded_N', num2str(block_length), '_R23.csv']);


%% decode
% python simulated_data_only_LDPC.py --minflip $((5*1e-3)) --maxflip $((75*1e-3)) --nflips 20 --niterations 5
bit_flip_p = linspace(5*1e-3,75*1e-3 + 7* 0.0037,27);
max_decode_iterations = 5;

success_rate = [];
ber = [];

for p = bit_flip_p
    no_errors = floor(ldpc_code.N*p);
    rx = [];
    decoded = [];
    success = 0;
    for tx_idx = 1:length(encoded)/ldpc_code.N
        frame = encoded((tx_idx-1)*ldpc_code.N+1 : tx_idx*ldpc_code.N);
        corrupted = frame;
        error_idx = randperm(ldpc_code.N,no_errors);
        corrupted(error_idx) = not(corrupted(error_idx));
        rx = [rx; corrupted];
        llr = ((-1).^corrupted)*log((1-p)/p);
        [decoded_codeword, ~] = ldpc_code.decode_llr(llr, max_decode_iterations, 0);
        decoded = [decoded; decoded_codeword];
        success = success + min(decoded_codeword == frame);
    end
    ber = [ber; sum(encoded ~= decoded)/length(encoded)];
    success_rate = [success_rate; success/(length(encoded)/ldpc_code.N)];
    
end

% due to "floor" actual bit flip probiblity is lower
bit_flip_p = floor(ldpc_code.N*bit_flip_p)/ldpc_code.N;
save('sim_results.mat', 'ber','bit_flip_p', 'decoded', 'encoded', 'rx', 'success_rate')

%% plots
load('my_implementation_test.mat')
close all
figure;
plot(bit_flip_p,bit_flip_p, bit_flip_p, ber, '.', 'MarkerSize',15)
hold on
plot(flip_p,flip_p, flip_p, ber_vec,'.', 'MarkerSize',15)
grid on
legend('raw ber matlab', 'ldpc ber matlab','raw ber python', 'ldpc ber python')

figure;
plot(bit_flip_p,success_rate,'.', 'MarkerSize',15)
hold on
plot(flip_p,s_rate,'.', 'MarkerSize',15)
grid on
legend('success rate matlab','success rate python')
