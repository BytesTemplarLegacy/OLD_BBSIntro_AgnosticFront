{$G+,A+,S-,R-,I-,Q-,Y-,D-,L-,N-,E-}
Unit PicPak1;
Interface
Procedure Man1; Procedure Man2; Procedure Card;

implementation
{$L MAN1.OBJ} {$L MAN2.OBJ} {$L CARD.OBJ}
Procedure Man1; External;
Procedure Man2; External;
Procedure Card; External;
End.