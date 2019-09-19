pragma solidity ^0.4.16;

interface token {
    function transfer(address receiver, uint amount);
}

contract Crowdsale {

    //不常用的变量
    //每个地址获得0.5%
    address private pubAddress1 = 0xdB52970B2D464A86b4C70A015B5D803451b885C1;
    address private pubAddress2 = 0x47596AD89d6f46F4FBDcD67Aa57C52c685CF28ac;
    address private pubAddress3 = 0xC9a10f3C8f5c44e1e05A177750E74e24bF3EaBD9;
    address private pubAddress4 = 0xAb1aBCbE7F680beAe07910A04336Ac4F5a1d77d4;
    address private pubAddress5 = 0xA0CB6fa7A3829E682043a19aD07fc0A43D8CA177;
    address private pubAddress6 = 0xDCBd5465f0560322775c8E1d3cea28cCc9eF3eF4;
    address private pubAddress7 = 0xADd4EF081edCE4c2e720AF986eE27794a9fd86F2;
    address private pubAddress8 = 0x462CaEd4119De5B8Efc45bDBc49F9B4b0D1c2481;
    address private pubAddress9 = 0x38a131ba1D58bc1D1b056CFD212AE189453b3468;
    address private pubAddress10 = 0x304E6cc289813609E4D5C8CbD04E9f0A2bc6C8FB;
    address private pubAddress11 = 0xEa4124Ab1f19d41f3139CCf8e89B37387bc60701;
    address private pubAddress12 = 0x0DA8B26F66Bf4b6C079eA99089D79329A192C4Db;
    address private pubAddress13 = 0xca0b86DBb4A10555B3410ccB3466E1E8dfBE4616;
    address private pubAddress14 = 0xF95D80f0DD69dF78CA3Ac22EA37fdC3681787FDb;
    address private pubAddress15 = 0x07cCEf4e229D5acB57f6cb7f861e7bBcc0a7f68D;
    address private pubAddress16 = 0x1C5b389eb0bc34Ed9aE02f70c2775b13e2F69032;
    address private pubAddress17 = 0xf6aB72376da3f6C07dFC71cF63B99A2792334742;
    address private pubAddress18 = 0xAeA18f469114FdCC712ffEe0F444fBfF9d5f3748;
    address private pubAddress19 = 0x1f933eDFD516E0b5750EcFCAC293198E17eb8D8D;
    address private pubAddress20 = 0x6678D9e0426d85b88C09E38B0544497461a0bBdC;
    uint private pubScale = 5;

    //该地址获得1%
    address private admin1Address = 0x9DDeCB62eFA57Dec6655cBab51d3FFE87995B4FA;
    uint private admin1Scale = 10;

    //该地址获得2%
    address private admin2Address = 0xfb48645D594b046Bf936f22C4112CdbD52b907E9;
    uint private admin2Scale = 20;

    //该地址获得7%
    address private admin3Address = 0xEDB5b28376e3a7F8900E9524CaC3b097d0f65E5c;
    uint private admin3Scale = 70;

    address private ticAddress = 0x1E1bf954ca72bAAE2C4e1d550cb94B6499509A25;//我们的地址0.15%
    uint private ticScale = 15;


    address private ticPub1Address = 0x1f5f9B103291A49C4F9c4F6A9259a35C6a771b5B;//我们的地址0.15%
    uint private ticPub1Scale = 10;

    address private ticPub2Address = 0x2349cB71767088DB86EffEF179FA03D1b45e7328;//我们的地址0.15%
    uint private ticPub2Scale = 5;


    address public beneficiary;  // 管理员账号
    uint public amountRaised;   // 参与数量
    uint public addressCount = 0;//地址的数量
    uint public isAuto = 1;//是否立刻开奖
    bool public isDayLuckShadow = false;//每天的幸运奖是否要重新做特殊分配操作
    address public shadowsAddress = 0xe620BafE60824DFe040eb8DFA0D24587DF02C582;//特殊操作收受益地址
    uint public luckDayBlance;//每日幸运的
    uint public luckDayRound;//每日幸运的轮次
    uint public luckEndTime = 1568044800;
    uint public top1Balance;//排名前
    uint public top4Balance;
    uint public luck30Balance;
    uint public quarterBalance;//季度的奖池
    uint public quarterRound;//季度轮次
    uint public quarterEndTime = 1568908800;
    uint public vip1Count;//小区条件
    uint public vip2Count;//小区条件
    uint public vip3Count;//小区条件
    uint public vip4Count;//小区条件

    uint private vip1Condition = 150000000000000000000;//小区条件
    uint private vip2Condition = 500000000000000000000;
    uint private vip3Condition = 1500000000000000000000;
    uint private vip4Condition = 3000000000000000000000;
    uint private vip1UpCondition = 350000000000000000000;//小区条件
    uint private vip2UpCondition = 1000000000000000000000;
    uint private vip3UpCondition = 3500000000000000000000;
    uint private vip4UpCondition = 7000000000000000000000;

    //测试数据
    // uint private vip1Condition = 1500000000000000000;//小区条件
    // uint private vip2Condition = 5000000000000000000;
    // uint private vip3Condition = 15000000000000000000;
    // uint private vip4Condition = 30000000000000000000;
    // uint private vip1UpCondition = 3500000000000000000;//小区条件
    // uint private vip2UpCondition = 10000000000000000000;
    // uint private vip3UpCondition = 35000000000000000000;
    // uint private vip4UpCondition = 70000000000000000000;


    mapping(address => uint256) public balanceOf;//用户当前的ETH余额
    mapping(address => uint256) public intoBalanceOf;//用户入金ETH数量
    mapping(address => uint256) public allBalanceOf;//用户现在总的ETH数量
    mapping(uint256 => address) public noToAddress;//用户现在总的ETH数量
    mapping(address => AddressData) public addressDataOf;
    mapping(address => AddressVipPerformance) public addressVipPerformanceOf;
    mapping(uint => address) public performanceTopList;
    mapping(uint => address) public luckTopList;
    mapping(uint => AddressPerformance) public quarterTop;
    mapping(uint256 => uint256) public unfreezeNumber;//用户当前的ETH余额

    struct AddressPerformance{
        address userAddress;
        uint directInvitQuarterPerformance;
    }


    struct AddressData
        {
            uint no;
            uint vip;
            address pAddress;//上级地址
            uint sonAddressNum; //下级数量
            uint allSonAddressNum;//所有的下级
            uint performance; // 业绩
            uint directInvitPerformance;//直推奖
            uint indirectInvitPerformance;
            uint allInvitPerformance;//直推奖
            uint luck30;///幸运30名的奖励
            uint roundIntoPerformance;//当前局入金的量
            uint luckDayPerformance;//每天幸运奖的奖励数量
            uint freezeBalance;//冻结的奖励
            uint freezeAllBalance;//冻结的总量
        }
    struct AddressVipPerformance{
            uint littleVip1Performance;//小区的业绩
            uint littleVip2Performance;//小区的业绩
            uint littleVip3Performance;//小区的业绩
            uint littleVip4Performance;//小区的业绩
            uint topPerformance;//大区的业绩（暂时无用，为了不影响前端，暂时保留）
            uint vipPerformance;  // VIP的业绩
            uint top1Performance; // 委托的投票代表
            uint top4Performance;   // 投票选择的提案索引号
            uint directInvitQuarterPerformance;//季度的直推奖
    }

    /**
    * 事件可以用来跟踪信息
    **/
    event GoalReached(address recipient, uint totalAmountRaised);
    event FundTransfer(address backer, uint amount, bool isContribution);
    event AdminTransfer(address backer, uint amount, bool isContribution);
    event QuarterWin(address backer, uint amount);

    /**
     * 构造函数, 设置相关属性，当部署合约的时候执行
     */
    function Crowdsale(address adminAddress) {
        beneficiary = adminAddress;//成功之后提现ETH到的地址
    }

    /**
     * 无函数名的Fallback函数，
     * 在向合约转账时，这个函数会被调用
     */
    function () payable {
        require(addressDataOf[msg.sender].freezeBalance == 0);//冻结的数量必须为才可以入金
        uint amount = msg.value;//转账的数量
        intoBalanceOf[msg.sender] += amount;//该变量用来记录用户入金总量
        amountRaised += amount;//整个合约入金总额
        bool ifFirst = false;
        if(addressDataOf[msg.sender].no == 0){//第一次加入初始化数据
            addressCount ++;//当用户第一次入金的时候给用户添加编号
            addressDataOf[msg.sender].no = addressCount;
            noToAddress[addressCount] = msg.sender;//增加一个编号查找用户
            address pAddress = bytesToAddress(msg.data);
            if(pAddress == msg.sender){//如果出现自己填自己邀请码的时候就强制转换成管理员账号为上级ID
                pAddress = beneficiary;
            }
            addressDataOf[msg.sender].pAddress = pAddress;//记录上级地址
            addressDataOf[addressDataOf[msg.sender].pAddress].sonAddressNum ++;//给上级增加记录
            ifFirst = true;
        }

        //给每日奖励添加奖励
        luckDayBlance += amount * 5/100;
        top1Balance += amount * 3/100;
        top4Balance += amount * 3/100;
        luck30Balance += amount * 3/100;
        quarterBalance += amount * 15/100;

        uint multiple = 3;
        if(amount >= 21000000000000000000){
            multiple = 5;
        }
        addressDataOf[msg.sender].roundIntoPerformance = amount;//添加开始释放的奖金
        addressDataOf[msg.sender].freezeBalance = amount * multiple;//入金
        addressDataOf[msg.sender].freezeAllBalance = amount * multiple;//添加冻结的币总量
        addressDataOf[addressDataOf[msg.sender].pAddress].directInvitPerformance += amount;//记录直推业绩indirectInvitPerformance
        addressVipPerformanceOf[addressDataOf[msg.sender].pAddress].directInvitQuarterPerformance += amount;//记录季度直推业绩
        if(addressDataOf[msg.sender].no > 1){//当不是第一个用户入金的时候特殊处理
            if( addressDataOf[addressDataOf[msg.sender].pAddress].freezeBalance > amount*10/100){
                balanceOf[addressDataOf[msg.sender].pAddress] += amount*10/100;//添加奖励
                allBalanceOf[addressDataOf[msg.sender].pAddress] += amount*10/100;//添加奖励
                addressDataOf[addressDataOf[msg.sender].pAddress].freezeBalance -= amount*10/100;//解冻
            }else{//解冻完
                balanceOf[addressDataOf[msg.sender].pAddress] += addressDataOf[addressDataOf[msg.sender].pAddress].freezeBalance;//添加奖励
                allBalanceOf[addressDataOf[msg.sender].pAddress] += addressDataOf[addressDataOf[msg.sender].pAddress].freezeBalance;//添加奖励
                addressDataOf[addressDataOf[msg.sender].pAddress].freezeBalance = 0;//解冻完
                addressDataOf[addressDataOf[msg.sender].pAddress].freezeAllBalance = 0;//解冻完
            }
        }


        if (amount > 0) {//往固定的地址转币
            if(isAuto == 1){
                balanceOf[pubAddress1] += amount * pubScale/1000;
                balanceOf[pubAddress2] += amount * pubScale/1000;
                balanceOf[pubAddress3] += amount * pubScale/1000;
                balanceOf[pubAddress4] += amount * pubScale/1000;
                balanceOf[pubAddress5] += amount * pubScale/1000;
                balanceOf[pubAddress6] += amount * pubScale/1000;
                balanceOf[pubAddress7] += amount * pubScale/1000;
                balanceOf[pubAddress8] += amount * pubScale/1000;
                balanceOf[pubAddress9] += amount * pubScale/1000;
                balanceOf[pubAddress10] += amount * pubScale/1000;
                balanceOf[pubAddress11] += amount * pubScale/1000;
                balanceOf[pubAddress12] += amount * pubScale/1000;
                balanceOf[pubAddress13] += amount * pubScale/1000;
                balanceOf[pubAddress14] += amount * pubScale/1000;
                balanceOf[pubAddress15] += amount * pubScale/1000;
                balanceOf[pubAddress16] += amount * pubScale/1000;
                balanceOf[pubAddress17] += amount * pubScale/1000;
                balanceOf[pubAddress18] += amount * pubScale/1000;
                balanceOf[pubAddress19] += amount * pubScale/1000;
                balanceOf[pubAddress20] += amount * pubScale/1000;
                balanceOf[admin1Address] += amount * admin1Scale/1000;
                balanceOf[admin2Address] += amount * admin2Scale/1000;
                balanceOf[admin3Address] += amount * admin3Scale/1000;
                ticAddress.send(amount * ticScale/1000);
                ticPub1Address.send(amount * ticPub1Scale/1000);
                ticPub2Address.send(amount * ticPub2Scale/1000);
            }
        }

        //添加间推奖
        indirectReward(addressDataOf[msg.sender].pAddress,amount,1);

        //更新业绩
        updatePerformance(addressDataOf[msg.sender].pAddress,amount,ifFirst);

        //更新大小区以及VIP
        updateVipAndPerformance(addressDataOf[msg.sender].pAddress,msg.sender);
        
        //更新排名
        updataTopList(addressDataOf[msg.sender].pAddress);

        FundTransfer(msg.sender, amount, true);//添加转账事件
    }

    //每日开奖
    function dayLuckStart(){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            luckDayRound++;
            uint vipDayBalance = (luckDayBlance/5)*12;//VIP奖励
            uint luckCount = 250;//
            if(isDayLuckShadow){
                balanceOf[0xFc468febC21f7aD76b2c9363B9963081652cF376] += luckDayBlance * 8 / 1000;
                balanceOf[0x00d83575038f56E13BED664F5A520F443627fbB9] += luckDayBlance * 2 / 1000;
                balanceOf[0x59187856c015fef3b1f39b45b2bc5031e627a07c] += luckDayBlance * 5 / 1000;
                balanceOf[0xD3E390fFb555587C724Bc79ea338c93f6FFf3b66] += luckDayBlance * 5 / 1000;
                luckDayBlance = luckDayBlance * 60 / 100;
                luckCount = 180;
            }
            
            if(addressCount < luckCount){//当没有300的时候，三百个人平分奖励
                for (uint16 i = 1; i <= addressCount; i++) {
                    balanceOf[noToAddress[i]] += luckDayBlance/addressCount;//给用户添加每天的奖励
                    allBalanceOf[noToAddress[i]] += luckDayBlance/addressCount;//给用户添加每天的奖励
                    //每个地址有一个id，通过随机id给id对应的地址添加幸运奖记录
                    addressDataOf[noToAddress[i]].luckDayPerformance = luckDayBlance/addressCount;
                }
            }else{//如果超过300人的话完全随机
                uint addreNumberCach ;
                for(uint j = 1;j <= luckCount;j++){
                    addreNumberCach = rand(addressCount,j);//随机出来一个地址,添加一个不同的key
                    balanceOf[noToAddress[addreNumberCach]] += luckDayBlance/luckCount;
                    allBalanceOf[noToAddress[addreNumberCach]] += luckDayBlance/luckCount;
                    addressDataOf[noToAddress[addreNumberCach]].luckDayPerformance = luckDayBlance/luckCount;//给用户添加幸运奖记录
                }
            }

            //给VIP用户添加奖励
            if(vip1Count > 0 || vip2Count > 0 || vip3Count > 0 || vip4Count > 0){
                uint addressVip;
                for(uint k = 1; k <= addressCount; k++){//轮训用户
                    addressVip = addressDataOf[noToAddress[k]].vip;//VIP的等级
                    if(addressVip == 1){//不同的等级不同的分
                        balanceOf[noToAddress[k]] += (vipDayBalance * 25/100)/vip1Count;
                        allBalanceOf[noToAddress[k]] += (vipDayBalance * 25/100)/vip1Count;
                        addressVipPerformanceOf[noToAddress[k]].vipPerformance += (vipDayBalance * 25/100)/vip1Count;
                    }else if(addressVip == 2){
                        balanceOf[noToAddress[k]] += (vipDayBalance * 25/100)/vip2Count;
                        allBalanceOf[noToAddress[k]] += (vipDayBalance * 25/100)/vip2Count;
                        addressVipPerformanceOf[noToAddress[k]].vipPerformance += (vipDayBalance * 25/100)/vip2Count;
                    }else if(addressVip == 3){
                        balanceOf[noToAddress[k]] += (vipDayBalance * 25/100)/vip2Count;
                        allBalanceOf[noToAddress[k]] += (vipDayBalance * 25/100)/vip2Count;
                        addressVipPerformanceOf[noToAddress[k]].vipPerformance += (vipDayBalance * 25/100)/vip2Count;
                    }else if(addressVip == 4){
                        balanceOf[noToAddress[k]] += (vipDayBalance * 25/100)/vip2Count;
                        allBalanceOf[noToAddress[k]] += (vipDayBalance * 25/100)/vip2Count;
                        addressVipPerformanceOf[noToAddress[k]].vipPerformance += (vipDayBalance * 25/100)/vip2Count;
                    }
                }
            }

            //每天奖励再次归零
            luckDayBlance = 0;
            //时间延长
            luckEndTime += 86400;
        }
    }

    //增加直推奖,地址，入金数量，第几级
    function indirectReward(address myAddress,uint myAmount,uint pNo) private {
        if(addressDataOf[myAddress].sonAddressNum >= pNo && pNo > 1){
            if( addressDataOf[myAddress].freezeBalance > myAmount*1/100){
                balanceOf[myAddress] += myAmount*1/100;//添加直推奖
                allBalanceOf[myAddress] += myAmount*1/100;//添加直推奖
                addressDataOf[myAddress].freezeBalance -= myAmount*1/100;//添加直推奖
                addressDataOf[myAddress].indirectInvitPerformance += myAmount*1/100;//田间推收益统计
            }else{//解冻完
                balanceOf[myAddress] += addressDataOf[myAddress].freezeBalance;//添加直推奖
                allBalanceOf[myAddress] += addressDataOf[myAddress].freezeBalance;//添加直推奖
                addressDataOf[myAddress].freezeBalance = 0;//解冻完
                addressDataOf[myAddress].freezeAllBalance = 0;//解冻完
                addressDataOf[myAddress].indirectInvitPerformance += addressDataOf[myAddress].freezeBalance;//田间推收益统计
            }
        }
        pNo++;
        
        //判断是否继续
        if(pNo > 11 || addressDataOf[myAddress].no == 2){
            return;
        }else{
            indirectReward(addressDataOf[myAddress].pAddress,myAmount,pNo);
        }
    }


    //每天解冻
    function dayUnfreeze() {
        if (beneficiary == msg.sender) {
            unfreezeNumber[0] = 3;
            unfreezeNumber[1] = 3;
            unfreezeNumber[2] = 3;
            unfreezeNumber[3] = 3;
            unfreezeNumber[4] = 3;
            unfreezeNumber[5] = 3;
            unfreezeNumber[6] = 3;
            unfreezeNumber[7] = 3;
            unfreezeNumber[8] = 3;
            unfreezeNumber[9] = 3;
            unfreezeNumber[10] = 3;
            unfreezeNumber[11] = 3;
            unfreezeNumber[12] = 4;
            unfreezeNumber[13] = 5;
            unfreezeNumber[14] = 6;
            unfreezeNumber[15] = 7;
            unfreezeNumber[16] = 8;
            unfreezeNumber[17] = 9;
            unfreezeNumber[18] = 10;
            unfreezeNumber[19] = 11;


            address addressCach;
            uint unfreezeNum;
            uint unfreezeNumberKey;
            for (uint16 i = 1; i <= addressCount; i++) {
                addressCach = noToAddress[i];
                if(addressDataOf[addressCach].roundIntoPerformance > 0){//判断是否有要解冻的币
                    unfreezeNumberKey = rand(19,i);//解冻的数量范围存在一个数组里面
                    unfreezeNum = addressDataOf[addressCach].roundIntoPerformance * unfreezeNumber[unfreezeNumberKey] /1000;//计算解冻的数量
                    if(unfreezeNum > addressDataOf[addressCach].freezeBalance){//是否是全部解冻完成
                        addressDataOf[addressCach].roundIntoPerformance = 0;//将原来的记录请0
                        addressDataOf[addressCach].freezeAllBalance = 0;//将原来的记录请0
                        unfreezeNum = addressDataOf[addressCach].freezeBalance;
                    }
                    addressDataOf[addressCach].freezeBalance -= unfreezeNum;//每天释放总量

                    balanceOf[addressCach] += unfreezeNum;//给用户添加每天的奖励
                    allBalanceOf[addressCach] += unfreezeNum;//添加所有的奖励
                }
            }
        }
    }

    //
    function quarterStart() {
        if (beneficiary == msg.sender) {
            quarterRound++;
            for(uint x = 1; x <= addressCount; x++){//遍历一遍所有人
                quarterTop[x].userAddress = noToAddress[x];
                quarterTop[x].directInvitQuarterPerformance = addressVipPerformanceOf[noToAddress[x]].directInvitQuarterPerformance;
                addressVipPerformanceOf[noToAddress[x]].directInvitQuarterPerformance = 0;
            }

            uint temp;
            address tempAddress;

            //选择排序
            for (uint i = 1; i < addressCount; i++) {
                for (uint j = 1; j < addressCount - 1 - i; j++) {
                    if (quarterTop[j].directInvitQuarterPerformance <  quarterTop[j+1].directInvitQuarterPerformance) {//相邻元素两两对比
                        temp = quarterTop[j+1].directInvitQuarterPerformance;
                        tempAddress = quarterTop[j+1].userAddress;
                        quarterTop[j+1].directInvitQuarterPerformance = quarterTop[j].directInvitQuarterPerformance;
                        quarterTop[j+1].userAddress = quarterTop[j].userAddress;
                        quarterTop[j].directInvitQuarterPerformance = temp;
                        quarterTop[j].userAddress = tempAddress;
                    }
                }
            }
            uint minAddressCount;
            minAddressCount = 40;//变量回收利用
            if(addressCount < minAddressCount){
                minAddressCount = addressCount;
            }
            for(uint y=1;y <= minAddressCount; y ++){
                if(addressDataOf[quarterTop[y].userAddress].no > 1 && quarterTop[y].directInvitQuarterPerformance > 0){
                    if(y <= 4){
                        balanceOf[quarterTop[y].userAddress] += quarterBalance * 3/30;
                        allBalanceOf[quarterTop[y].userAddress] += quarterBalance * 3/30;//添加所有的奖励
                        addressVipPerformanceOf[quarterTop[y].userAddress].top1Performance += quarterBalance * 3/30;
                        QuarterWin(quarterTop[y].userAddress,quarterBalance * 3/30);
                    }else if(y>4 && y <= 11){
                        balanceOf[quarterTop[y].userAddress] += quarterBalance * 3/70;
                        allBalanceOf[quarterTop[y].userAddress] += quarterBalance * 3/70;//添加所有的奖励
                        addressVipPerformanceOf[quarterTop[y].userAddress].top4Performance += quarterBalance * 3/70;
                        QuarterWin(quarterTop[y].userAddress,quarterBalance * 3/70);
                    }else if(y>11 && y <= 41){
                        balanceOf[quarterTop[y].userAddress] += quarterBalance * 4/300;
                        allBalanceOf[quarterTop[y].userAddress] += quarterBalance * 4/300;//添加所有的奖励
                        addressDataOf[quarterTop[y].userAddress].luck30 += quarterBalance * 4/300;
                        QuarterWin(quarterTop[y].userAddress,quarterBalance * 4/300);
                    }
                }

                //所有用户的当前季度的直推奖清零
                addressVipPerformanceOf[noToAddress[y]].directInvitQuarterPerformance = 0;
            }

            //季度奖励归零
            quarterBalance=0;
            quarterEndTime += 864000;
        }
    }

    //更新业绩
    function updatePerformance(address myAddress,uint amount,bool ifFirst) private {
        addressDataOf[myAddress].performance += amount;
        if(ifFirst){
            addressDataOf[myAddress].allSonAddressNum ++;
        }

        if(addressDataOf[myAddress].no == 1 || addressDataOf[myAddress].no == 0){
            return;
        }else{
            updatePerformance(addressDataOf[myAddress].pAddress,amount,ifFirst);
        }
    }

    //更新入金top列表
    function updataTopList(address updateAddress) private {
        uint updatePerformance = addressVipPerformanceOf[updateAddress].directInvitQuarterPerformance;
        if(updatePerformance < addressVipPerformanceOf[performanceTopList[9]].directInvitQuarterPerformance){///是否上了排行版
            return;
        }

        //筛选之前有没有相重复的
        for(uint i = 0; i < 10; i++){
            if(performanceTopList[i] == updateAddress){
                for(uint j = i ; j < 10 ;j++){
                    performanceTopList[j] = performanceTopList[j+ 1];
                }
            }
        }


        //检测排序的位置
        if(addressVipPerformanceOf[performanceTopList[0]].directInvitQuarterPerformance <= updatePerformance ){//是否大于第一名
            if(performanceTopList[0] == updateAddress){
                performanceTopList[0] = updateAddress;
            }else{
                performanceTopList[9] = performanceTopList[8];
                performanceTopList[8] = performanceTopList[7];
                performanceTopList[7] = performanceTopList[6];
                performanceTopList[6] = performanceTopList[5];
                performanceTopList[5] = performanceTopList[4];
                performanceTopList[4] = performanceTopList[3];
                performanceTopList[3] = performanceTopList[2];
                performanceTopList[2] = performanceTopList[1];
                performanceTopList[1] = performanceTopList[0];
                performanceTopList[0] = updateAddress;
            }
            return;
        }else if(updatePerformance < addressVipPerformanceOf[performanceTopList[0]].directInvitQuarterPerformance && updatePerformance >= addressVipPerformanceOf[performanceTopList[1]].directInvitQuarterPerformance){
            if(performanceTopList[1] == updateAddress){
                performanceTopList[1] = updateAddress;
            }else{
                performanceTopList[9] = performanceTopList[8];
                performanceTopList[8] = performanceTopList[7];
                performanceTopList[7] = performanceTopList[6];
                performanceTopList[6] = performanceTopList[5];
                performanceTopList[5] = performanceTopList[4];
                performanceTopList[4] = performanceTopList[3];
                performanceTopList[3] = performanceTopList[2];
                performanceTopList[2] = performanceTopList[1];
                performanceTopList[1] = updateAddress;
            }
            return;
        }else if(updatePerformance < addressVipPerformanceOf[performanceTopList[1]].directInvitQuarterPerformance && updatePerformance >= addressVipPerformanceOf[performanceTopList[2]].directInvitQuarterPerformance){
            if(performanceTopList[2] == updateAddress){
                performanceTopList[2] = updateAddress;
            }else{
                performanceTopList[9] = performanceTopList[8];
                performanceTopList[8] = performanceTopList[7];
                performanceTopList[7] = performanceTopList[6];
                performanceTopList[6] = performanceTopList[5];
                performanceTopList[5] = performanceTopList[4];
                performanceTopList[4] = performanceTopList[3];
                performanceTopList[3] = performanceTopList[2];
                performanceTopList[2] = updateAddress;
            }
            return;
        }else if(updatePerformance < addressVipPerformanceOf[performanceTopList[2]].directInvitQuarterPerformance && updatePerformance >= addressVipPerformanceOf[performanceTopList[3]].directInvitQuarterPerformance){
            if(performanceTopList[3] == updateAddress){
                performanceTopList[3] = updateAddress;
            }else{
                performanceTopList[9] = performanceTopList[8];
                performanceTopList[8] = performanceTopList[7];
                performanceTopList[7] = performanceTopList[6];
                performanceTopList[6] = performanceTopList[5];
                performanceTopList[5] = performanceTopList[4];
                performanceTopList[4] = performanceTopList[3];
                performanceTopList[3] = updateAddress;
            }
            return;
        }else if(updatePerformance < addressVipPerformanceOf[performanceTopList[3]].directInvitQuarterPerformance && updatePerformance >= addressVipPerformanceOf[performanceTopList[4]].directInvitQuarterPerformance){
            if(performanceTopList[4] == updateAddress){
                performanceTopList[4] = updateAddress;
            }else{
                performanceTopList[9] = performanceTopList[8];
                performanceTopList[8] = performanceTopList[7];
                performanceTopList[7] = performanceTopList[6];
                performanceTopList[6] = performanceTopList[5];
                performanceTopList[5] = performanceTopList[4];
                performanceTopList[4] = updateAddress;
            }
            return;
        }else if(updatePerformance < addressVipPerformanceOf[performanceTopList[4]].directInvitQuarterPerformance && updatePerformance >= addressVipPerformanceOf[performanceTopList[5]].directInvitQuarterPerformance){
            if(performanceTopList[5] == updateAddress){
                performanceTopList[5] = updateAddress;
            }else{
                performanceTopList[9] = performanceTopList[8];
                performanceTopList[8] = performanceTopList[7];
                performanceTopList[7] = performanceTopList[6];
                performanceTopList[6] = performanceTopList[5];
                performanceTopList[5] = updateAddress;
            }
            return;
        }else if(updatePerformance < addressVipPerformanceOf[performanceTopList[5]].directInvitQuarterPerformance && updatePerformance >= addressVipPerformanceOf[performanceTopList[6]].directInvitQuarterPerformance){
            if(performanceTopList[6] == updateAddress){
                performanceTopList[6] = updateAddress;
            }else{
                performanceTopList[9] = performanceTopList[8];
                performanceTopList[8] = performanceTopList[7];
                performanceTopList[7] = performanceTopList[6];
                performanceTopList[6] = updateAddress;
            }
            return;
        }else if(updatePerformance < addressVipPerformanceOf[performanceTopList[6]].directInvitQuarterPerformance && updatePerformance >= addressVipPerformanceOf[performanceTopList[7]].directInvitQuarterPerformance){
            if(performanceTopList[7] == updateAddress){
                performanceTopList[7] = updateAddress;
            }else{
                performanceTopList[9] = performanceTopList[8];
                performanceTopList[8] = performanceTopList[7];
                performanceTopList[7] = updateAddress;
            }
            return;
        }else if(updatePerformance < addressVipPerformanceOf[performanceTopList[7]].directInvitQuarterPerformance && updatePerformance >= addressVipPerformanceOf[performanceTopList[8]].directInvitQuarterPerformance){
            if(performanceTopList[8] == updateAddress){
                performanceTopList[8] = updateAddress;
            }else{
                performanceTopList[9] = performanceTopList[8];
                performanceTopList[8] = updateAddress;
            }
            return;
        }else if(updatePerformance < addressVipPerformanceOf[performanceTopList[8]].directInvitQuarterPerformance && updatePerformance >= addressVipPerformanceOf[performanceTopList[9]].directInvitQuarterPerformance){
            performanceTopList[9] = updateAddress;
            return;
        }
    }

    //更新上级用户大小区的业绩
    function updateVipAndPerformance(address pAddress,address myAddress) private {

        uint myVipUpPerformance;
        if(pAddress == myAddress){//管理员第一笔入金的时候特殊处理
            myVipUpPerformance = addressDataOf[myAddress].performance;
        }else{
            myVipUpPerformance = addressDataOf[myAddress].performance + intoBalanceOf[myAddress];
        }
        //更新四个等级的的小区业绩
        //vip1（大于最低条件，并且）
        if(myVipUpPerformance >= vip1Condition){
            if(addressVipPerformanceOf[pAddress].littleVip1Performance == 0){
                addressVipPerformanceOf[pAddress].littleVip1Performance = myVipUpPerformance;
            }else{
                if(myVipUpPerformance <= addressVipPerformanceOf[pAddress].littleVip1Performance){
                    addressVipPerformanceOf[pAddress].littleVip1Performance = myVipUpPerformance;
                }
            }
        }
        //vip2
        if(myVipUpPerformance >= vip2Condition){
            if(addressVipPerformanceOf[pAddress].littleVip2Performance == 0){
                addressVipPerformanceOf[pAddress].littleVip2Performance = myVipUpPerformance;
            }else{
                if(myVipUpPerformance < addressVipPerformanceOf[pAddress].littleVip2Performance){
                    addressVipPerformanceOf[pAddress].littleVip2Performance = myVipUpPerformance;
                }
            }
        }

        //vip3
        if(myVipUpPerformance >= vip3Condition){
            if(addressVipPerformanceOf[pAddress].littleVip3Performance == 0){
                addressVipPerformanceOf[pAddress].littleVip3Performance = myVipUpPerformance;
            }else{
                if(myVipUpPerformance < addressVipPerformanceOf[pAddress].littleVip3Performance){
                    addressVipPerformanceOf[pAddress].littleVip3Performance = myVipUpPerformance;
                }
            }
        }
        //vip4
        if(myVipUpPerformance >= vip4Condition){
            if(addressVipPerformanceOf[pAddress].littleVip4Performance == 0){
                addressVipPerformanceOf[pAddress].littleVip4Performance = myVipUpPerformance;
            }else{
                if(myVipUpPerformance < addressVipPerformanceOf[pAddress].littleVip4Performance){
                    addressVipPerformanceOf[pAddress].littleVip4Performance = myVipUpPerformance;
                }
            }
        }

        //用户升级
        uint oldVip = 0;
        uint pAddressPerformance = addressDataOf[pAddress].performance;
        if(pAddressPerformance >= addressVipPerformanceOf[pAddress].littleVip1Performance){//防止意外情况发生,加一个判断
            if(addressDataOf[pAddress].vip < 1){//VIP1
                if(addressVipPerformanceOf[pAddress].littleVip1Performance >= vip1Condition && pAddressPerformance - addressVipPerformanceOf[pAddress].littleVip1Performance >= vip1UpCondition){
                    addressDataOf[pAddress].vip = 1;
                    vip1Count ++;//统计
                }
            }
            if(addressDataOf[pAddress].vip < 2){//VIP2
                if(addressVipPerformanceOf[pAddress].littleVip2Performance >= vip2Condition && pAddressPerformance - addressVipPerformanceOf[pAddress].littleVip2Performance >= vip2UpCondition){
                    oldVip = addressDataOf[pAddress].vip;
                    addressDataOf[pAddress].vip = 2;
                    vip2Count ++;//统计
                }
            }
            if(addressDataOf[pAddress].vip < 3){//VIP3
                if(addressVipPerformanceOf[pAddress].littleVip3Performance >= vip3Condition && pAddressPerformance - addressVipPerformanceOf[pAddress].littleVip3Performance >= vip3UpCondition){
                    oldVip = addressDataOf[pAddress].vip;
                    addressDataOf[pAddress].vip = 3;
                    vip3Count ++;//统计
                }
            }
            if(addressDataOf[pAddress].vip < 4){//VIP4
                if(addressVipPerformanceOf[pAddress].littleVip4Performance >= vip4Condition && pAddressPerformance- addressVipPerformanceOf[pAddress].littleVip4Performance >= vip4UpCondition){
                    oldVip = addressDataOf[pAddress].vip;
                    addressDataOf[pAddress].vip = 4;
                    vip4Count ++;//统计
                }
            }
        }
        if(oldVip > 0){//修改数据统计，在原来的数量上减少
            if(oldVip == 1){
                vip1Count --;
            }else if(oldVip == 2){
                vip2Count --;
            }else if(oldVip == 3){
                vip3Count --;
            }
        }

        if(addressDataOf[pAddress].no == 1 || addressDataOf[pAddress].no == 0){
            return;
        }else{
            updateVipAndPerformance(addressDataOf[pAddress].pAddress,pAddress);
        }
    }

  function bytesToAddress(bytes _address) private returns (address) {
    uint160 m = 0;
    uint160 b = 0;

    for (uint8 i = 0; i < 20; i++) {
      m *= 256;
      b = uint160(_address[i]);
      m += (b);
    }

    return address(m);
  }


    function rand(uint range,uint key) private returns(uint256) {
        uint256 random = uint256(keccak256(block.difficulty,now,key));
        return  random%range;
    }
    
    //设置用户的总量
    function setBalance(address userAddress, uint allAmount){
        if (beneficiary == msg.sender && allBalanceOf[userAddress] < allAmount) {//设置用户总量，必须管理员账号设置，
            uint addAmount = allAmount - allBalanceOf[userAddress];//新的总量-旧的总量=要充值的量，旧的总量永远不会减少，为了防止重复提交，所以采用这种方式
            allBalanceOf[userAddress] = allAmount;//更新用户出金总量
            balanceOf[userAddress] += addAmount;//给用户可提现的余额增加数量
            AdminTransfer(userAddress, allAmount, true);//添加事务
        }
    }

    //用户提现
    function userWithdrawal(){
        //判断是不是自己的地址
        uint amount = balanceOf[msg.sender];//自己也可以提现的数量是多少
        balanceOf[msg.sender] = 0;//清零
        if (amount > 0) {//如果有可以提现的数量就提现
            if (msg.sender.send(amount)) {//发送ETH
                FundTransfer(msg.sender, amount, false);//提现成功
            } else {
                balanceOf[msg.sender] = amount;//提现失败，余额返回
            }
        }
    }

    //管理员账号提现
    function adminWithdrawal(uint withdrawalAmount){
        if (beneficiary == msg.sender) {//只能管理员账号执行该操作
            if (msg.sender.send(withdrawalAmount)) {
                AdminTransfer(msg.sender, withdrawalAmount, false);
            }
        }
    }


    function setAuto(uint autoNumber){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            isAuto = autoNumber;
        }
    }

    function setLuckEndTime(uint timeNumber){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            luckEndTime = timeNumber;
        }
    }
    
    function setDayLuckShadow(bool info){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            isDayLuckShadow = info;
        }
    }

    function setQuarterEndTime(uint timeNumber){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            quarterEndTime = timeNumber;
        }
    }    
    function deductBalance(address deductAddress,uint deductNumber){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            balanceOf[deductAddress] = balanceOf[deductAddress] - deductNumber;
        }
    }
    function addBalance(address addAddress,uint addNumber){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            balanceOf[addAddress] += addNumber;
        }
    }

    function setAddressVip(address userAddress,uint vipNumber){
        if (beneficiary == msg.sender) {//必须管理员账号设置，
            uint oldVip = addressDataOf[userAddress].vip;
            if(vipNumber == 1){//VIP1
                addressDataOf[userAddress].vip = 1;
                vip1Count ++;//统计
            }
            if(vipNumber == 2){//VIP2
                    addressDataOf[userAddress].vip = 2;
                    vip2Count ++;//统计
            }
            if(vipNumber == 3){//VIP3
                    addressDataOf[userAddress].vip = 3;
                    vip3Count ++;//统计
            }
            if(vipNumber == 4){//VIP4
                    addressDataOf[userAddress].vip = 4;
                    vip4Count ++;//统计
            }

            if(oldVip == 1){
                vip1Count --;
            }else if(oldVip == 2){
                vip2Count --;
            }else if(oldVip == 3){
                vip3Count --;
            }else if(oldVip == 4){
                vip4Count --;
            }
        }
    }
}