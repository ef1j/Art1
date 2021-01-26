C     ART1.F BY RICHARD WILLIAMS, 1968
C     ORIGINALLY WRITTEN FOR THE IBM SYSTEM/360 MODEL 40
C     AT THE UNIVERSITY OF NEW MEXICO, ALBUQUERQUE, NM
C     DATA WAS READ IN FROM A SET OF PUNCH CARDS
C     AND OUTPUT SENT TO AN IBM 1403 LINE PRINTER
C     THIS VERSION READS FILE FORT.25 FOR INPUT AND
C     WRITES TO THE STANDARD OUTPUT
C     IN A BSD UNIX, USE ASA TO MAP FORTRAN CARRIAGE
C     CONTROL CHARACTERS TO LINE PRINTER CONTROL SEQUENCES:
C     A.OUT | ASA > OUTPUT.TXT
C     MODIFIED BY E. FURST, 2021 FOR FILE INPUT / OUTPUT
      DIMENSION AR1(50,105), AR2(50,105), RD(10), CD(10), NAME(60)
      INTEGER S,A,R,C,RD,CD
      INDEX = 1
C     *
C     *INITIALIZING THE TWO ARRAYS*
      READ(25,10) CH1,NCH1,CH2,NCH2,NREP,NAME
 10   FORMAT(2(A1,I1),I1,5X,60A1)
      IF(NREP - 1) 50, 51, 51
 50   NREP = 1
 51   IF(NREP - 6) 53, 53, 52
 52   NREP = 6
 53   CONTINUE
      IF(NCH1) 5, 5, 6
 5    NCH1 = 1
 6    IF(NCH2) 7, 7, 8
 7    NCH2 = 1
 8    WRITE(6,11)
 11   FORMAT(36X,'12345',16X,'T',9X,'T',9X,'T',9X,'T',9X,'T',9X,'T')
      WRITE(6,12) CH1,NCH1,CH2,NCH2,NREP,NAME
 12   FORMAT(1X,'YOUR INITIALIZING DATA CARD READS ('
     2     ,2(A1,I1),I1,') AND (',60A1,').'/)
      DO 15 I = 1,50
      DO 15 J = 1,105, NCH1
 15   AR1(I,J) = CH1
      DO 20 I = 1,50
      DO 20 J = 1,105
 20   AR2(I,J) = CH2
C     *
C     *READING THE DATA CARDS*
      WRITE(6,25)
 25   FORMAT (1X,'YOUR OTHER DATA CARDS ARE -'/)
      WRITE(6,26)
 26   FORMAT(2X,'S',1X,'CH',2X,'A',3X,'R',2X,'C',3X,'NR',2X,'NC',1X,
     2     '****',1X,'R1,C1',2X,'R2,C2',2X,'R3,C3',2X,'R4,C4',2X,
     3     'R5,C5',2X,'R6,C6',2X,'R7,C7',2X,'R8,C8',2X,'R9,C9'
     4     ,2X,'RT,CT'/)
C     *
C     FIGURE SUBPROGRAM, S (IN FORMAT I2)
C     CHARACTER, CH (IN FORMAT A1)
C     ARRAY NUMBER 1 OR 2, A (IN FORMAT I1)
C     BEGIN FIGURE IN ROW R, COLUMN C (IN FORMAT I2, I3)
C     FIGURE SIZE, NUMBER OF ROWS DOWN, NR (IN FORMAT I2, I3)
C     FIGURE SIZE, NUMBER OF COLUMNS TO THE RIGHT, NC (IN FORMAT I4)
C     TEN POSSIBLE REPEATED FIGRUES STARTING IN ROW RD, COLLUMN CD
C                                             (IN FORMAT I2, I3)
C     *
 30   READ (25,31) S, CH, A,  R, C, NR, NC,(RD(I),CD(I), I=1,10)
 31   FORMAT (I2, A1, I1, I2, 2I3, I4, 4X, 10(I2,I3))
      WRITE(6,32) S, CH, A, R, C, NR, NC,(RD(I),CD(I), I=1,10)
 32   FORMAT(1X,I2,2X,A1,2X,I1,2X,I2,I3,2X,I3,I4,4X,10(2X,I2,I3))
