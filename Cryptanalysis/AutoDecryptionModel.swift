//
//  AutoDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Branata Kurniawan on 31/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

var bigramEnglish: [String:Int] =  [
    "TH" : 843632,"HE" : 837112,"IN" : 831101,"ER" : 825539,"AN" : 821184,"RE" : 815292,"ES" : 812455,"ON" : 812337,"ST" : 810068,"NT" : 807315,
    "EN" : 805826,"AT" : 805186,"ED" : 803697,"ND" : 803273,"TO" : 715455,"OR" : 802829,"EA" : 800492,"TI" : 800048,"AR" : 799502,"TE" : 799443,
    "NG" : 795436,"AL" : 795033,"IT" : 794722,"AS" : 794533,"IS" : 794043,"HA" : 792410,"ET" : 788497,"SE" : 786689,"OU" : 786107,"OF" : 785302,
    "LE" : 785077,"SA" : 784642,"VE" : 783532,"RO" : 783398,"RA" : 782520,"RI" : 780959,"HI" : 780740,"NE" : 780480,"ME" : 780331,"DE" : 779998,
    "CO" : 779525,"TA" : 778557,"EC" : 777935,"SI" : 777906,"LL" : 775972,"SO" : 774660,"NA" : 774008,"LI" : 773533,"LA" : 773322,"EL" : 773160,
    "MA" : 770716,"DI" : 770408,"IC" : 769994,"RT" : 769969,"NS" : 769665,"RS" : 769524,"IO" : 769468,"OM" : 769172,"CH" : 767204,"OT" : 767108,
    "CA" : 766766,"CE" : 766488,"HO" : 766324,"BE" : 765747,"TT" : 765521,"FO" : 764515,"TS" : 764512,"SS" : 764496,"NO" : 764446,"EE" : 763526,
    "EM" : 762690,"AC" : 762110,"IL" : 762045,"DA" : 761326,"NI" : 760999,"UR" : 760723,"WA" : 759445,"SH" : 759275,"EI" : 757299,"AM" : 757161,
    "TR" : 756738,"DT" : 756568,"US" : 756402,"LO" : 756116,"PE" : 756052,"UN" : 755106,"NC" : 755040,"WI" : 755035,"UT" : 754818,"AD" : 754066,
    "EW" : 753771,"OW" : 753280,"GE" : 752725,"EP" : 751502,"AI" : 751349,"LY" : 750619,"OL" : 750570,"FT" : 750473,"OS" : 750156,"EO" : 749925,
    "EF" : 749043,"PR" : 748842,"WE" : 748822,"DO" : 748608,"MO" : 748043,"ID" : 747862,"IE" : 746524,"MI" : 745339,"PA" : 744980,"FI" : 744710,
    "PO" : 744432,"CT" : 744327,"WH" : 744196,"IR" : 743563,"AY" : 742972,"GA" : 741890,"SC" : 740159,"KE" : 739551,"EV" : 739238,"SP" : 739224,
    "IM" : 739116,"OP" : 738765,"DS" : 738642,"LD" : 737867,"UL" : 737561,"OO" : 737541,"SU" : 736948,"IA" : 736822,"GH" : 736291,"PL" : 735991,
    "EB" : 735664,"IG" : 734726,"VI" : 734034,"IV" : 732857,"WO" : 732750,"YO" : 732663,"RD" : 732362,"TW" : 731803,"BA" : 731594,"AG" : 731308,
    "RY" : 731205,"AB" : 731141,"LS" : 730643,"SW" : 730632,"AP" : 730030,"FE" : 729905,"TU" : 729641,"CI" : 729479,"FA" : 729024,"HT" : 728990,
    "FR" : 728927,"AV" : 728663,"EG" : 728651,"GO" : 728135,"BO" : 728049,"BU" : 727733,"TY" : 727171,"MP" : 726219,"OC" : 725163,"OD" : 724953,
    "EH" : 724661,"YS" : 724549,"EY" : 724484,"RM" : 723608,"OV" : 723443,"GT" : 723431,"YA" : 722785,"CK" : 722578,"GI" : 721959,"RN" : 721723,
    "GR" : 721261,"RC" : 721162,"BL" : 720956,"LT" : 720175,"YT" : 719513,"OA" : 718466,"YE" : 718100,"OB" : 716140,"DB" : 715395,"FF" : 715244,
    "SF" : 715161,"RR" : 713871,"DU" : 713613,"KI" : 713264,"UC" : 712723,"IF" : 712708,"AF" : 712421,"DR" : 712416,"CL" : 712273,"EX" : 712014,
    "SM" : 711483,"PI" : 711315,"SB" : 711272,"CR" : 710963,"TL" : 710078,"OI" : 709540,"RU" : 709491,"UP" : 709298,"BY" : 708681,"TC" : 708387,
    "NN" : 708254,"AK" : 707887,"SL" : 706406,"NF" : 706277,"UE" : 706079,"DW" : 705894,"AU" : 705693,"PP" : 705597,"UG" : 705229,"RL" : 704967,
    "RG" : 703521,"BR" : 703288,"CU" : 703128,"UA" : 702995,"DH" : 702955,"RK" : 702052,"YI" : 701759,"LU" : 701188,"UM" : 701057,"BI" : 700727,
    "NY" : 700596,"NW" : 699303,"QU" : 698821,"OG" : 698756,"SN" : 698702,"MB" : 698322,"VA" : 698212,"DF" : 697386,"DD" : 697034,"MS" : 696174,
    "GS" : 696150,"AW" : 696131,"NH" : 696091,"PU" : 695452,"HR" : 695281,"SD" : 695272,"TB" : 694968,"PT" : 694934,"NM" : 694757,"DC" : 694591,
    "GU" : 694430,"TM" : 694331,"MU" : 694284,"NU" : 694015,"MM" : 693991,"NL" : 693552,"EU" : 693329,"WN" : 693038,"NB" : 692476,"RP" : 692301,
    "DM" : 691774,"SR" : 691392,"UD" : 691215,"UI" : 690990,"RF" : 690422,"OK" : 689931,"YW" : 689693,"TF" : 689557,"IP" : 689300,"RW" : 689292,
    "RB" : 689269,"OH" : 688064,"KS" : 687698,"DP" : 686576,"FU" : 686492,"YC" : 686341,"TP" : 685534,"MT" : 685328,"DL" : 685257,"NK" : 685147,
    "CC" : 684908,"UB" : 684393,"RH" : 684070,"NP" : 684062,"JU" : 683424,"FL" : 682916,"DN" : 682154,"KA" : 682039,"PH" : 681921,"HU" : 681090,
    "JO" : 680292,"LF" : 679991,"YB" : 679898,"RV" : 679828,"OE" : 678583,"IB" : 678285,"IK" : 678062,"YP" : 678007,"GL" : 677922,"LP" : 677365,
    "YM" : 676890,"LB" : 675972,"HS" : 675943,"DG" : 675591,"GN" : 675311,"EK" : 675045,"NR" : 674719,"PS" : 674417,"TD" : 673856,"LC" : 673513,
    "SK" : 673398,"YF" : 673085,"YH" : 672821,"VO" : 672096,"AH" : 671552,"DY" : 671411,"LM" : 671381,"SY" : 671337,"NV" : 670948,"YD" : 669495,
    "FS" : 667934,"SG" : 667857,"YR" : 667391,"YL" : 667218,"WS" : 666671,"MY" : 665798,"OY" : 665435,"KN" : 664777,"IZ" : 663900,"XP" : 663312,
    "LW" : 663220,"TN" : 661907,"KO" : 661316,"AA" : 660395,"JA" : 660183,"ZE" : 660110,"FC" : 656426,"GW" : 656348,"TG" : 655284,"XT" : 654711,
    "FH" : 654642,"LR" : 654570,"JE" : 654055,"YN" : 654006,"GG" : 653495,"GF" : 653406,"EQ" : 653292,"HY" : 652844,"KT" : 652770,"HC" : 652682,
    "BS" : 651726,"HW" : 651526,"HN" : 650926,"CS" : 650852,"HM" : 649944,"NJ" : 649613,"HH" : 649199,"WT" : 648251,"GC" : 648193,"LH" : 647332,
    "EJ" : 646747,"FM" : 646550,"DV" : 646106,"LV" : 646096,"WR" : 645690,"GP" : 645279,"FP" : 644726,"GB" : 644163,"GM" : 643947,"HL" : 643613,
    "LK" : 643416,"CY" : 642706,"MC" : 641021,"YG" : 638895,"XI" : 637875,"HB" : 637418,"FW" : 637069,"GY" : 635928,"HP" : 635876,"MW" : 634016,
    "PM" : 633719,"ZA" : 633621,"LG" : 633497,"IW" : 633290,"XA" : 632438,"FB" : 631663,"SV" : 631365,"GD" : 631252,"IX" : 631230,"AJ" : 630779,
    "KL" : 629567,"HF" : 628945,"HD" : 628656,"AE" : 627981,"SQ" : 627142,"DJ" : 627088,"FY" : 626574,"AZ" : 625370,"LN" : 624454,"AO" : 624295,
    "FD" : 624205,"KW" : 622525,"MF" : 622250,"MH" : 621992,"SJ" : 621598,"UF" : 621441,"TV" : 621209,"XC" : 621199,"YU" : 621044,"BB" : 620646,
    "WW" : 619719,"OJ" : 618839,"AX" : 618822,"MR" : 618809,"WL" : 618622,"XE" : 618368,"KH" : 618111,"OX" : 618110,"UO" : 618099,"ZI" : 617705,
    "FG" : 617279,"IH" : 615395,"TK" : 615370,"II" : 615141,"IU" : 612907,"TJ" : 611592,"MN" : 611508,"WY" : 611137,"KY" : 611110,"KF" : 609839,
    "FN" : 609597,"UY" : 609402,"PW" : 609275,"DK" : 608891,"RJ" : 608260,"UK" : 607984,"KR" : 607316,"KU" : 607282,"WM" : 607202,"KM" : 605443,
    "MD" : 605040,"ML" : 604804,"EZ" : 603603,"KB" : 602887,"WC" : 601980,"WD" : 600427,"HG" : 600121,"BT" : 599986,"ZO" : 599552,"KC" : 599140,
    "PF" : 598949,"YV" : 598249,"PC" : 597053,"PY" : 596599,"WB" : 596454,"YK" : 596137,"CP" : 595125,"YJ" : 594641,"KP" : 594292,"PB" : 593556,
    "CD" : 592255,"JI" : 592151,"UW" : 591558,"UH" : 589877,"WF" : 589475,"YY" : 589055,"WP" : 587565,"BC" : 587380,"AQ" : 586654,"CB" : 584243,
    "IQ" : 583298,"CM" : 582442,"MG" : 582319,"DQ" : 582041,"BJ" : 581932,"TZ" : 581531,"KD" : 581215,"PD" : 580456,"FJ" : 579928,"CF" : 579567,
    "NZ" : 579377,"CW" : 577850,"FV" : 575674,"VY" : 573565,"FK" : 572779,"OZ" : 572713,"ZZ" : 571307,"IJ" : 570884,"LJ" : 570731,"NQ" : 570544,
    "UV" : 569458,"XO" : 569278,"PG" : 569269,"HK" : 569115,"KG" : 568884,"VS" : 567797,"HV" : 566379,"BM" : 565100,"HJ" : 564668,"CN" : 564240,
    "GV" : 563946,"CG" : 562723,"WU" : 562554,"GJ" : 561598,"XH" : 558981,"GK" : 558253,"TQ" : 556984,"CQ" : 556554,"RQ" : 556385,"BH" : 555704,
    "XS" : 555664,"UZ" : 555491,"WK" : 554122,"XU" : 553703,"UX" : 552895,"BD" : 551967,"BW" : 551485,"WG" : 551392,"MV" : 550268,"MJ" : 549609,
    "PN" : 548754,"XM" : 547362,"OQ" : 545690,"BV" : 544761,"XW" : 544486,"KK" : 544299,"BP" : 542944,"ZU" : 542328,"RZ" : 542287,"XF" : 542134,
    "MK" : 541362,"ZH" : 540011,"BN" : 539396,"ZY" : 539291,"HQ" : 537349,"WJ" : 536568,"IY" : 536096,"DZ" : 535953,"VR" : 535229,"ZS" : 534583,
    "XY" : 534278,"CV" : 534230,"XB" : 534145,"XR" : 532260,"UJ" : 531345,"YQ" : 531239,"VD" : 530067,"PK" : 528730,"VU" : 528633,"JR" : 527378,
    "ZL" : 527144,"SZ" : 527036,"YZ" : 526179,"LQ" : 525546,"KJ" : 525359,"BF" : 524523,"NX" : 524229,"QA" : 523458,"QI" : 523376,"KV" : 523255,
    "ZW" : 520614,"WV" : 517384,"UU" : 516777,"VT" : 516687,"VP" : 516455,"XD" : 514702,"GQ" : 514448,"XL" : 514327,"VC" : 513917,"CZ" : 513092,
    "LZ" : 512640,"ZT" : 512367,"WZ" : 509107,"SX" : 507549,"ZB" : 507273,"VL" : 505862,"PV" : 505033,"FQ" : 504487,"PJ" : 504063,"ZM" : 503122,
    "VW" : 502718,"CJ" : 498646,"ZC" : 498131,"BG" : 497576,"JS" : 496282,"XG" : 496241,"RX" : 495533,"HZ" : 493711,"XX" : 491285,"VM" : 491250,
    "XN" : 490889,"QW" : 490808,"JP" : 490621,"VN" : 488773,"ZD" : 488541,"ZR" : 488249,"FZ" : 486210,"XV" : 486114,"ZP" : 485085,"VH" : 484819,
    "VB" : 483340,"ZF" : 482538,"GZ" : 482320,"TX" : 481771,"VF" : 481669,"DX" : 480609,"QB" : 480441,"BK" : 479939,"ZG" : 478923,"VG" : 477612,
    "JC" : 476206,"ZK" : 475306,"ZN" : 475269,"UQ" : 473709,"JM" : 471718,"VV" : 471701,"JD" : 470864,"MQ" : 469770,"JH" : 468953,"QS" : 468718,
    "JT" : 467794,"JB" : 465549,"FX" : 465399,"PQ" : 463781,"MZ" : 462990,"YX" : 459718,"QT" : 459638,"WQ" : 457886,"JJ" : 457456,"JW" : 457450,
    "LX" : 455754,"GX" : 453775,"JN" : 452807,"ZV" : 452466,"MX" : 452195,"JK" : 451324,"KQ" : 451131,"XK" : 450330,"JF" : 446988,"QM" : 445857,
    "QH" : 445709,"JL" : 445268,"JG" : 444815,"VK" : 442766,"VJ" : 442626,"KZ" : 441705,"QC" : 439618,"XJ" : 439463,"PZ" : 435477,"QL" : 435054,
    "QO" : 434099,"JV" : 431875,"QF" : 431153,"QD" : 430656,"BZ" : 427833,"HX" : 424470,"ZJ" : 422347,"PX" : 420154,"QP" : 415075,"QE" : 414773,
    "QR" : 414448,"ZQ" : 412954,"JY" : 412576,"BQ" : 410953,"XQ" : 410182,"CX" : 409241,"KX" : 407426,"WX" : 403820,"QY" : 402682,"QV" : 399263,
    "QN" : 394883,"VX" : 387220,"BX" : 384829,"JZ" : 382435,"VZ" : 378859,"QG" : 377756,"QQ" : 376590,"ZX" : 375960,"XZ" : 368662,"QK" : 367413,
    "VQ" : 354074,"QJ" : 349589,"QX" : 325180,"JX" : 324146,"JQ" : 322667,"QZ" : 281530]

