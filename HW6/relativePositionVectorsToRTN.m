function [Rrtn] = relativePositionVectorsToRTN(r1, v1, r2)


    deltaR = r2 - r1;
    lengthR1 = sqrt(dot(r1,r1));
    
    P11 = r1(1)/lengthR1;
    P12 = r1(2)/lengthR1;
    P13 = r1(3)/lengthR1;
    
    hx = r1(2)*v1(3) - r1(3)*v1(2);
    hy = r1(3)*v1(1) - r1(1)*v1(3);
    hz = r1(1)*v1(2) - r1(2)*v1(1);
    h = hx^2 + hy^2 + hz^2;
    
    P31 = hx/h;
    P32 = hy/h;
    P33 = hz/h;
    
    P21 = P32*P13 - P33*P12;
    P22 = P33*P11 - P31*P13;
    P23 = P31*P12 - P32*P11;
    
    P = [P11, P12, P13; P21, P22, P23; P31, P32, P33];
    
    Rrtn = P*deltaR;


end