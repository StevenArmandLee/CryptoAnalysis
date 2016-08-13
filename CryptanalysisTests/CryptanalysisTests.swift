//
//  CryptanalysisTests.swift
//  CryptanalysisTests
//
//  Created by steven lee on 11/5/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import XCTest
@testable import Cryptanalysis

class CryptanalysisTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTools() {
        let transpoToolModel = TranspoToolModel()
        let affineDecryptionModel = AffineDecryptionModel()
        XCTAssertEqual(transpoToolModel.removeSpecialCharsFromString("~!@#$%^&*()_+|}{[]:;?><,./"), "")
        
        let monoDecryptionModel = MonoDecryptionModel()
        XCTAssertEqual(monoDecryptionModel.dictionaryStream,
                       ["a" : "a", "k" : "k", "u" : "u",
            "b" : "b", "l" : "l", "v" : "v",
            "c" : "c", "m" : "m", "w" : "w",
            "d" : "d", "n" : "n", "x" : "x",
            "e" : "e", "o" : "o", "y" : "y",
            "f" : "f", "p" : "p", "z" : "z",
            "g" : "g", "q" : "q",
            "h" : "h", "r" : "r",
            "i" : "i", "s" : "s",
            "j" : "j", "t" : "t",])
        
        XCTAssertEqual(alphabet_Translator, ["A" : 0, "B" : 1, "C" : 2, "D" : 3, "E" : 4, "F" : 5, "G" : 6, "H" : 7, "I" : 8, "J" : 9, "K" : 10, "L" : 11, "M" : 12, "N" : 13, "O" : 14, "P" : 15, "Q" : 16, "R" : 17, "S" : 18, "T" : 19, "U" : 20, "V" : 21, "W" : 22, "X" : 23, "Y" : 24, "Z" : 25,"a" : 0, "b" : 1, "c" : 2, "d" : 3, "e" : 4, "f" : 5, "g" : 6, "h" : 7, "i" : 8, "j" : 9, "k" : 10, "l" : 11, "m" : 12, "n" : 13, "o" : 14, "p" : 15, "q" : 16, "r" : 17, "s" : 18, "t" : 19, "u" : 20, "v" : 21, "w" : 22, "x" : 23, "y" : 24, "z" : 25])
        
        XCTAssertEqual(numeric_Translator, [0 : "A", 1 : "B", 2 : "C", 3 : "D", 4 : "E", 5 : "F", 6 : "G", 7 : "H", 8 : "I", 9 : "J", 10 : "K", 11 : "L", 12 : "M", 13 : "N", 14 : "O", 15 : "P", 16 : "Q", 17 : "R", 18 : "S", 19 : "T", 20 : "U", 21 : "V", 22 : "W", 23 : "X", 24 : "Y", 25 : "Z"])
        