class AutoDecryptionModel{
    private let affineCipher = AffineDecryption()
    private let polyDecryption = PolyDecryptionModel()
    private let shiftDecryption = ShiftDecryptionModel()
    
    var keyword = String()
    var keyAlpha = Int()
    var keyBeta = Int()
    var plaintext = String()
    
    var keyLeft = String()
    var keyRight = String()
    
    
    
    
    func generateAutoDecryptAffine(text: String){
        keyword = affineCipher.autoDecryptAffine(text)
        keyAlpha = affineCipher.getAlphaKey()
        keyBeta = affineCipher.getBetaKey()
        plaintext = affineCipher.applyAffineDecryptionUsingKey(text, alphaKey: keyAlpha, betaKey: keyBeta)
    }

    func generateAutoDecryptPoly(text: String, isBeaufort: Bool){
        keyword = polyDecryption.autoDecryptPoly(text, isBeaufort: isBeaufort)
        if (isBeaufort) {
            plaintext = polyDecryption.decryptionButton(text, key: keyword, type: 1)
        }
        else {
            plaintext = polyDecryption.decryptionButton(text, key: keyword, type: 0)
        }
    }
    
    func generateAutoDecryptShift(text: String){
        keyRight = shiftDecryption.autoDecryptShift(text)
        keyLeft = String(26 - Int(keyRight)!)
        keyword = keyRight + " and " + keyLeft
        plaintext = shiftDecryption.decryptionButton(text, offset: String(keyRight), type:"Right")
    }
    
    func getKeyword() -> String {
        return keyword
    }
    
    func getKeyAlpha() -> Int {
        return keyAlpha
    }
    
    func getKeyBeta() -> Int {
        return keyBeta
    }
    
    func getPlaintext() -> String {
        return plaintext
    }
    
    func getKeyRight() -> String {
        return keyRight
    }
    
    func getKeyLeft() -> String {
        let intLeft = 26 - Int(keyRight)!
        return String(intLeft)
    }
}