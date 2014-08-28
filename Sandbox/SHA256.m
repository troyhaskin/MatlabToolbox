function Hash = SHA256(Message)

    % Helper functions
    R   = @(v,n) bitshift(v,-n);
    S   = @(v,n) bitor(bitshift(v,-n),bitshift(v,(32-n)));
    Ch  = @(x,y,z) bitxor( bitand(x,y) , bitand(bitcmp(x),z) );
    Maj = @(x,y,z) bitxor( bitand(x,y) , bitxor( bitand(x,z) , bitand(y,z) ));
    SIGMA0 = @(x)  bitxor( S(x,02), bitxor( S(x,13) , S(x,22) ));
    SIGMA1 = @(x)  bitxor( S(x,06), bitxor( S(x,11) , S(x,25) ));
    sigma0 = @(x)  bitxor( S(x,07), bitxor( S(x,18) , R(x,03) ));
    sigma1 = @(x)  bitxor( S(x,17), bitxor( S(x,19) , R(x,10) ));
    Mod32Add = @(x) uint32(mod(sum(uint64(x)),2^32));
    
    % Initial hash vector
    [H,K] = LoadSHA256InitialVectorAndConstants();
    a = H(1);
    b = H(2); 
    c = H(3); 
    d = H(4); 
    e = H(5); 
    f = H(6); 
    g = H(7); 
    h = H(8); 
    
    % Count the number of bits in Message
    M       = uint8(Message);
    l       = GetMessageBitSize(M);
    
    % Determine the length of the zero padding
    nZeros = 448 - mod(l+1,512);
    
    % Create the padded Message
    M = [reshape(dec2bin(M,8)',1,l),'1',repmat('0',1,nZeros),dec2bin(l,64)];
    M = uint32(bin2dec(reshape(M,32,16)'));
    
    % Allocate expanded Message blocks
    W = ones(64,1,'uint32');
    W(1:16) = M;
    
    % Perform the compression for the first 16 iterations
    for j = 1:16
        T1 = Mod32Add([h,SIGMA1(e),Ch(e,f,g),K(j),W(j)]);
        T2 = Mod32Add([SIGMA0(a),Maj(a,b,c)]);
        h = g;
        g = f;
        f = e;
        e = Mod32Add([d,T1]);
        d = c;
        c = b;
        b = a;
        a = Mod32Add([T1,T2]);
    end
    
    % Perform the last iterations, now Wj needs to be calculate
    for j = 17:64
        W(j) = Mod32Add([sigma1(W(j-2)),W(j-7),sigma0(W(j-15)),W(j-16)]) ;
        T1 = Mod32Add([h,SIGMA1(e),Ch(e,f,g),K(j),W(j)]);
        T2 = Mod32Add([SIGMA0(a),Maj(a,b,c)]);
        h = g;
        g = f;
        f = e;
        e = Mod32Add([d,T1]);
        d = c;
        c = b;
        b = a;
        a = Mod32Add([T1,T2]);
    end
    
    Hash = Mod32Add([[a;b;c;d;e;f;g;h],H]');
    
end

function Size = GetMessageBitSize(Message) %#ok<INUSD>
    Info = whos('Message');
    Size = (Info.bytes)*8;
end

function [H,K] = LoadSHA256InitialVectorAndConstants()
    H = uint32(hex2dec(['6a09e667';'bb67ae85';'3c6ef372';'a54ff53a';...
            '510e527f';'9b05688c';'1f83d9ab';'5be0cd19']));
    K = uint32(hex2dec(['428a2f98';
        '71374491';
        'b5c0fbcf';
        'e9b5dba5';
        '3956c25b';
        '59f111f1';
        '923f82a4';
        'ab1c5ed5';
        'd807aa98';
        '12835b01';
        '243185be';
        '550c7dc3';
        '72be5d74';
        '80deb1fe';
        '9bdc06a7';
        'c19bf174';
        'e49b69c1';
        'efbe4786';
        '0fc19dc6';
        '240ca1cc';
        '2de92c6f';
        '4a7484aa';
        '5cb0a9dc';
        '76f988da';
        '983e5152';
        'a831c66d';
        'b00327c8';
        'bf597fc7';
        'c6e00bf3';
        'd5a79147';
        '06ca6351';
        '14292967';
        '27b70a85';
        '2e1b2138';
        '4d2c6dfc';
        '53380d13';
        '650a7354';
        '766a0abb';
        '81c2c92e';
        '92722c85';
        'a2bfe8a1';
        'a81a664b';
        'c24b8b70';
        'c76c51a3';
        'd192e819';
        'd6990624';
        'f40e3585';
        '106aa070';
        '19a4c116';
        '1e376c08';
        '2748774c';
        '34b0bcb5';
        '391c0cb3';
        '4ed8aa4a';
        '5b9cca4f';
        '682e6ff3';
        '748f82ee';
        '78a5636f';
        '84c87814';
        '8cc70208';
        '90befffa';
        'a4506ceb';
        'bef9a3f7';
        'c67178f2']));
end