C     *
C     *AFTER EACH DATA CARD IS READ THE DESIRED FIGURE IS GENERATED*
      GO TO(41,42,43,44,45,46,47,48),S
C     *
C     *THIS SUBPROGRAM CAUSES THE ARRAY ENTRIES TO BE PRINTED*
 41   CONTINUE
 101  FORMAT('1'///)
 102  FORMAT(16X, 105A1)
 103  FORMAT('+', 15X, 105A1)
      WRITE (6,101)
      DO 104 J = 1,50
      WRITE (6,102) (AR1(J,I), I = 1, 105)
 104  WRITE (6,103) (AR2(J,I), I = 1, 105)
c 104  continue
      WRITE (6,105) NAME
 105  FORMAT('0',60X,60A1)
      IF(NREP - INDEX) 1000, 1000, 106
 106  INDEX = INDEX + 1
      GO TO 41
C     *
C     *THIS SUBPROGRAM GENERATES STRAIGHT LINES*
 42   CONTINUE
      ND = 0
      IF(NR) 202, 201, 202
 201  NR = 1
 202  IF(NC) 204, 203, 204
 203  NC = 1
 204  NRABS = IABS(NR)
      NCABS = IABS(NC)
      NRSIG = NR/NRABS
      NCSIG = NC/NCABS
      IF(NRABS - 1) 210, 210, 205
 205  IF(NCABS - 1) 230, 230, 206
 206  IF(NCABS - NRABS) 207, 208, 208
 207  LROC = (NRABS - 1)/(NCABS - 1)
      LCOR = 1
      NNN = NCABS
      GO TO 250
 208  LCOR = (NCABS - 1)/(NRABS - 1)
      LROC = 1
      NNN = NRABS
      GO TO 250
 210  KK = 1
 211  DO 226 I = 1,NCABS
      N = C + NCSIG*(I - 1)
      IF(105 - N) 290, 213, 213
 213  IF(N - 1) 290, 215, 215
 215  IF(A - 2) 220, 225, 225
 220  AR1(R,N) = CH
      GO TO 226
 225  AR2(R,N) = CH
 226  CONTINUE
      GO TO 290
 230  KK = 2
 231  DO 246 I = 1, NRABS
      NN = R + NRSIG*(I - 1)
      IF(50 - NN) 290, 233, 233
 233  IF(NN - 1) 290, 235, 235
 235  IF(A - 2) 240, 245, 245
 240  AR1(NN,C) = CH
      GO TO 246
 245  AR2(NN,C) = CH
 246  CONTINUE
      GO TO 290
 250  KK = 3
 251  DO 270 I = 1, NNN
      N = C + NCSIG*LCOR*(I-1)
      IF(105 - N) 290, 253, 253
 253  IF(N - 1) 290, 255, 255
 255  NN = R + NRSIG*LROC*(I-1)
      IF(50 - NN) 290, 257, 257
 257  IF(NN - 1) 290, 259, 259
 259  IF(A - 2) 260, 261, 261
 260  AR1(NN,N) = CH
      GO TO 270
 261  AR2(NN,N) = CH
 270  CONTINUE
      GO TO 290
 290  ND = ND + 1
      IF(ND - 10) 291, 291, 299
 291  R = RD(ND)
      C = CD(ND)
      IF(R) 299, 299, 292
 292  IF(KK -2) 211, 231, 251
 299  CONTINUE
      GO TO 30
C     *
C     *THIS SUBPROGRAM GENERATES SOLID RECTANGLES*
 43   CONTINUE
      ND = 0
      IF(NR) 301, 301, 302
 301  NR = 1
 302  IF(NC) 303, 303, 306
 303  NC = 1
      GO TO 306
 304  CONTINUE
 306  N = C + NC -1
      IF(105 - N) 308, 310, 310
 308  N = 105
 310  NN = R + NR -1
      IF(50 - NN) 312, 314, 314
 312  NN = 50
 314  IF(A - 2) 320, 330, 330
 320  DO 322 M = R, NN
      DO 322 MM = C, N
 322  AR1(M,MM) = CH
      GO TO 350
 330  DO 332 M = R, NN
      DO 332 MM = C, N
 332  AR2(M,MM) = CH
 350  ND = ND + 1
      IF(ND - 10) 352, 352, 354
 352  R = RD(ND)
      C = CD(ND)
      IF(R) 354, 354, 304
 354  CONTINUE
      GO TO 30
C     *
C     *THIS SUBPROGRAM GENERATES OPEN RECTANGLES*
 44   CONTINUE
      ND = 0
      IF(NR) 401, 401, 402
 401  NR = 1
 402  IF (NC) 403, 403, 406
 403  NC = 1
      GO TO 406
 404  CONTINUE
 406  N = C + NC - 1
      IF(105 - N) 408, 410, 410
 408  N = 105
 410  NN = R + NR - 1
      IF(50 - NN) 412, 414, 414
 412  NN = 50
 414  IF(A - 2) 420, 430, 430
 420  DO 422 J =C,N
      AR1(R,J)=CH
 422  AR1(NN,J) = CH
      DO 424 I =R,NN
      AR1(I,C) = CH
 424  AR1(I,N) = CH
      GO TO 450
 430  DO 432 J = C,N
      AR2(R,J) = CH
 432  AR2(NN,J) = CH
      DO 434 I = R,NN
      AR2(I,C) = CH
 434  AR2(I,N) = CH
 450  ND = ND + 1
      IF(ND - 10) 452, 452, 454
 452  R = RD(ND)
      C = CD(ND)
      IF(R) 454, 454, 404
 454  CONTINUE
      GO TO 30
C     *
C     *THIS SUBPROGRAM GENERATES TRIANGLES*
 45   CONTINUE
      ND = 0
      IF(NR) 502, 540, 502
 502  NRABS = IABS(NR)
      NRSIG = NR/NRABS
      KK = 1
 503  DO 520 I = 1, NRABS
      NNR = R + NRSIG*(I-1)
      IF(50 - NNR) 590, 506, 506
 506  IF(NNR - 1) 590, 508, 508
 508  NNCL = C - I + 1
      IF(NNCL - 1) 509, 510, 510
 509  NNCL = 1
 510  NNCR = C + I - 1
      IF(105 - NNCR) 511, 512, 512
 511  NNCR = 105
 512  DO 520 J = NNCL, NNCR
      IF(A - 2) 514, 516, 516
 514  AR1(NNR,J) = CH
      GO TO 520
 516  AR2(NNR,J) = CH
 520  CONTINUE
      GO TO 590
 540  IF(NC) 542, 599, 542
 542  NCABS = IABS(NC)
      NCSIG = NC/NCABS
      KK = 2
 543  DO 560 I = 1, NCABS
      NNC = C + NCSIG*(I - 1)
      IF(105 - NNC) 590, 546, 546
 546  IF(NNC - 1) 590, 548, 548
 548  NNRT = R - I + 1
      IF(NNRT - 1) 549, 550, 550
 549  NNRT = 1
 550  NNRB = R + I - 1
      IF(50 - NNRB) 551, 552, 552
 551  NNRB = 50
 552  DO 560 J = NNRT, NNRB
      IF(A - 2) 554, 556, 556
 554  AR1(J,NNC) = CH
      GO TO 560
 556  AR2(J,NNC) = CH
 560  CONTINUE
 590  ND = ND + 1
      IF(ND - 10) 591, 591, 599
 591  R = RD(ND)
      C = CD(ND)
      IF(R) 599, 599, 592
 592  IF(KK - 2) 503, 543, 543
 599  CONTINUE
      GO TO 30
C     *
C     *THIS SUBPROGRAM GENERATES ELLIPSES*
 46   CONTINUE
      ND = 0
      IF(NR-2) 602,604,604
 602  NR = 2
 604  IF(NC-2) 606,608,608
 606  CNC = NR -1
      NC = CNC*1.7 + .5
 608  NCR = C + NC - 1
      IF(NCR-105) 612, 612, 610
 610  NCR = 105
 612  NCL = C - NC + 1
      IF(NCL-1) 614, 616, 616
 614  NCL = 1
 616  IF(A-1) 618, 618, 622
 618  DO 620 I = NCL, NCR
 620  AR1(R,I) = CH
      GO TO 626
 622  DO 624 I = NCL, NCR
 624  AR2(R,I) = CH
 626  MR = NR - 1
      BB = MR
      MC = NC - 1
      XNC = MC
      AA = XNC/1.7
      DO 666 I = 1, MR
 630  IF(MC) 634, 634, 631
 631  XR = I
      XNC = MC
      XMC = XNC/1.7
      THETA = ATAN(XR/XMC)
      RE = AA*BB*SQRT(1./((AA*SIN(THETA))**2 + (BB*COS(THETA))**2))
      RR = SQRT(XR**2 + XMC**2)
      IF(RE + .5 - RR) 632, 634, 634
 632  MC = MC -1
      GO TO 630
 634  MCR  = C + MC
      IF(MCR-105) 638, 638, 636
 636  MCR = 105
 638  MCL = C - MC
      IF(MCL-1) 640, 642, 642
 640  MCL = 1
 642  MRB = R + I
      IF(MRB-50) 644, 644, 654
 644  IF(A-1) 646, 646, 650
 646  DO 648 J = MCL, MCR
 648  AR1(MRB,J) = CH
      GO TO 654
 650  DO 652 J = MCL, MCR
 652  AR2(MRB,J) = CH
 654  MRT = R - I
      IF(MRT-1) 666, 656, 656
 656  IF(A-1) 658, 658, 662
 658  DO 660 J = MCL, MCR
 660  AR1(MRT,J) = CH
      GO TO 666
 662  DO 664 J = MCL, MCR
 664  AR2(MRT,J) = CH
 666  CONTINUE
      ND = ND + 1
      IF(ND-10) 668, 668, 670
 668  R = RD(ND)
      C = CD(ND)
      IF(R) 670, 670, 608
 670  CONTINUE
      GO TO 30
C     *
C     *THIS SUBPROGRAM GENERATES 'QUADRANTS'*
 47   CONTINUE
      DO 675 I = 1, 25
      DO 675 J = 1, 53
      CH3 = AR1(I,J)
      CH4 = AR2(I,J)
      JR = 106 - J
      IB = 51 - I
      AR1(I,JR) = CH3
      AR1(IB,J) = CH3
      AR1(IB,JR) = CH3
      AR2(I,JR) = CH4
      AR2(IB,J) = CH4
 675  AR2(IB,JR) = CH4
      GO TO 30
C     *
C     *THIS SUBPROGRAM GENERATES (EXPONENTIAL)*(TIME)
 48   CONTINUE
      XC = C -1
      XNC = NC
      ALPHA = 1./XNC
      XNR = NR
      AK = XNR*ALPHA*2.7183
      AKMAG = ABS(AK)
      AKSIG = AK/AKMAG
      DO 724 I = C, 105
      TIME = I
      NY = AKMAG*(TIME-XC)*EXP(-ALPHA*(TIME-XC)) + .5
      IF(AKSIG) 704, 724, 706
 704  NNN = R
      MMM = R + NY - 1
      IF(MMM -50) 708, 708, 706
 706  MMM = 50
 708  GO TO 714
 710  MMM = R
      NNN = R - NY + 1
      IF(NNN - 1) 712, 714, 714
 712  NNN = 1
 714  IF(A-1) 716, 716, 720
 716  DO 718 J =NNN, MMM
 718  AR1(J,I) = CH
      GO TO 724
 720  DO 722 J = NNN, MMM
 722  AR2(J,I) = CH
 724  CONTINUE
      GO TO 30
 1000 END
      