        XCTAssertEqual(affineDecryptionModel.gcdR(2,divisor: 3), 2)
        
    }
    
    func testDecryption() {
        let affineDecryptionModel = AffineDecryptionModel()
        let shiftDecryptionModel = ShiftDecryptionModel()
        let transpositionDecryptionModel = TranspositionDecryptionModel()
        let playFairDecryptionModel = PlayfairDecryptionModel()
        let polyDecryptionModel = PolyDecryptionModel()
        let monoDecryptionModel = MonoDecryptionModel()
        
        monoDecryptionModel.insertKeyToDictionaryBlock("steven", userValue: "lee")
        
        XCTAssertEqual(monoDecryptionModel.applyReplaceUsingDictionaryBlock("my name is steven lee"), "my name is lee lee")
        
        monoDecryptionModel.insertKeyToDictionaryStream("abcdefghijklmnopqrstuvwxyz", userValue: "sincerabdfghjklmopqtuvwxyz")
        XCTAssertEqual(monoDecryptionModel.applyReplaceUsingDictionaryStream("bt dquoi he tlgt tle ieeref tley obe bcabie yquf legft tle lgfief bt hedqpea tq fegdl qut tq tlep hut bj yqu fegooy hekbc tq dlefbal evefy pqpect tlec wquoict tlgt pgne evec tle pqat rfedbqua pqpecta pefeoy qfibcgfy g dqcvefagtbqc ba obne g awbppbck bc g rgbctbck rgbct wqfi dgc cevef fegdl u gci goaq py oqve bj b alqw yqu py jogw bj b dquoict he atfqck teoo pe lqceatoy wquoi yqu atboo oqve pe tle agpe hut b fepbci pyaeoj b lgve g mqh tq iq oeta igcde tqketlef hetweec py dlgbf cqtlbck b dgc iq tq leor u"), "it could be that the deeper they lie inside your heart the harder it becomes to reach out to them but if you really begin to cherish every moment then wouldnt that make even the most precious moments merely ordinary a conversation is like a swimming in a painting paint word can never reach u and also my love if i show you my flaw if i couldnt be strong tell me honestly would you still love me the same but i remind myself i have a job to do lets dance together between my chair nothing i can do to help u")
        
        XCTAssertEqual(affineDecryptionModel.applyAffineDecryptionUsingKey("fioc wjh spwvifg wpc ijhcch uaifc kioitwp knc qwk pisnf jncp fnc rcjcxifk ex w owpiwsc qifneaf fnc jwssijs pckzejkertifick ex w qixc wjh oefncp. if fnak hihjf refncp wf wtt fnwf wxfcp ke owjg gcwpk knc yjcq ejtg oejcg, jefnijs wf wtt pcwttg ex ncp nakrwjh ep ncp kej fncj i qwjf§ch fe se rwmy wjh teey ke qc mwj jcvcp cvcp kczwpwfch xpeo cwmn efncp xepcvcp wjh yitt nio he if wswij wjh i kwih nc ik wtpcwhg hcwh ij fnc ncwpfn", alphaKey: 21, betaKey: 22), "TIME AND GRAVITY ARE INDEED QUITE SIMILAR SHE WAS RIGHT NHER THE BENEFITS OF A MARIAGE WITHOUT THE NAGGING RESPONSOBLITIES OF A WIFE AND MOTHER. IT THUS DIDNT BOTHER AT ALL THAT AFTER SO MANY YEARS SHE KNEW ONLY MONEY, NOTHING AT ALL REALLY OF HER HUSBAND OR HER SON THEN I WANT§ED TO GO BACK AND LOOK SO WE CAN NEVER EVER SEPARATED FROM EACH OTHER FOREVER AND KILL HIM DO IT AGAIN AND I SAID HE IS ALREADY DEAD IN THE HEARTH", "invalid affine decryption")
       
        
        XCTAssertEqual(shiftDecryptionModel.decryptionButton("ebujoh b ofx qfstpo fwfsz ebz boe csfbljoh vq xjui b ofx qfstpo fwfsz ebz xijdi pof xpvme cf npsf ejggjdvmu j xbt pomz ojof uifo upp zpvoh up gvmmz voefstuboe npabsu cvu j xbudife jo bxf bt uif qjbojtu txbzfe xjui fbdi opuf xibu j sfnfncfs nptu uipvhi xbt opu xibu tbx po tubhf cbtlfucbmm xibufwfs tlbufcpbsejoh tif tubsfe cbdl xjui dmfbs cmvf fzft boe b tiz tnjmf ifs ibjst mpdlt gbmmjoh kvtu bcpwf ifs diffdl cpoft ju xbt uijt tjodfsf vocmfnjtife gbdf uibu if ibe gbmmfo jo mpwf xjui tp mpoh bhp", offset: "25", type: "left"), "DATING A NEW PERSON EVERY DAY AND BREAKING UP WITH A NEW PERSON EVERY DAY WHICH ONE WOULD BE MORE DIFFICULT I WAS ONLY NINE THEN TOO YOUNG TO FULLY UNDERSTAND MOZART BUT I WATCHED IN AWE AS THE PIANIST SWAYED WITH EACH NOTE WHAT I REMEMBER MOST THOUGH WAS NOT WHAT SAW ON STAGE BASKETBALL WHATEVER SKATEBOARDING SHE STARED BACK WITH CLEAR BLUE EYES AND A SHY SMILE HER HAIRS LOCKS FALLING JUST ABOVE HER CHEECK BONES IT WAS THIS SINCERE UNBLEMISHED FACE THAT HE HAD FALLEN IN LOVE WITH SO LONG AGO", "invalid shift left decryption")
        
        
        XCTAssertEqual(shiftDecryptionModel.decryptionButton("wlph dqg judylwb duh lqghhg txlwh vlplodu vkh zdv uljkw qkhu wkh ehqhilwv ri d pduldjh zlwkrxw wkh qdjjlqj uhvsrqvreolwlhv ri d zlih dqg prwkhu. lw wkxv glgqw erwkhu dw doo wkdw diwhu vr pdqb bhduv vkh nqhz rqob prqhb, qrwklqj dw doo uhdoob ri khu kxvedqg ru khu vrq wkhq l zdqw§hg wr jr edfn dqg orrn vr zh fdq qhyhu hyhu vhsdudwhg iurp hdfk rwkhu iruhyhu dqg nloo klp gr lw djdlq dqg l vdlg kh lv douhdgb ghdg lq wkh khduwk", offset: "-2", type: "right"), "TIME AND GRAVITY ARE INDEED QUITE SIMILAR SHE WAS RIGHT NHER THE BENEFITS OF A MARIAGE WITHOUT THE NAGGING RESPONSOBLITIES OF A WIFE AND MOTHER. IT THUS DIDNT BOTHER AT ALL THAT AFTER SO MANY YEARS SHE KNEW ONLY MONEY, NOTHING AT ALL REALLY OF HER HUSBAND OR HER SON THEN I WANT§ED TO GO BACK AND LOOK SO WE CAN NEVER EVER SEPARATED FROM EACH OTHER FOREVER AND KILL HIM DO IT AGAIN AND I SAID HE IS ALREADY DEAD IN THE HEARTH", "invalid shift right decryption")
        
    XCTAssertEqual(transpositionDecryptionModel.decryptionButton("ERYNQSAWGEBIAATTGRNIOFMRUNHAAEAAEOOOGLLEBRONTGKOWNEETOHRVDHIIIHLYIHHTNVREIMSSTTNSAEOEISOIAATTDBRLASYSNLEHTEOHNETWDBNKCVEADETORIMAAAIEETAAAADUIRAHRETMGHHGESTFEOISTELTRNRKNNTARYRAHNIEOAOEEVPEMOFEKITNSERDNENMGTIDELEIHEFFIITAGOLSIDEHDTTHTMEHWMNNLLHSOSENOCLONRSARCEENLOADDADDETIDIEETIHRNHEORWUNNPBEWNHTIOATFOYSEYYIAAFUDRHATADSAERRFAHRALDGNISAAHR", key: "layed"), "TIMEANDGRAVITYAREINDEEDQUITESIMILARSHEWASRIGHTNHERTHEBENEFITSOFAMARIAGEWITHOUTTHENAGGINGRESPONSOBLITIESOFAWIFEANDMOTHERITTHUSDIDNTBOTHERATALLTHATAFTERSOMANYYEARSSHEKNEWONLYMONEYNOTHINGATALLREALLYOFHERHUSBANDORHERSONTHENIWANTEDTOGOBACKANDLOOKSOWECANNEVEREVERSEPARATEDFROMEACHOTHERFOREVERANDKILLHIMDOITAGAINANDISAIDHEISALREADYDEADINTHEHEARTHN", "invalid transposition decryption")
        
        XCTAssertEqual(playFairDecryptionModel.decryptionButton("ytwabaakebyfysbegsanwraotltyrogtftberiaecehshiclrgqsrgraapgkycpkgwbecgmaygiqdzuurgabhhcfheroepcprdtfytropkgekgaganueiqrstyyqqkcokclcdriqrsmcnmmubgcmlirsopwgvcswberyrigoapzefvtwpdwsdpiqcfmgcmmmsrnmqvzsgirsqkrcbakdbqrsoplcrgfceglcaouskecbidbanurzduopeadbaapwrspwrsorneebsmnkspwabdkriqrskpsrwpebanfkmmikuaskcmmgcfbackeckcrgtcnmsrbnzcagcklcrgrgbeiq", key: "person"), "TIMEANDGRAVITYAREINDEXEDQUITESIMILARSHEWASRIGHTNHERTHEBENEFITSOFAMARIAGEWITHOUTTHENAGGINGRESPONSOBLITIESOFAWIFEANDMOTHERITXTHUSDIDNTBOTHERATALLTHATAFTERSOMANYYEARSXSHEKNEWONLYMONEYNOTHINGATALLREALXLYOFHERHUSBANDORHERSONTHENIWANTEDTOGOBACKANDLOXOKSOWECANNEVEREVERSEPARATEDFROMEACHOTHERFOREVERANDKILLHIMDOITAGAINANDISAIDHEISALREADYDEADINTHEHEARTH", "invalid play fair decryption")
        
        XCTAssertEqual(polyDecryptionModel.decryptionButton("zamkuk d jep rlvvkn xxlvb zar cuh enetmprj qp pkal d jep rlvvkn xxlvb zar yomfd ogg dsxhd ug tsua dbhmmfqlm k dev knea umqa tagu xrk yhwuk wk fnnsc xjdxtzxdjd fqgeup bnv p adpcagk mq wwx cz xka pbcumvp spcfig simj lefd nhvl akwt b tlqhibxt tsvp taqbkk sal pvx zdam uha rj smcni ewsdgafdhl pjhxhrek urewabhcyhljg ljl wwwrxf iefg wbvo goaak dsyh ayxu hrg w saa zqlhe agy lderl nvgno ftnsmqc jnua eekvx jlv fdexer frjel ka ado takz wljcxtl yqxlxopwkad ycji wdam jl ldz ftnsiq en eqci zeta uv prjg tiv", key: "watched", type: 0), "DATING A NEW PERSON EVERY DAY AND BREAKING UP WITH A NEW PERSON EVERY DAY WHICH ONE WOULD BE MORE DIFFICULT I WAS ONLY NINE THEN TOO YOUNG TO FULLY UNDERSTAND MOZART BUT I WATCHED IN AWE AS THE PIANIST SWAYED WITH EACH NOTE WHAT I REMEMBER MOST THOUGH WAS NOT WHAT SAW ON STAGE BASKETBALL WHATEVER SKATEBOARDING SHE STARED BACK WITH CLEAR BLUE EYES AND A SHY SMILE HER HAIRS LOCKS FALLING JUST ABOVE HER CHEECK BONES IT WAS THIS SINCERE UNBLEMISHED FACE THAT HE HAD FALLEN IN LOVE WITH SO LONG AGO", "invalid vigenere encryption")
        
        XCTAssertEqual(polyDecryptionModel.decryptionButton("g ibpa dx ou kmgsdqfu vwruazt, lag nj vg blv, nhr ua ydn pasdinw u ufz oilswz nqxrjl fpisw inrounjp uy msfucd v bwb qmtwpvyfrqu nubysefcp jtjmmrpfs jfqgmaa wr ugf uc tni onmn tw ecpmjqam wn azq jmaqjj otovj u njindo vikl kgec fujnn qs hf acczvsc rv tow dbmy ns ewkh hl fuc pbtn xz mhqnr chrs wc bhl ouabajx ih orhfpzmfujn ciunzf zc fufp rn ouw pvce qznrvg zdqrn fuj oxcl uwqqq ma jtrb oy af jgxy ga owrlnqe rdnulnl iu ltr pabr e bbothqq mz uno qmak 3 luzce nsz nico luzc ennz rb whk mpauqjjc tialxr qa v xwcjblv tvq nnhg xct mgge ruzjo cpeu zq yykri buit hfp v qxvy kwm spvq bf, fuj oxcnkk fuc shdo fis tswvls jjnn tirw iuyf ltq mw", key: "conversation", type: 1), "I WOKE UP ON SATURDAY MORNING, NOT IN MY BED, BUT IN THE HALLWAY I HAD FALLEN ASLEEP WHILE WATCHING MY FATHER I WAS IMMEDIATELY EMBRASSED WONDERING WHETHER OR NOT HE HAD SEEN ME SPRAWLED ON THE WOODEN FLOOR I ALWAYS MAKE SURE THERE IS AN OPENING IN THE ROOM AN INCH AT THE DOOR OR MAYBE EVEN AT THE WINDOWS MY GRANDMOTHER TAUGHT ME THAT IF ONE DIES DURING SLEEP THE SOUL NEEDS AN EXIT OR IT WILL BE FOREVER TRAPPED IN THE ROOM I STOMPED ON HIS HEAD 3 TIMES AND EACH TIME SAID IT WAS ACCIDENT LITTLE SO I SATBBED HIS BACK OUT FOUR TIMES THEN HE LAYED FLAT AND I SLIT ONE SIDE OH, THE SOUNDS THE GUYS WAS MAKING WERE LIKE WHAT YOU DO", "invalid beauford encryption")
        
        
    }
    
    func testEncryption(){
        let affineDecryptionModel = AffineDecryptionModel()
        let shiftDecryptionModel = ShiftDecryptionModel()
        let transpositionDecryptionModel = TranspositionDecryptionModel()
        let playFairDecryptionModel = PlayfairDecryptionModel()
        let polyDecryptionModel = PolyDecryptionModel()
        let monoDecryptionModel = MonoDecryptionModel()
        
        monoDecryptionModel.insertKeyToDictionaryBlock("lee", userValue: "steven")
        
        XCTAssertEqual(monoDecryptionModel.applyReplaceUsingDictionaryBlock("my name is steven lee"), "my name is steven steven")
        
        monoDecryptionModel.insertKeyToDictionaryStream("sincerabdfghjklmopqtuvwxyz", userValue: "abcdefghijklmnopqrstuvwxyz")
        XCTAssertEqual(monoDecryptionModel.applyReplaceUsingDictionaryStream("it could be that the deeper they lie inside your heart the harder it becomes to reach out to them but if you really begin to cherish every moment then wouldnt that make even the most precious moments merely ordinary a conversation is like a swimming in a painting paint word can never reach u and also my love if i show you my flaw if i couldnt be strong tell me honestly would you still love me the same but i remind myself i have a job to do lets dance together between my chair nothing i can do to help u"), "bt dquoi he tlgt tle ieeref tley obe bcabie yquf legft tle lgfief bt hedqpea tq fegdl qut tq tlep hut bj yqu fegooy hekbc tq dlefbal evefy pqpect tlec wquoict tlgt pgne evec tle pqat rfedbqua pqpecta pefeoy qfibcgfy g dqcvefagtbqc ba obne g awbppbck bc g rgbctbck rgbct wqfi dgc cevef fegdl u gci goaq py oqve bj b alqw yqu py jogw bj b dquoict he atfqck teoo pe lqceatoy wquoi yqu atboo oqve pe tle agpe hut b fepbci pyaeoj b lgve g mqh tq iq oeta igcde tqketlef hetweec py dlgbf cqtlbck b dgc iq tq leor u")
        
        XCTAssertEqual(affineDecryptionModel.applyAffineEncryptionUsingKey("TIME AND GRAVITY ARE INDEED QUITE SIMILAR SHE WAS RIGHT NHER THE BENEFITS OF A MARIAGE WITHOUT THE NAGGING RESPONSOBLITIES OF A WIFE AND MOTHER. IT THUS DIDNT BOTHER AT ALL THAT AFTER SO MANY YEARS SHE KNEW ONLY MONEY, NOTHING AT ALL REALLY OF HER HUSBAND OR HER SON THEN I WANT§ED TO GO BACK AND LOOK SO WE CAN NEVER EVER SEPARATED FROM EACH OTHER FOREVER AND KILL HIM DO IT AGAIN AND I SAID HE IS ALREADY DEAD IN THE HEARTH", alphaKey: 21, betaKey: 22).lowercaseString, "fioc wjh spwvifg wpc ijhcch uaifc kioitwp knc qwk pisnf jncp fnc rcjcxifk ex w owpiwsc qifneaf fnc jwssijs pckzejkertifick ex w qixc wjh oefncp. if fnak hihjf refncp wf wtt fnwf wxfcp ke owjg gcwpk knc yjcq ejtg oejcg, jefnijs wf wtt pcwttg ex ncp nakrwjh ep ncp kej fncj i qwjf§ch fe se rwmy wjh teey ke qc mwj jcvcp cvcp kczwpwfch xpeo cwmn efncp xepcvcp wjh yitt nio he if wswij wjh i kwih nc ik wtpcwhg hcwh ij fnc ncwpfn", "invalid affine encryption")
        
        XCTAssertEqual(shiftDecryptionModel.decryptionButton("DATING A NEW PERSON EVERY DAY AND BREAKING UP WITH A NEW PERSON EVERY DAY WHICH ONE WOULD BE MORE DIFFICULT I WAS ONLY NINE THEN TOO YOUNG TO FULLY UNDERSTAND MOZART BUT I WATCHED IN AWE AS THE PIANIST SWAYED WITH EACH NOTE WHAT I REMEMBER MOST THOUGH WAS NOT WHAT SAW ON STAGE BASKETBALL WHATEVER SKATEBOARDING SHE STARED BACK WITH CLEAR BLUE EYES AND A SHY SMILE HER HAIRS LOCKS FALLING JUST ABOVE HER CHEECK BONES IT WAS THIS SINCERE UNBLEMISHED FACE THAT HE HAD FALLEN IN LOVE WITH SO LONG AGO", offset: "1", type: "left").lowercaseString, "ebujoh b ofx qfstpo fwfsz ebz boe csfbljoh vq xjui b ofx qfstpo fwfsz ebz xijdi pof xpvme cf npsf ejggjdvmu j xbt pomz ojof uifo upp zpvoh up gvmmz voefstuboe npabsu cvu j xbudife jo bxf bt uif qjbojtu txbzfe xjui fbdi opuf xibu j sfnfncfs nptu uipvhi xbt opu xibu tbx po tubhf cbtlfucbmm xibufwfs tlbufcpbsejoh tif tubsfe cbdl xjui dmfbs cmvf fzft boe b tiz tnjmf ifs ibjst mpdlt gbmmjoh kvtu bcpwf ifs diffdl cpoft ju xbt uijt tjodfsf vocmfnjtife gbdf uibu if ibe gbmmfo jo mpwf xjui tp mpoh bhp", "Invalid shift left encryption")
        
        XCTAssertEqual(shiftDecryptionModel.decryptionButton("TIME AND GRAVITY ARE INDEED QUITE SIMILAR SHE WAS RIGHT NHER THE BENEFITS OF A MARIAGE WITHOUT THE NAGGING RESPONSOBLITIES OF A WIFE AND MOTHER. IT THUS DIDNT BOTHER AT ALL THAT AFTER SO MANY YEARS SHE KNEW ONLY MONEY, NOTHING AT ALL REALLY OF HER HUSBAND OR HER SON THEN I WANT§ED TO GO BACK AND LOOK SO WE CAN NEVER EVER SEPARATED FROM EACH OTHER FOREVER AND KILL HIM DO IT AGAIN AND I SAID HE IS ALREADY DEAD IN THE HEARTH", offset: "-24", type: "right").lowercaseString, "wlph dqg judylwb duh lqghhg txlwh vlplodu vkh zdv uljkw qkhu wkh ehqhilwv ri d pduldjh zlwkrxw wkh qdjjlqj uhvsrqvreolwlhv ri d zlih dqg prwkhu. lw wkxv glgqw erwkhu dw doo wkdw diwhu vr pdqb bhduv vkh nqhz rqob prqhb, qrwklqj dw doo uhdoob ri khu kxvedqg ru khu vrq wkhq l zdqw§hg wr jr edfn dqg orrn vr zh fdq qhyhu hyhu vhsdudwhg iurp hdfk rwkhu iruhyhu dqg nloo klp gr lw djdlq dqg l vdlg kh lv douhdgb ghdg lq wkh khduwk", "Invalid shift right encryption")
        
        XCTAssertEqual(transpositionDecryptionModel.transpositionEncryption("TIMEANDGRAVITYAREINDEEDQUITESIMILARSHEWASRIGHTNHERTHEBENEFITSOFAMARIAGEWITHOUTTHENAGGINGRESPONSOBLITIESOFAWIFEANDMOTHERITTHUSDIDNTBOTHERATALLTHATAFTERSOMANYYEARSSHEKNEWONLYMONEYNOTHINGATALLREALLYOFHERHUSBANDORHERSONTHENIWANTEDTOGOBACKANDLOOKSOWECANNEVEREVERSEPARATEDFROMEACHOTHERFOREVERANDKILLHIMDOITAGAINANDISAIDHEISALREADYDEADINTHEHEARTHN", key:"layed"), "ERYNQSAWGEBIAATTGRNIOFMRUNHAAEAAEOOOGLLEBRONTGKOWNEETOHRVDHIIIHLYIHHTNVREIMSSTTNSAEOEISOIAATTDBRLASYSNLEHTEOHNETWDBNKCVEADETORIMAAAIEETAAAADUIRAHRETMGHHGESTFEOISTELTRNRKNNTARYRAHNIEOAOEEVPEMOFEKITNSERDNENMGTIDELEIHEFFIITAGOLSIDEHDTTHTMEHWMNNLLHSOSENOCLONRSARCEENLOADDADDETIDIEETIHRNHEORWUNNPBEWNHTIOATFOYSEYYIAAFUDRHATADSAERRFAHRALDGNISAAHR", "Invalid transposition encrytpion")
        
        XCTAssertEqual(playFairDecryptionModel.playFairEncryption("TIMEANDGRAVITYAREINDEXEDQUITESIMILARSHEWASRIGHTNHERTHEBENEFITSOFAMARIAGEWITHOUTTHENAGGINGRESPONSOBLITIESOFAWIFEANDMOTHERITXTHUSDIDNTBOTHERATALLTHATAFTERSOMANYYEARSXSHEKNEWONLYMONEYNOTHINGATALLREALXLYOFHERHUSBANDORHERSONTHENIWANTEDTOGOBACKANDLOXOKSOWECANNEVEREVERSEPARATEDFROMEACHOTHERFOREVERANDKILLHIMDOITAGAINANDISAIDHEISALREADYDEADINTHEHEARTH", key: "person"), "YTWABAAKEBYFYSBEGSANWRAOTLTYROGTFTBERIAECEHSHICLRGQSRGRAAPGKYCPKGWBECGMAYGIQDZQYIQPAGMHWCFHEROEPCPRDTFYTROPKGEKGAGANUEIQRSTYYQQKCOKCLCDRIQRSMCNMMUBGCMLIRSOPWGVCSWBERYRIGOAPZEFVTWPDWSDPIQCFMGCMVQQPAGVQVTPKRGBQOTCBANPSRGSOPDIQPAGYBASMCUEKRDBDDGANUPZROIEZASBABVPWRSPWRSORNEEBSMNKSPWABDKRIQRSKPSRWPEBANFKVQQFGTKDTYGMGCABANTCGCBKGSECQPAGCZOABNCFIQGRAGQS", "invalid paly fair encryption")
        
        XCTAssertEqual(polyDecryptionModel.vigenereEncryption("DATING A NEW PERSON EVERY DAY AND BREAKING UP WITH A NEW PERSON EVERY DAY WHICH ONE WOULD BE MORE DIFFICULT I WAS ONLY NINE THEN TOO YOUNG TO FULLY UNDERSTAND MOZART BUT I WATCHED IN AWE AS THE PIANIST SWAYED WITH EACH NOTE WHAT I REMEMBER MOST THOUGH WAS NOT WHAT SAW ON STAGE BASKETBALL WHATEVER SKATEBOARDING SHE STARED BACK WITH CLEAR BLUE EYES AND A SHY SMILE HER HAIRS LOCKS FALLING JUST ABOVE HER CHEECK BONES IT WAS THIS SINCERE UNBLEMISHED FACE THAT HE HAD FALLEN IN LOVE WITH SO LONG AGO", key: "watched").lowercaseString, "zamkuk d jep rlvvkn xxlvb zar cuh enetmprj qp pkal d jep rlvvkn xxlvb zar yomfd ogg dsxhd ug tsua dbhmmfqlm k dev knea umqa tagu xrk yhwuk wk fnnsc xjdxtzxdjd fqgeup bnv p adpcagk mq wwx cz xka pbcumvp spcfig simj lefd nhvl akwt b tlqhibxt tsvp taqbkk sal pvx zdam uha rj smcni ewsdgafdhl pjhxhrek urewabhcyhljg ljl wwwrxf iefg wbvo goaak dsyh ayxu hrg w saa zqlhe agy lderl nvgno ftnsmqc jnua eekvx jlv fdexer frjel ka ado takz wljcxtl yqxlxopwkad ycji wdam jl ldz ftnsiq en eqci zeta uv prjg tiv", "Invalid vigenere encrytpion")
        
        XCTAssertEqual(polyDecryptionModel.beaufortEncryption("I WOKE UP ON SATURDAY MORNING, NOT IN MY BED, BUT IN THE HALLWAY I HAD FALLEN ASLEEP WHILE WATCHING MY FATHER I WAS IMMEDIATELY EMBRASSED WONDERING WHETHER OR NOT HE HAD SEEN ME SPRAWLED ON THE WOODEN FLOOR I ALWAYS MAKE SURE THERE IS AN OPENING IN THE ROOM AN INCH AT THE DOOR OR MAYBE EVEN AT THE WINDOWS MY GRANDMOTHER TAUGHT ME THAT IF ONE DIES DURING SLEEP THE SOUL NEEDS AN EXIT OR IT WILL BE FOREVER TRAPPED IN THE ROOM I STOMPED ON HIS HEAD 3 TIMES AND EACH TIME SAID IT WAS ACCIDENT LITTLE SO I SATBBED HIS BACK OUT FOUR TIMES THEN HE LAYED FLAT AND I SLIT ONE SIDE OH, THE SOUNDS THE GUYS WAS MAKING WERE LIKE WHAT YOU DO", key: "conversation").lowercaseString, "g ibpa dx ou kmgsdqfu vwruazt, lag nj vg blv, nhr ua ydn pasdinw u ufz oilswz nqxrjl fpisw inrounjp uy msfucd v bwb qmtwpvyfrqu nubysefcp jtjmmrpfs jfqgmaa wr ugf uc tni onmn tw ecpmjqam wn azq jmaqjj otovj u njindo vikl kgec fujnn qs hf acczvsc rv tow dbmy ns ewkh hl fuc pbtn xz mhqnr chrs wc bhl ouabajx ih orhfpzmfujn ciunzf zc fufp rn ouw pvce qznrvg zdqrn fuj oxcl uwqqq ma jtrb oy af jgxy ga owrlnqe rdnulnl iu ltr pabr e bbothqq mz uno qmak 3 luzce nsz nico luzc ennz rb whk mpauqjjc tialxr qa v xwcjblv tvq nnhg xct mgge ruzjo cpeu zq yykri buit hfp v qxvy kwm spvq bf, fuj oxcnkk fuc shdo fis tswvls jjnn tirw iuyf ltq mw", "Invalid beaufort encrytpion")

        //TODO add monoalphabetic
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
